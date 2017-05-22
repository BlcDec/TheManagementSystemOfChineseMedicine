package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.AppointmentOrRegistration;
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
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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
     */
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
        doctorLoginPage(redirectUrl, request);
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
                          HttpSession session) {
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");

        //限制不同医生的窗口
        switch (doctor.getPosition()) {
            //诊断
            case "1":
                request.setAttribute("redirect_url", "diagnose.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
            //收费
            case "2":
                request.setAttribute("redirect_url", "collection.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
        }
        request.setAttribute("name", doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/windows";
    }

    /**
     * 注销
     */
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
     */
    @At("doctor/diagnose")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object diagnosePage(HttpServletRequest request,
                               HttpSession session) {
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        //限制不同医生的窗口
        switch (doctor.getPosition()) {
            //挂号
            case "0":
                request.setAttribute("redirect_url", "windows.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
            //收费
            case "2":
                request.setAttribute("redirect_url", "collection.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
        }
        request.setAttribute("name", doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/diagnose";
    }

    /**
     * 收费窗口
     */
    @At("doctor/collection")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object collectionPage(HttpServletRequest request,
                                 HttpSession session) {
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        //限制不同医生的窗口
        switch (doctor.getPosition()) {
            //挂号
            case "0":
                request.setAttribute("redirect_url", "windows.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
            //诊断
            case "1":
                request.setAttribute("redirect_url", "diagnose.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
        }
        request.setAttribute("name", doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/collection";
    }

    /**
     * 跳转界面
     */
    @At("doctor/jump")
    @Ok("re")
    @Fail("http:500")
    @Filters
    public String jump(@Param("redirect_url") String redirectUrl, HttpServletRequest request) {
        request.setAttribute("redirect_url", redirectUrl);
        return "jsp:doctor/jump";
    }


    @At("doctor/add_registration")
    @Ok("re")
    @Fail("http:500")
    public Object addRegistrationPage(HttpServletRequest request,
                                      HttpSession session) {
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        request.setAttribute("name", doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/add_registration";
    }

    /**
     * 现场患者挂号，现场已缴纳挂号费
     * */
    @At("doctor/add_registration_msg")
    @Ok("json")
    @Fail("http:500")
    public Object addRegistration(HttpServletRequest request,
                                  HttpSession session,
                                  @Param("name") String name,
                                  @Param("sex") String sex,
                                  @Param("year") String year,
                                  @Param("phone_num") String phoneNum,
                                  @Param("appear_time") String appearTime,
                                  @Param("department") String department,
                                  @Param("id_card") String idCard) {
        Map<String, Object> map = new HashMap<>();
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        Patient patient = dao.fetch(Patient.class, Cnd.where("A_IDCARD", "=", idCard));
        if(patient == null){
            map.put("code", -9);
            map.put("msg", "挂号失败，患者信息无效");
            request.setAttribute("doctor", patient);
            request.setAttribute("name", doctor.getName());
            return map;
        }

        //一个用户有未支付预约信息
        if (dao.count(AppointmentOrRegistration.class,
                Cnd.where("patientIdCard", "=",
                        patient.getIdCard())
                        .and("registrationFeeState", "=", "0")
                        .and("isAppointment","=",true)) != 0) {
            map.put("code", -9);
            map.put("msg", "挂号失败，每个用户只可挂号一次");
            request.setAttribute("patient", patient);
            request.setAttribute("name", patient.getName());
            return map;
        }
        AppointmentOrRegistration appointmentOrRegistration = new AppointmentOrRegistration(true);
        appointmentOrRegistration.setAddTime(new Date(System.currentTimeMillis()));
        appointmentOrRegistration.setAppearTime(appearTime);
        appointmentOrRegistration.setDepartment(department);
        appointmentOrRegistration.setPatientIdCard(patient.getIdCard());
        appointmentOrRegistration.setRegistrationFeeState(1);//已经支付挂号费
        appointmentOrRegistration.setPayForTime(new Date(System.currentTimeMillis()));
        appointmentOrRegistration.setAppointment(false);//不是预约信息
        dao.insert(appointmentOrRegistration);

        map.put("code", 0);
        map.put("msg", "挂号成功");
        request.setAttribute("doctor", doctor);
        request.setAttribute("name", doctor.getName());
        return map;
    }

}
