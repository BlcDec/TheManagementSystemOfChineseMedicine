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
 * 主过滤器,验证用户的登录状态
 */
@IocBean
public class AuthorityFilter implements ActionFilter{
    @Inject
    Dao dao;

    @Override
    public View match(ActionContext actionContext) {
        //获取User对象，如果获取失败，则说明用户未登录，跳转到login.php
        User user = (User) actionContext.getRequest().getSession().getAttribute("user");
        if (user == null){
            return new ServerRedirectView("/public/jump.php?redirect_url=login.php");
        }
        return null;
    }
}
