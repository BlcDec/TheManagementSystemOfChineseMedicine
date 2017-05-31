package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.AppointmentOrRegistration;
import com.imudges.web.manager_medicine_system.bean.Patient;
import com.imudges.web.manager_medicine_system.bean.User;
import com.imudges.web.manager_medicine_system.util.Toolkit;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 患者主要逻辑
 */

@IocBean
@Filters({@By(type = PatientFilter.class, args = {"ioc:patientFilter"})})
public class PatientModule {
    @Inject
    private Dao dao;


    @At("patient/main")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object mainPage(HttpServletRequest request,
                           HttpSession session,
                           @Param("year") String year) {

        Patient patient = (Patient) session.getAttribute("patient");

        if(year == null || year.equals("")){
            year = "";
            for (int i = 6; i <= 9; i++) {
                year += patient.getIdCard().charAt(i) + "";
            }
        }

        request.setAttribute("name", patient.getName());
        request.setAttribute("year", (Integer.parseInt(Toolkit.getCurrentYear()) - Integer.parseInt(year)) + "");
        request.setAttribute("patient", patient);
        request.setAttribute("msg","ok");
        return "jsp:patient/main";
    }

    @At("patient/upload_appointment")
    @Ok("json")
    @Fail("http:500")
    public Object uploadAppointment(HttpServletRequest request,
                                    HttpSession session,
                                    @Param("name") String name,
                                    @Param("sex") String sex,
                                    @Param("year") String year,
                                    @Param("phone_num") String phoneNum,
                                    @Param("appear_time") String appearTime,
                                    @Param("department") String department){
        Patient patient = (Patient) session.getAttribute("patient");
        Map<String, Object> map = new HashMap<>();
        //一个用户不可多次预约
        if(dao.count(AppointmentOrRegistration.class, Cnd.where("patientIdCard","=",patient.getIdCard()).and("registrationFeeState","=","0"))!=0){
            map.put("code",-7);
            map.put("msg","预约失败，每个用户只可预约一次");
            request.setAttribute("patient", patient);
            request.setAttribute("name", patient.getName());
            return map;
        }
        AppointmentOrRegistration appointmentOrRegistration = new AppointmentOrRegistration(true);
        appointmentOrRegistration.setAddTime(new Date(System.currentTimeMillis()));
        appointmentOrRegistration.setAppearTime(appearTime);
        appointmentOrRegistration.setDepartment(department);
        appointmentOrRegistration.setPatientIdCard(patient.getIdCard());
        appointmentOrRegistration.setRegistrationFeeState(0);//未支付挂号费
        dao.insert(appointmentOrRegistration);

        map.put("code",0);
        map.put("msg","预约成功");
        request.setAttribute("patient", patient);
        request.setAttribute("name", patient.getName());
        return map;
    }

    @At("patient/user")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object userPage(HttpServletRequest request,
                           HttpSession session) {
        Patient patient = (Patient) session.getAttribute("patient");
        //已生效的预约
        List<AppointmentOrRegistration> lists = dao.query(AppointmentOrRegistration.class,
                Cnd.where("patientIdCard","=",patient.getIdCard())
                        .and("registrationFeeState","=","1")
                        .and("isAppointment","=",true));
        //已生效的挂号信息
        List<AppointmentOrRegistration> registrationList = dao.query(AppointmentOrRegistration.class,
                Cnd.where("patientIdCard","=",patient.getIdCard())
                        .and("registrationFeeState","=","1")
                        .and("isAppointment","=",false));

        //正在进行中的预约
        List<AppointmentOrRegistration> list = dao.query(AppointmentOrRegistration.class,
                Cnd.where("patientIdCard","=",patient.getIdCard())
                        .and("registrationFeeState","=","0")
                        .and("isAppointment","=",true));


        request.setAttribute("user",session.getAttribute("user"));
        request.setAttribute("name", patient.getName());
        request.setAttribute("patient", patient);
        request.setAttribute("effective_registration",registrationList.size());
        request.setAttribute("effective_appointment",lists.size());
        request.setAttribute("underway_appointment",list.size());
        return "jsp:patient/user";
    }

