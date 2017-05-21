package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.Doctor;
import com.imudges.web.manager_medicine_system.bean.Patient;
import com.imudges.web.manager_medicine_system.bean.User;
import com.imudges.web.manager_medicine_system.util.MD5;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.*;

import javax.print.Doc;
import javax.servlet.http.*;

/**
 * 医生的主要逻辑
 */
@IocBean
@Filters({@By(type = DoctorFilter.class, args = {"ioc:doctorFilter"})})
public class DoctorModule {
    @Inject
    Dao dao;

    /**
     * 医生登录GET
     * */
    @Filters(@By(type = ConfigFilter.class))
    @At("public/doctor_login")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object doctorLoginPage(@Param("redirect_url") String redirectUrl,
                                  HttpServletRequest request) {

        request.setAttribute("code", 0);
        return "jsp:public/doctor_login";
    }

    @Filters(@By(type = ConfigFilter.class))
    @At("public/doctor_login")
    @Ok("re")
    @Fail("http:500")
    @POST
    public Object doctorLogin(@Param("username") String username,
                              @Param("password") String password,
                              @Param("redirect_url") String redirectUrl,
                              HttpSession session,
                              HttpServletRequest request,
                              HttpServletResponse response) {
        doctorLoginPage(redirectUrl,request);
        boolean isLogin = false;
        if (username == null || password == null || username.equals("") || password.equals("")) {
            //请求参数错误
            request.setAttribute("redirect_url", "doctor_login.php");
            request.setAttribute("code", -1);
        } else {
            //请求参数正确
            User user = dao.fetch(User.class, Cnd.where("username", "=", username).and("password", "=", password));
            if (user != null) {
                //登陆成功时向Sessionz中写入user对象
                session.setAttribute("user", user);
                //设置Cookie
                String ak = MD5.encryptTimeStamp(System.currentTimeMillis() + "");
                javax.servlet.http.Cookie cookie = new javax.servlet.http.Cookie("ak", ak);
                cookie.setMaxAge(365 * 24 * 3600);//时间一年
                cookie.setPath("/");
                cookie.setHttpOnly(true);
                response.addCookie(cookie);
                user.setAk(ak);
                dao.update(user);
                //患者
                Doctor doctor = dao.fetch(Doctor.class, Cnd.where("A_USERID", "=", user.getId()));
                if (doctor != null) {
                    request.setAttribute("redirect_url", "windows.php");
                    request.setAttribute("name", doctor.getName());
                    session.setAttribute("doctor", doctor);
                    request.setAttribute("code", 0);
                    isLogin = true;
                } else {
                    isLogin = false;
                }
            } else {
                request.setAttribute("redirect_url", "doctor_login.php");
                request.setAttribute("code", -2);
            }

        }
        if (isLogin) {
            return ">>:../doctor/windows.php";
        } else {
            return "jsp:public/doctor_login";
        }
    }

    @At("doctor/windows")
    @Ok("re")
    @Fail("http:500")
    public Object windows(HttpServletRequest request,
                          HttpSession session){
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        request.setAttribute("name",doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/windows";
    }

    /**
     * 注销
     * */
    @At("doctor/logout")
    @Ok("re")
    @Fail("http:500")
    @Filters
    public String logout(HttpServletRequest request,
                         HttpServletResponse response,
                         HttpSession session) {
        //清除用户的AK信息
        User user = (User) session.getAttribute("user");
        try {
            user.setAk("");
            dao.update(user);
            String s = request.getContextPath();
        } catch (Exception e) {
        }
        javax.servlet.http.Cookie cookie = new javax.servlet.http.Cookie("ak", "hupeng");
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setMaxAge(365 * 24 * 3600);
        response.addCookie(cookie);
        session.removeAttribute("user");
        request.setAttribute("redirect_url", "../public/doctor_login.php");
        request.setAttribute("msg", "注销成功！");
        return "jsp:public/graph_jump";
    }

    /**
     * 诊断窗口
     * */
    @At("doctor/diagnose")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object diagnosePage(HttpServletRequest request,
                          HttpSession session){
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        request.setAttribute("name",doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/diagnose";
    }

    /**
     * 收费窗口
     * */
    @At("doctor/collection")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object collectionPage(HttpServletRequest request,
                           HttpSession session){
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        request.setAttribute("name",doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/collection";
    }
}
