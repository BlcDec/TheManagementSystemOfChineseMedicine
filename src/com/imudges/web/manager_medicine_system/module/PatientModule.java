package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.AppointmentOrRegistration;
import com.imudges.web.manager_medicine_system.bean.Patient;
import com.imudges.web.manager_medicine_system.util.Toolkit;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * Created by yangyang on 2017/5/18.
 */

@IocBean
@Filters({@By(type = AuthorityFilter.class, args = {"ioc:authorityFilter"})})
public class PatientModule {
    @Inject
    private Dao dao;


    @At("patient/main")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object mainPage(HttpServletRequest request,
                           HttpSession session,
                           @Param("name") String name,
                           @Param("sex") String sex,
                           @Param("year") String year,
                           @Param("phone_num") String phoneNum,
                           @Param("appear_time") String appearTime,
                           @Param("department") String department) {

        Patient patient = (Patient) session.getAttribute("patient");

        if(year == null || year.equals("")){
            year = "";
            for (int i = 6; i <= 9; i++) {
                year += patient.getIdCard().charAt(i) + "";
            }
        }
        if(department != null && !department.equals("")){
            //进入if表示从在线预约提交来的数据

            //一个用户不可多次预约
            if(dao.count(AppointmentOrRegistration.class, Cnd.where("patientIdCard","=",patient.getIdCard()))!=0){
                request.setAttribute("code",-7);
                request.setAttribute("msg","预约失败，每个用户只可预约一次");
                request.setAttribute("patient", patient);
                request.setAttribute("name", patient.getName());
                return "jsp:patient/main";
            }
            AppointmentOrRegistration appointmentOrRegistration = new AppointmentOrRegistration(true);
            appointmentOrRegistration.setAddTime(new Date(System.currentTimeMillis()));
            appointmentOrRegistration.setAppearTime(appearTime);
            appointmentOrRegistration.setDepartment(department);
            appointmentOrRegistration.setPatientIdCard(patient.getIdCard());
            appointmentOrRegistration.setRegistrationFeeState(0);//未支付挂号费
            dao.insert(appointmentOrRegistration);
            request.setAttribute("code",0);
            request.setAttribute("msg","预约成功");
            request.setAttribute("patient", patient);
            request.setAttribute("name", patient.getName());
            return "jsp:patient/main";
        }

        request.setAttribute("name", patient.getName());
        request.setAttribute("year", (Integer.parseInt(Toolkit.getCurrentYear()) - Integer.parseInt(year)) + "");
        request.setAttribute("patient", patient);
        request.setAttribute("msg","ok");
        return "jsp:patient/main";
    }


    @At("patient/user")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object userPage(HttpServletRequest request,
                           HttpSession session) {
        Patient patient = (Patient) session.getAttribute("patient");
        request.setAttribute("name", patient.getName());
        request.setAttribute("patient", patient);
        return "jsp:patient/user";
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
}