    /**
     * 正在进行的预约信息
     * */
    @At("patient/underway_appointment")
    @Ok("re")
    @Fail("http:500")
    public Object underwayAppointment(HttpServletRequest request,
                                      HttpSession session){
        Patient patient = (Patient) session.getAttribute("patient");
        User user = (User) session.getAttribute("user");
        List<AppointmentOrRegistration> list = dao.query(AppointmentOrRegistration.class,
                Cnd.where("patientIdCard","=",patient.getIdCard())
                        .and("registrationFeeState","=","0")
                        .and("isAppointment","=",true));
        request.setAttribute("code",0);
        request.setAttribute("name", patient.getName());
        request.setAttribute("msg","pageOk");
        request.setAttribute("underway_appointment",list);
        return "jsp:patient/underway_appointment";
    }

    /**
     * 已生效的预约信息页面
     * */
    @At("patient/effect_appointment")
    @Ok("re")
    @Fail("http:500")
    public Object effectAppointment(HttpServletRequest request,
                                      HttpSession session){
        Patient patient = (Patient) session.getAttribute("patient");
        User user = (User) session.getAttribute("user");
        List<AppointmentOrRegistration> list = dao.query(AppointmentOrRegistration.class,
                Cnd.where("patientIdCard","=",patient.getIdCard())
                        .and("registrationFeeState","=","1")
                        .and("isAppointment","=",true));
        request.setAttribute("code",0);
        request.setAttribute("msg","pageOk");
        request.setAttribute("name", patient.getName());
        request.setAttribute("effect_appointment",list);
        return "jsp:patient/effect_appointment";
    }


    /**
     * 在线支付挂号费
     * */
    @At("patient/pay_for_appointment")
    @Ok("json")
    @Fail("http:50")
    public Object payForAppointment(@Param("appointment_id")String appointmentId,
                                    HttpServletRequest request,
                                    HttpSession session){
        Patient patient = (Patient) session.getAttribute("patient");
        Map<String ,String >res = new HashMap<>();
        AppointmentOrRegistration appointmentOrRegistration = dao.fetch(AppointmentOrRegistration.class
                ,Cnd.where("id","=",appointmentId)
                        .and("patientIdCard","=",patient.getIdCard()));
        if(appointmentOrRegistration!=null){
            appointmentOrRegistration.setRegistrationFeeState(1);
            appointmentOrRegistration.setPayForTime(new Date(System.currentTimeMillis()));
            appointmentOrRegistration.setAppointment(true);
            dao.update(appointmentOrRegistration);
            res.put("code","0");
        } else {
            res.put("code","-8");
        }
        return res;
    }

    @At("patient/search")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object searchPage(HttpServletRequest request,
                             HttpSession session) {

        Patient patient = (Patient) session.getAttribute("patient");
        request.setAttribute("name", patient.getName());
        request.setAttribute("patient", patient);
        return "jsp:patient/search";
    }

    /**
     * 已生效的挂号信息
     * */
    @At("patient/effect_registration")
    @Ok("re")
    @Fail("http:500")
    public Object effectRegistration(HttpServletRequest request,
                                    HttpSession session){
        Patient patient = (Patient) session.getAttribute("patient");
        User user = (User) session.getAttribute("user");
        List<AppointmentOrRegistration> list = dao.query(AppointmentOrRegistration.class,
                Cnd.where("patientIdCard","=",patient.getIdCard())
                        .and("registrationFeeState","=","1")
                        .and("isAppointment","=",false));
        request.setAttribute("code",0);
        request.setAttribute("msg","pageOk");
        request.setAttribute("name", patient.getName());
        request.setAttribute("effect_registration",list);
        return "jsp:patient/effect_registration";
    }
}
