package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.Doctor;
import com.imudges.web.manager_medicine_system.bean.Patient;
import com.imudges.web.manager_medicine_system.bean.User;
import com.imudges.web.manager_medicine_system.util.Config;
import com.imudges.web.manager_medicine_system.util.ConfigReader;
import com.imudges.web.manager_medicine_system.util.Toolkit;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.*;
import sun.misc.Request;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


@IocBean
@Filters(@By(type = AuthorityFilter.class, args = {"ioc:authorityFilter"}))
public class PublicModule {
    @Inject
    Dao dao;

    @Filters(@By(type = ConfigFilter.class))
    @At("public/login")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object loginPage(HttpServletRequest request,
                            @Param("redirect_url") String redirectUrl) {

        request.setAttribute("code", 0);
        return "jsp:public/login";
    }

    @Filters(@By(type = ConfigFilter.class))
    @At("public/login")
    @Ok("re")
    @Fail("http:500")
    @POST
    public Object login(@Param("username") String username,
                        @Param("password") String password,
                        HttpSession session,
                        HttpServletRequest request) {
        boolean isLogin = false;
        if (username == null || password == null || username.equals("") || password.equals("")) {
            //请求参数错误
            request.setAttribute("redirect_url", "login.php");
            request.setAttribute("code", -1);
        } else {
            //请求参数正确
            User user = dao.fetch(User.class, Cnd.where("username", "=", username).and("password", "=", password));
            if (user != null) {
                //登陆成功时向Sessionz中写入user对象
                session.setAttribute("user", user);
                switch (user.getType()) {
                    case "0":

                        break;
                    case "1":
                        //医生
                        Doctor doctor = dao.fetch(Doctor.class, Cnd.where("A_USERID", "=", user.getId()));
                        if (doctor != null) {
//                            result.put("code",0);
//                            result.put("ak",doctor.getAk());
//                            result.put("name",doctor.getName());
                            isLogin = true;
                        } else {
                            isLogin = false;
                        }
                        break;
                    case "2":
                        //患者

                        Patient patient = dao.fetch(Patient.class, Cnd.where("A_USERID", "=", user.getId()));
                        if (patient != null) {
                            request.setAttribute("redirect_url", "main.php");
                            request.setAttribute("name",patient.getName());
                            session.setAttribute("patient",patient);
                            request.setAttribute("code", 0);
                            isLogin = true;
                        } else {
                            isLogin = false;
                        }
                        break;
                }
            } else {
                request.setAttribute("redirect_url", "login.php");
                request.setAttribute("code", -2);
            }

        }
        if (isLogin) {
            return ">>:../patient/main.php";
        } else {
            return "jsp:public/login";
        }
    }

    @Filters(@By(type = ConfigFilter.class))
    @At("public/signIn")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object signInPage(HttpServletRequest request) {

        request.setAttribute("code", 0);
        return "jsp:public/signIn";
    }

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
                request.setAttribute("msg","身份证号长度错误");
                return "jsp:public/signIn";
            }
            if (dao.fetch(Patient.class, Cnd.where("A_IDCARD", "=", idCard)) != null) {
                request.setAttribute("code",-6);
                request.setAttribute("msg","您的身份证号已经注册！");
                return "jsp:public/signIn";
            }
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
                //生成ak
                String ak = Toolkit.getAccessKey();
                User user = new User(p, username, password, ak);
                dao.insert(user);
                user = dao.fetch(User.class,Cnd.where("id","=",user.getId()));
                patient.setUserId(user.getId() + "");
                session.setAttribute("patient",p);
                request.setAttribute("code", 0);
                request.setAttribute("username", username);
                request.setAttribute("redirect_url", "login.php");
            }
        } else {
            request.setAttribute("code", -4);
        }
        return "jsp:public/signIn";
    }

    @At("public/jump")
    @Ok("re")
    @Fail("http:500")
    @Filters
    public String jump(@Param("redirect_url")String redirectUrl, HttpServletRequest request){
        request.setAttribute("redirect_url",redirectUrl);
        return "jsp:public/jump";
    }
}
