package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.Admin;
import com.imudges.web.manager_medicine_system.bean.User;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 管理员
 */
@IocBean
@Filters({@By(type = AdminFilter.class, args = {"ioc:adminFilter"})})
public class AdminModule {
    @Inject
    private Dao dao;

    /**
     * 管理员登录GET
     * */
    @Filters(@By(type = ConfigFilter.class))//登录页面是不需要过滤器的
    @At("public/admin_login")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object adminoginPage(HttpServletRequest request,
                                @Param("redirect_url") String redirectUrl) {

        request.setAttribute("code", 0);
        return "jsp:public/admin_login";
    }

    /**
     * 管理员登录逻辑
     * */
    @Filters(@By(type = ConfigFilter.class))//登录是不需要过滤器的
    @At("public/admin_login")
    @Ok("re")
    @Fail("http:500")
    public Object login(@Param("username") String username,
                        @Param("password") String password,
                        HttpSession session,
                        HttpServletRequest request){
        boolean isLogin = false;
        if(username == null || password == null || username.equals("") || password.equals("")){
            request.setAttribute("code",-1);
            request.setAttribute("msg","请求参数错误");
            return "jsp:public/admin_login";
        }

        User user = dao.fetch(User.class,Cnd.where("username","=",username).and("password","=",password));
        if(user == null){
            request.setAttribute("code",-2);
            request.setAttribute("msg","用户名或密码错误");
            return "jsp:public/admin_login";
        }

        Admin admin = dao.fetch(Admin.class, Cnd.where("userId","=",user.getId()));
        if(admin!=null){
            session.setAttribute("user",user);
            isLogin = true;
        } else {
            isLogin = false;
        }
        if(isLogin){
            return ">>:../admin/main.php";
        } else {
            return "jsp:public/admin_login";
        }
    }

    /**
     * 主界面
     * */
    @At("admin/main")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object mainPage(){

        return "jsp:admin/main";
    }
}
