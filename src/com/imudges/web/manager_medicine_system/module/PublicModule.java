package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.CheckCode;
import com.imudges.web.manager_medicine_system.bean.Doctor;
import com.imudges.web.manager_medicine_system.bean.Patient;
import com.imudges.web.manager_medicine_system.bean.User;
import com.imudges.web.manager_medicine_system.util.Config;
import com.imudges.web.manager_medicine_system.util.ConfigReader;
import com.imudges.web.manager_medicine_system.util.MD5;
import com.imudges.web.manager_medicine_system.util.Toolkit;
import com.sun.deploy.net.HttpResponse;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.JsonParser;
import org.nutz.mvc.annotation.*;
import sun.misc.Request;


import javax.servlet.http.*;
import javax.servlet.http.Cookie;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 患者共有的
 * */

@IocBean
@Filters(@By(type = PatientFilter.class, args = {"ioc:patientFilter"}))
public class PublicModule {
    @Inject
    Dao dao;

    /**
     * 患者登录GET
     * */
    @Filters(@By(type = ConfigFilter.class))
    @At("public/patient_login")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object patientLoginPage(HttpServletRequest request,
                                   @Param("redirect_url") String redirectUrl) {

        request.setAttribute("code", 0);
        return "jsp:public/patient_login";
    }

    /**
     * 患者登录
     * */
    @Filters(@By(type = ConfigFilter.class))
    @At("public/patient_login")
    @Ok("re")
    @Fail("http:500")
    @POST
    public Object patientLogin(@Param("username") String username,
                               @Param("password") String password,
                               HttpSession session,
                               HttpServletRequest request,
                               HttpServletResponse response) {
        boolean isLogin = false;
        if (username == null || password == null || username.equals("") || password.equals("")) {
            //请求参数错误
            request.setAttribute("redirect_url", "patient_login.php");
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
                Patient patient = dao.fetch(Patient.class, Cnd.where("A_USERID", "=", user.getId()));
                if (patient != null) {
                    request.setAttribute("redirect_url", "main.php");
                    request.setAttribute("name", patient.getName());
                    session.setAttribute("patient", patient);
                    request.setAttribute("code", 0);
                    isLogin = true;
                } else {
                    request.setAttribute("code", -2);
                    isLogin = false;
                }
            } else {
                request.setAttribute("redirect_url", "patient_login.php");
                request.setAttribute("code", -2);
            }

        }
        if (isLogin) {
            return ">>:../patient/main.php";
        } else {
            return "jsp:public/patient_login";
        }
    }


    /**
     * 患者注册页面
     * */
    @Filters(@By(type = ConfigFilter.class))
    @At("public/signIn")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object signInPage(HttpServletRequest request) {

        request.setAttribute("code", 0);
        return "jsp:public/signIn";
    }

    /**
     * 患者注册
     * */
    @Filters(@By(type = ConfigFilter.class))
    @At("public/signIn")
    @Ok("re")
    @Fail("http:500")
    @POST
    public Object signIn(@Param("name") String name,
                         @Param("sex") String sex,
                         @Param("id_card") String idCard,
                         @Param("phone_num") String phoneNum,
                         @Param("password") String password,
                         @Param("check_code") String checkCode,
                         HttpServletRequest request,
                         HttpSession session) {
        if (idCard == null || idCard.equals("") || password == null || password.equals("")) {
            request.setAttribute("code", -1);//请求参数错误
            return "jsp:public/signIn";
        }
        Patient patient = new Patient();
        boolean isCreate = false;
        try {
            if (idCard.length() != 18) {
                request.setAttribute("code", -5);
                request.setAttribute("msg", "身份证号长度错误");
                return "jsp:public/signIn";
            }
            if (dao.fetch(Patient.class, Cnd.where("A_IDCARD", "=", idCard)) != null) {
                request.setAttribute("code", -6);
                request.setAttribute("msg", "您的身份证号已经注册！");
                return "jsp:public/signIn";
            }
            //TODO 如果需要验证码，在此处检测
            patient.setName(name);
            patient.setSex(sex);
            patient.setPhoneNum(phoneNum);
            patient.setIdCard(idCard);
            patient.setAddTime(new Date(System.currentTimeMillis()));
            dao.insert(patient);
            isCreate = true;
        } catch (Exception e) {
        }

        if (isCreate) {
            Patient p = dao.fetch(Patient.class, Cnd.where("A_IDCARD", "=", idCard));
            if (p == null) {
                //添加用户失败
                request.setAttribute("code", -3);
                return "jsp:public/signIn";
            } else {
                //生成用户名
                String username = idCard;
                User user = new User(p, username, password);
                dao.insert(user);
                user = dao.fetch(User.class, Cnd.where("id", "=", user.getId()));
                //将患者与User绑定
                patient.setUserId(user.getId() + "");
                dao.update(patient);
                session.setAttribute("patient", p);
                request.setAttribute("code", 0);
                request.setAttribute("username", username);
                request.setAttribute("redirect_url", "patient_login.php");
            }
        } else {
            request.setAttribute("code", -4);
        }
        return "jsp:public/signIn";
    }

    /**
     * 验证码
     * */
    @At("public/signIn")
    @Ok("json")
    @Fail("http:500")
    @Filters
    public Object getCheckCode(@Param("id_card") String idCard,
                               @Param("phone_num") String phoneNum,
                               HttpServletRequest request) {
        Map<String, Object> res = new HashMap<>();
        if (idCard == null || idCard.equals("") || phoneNum == null || phoneNum.equals("")) {
            res.put("code", -6);
            return res;
        }
        CheckCode checkCode = new CheckCode();
        checkCode.setContent("1234");
        checkCode.setStartTime(System.currentTimeMillis() + "");
        //过期时间 三十分钟之后
        checkCode.setEndTime(System.currentTimeMillis() + 1800000 + "");
        dao.insert(checkCode);
        return "str";
    }

    /**
     * 跳转页面
     * */
    @At("public/jump")
    @Ok("re")
    @Fail("http:500")
    @Filters
    public String jump(@Param("redirect_url") String redirectUrl, HttpServletRequest request) {
        request.setAttribute("redirect_url", redirectUrl);
        return "jsp:public/jump";
    }

    /**
     * 注销
     * */
    @At("public/logout")
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
        javax.servlet.http.Cookie cookie = new Cookie("ak", "hupeng");
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setMaxAge(365 * 24 * 3600);
        response.addCookie(cookie);
        session.removeAttribute("user");
        request.setAttribute("redirect_url", "patient_login.php");
        request.setAttribute("msg", "注销成功！");
        return "jsp:public/graph_jump";
    }
}