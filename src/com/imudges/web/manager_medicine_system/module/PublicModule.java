package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.Doctor;
import com.imudges.web.manager_medicine_system.bean.Patient;
import com.imudges.web.manager_medicine_system.bean.User;
import com.imudges.web.manager_medicine_system.util.ConfigReader;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;


@IocBean
public class PublicModule {
    @Inject
    Dao dao;

    @At("public/login")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object loginPage(){


        return "jsp:public/login";
    }

    @At("public/login")
    @Ok("re")
    @Fail("http:500")
    public Object login(@Param("username") String username,
                        @Param("password") String password,
                        HttpSession session,
                        HttpServletRequest request){
        if(username == null || password == null || username.equals("") || password.equals("")){
            //请求参数错误
            request.setAttribute("redirect_url","404.php");
        } else {
            //请求参数正确
            User user = dao.fetch(User.class, Cnd.where("username","=",username).and("password","=",password));
            if(user!=null){
                switch (user.getType()){
                    case "0":
                        //TODO 管理员逻辑
                        break;
                    case "1":
                        //医生
                        Doctor doctor = dao.fetch(Doctor.class,Cnd.where("id","=",user.getCustomerId()));
                        if(doctor!=null){
//                            result.put("code",0);
//                            result.put("ak",doctor.getAk());
//                            result.put("name",doctor.getName());
                        } else {

                        }
                        break;
                    case "2":
                        //患者
                        Patient patient = dao.fetch(Patient.class,Cnd.where("id","=",user.getCustomerId()));
                        if(patient!=null){
//                            result.put("code",0);
//                            result.put("ak",patient.getAk());
//                            result.put("name",patient.getName());
                            session.setAttribute("patient",patient);
                            request.setAttribute("redirect_url","main.php");
                        } else {

                        }
                        break;
                }
            } else {
//                result.put("code",-2);
            }

        }
//        result.put("msg",new ConfigReader().read(result.get("code").toString()));
        return "jsp:public/jump";
    }

    @At("public/main")
    @Ok("re")
    @Fail("http:500")
    public Object main(HttpServletRequest request,
                       HttpSession session){
        /**
         * 主界面只有患者可以访问
         * */
        Patient patient = (Patient) session.getAttribute("patient");
        request.setAttribute("patient",patient);
        return "jsp:public/main";
    }

}
