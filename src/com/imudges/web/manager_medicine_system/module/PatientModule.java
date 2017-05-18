package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.Patient;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by yangyang on 2017/5/18.
 */

@IocBean
@Filters({@By(type = AuthorityFilter.class, args = {"ioc:authorityFilter"})} )
public class PatientModule {
    @Inject
    private Dao dao;


    @At("patient/main")
    @Ok("re")
    @Fail("http:500")

    public Object main(HttpServletRequest request,
                       HttpSession session) {
        /**
         * 主界面只有患者可以访问
         * */
        Patient patient = (Patient) session.getAttribute("patient");
        request.setAttribute("name",patient.getName());
        request.setAttribute("patient", patient);
        return "jsp:patient/main";
    }
}
