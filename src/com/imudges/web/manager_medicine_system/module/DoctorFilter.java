package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.Doctor;
import com.imudges.web.manager_medicine_system.bean.User;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.ActionContext;
import org.nutz.mvc.ActionFilter;
import org.nutz.mvc.View;
import org.nutz.mvc.view.ServerRedirectView;

import javax.servlet.http.Cookie;

/**
 * 医生过滤器
 */
@IocBean
public class DoctorFilter implements ActionFilter{
    @Inject
    Dao dao;

    @Override
    public View match(ActionContext actionContext) {
        //获取User对象，如果获取失败，则说明用户未登录，跳转到login.php
        User user = (User) actionContext.getRequest().getSession().getAttribute("user");
        if (user == null){
            return new ServerRedirectView("/public/jump.php?redirect_url=doctor_login.php");
        }

        String ak = null;
        Cookie[] cookies = actionContext.getRequest().getCookies();
        try {
            for(Cookie cookie : cookies){
                if("ak".equals(cookie.getName())){
                    ak = cookie.getValue();
                }
            }
        }catch (Exception e){
            return new ServerRedirectView("/public/jump.php?redirect_url=doctor_login.php");
        }

        if(ak == null){
            //获取ak失败，返回登录页面
            return new ServerRedirectView("/public/jump.php?redirect_url=doctor_login.php");
        }
        //注册之后设置一个ak
        if(user.getAk() == null || user.getAk().equals("")){
            user.setAk(ak);
            return null;
        }

        //多端登录时，返回登录页面
        user = dao.fetch(User.class, Cnd.where("ak","=",ak));
        if(user == null){
            return new ServerRedirectView("/public/jump.php?redirect_url=doctor_login.php");
        }
        if(!user.getAk().equals(ak)){
            return new ServerRedirectView("/public/jump.php?redirect_url=doctor_login.php");
        }
        Doctor doctor = dao.fetch(Doctor.class,Cnd.where("userId","=",user.getId()));

        if(doctor == null){
            return new ServerRedirectView("/public/jump.php?redirect_url=doctor_login.php");
        }

        actionContext.getRequest().getSession().setAttribute("doctor",doctor);
        actionContext.getRequest().getSession().setAttribute("name",doctor.getName());

//        switch (doctor.getPosition()){
//            case "0":
//                return new ServerRedirectView("/doctor/jump.php?redirect_url=windows.php");
//
//            case "1":
//                return new ServerRedirectView("/doctor/jump.php?redirect_url=diagnose.php");
//
//            case "2":
//                return new ServerRedirectView("/doctor/jump.php?redirect_url=collection.php");
//        }


        return null;
    }
}
