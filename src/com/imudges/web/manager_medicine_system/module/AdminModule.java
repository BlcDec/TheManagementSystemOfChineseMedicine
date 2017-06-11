package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.Admin;
import com.imudges.web.manager_medicine_system.bean.Doctor;
import com.imudges.web.manager_medicine_system.bean.User;
import com.imudges.web.manager_medicine_system.util.Toolkit;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.*;

import javax.print.Doc;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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
     */
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
     */
    @Filters(@By(type = ConfigFilter.class))//登录是不需要过滤器的
    @At("public/admin_login")
    @Ok("re")
    @Fail("http:500")
    public Object login(@Param("username") String username,
                        @Param("password") String password,
                        HttpSession session,
                        HttpServletRequest request) {
        boolean isLogin = false;
        if (username == null || password == null || username.equals("") || password.equals("")) {
            request.setAttribute("code", -1);
            request.setAttribute("msg", "请求参数错误");
            return "jsp:public/admin_login";
        }

        User user = dao.fetch(User.class, Cnd.where("username", "=", username).and("password", "=", password));
        if (user == null) {
            request.setAttribute("code", -2);
            request.setAttribute("msg", "用户名或密码错误");
            return "jsp:public/admin_login";
        }

        Admin admin = dao.fetch(Admin.class, Cnd.where("userId", "=", user.getId()));
        if (admin != null) {
            session.setAttribute("user", user);
            isLogin = true;
        } else {
            isLogin = false;
        }
        if (isLogin) {
            return ">>:../admin/main.php";
        } else {
            return "jsp:public/admin_login";
        }
    }

    /**
     * 主界面
     */
    @At("admin/main")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object mainPage() {

        return "jsp:admin/main";
    }

    //以下为用户管理

    /**
     * 添加医生页面
     */
    @At("admin/add_doctor")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object addDoctorPage(HttpSession session,
                                HttpServletRequest request) {

        return "jsp:admin/add_doctor";
    }

    /**
     * 添加医生
     */
    @At("admin/add_doctor")
    @Ok("json")
    @Fail("http:500")
    @POST
    public Object addDoctorLogic(@Param("name") String name,
                                 @Param("sex") String sex,
                                 @Param("id_card") String idCard,
                                 @Param("salary") String salary,
                                 @Param("position") String position,
                                 @Param("department") String department,
                                 @Param("degree") String degree,
                                 HttpSession session,
                                 HttpServletRequest request) {
        Map<String, String> res = new HashMap<>();
        if (name == null ||
                sex == null ||
                idCard == null ||
                salary == null ||
                position == null ||
                department == null ||
                degree == null ||
                name.equals("")||
                session.equals("")||
                idCard.equals("")||
                salary.equals("")||
                position.equals("")||
                department.equals("")||
                degree.equals("")) {
            res.put("code","-1");
            res.put("msg","请求与参数错误");
            return res;
        }
        //查重
        if(dao.count(User.class,Cnd.where("A_USRNAME","=",idCard)) != 0){
            res.put("code","-14");
            res.put("msg","此用户已存在");
            return res;
        }

        User user = new User();
        user.setUsername(idCard);
        user.setPassword(Toolkit.getIdCardLastSixNum(idCard));
        user.setType("1");
        dao.insert(user);

        Doctor doctor = new Doctor();
        switch (department){
            case "内分泌科":
                doctor.setDepartmentId("1");
                break;
            case "精神科":
                doctor.setDepartmentId("2");
                break;
            case "老年科":
                doctor.setDepartmentId("3");
                break;
            case "儿童科":
                doctor.setDepartmentId("4");
                break;
            case "牙科":
                doctor.setDepartmentId("5");
                break;
            case "呼吸内科":
                doctor.setDepartmentId("6");
                break;
            default:
                res.put("code","-1");
                res.put("msg","请求参数错误");
                return res;
        }
        switch (position){
            case "挂号":
                doctor.setPosition("0");
                break;
            case "诊断":
                doctor.setPosition("1");
                break;
            case "收款":
                doctor.setPosition("2");
                break;
            default:
                res.put("code","-1");
                res.put("msg","请求参数错误");
                return res;
        }
        doctor.setUsername(idCard);
        doctor.setPassword(Toolkit.getIdCardLastSixNum(idCard));
        doctor.setName(name);
        doctor.setSex(sex);
        doctor.setUserId(user.getId() + "");
        doctor.setSalary(Double.parseDouble(salary));
        System.err.print(Double.parseDouble(salary));
        doctor.setAddTime(new Date(System.currentTimeMillis()));
        doctor.setDegree(degree);
        dao.insert(doctor);
        doctor.setNum(doctor.getId() + "");
        dao.update(doctor);
        res.put("code","0");
        res.put("msg","添加成功");
        return res;
    }

    /**
     * 删除医生页面
     * */
    @At("admin/delete_doctor")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object deleteDoctorPage(HttpSession session,
                                HttpServletRequest request) {

        return "jsp:admin/delete_doctor";
    }
}
