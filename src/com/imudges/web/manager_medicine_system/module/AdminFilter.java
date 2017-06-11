package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.Admin;
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

/**
 * 管理员过滤器
 */
@IocBean
public class AdminFilter implements ActionFilter {
    @Inject
    Dao dao;

    @Override
    public View match(ActionContext actionContext) {
        User user = (User) actionContext.getRequest().getSession().getAttribute("user");
        if (user == null){
            return new ServerRedirectView("/public/jump.php?redirect_url=admin_login.php");
        }

        Admin admin = dao.fetch(Admin.class, Cnd.where("userId","=",user.getId() + ""));
        if(admin == null){
            return new ServerRedirectView("/public/jump.php?redirect_url=admin_login.php");
        }
        String adminName = Toolkit.getAdminName();
        actionContext.getRequest().setAttribute("admin_name",adminName);
        actionContext.getRequest().getSession().setAttribute("user",user);
        actionContext.getRequest().getSession().setAttribute("admin",admin);

        return null;
    }
}
