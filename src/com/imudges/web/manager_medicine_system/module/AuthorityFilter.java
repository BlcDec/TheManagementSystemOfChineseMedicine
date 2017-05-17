package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.Doctor;
import com.imudges.web.manager_medicine_system.bean.Patient;
import com.imudges.web.manager_medicine_system.bean.User;
import com.imudges.web.manager_medicine_system.util.Toolkit;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.ActionContext;
import org.nutz.mvc.ActionFilter;
import org.nutz.mvc.View;
import org.nutz.mvc.view.ServerRedirectView;

import javax.print.Doc;
import javax.servlet.http.Cookie;

/**
 * 主过滤器
 */
@IocBean
public class AuthorityFilter implements ActionFilter{
    @Inject
    Dao dao;

    @Override
    public View match(ActionContext actionContext) {
//        String ak = null;
//        Cookie[] cookies = actionContext.getRequest().getCookies();
//        try {
//            for(Cookie cookie : cookies){
//                if("ak".equals(cookie.getName())){
//                    ak = cookie.getValue();
//                }
//            }
//        }catch (Exception e){
//            return new ServerRedirectView("/public/login.php?redirect_url=" + actionContext.getRequest().getRequestURI());
//        }
//
//        if (ak == null){
//            return new ServerRedirectView("/public/login.php?redirect_url=" + actionContext.getRequest().getRequestURI());
//        }
//        User user = dao.fetch(User.class, Cnd.where("ak","=",ak));
//        if (user == null){
//            return new ServerRedirectView("/public/login.php?redirect_url=" + actionContext.getRequest().getRequestURI());
//        }
//
//        //Session 中写入user对象以及patient对象
//        actionContext.getRequest().getSession().setAttribute("user",user);
//        if(user.getType().equals("1")){
//            Doctor doctor = dao.fetch(Doctor.class,Cnd.where("id","=",user.getCustomerId()));
//            actionContext.getRequest().getSession().setAttribute("doctor",doctor);
//        }
//        if(user.getType().equals("2")){
//            Patient patient = dao.fetch(Patient.class,Cnd.where("id","=",user.getCustomerId()));
//            actionContext.getRequest().getSession().setAttribute("doctor",patient);
//        }

        //Request中写入版权信息
        actionContext.getRequest().setAttribute("system_name", Toolkit.getSystemName());
        return null;
    }
}
