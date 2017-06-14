package com.imudges.web.manager_medicine_system.module;

import com.imudges.web.manager_medicine_system.bean.*;
import com.imudges.web.manager_medicine_system.util.MD5;
import com.imudges.web.manager_medicine_system.util.Toolkit;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.dao.pager.Pager;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.*;

import javax.print.Doc;
import javax.servlet.http.*;
import java.util.*;

/**
 * 医生的主要逻辑
 */
@IocBean
@Filters({@By(type = DoctorFilter.class, args = {"ioc:doctorFilter"})})
public class DoctorModule {
    @Inject
    Dao dao;

    /**
     * 医生登录GET
     */
    @Filters(@By(type = ConfigFilter.class))
    @At("public/doctor_login")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object doctorLoginPage(@Param("redirect_url") String redirectUrl,
                                  HttpServletRequest request) {

        request.setAttribute("code", 0);
        return "jsp:public/doctor_login";
    }

    @Filters(@By(type = ConfigFilter.class))
    @At("public/doctor_login")
    @Ok("re")
    @Fail("http:500")
    @POST
    public Object doctorLogin(@Param("username") String username,
                              @Param("password") String password,
                              @Param("redirect_url") String redirectUrl,
                              HttpSession session,
                              HttpServletRequest request,
                              HttpServletResponse response) {
        doctorLoginPage(redirectUrl, request);
        boolean isLogin = false;
        if (username == null || password == null || username.equals("") || password.equals("")) {
            //请求参数错误
            request.setAttribute("redirect_url", "doctor_login.php");
            request.setAttribute("code", -1);
        } else {
            //请求参数正确
            User user = dao.fetch(User.class, Cnd.where("username", "=", username).and("password", "=", password));
            if (user != null) {
                //登陆成功时向Sessionz中写入user对象
                session.setAttribute("user", user);
                //设置Cookie
                String ak = MD5.encryptTimeStamp(System.currentTimeMillis() + "");
                javax.servlet.http.Cookie cookie = new javax.servlet.http.Cookie("ak", ak);
                cookie.setMaxAge(365 * 24 * 3600);//时间一年
                cookie.setPath("/");
                cookie.setHttpOnly(true);
                response.addCookie(cookie);
                user.setAk(ak);
                dao.update(user);
                Doctor doctor = dao.fetch(Doctor.class, Cnd.where("A_USERID", "=", user.getId()));
                if (doctor != null) {
                    request.setAttribute("redirect_url", Toolkit.getDoctorUrl(doctor));
                    request.setAttribute("name", doctor.getName());
                    session.setAttribute("doctor", doctor);
                    request.setAttribute("code", 0);
                    isLogin = true;
                } else {
                    isLogin = false;
                }
            } else {
                request.setAttribute("redirect_url", "doctor_login.php");
                request.setAttribute("code", -2);
            }

        }
        if (isLogin) {
            String url = Toolkit.getDoctorUrl((Doctor) session.getAttribute("doctor"));//返回不同医生的界面
            String res = ">>:../doctor/" + url;
            return res;
        } else {
            return "jsp:public/doctor_login";
        }
    }

    @At("doctor/windows")
    @Ok("re")
    @Fail("http:500")
    public Object windows(HttpServletRequest request,
                          HttpSession session) {
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");

        //限制不同医生的窗口
        switch (doctor.getPosition()) {
            //诊断
            case "1":
                request.setAttribute("redirect_url", "diagnose.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
            //收费
            case "2":
                request.setAttribute("redirect_url", "collection.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
        }
        request.setAttribute("name", doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/windows";
    }

    /**
     * 注销
     */
    @At("doctor/logout")
    @Ok("re")
    @Fail("http:500")
    @Filters
    public String logout(HttpServletRequest request,
                         HttpServletResponse response,
                         HttpSession session) {
        //清除用户的AK信息
        User user = (User) session.getAttribute("user");
        try {
            user.setAk("");
            dao.update(user);
            String s = request.getContextPath();
        } catch (Exception e) {
        }
        javax.servlet.http.Cookie cookie = new javax.servlet.http.Cookie("ak", "hupeng");
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        cookie.setMaxAge(365 * 24 * 3600);
        response.addCookie(cookie);
        session.removeAttribute("user");
        request.setAttribute("redirect_url", "../public/doctor_login.php");
        request.setAttribute("msg", "注销成功！");
        return "jsp:public/graph_jump";
    }

    /**
     * 诊断窗口
     */
    @At("doctor/diagnose")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object diagnosePage(HttpServletRequest request,
                               HttpSession session) {
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        //限制不同医生的窗口
        switch (doctor.getPosition()) {
            //挂号
            case "0":
                request.setAttribute("redirect_url", "windows.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
            //收费
            case "2":
                request.setAttribute("redirect_url", "collection.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
        }
        request.setAttribute("name", doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/diagnose";
    }

    /**
     * 收费窗口
     */
    @At("doctor/collection")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object collectionPage(HttpServletRequest request,
                                 HttpSession session) {
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        //限制不同医生的窗口
        switch (doctor.getPosition()) {
            //挂号
            case "0":
                request.setAttribute("redirect_url", "windows.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
            //诊断
            case "1":
                request.setAttribute("redirect_url", "diagnose.php");
                request.setAttribute("msg", "对不起，您的身份权限不足！正在跳转您可访问的页面...");
                return "jsp:doctor/graph_jump";
        }
        request.setAttribute("name", doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/collection";
    }

    /**
     * 跳转界面
     */
    @At("doctor/jump")
    @Ok("re")
    @Fail("http:500")
    @Filters
    public String jump(@Param("redirect_url") String redirectUrl, HttpServletRequest request) {
        request.setAttribute("redirect_url", redirectUrl);
        return "jsp:doctor/jump";
    }


    @At("doctor/add_registration")
    @Ok("re")
    @Fail("http:500")
    public Object addRegistrationPage(HttpServletRequest request,
                                      HttpSession session) {
        User user = (User) request.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        request.setAttribute("name", doctor.getName());
        request.setAttribute("code", 0);
        return "jsp:doctor/add_registration";
    }

    /**
     * 现场患者挂号，现场已缴纳挂号费
     */
    @At("doctor/add_registration_msg")
    @Ok("json")
    @Fail("http:500")
    public Object addRegistration(HttpServletRequest request,
                                  HttpSession session,
                                  @Param("name") String name,
                                  @Param("sex") String sex,
                                  @Param("year") String year,
                                  @Param("phone_num") String phoneNum,
                                  @Param("appear_time") String appearTime,
                                  @Param("department") String department,
                                  @Param("id_card") String idCard) {
        Map<String, Object> map = new HashMap<>();
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        Patient patient = dao.fetch(Patient.class, Cnd.where("A_IDCARD", "=", idCard));
        if (patient == null) {
            map.put("code", -9);
            map.put("msg", "挂号失败，患者信息无效");
            request.setAttribute("doctor", patient);
            request.setAttribute("name", doctor.getName());
            return map;
        }

        //一个用户有未支付预约信息
        if (dao.count(AppointmentOrRegistration.class,
                Cnd.where("patientIdCard", "=",
                        patient.getIdCard())
                        .and("registrationFeeState", "=", "0")
                        .and("isAppointment", "=", true)) != 0) {
            map.put("code", -9);
            map.put("msg", "挂号失败，每个用户只可挂号一次");
            request.setAttribute("patient", patient);
            request.setAttribute("name", patient.getName());
            return map;
        }
        AppointmentOrRegistration appointmentOrRegistration = new AppointmentOrRegistration(true);
        appointmentOrRegistration.setAddTime(new Date(System.currentTimeMillis()));
        appointmentOrRegistration.setAppearTime(appearTime);
        appointmentOrRegistration.setDepartment(department);
        appointmentOrRegistration.setPatientIdCard(patient.getIdCard());
        appointmentOrRegistration.setRegistrationFeeState(1);//已经支付挂号费
        appointmentOrRegistration.setPayForTime(new Date(System.currentTimeMillis()));
        appointmentOrRegistration.setAppointment(false);//不是预约信息
        dao.insert(appointmentOrRegistration);

        map.put("code", 0);
        map.put("msg", "挂号成功");
        request.setAttribute("doctor", doctor);
        request.setAttribute("name", doctor.getName());
        return map;
    }

    /**
     * 缴纳预约患者的挂号费页面
     */
    @At("doctor/pay_appointment_fee")
    @Ok("re")
    @Fail("http:500")
    public Object payAppointmentFeePage(HttpServletRequest request,
                                        HttpSession session) {
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        request.setAttribute("name", doctor.getName());
        request.setAttribute("doctor", doctor);
        return "jsp:doctor/pay_appointment_fee";
    }

    /**
     * 缴纳预约患者的挂号费用
     */
    @At("doctor/commit_appointment_fee")
    @Ok("json")
    @Fail("http:500")
    public Object payAppointmentFee(@Param("id_card") String idCard,
                                    @Param("appointment_num") String appointmentNum,
                                    HttpSession session,
                                    HttpServletRequest request) {
        Map<String, Integer> res = new HashMap<>();
        if (idCard == null || appointmentNum == null || idCard.equals("") || appointmentNum.equals("")) {
            res.put("code", -1);
            return res;
        }
        Patient patient = dao.fetch(Patient.class, Cnd.where("A_IDCARD", "=", idCard));
        //患者不存在
        if (patient == null) {
            res.put("code", -5);
            return res;
        }
        //患者存在，但是没有预约信息或 为 非预约信息
        AppointmentOrRegistration appointmentOrRegistration = dao.fetch(AppointmentOrRegistration.class, Cnd.where("patientIdCard", "=", idCard)
                .and("id", "=", appointmentNum)
                .and("isAppointment", "=", true));
        if (appointmentOrRegistration == null) {
            res.put("code", -10);
            return res;
        }

        //此处所有信息都是正确的
        appointmentOrRegistration.setPayForTime(new Date(System.currentTimeMillis()));
        appointmentOrRegistration.setRegistrationFeeState(1);
        dao.update(appointmentOrRegistration);
        res.put("code", 0);
        return res;
    }

    /**
     * 医生个人信息页面（通用）
     */
    @At("doctor/user")
    @Ok("re")
    @Fail("http:500")
    public Object windowsUserPage(HttpServletRequest request,
                                  HttpSession session) {
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        User user = (User) session.getAttribute("user");

        request.setAttribute("user", user);
        request.setAttribute("doctor", doctor);
        request.setAttribute("name", doctor.getName());
        return "jsp:doctor/user";
    }

    /**
     * 修改密码（通用）
     */
    @At("doctor/modify_password")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object modifyPassword(HttpServletRequest request,
                                 HttpSession session) {
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        request.setAttribute("name", doctor.getName());
        request.setAttribute("doctor", doctor);
        return "jsp:doctor/modify_password";
    }

    /**
     * 开始诊断
     */
    @At("doctor/start_diagnose")
    @Ok("re")
    @Fail("http:500")
    public Object startDiagnose(HttpServletRequest request,
                                HttpSession session,
                                @Param("num") String num) {
        if(num !=null && !num.equals("")){
            session.setAttribute("num",num);
        }

        //num是患者挂号的号
        if(num == null || num.equals("")){
            num = (String) session.getAttribute("num");
        }

        if(num == null || num.equals("")){
            request.setAttribute("code", -1);
            request.setAttribute("msg", "请求参数错误");
            request.setAttribute("redirect_url", "diagnose.php");
            return "jsp:doctor/start_diagnose";
        }

        Doctor doctor = (Doctor) session.getAttribute("doctor");
        Department department = dao.fetch(Department.class, Cnd.where("id", "=", doctor.getDepartmentId()));
        request.setAttribute("name", doctor.getName());
        request.setAttribute("doctor", doctor);
        //patient_num是患者id
//        String patientNum = (String) session.getAttribute("patient_num");
//        /*if (session.getAttribute("patient_num") != null && !session.getAttribute("patient_num").equals("")) {
//            num = (String) session.getAttribute("patient_num");
//        }*/
//        //请求参数错误
//        if ((patientNum == null || patientNum.equals("")) && (num == null || num.equals(""))) {
//            request.setAttribute("code", -1);
//            request.setAttribute("msg", "请求参数错误");
//            request.setAttribute("redirect_url", "diagnose.php");
//            return "jsp:doctor/start_diagnose";
//        }

        //获取挂号号码失败
        AppointmentOrRegistration appointmentOrRegistration = dao.fetch(AppointmentOrRegistration.class, Cnd.where("id", "=", num));
        if (appointmentOrRegistration == null) {
            request.setAttribute("code", -11);
            request.setAttribute("msg", "号码输入错误");
            request.setAttribute("redirect_url", "diagnose.php");
            return "jsp:doctor/start_diagnose";
        }

        //判断是否缴纳挂号费
        if (appointmentOrRegistration.getRegistrationFeeState() == 0) {
            request.setAttribute("code", -12);
            request.setAttribute("msg", "该患者未缴纳挂号费！");
            request.setAttribute("redirect_url", "diagnose.php");
            return "jsp:doctor/start_diagnose";
        }

        //判断是否为本科室病人
        if (!appointmentOrRegistration.getDepartment().equals(department.getDepartmentName())) {
            request.setAttribute("code", -13);
            request.setAttribute("msg", "该患者挂号科室不是本科室");
            request.setAttribute("redirect_url", "diagnose.php");
            return "jsp:doctor/start_diagnose";
        }

        //成功
        Patient patient = dao.fetch(Patient.class, Cnd.where("A_IDCARD", "=", appointmentOrRegistration.getPatientIdCard()));
        session.setAttribute("patient_num", patient.getId() + "");

        if (dao.count(Diagnosis.class, Cnd.where("patientIdCard", "=", patient.getIdCard())
                .and("status", "=", 1)) > 0) {
            request.setAttribute("is_commit_diagnose", true);
        } else {
            request.setAttribute("is_commit_diagnose", false);
        }


        request.setAttribute("year", Toolkit.getYear(patient.getIdCard()));
        request.setAttribute("appointment_or_registration", appointmentOrRegistration);
        request.setAttribute("patient", patient);
        request.setAttribute("code", 0);
        return "jsp:doctor/start_diagnose";
    }

    /**
     * 提交诊断书
     */
    @At("doctor/upload_diagnosis")
    @Ok("json")
    @Fail("http:500")
    public Object uploadDiagnosis(HttpServletRequest request,
                                  HttpSession session,
                                  @Param("name") String name,
                                  @Param("sex") String sex,
                                  @Param("year") String year,
                                  @Param("patient_msg") String patientMsg,
                                  @Param("appear_time") String appearTime,
                                  @Param("id_card") String idCard,
                                  @Param("summary") String summary) {
        User user = (User) session.getAttribute("user");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        String num = (String) session.getAttribute("patient_num");
        Map<String, Integer> res = new HashMap<>();
        if (idCard == null || patientMsg == null || idCard.equals("") || patientMsg.equals("") || num == null || num.equals("")) {
            res.put("code", -1);
            return res;
        }

        Diagnosis diagnosis = new Diagnosis();
        diagnosis.setAddTime(new Date(System.currentTimeMillis()));
        diagnosis.setPatientSummary(patientMsg);
        diagnosis.setDoctorSummary(summary);
        diagnosis.setDoctorIdCard(doctor.getUsername());
        Patient patient = dao.fetch(Patient.class, Cnd.where("A_IDCARD", "=", idCard));
        if (patient == null) {
            res.put("code", -5);
            return res;
        }
        diagnosis.setPatientIdCard(patient.getIdCard());
        //默认为不开，开药的话再改
        diagnosis.setGiveMedicineOrNot(false);
        diagnosis.setStatus(1);
        dao.insert(diagnosis);


        //储存病历
        MedicineHistory medicineHistory = new MedicineHistory();
        medicineHistory.setDoctorIdCard(doctor.getUsername());
        medicineHistory.setCreateTime(new Date(System.currentTimeMillis()));
        medicineHistory.setPatientIdCard(patient.getIdCard());
        medicineHistory.setPatientSummary(patientMsg);
        medicineHistory.setDoctorSummary(summary);
        dao.insert(medicineHistory);

        res.put("code", 0);
        return res;
    }

    @At("doctor/search_medicine")
    @Ok("json")
    @Fail("http:500")
    public Object searchMedicine(@Param("search") String search,
                                 HttpServletRequest request,
                                 HttpSession session) {
        Map<String, String> res = new HashMap<>();
        if (search == null || search.equals("")) {
            res.put("code", "-1");
            res.put("msg", "请求参数错误");
            return res;
        }


        res.put("code", "0");
        return res;
    }

    /**
     * 手动选择系统已有药方
     */
    @At("doctor/select_prescription")
    @Ok("re")
    @Fail("http:500")
    public Object selectPrescription(@Param("search_content") String searchContent,
                                     @Param("page") String pageStr,
                                     HttpSession session,
                                     HttpServletRequest request) {
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        Map<String, String> res = new HashMap<>();

        if (searchContent == null || searchContent.equals("")) {
//            res.put("code","-1");
//            res.put("msg","数据有误");
//            return res;
            searchContent = "";
        }

        //结果显示相关功能
        int page = 1;
        try {
            page = Integer.parseInt(pageStr);
        } catch (Exception e) {
        }
        //每页显示的内容
        int pageSize = Toolkit.getSearchMedicinePage();
        int resourceSize = 0;
        Pager pager = dao.createPager(page, pageSize);
        List<Medicine> medicineList = null;
        if (searchContent.equals("") || searchContent == null) {
            medicineList = dao.query(Medicine.class, Cnd.where("id", ">", "0"), pager);
            resourceSize = dao.count(Medicine.class, Cnd.where("id", ">", "0"));
        } else {
            medicineList = dao.query(Medicine.class, Cnd.where("id", ">", "0").and("name", "like", "%" + searchContent + "%"), pager);
            resourceSize = dao.count(Medicine.class, Cnd.where("id", ">", "0").and("name", "like", "%" + searchContent + "%"));
        }
        //储存展示给用户最终的号码
        List<Integer> pageList = new LinkedList<>();
        //插入当前页面
        pageList.add(page);
        //特殊情况
        if (medicineList.size() == 0) {
            request.setAttribute("page", page);
            request.setAttribute("pageCount", 1);
            request.setAttribute("pageList", pageList);
            request.setAttribute("code", 1);
            request.setAttribute("msg", "没有搜索到相关图书");
            return "jsp:doctor/select_prescription";
        }
        //得到当前的总页数
        int pageCount = (resourceSize + pageSize - 1) / pageSize;

        //特殊情况
        if (page > pageCount) {
            request.setAttribute("redirect_url", "select_prescription.php");
            request.setAttribute("msg", "此页面不存在");
            return "jsp:doctor/select_prescription";
        }

        //处理特殊情况，page>pageCount
        while (pageList.size() < 5) {
            //插入之前节点
            int firstNode = pageList.get(0);
            if (firstNode > 1) {
                pageList.add(0, firstNode - 1);
            }

            //插入之后节点
            int lastNode = pageList.get(pageList.size() - 1);
            if (lastNode < pageCount) {
                pageList.add(lastNode + 1);
            }

            //判断之前节点与之后节点是否存在，若都不存在，则退出循环
            firstNode = pageList.get(0);
            lastNode = pageList.get(pageList.size() - 1);
            if (firstNode == 1 && lastNode == pageCount) {
                break;
            }
        }
        //查询药方所含的详细药材信息 用map返回
        Map<String, List<Materials>> materialsMap = new HashMap<>();

        for (Medicine medicine : medicineList) {
            List<Materials> materials = new LinkedList<>();
            //药方所包含所有的药材 关系
            List<MedicineList> medicineLists = dao.query(MedicineList.class, Cnd.where("medicineId", "=", medicine.getId()));
            //每一味药材，加入到list里
            for (MedicineList medicineList1 : medicineLists) {
                Materials materials1 = dao.fetch(Materials.class, Cnd.where("id", "=", medicineList1.getMaterialsId()));
                materials.add(materials1);
            }
            //TODO 需要修改，需要修改显示的内容，即不能为id + 内容
            materialsMap.put(medicine.getId() + "", materials);
        }

        //把search信息写入request
        request.setAttribute("materials", materialsMap);
        request.setAttribute("search_content", searchContent);
        //页码信息写入前端
        request.setAttribute("page", page);
        request.setAttribute("pageCount", pageCount);
        request.setAttribute("pageList", pageList);
        request.setAttribute("code", 0);
        request.setAttribute("medicineList", medicineList);
        request.setAttribute("msg", "以下为搜索到的药方");

        return "jsp:doctor/select_prescription";

    }

    /**
     * 处理搜索药方逻辑
     */
    @At("doctor/search_content")
    @Ok("re")
    @Fail("http:500")
    public Object searchContent(@Param("search_content") String searchContent,
                                @Param("page") String pageStr,
                                HttpSession session,
                                HttpServletRequest request) {

//        Map<String,>
        //TODO
        return "re";
//        Doctor doctor = (Doctor) session.getAttribute("doctor");
//        Map<String, String > res = new HashMap<>();
//
//        if(searchContent == null || searchContent.equals("")){
////            res.put("code","-1");
////            res.put("msg","数据有误");
////            return res;
//            searchContent = "";
//        }
//
//        //结果显示相关功能
//        int page = 1;
//        try {
//            page = Integer.parseInt(pageStr);
//        } catch (Exception e){}
//        //每页显示的内容
//        int pageSize = Toolkit.getSearchMedicinePage();
//        int resourceSize = 0;
//        Pager pager = dao.createPager(page,pageSize);
//        List<Medicine> medicineList = null;
//        if(searchContent.equals("") || searchContent == null){
//            medicineList = dao.query(Medicine.class,Cnd.where("id",">","0"),pager);
//            resourceSize = dao.count(Medicine.class,Cnd.where("id",">","0"));
//        } else {
//            medicineList = dao.query(Medicine.class,Cnd.where("id",">","0").and("name","like","%" + searchContent + "%"),pager);
//            resourceSize = dao.count(Medicine.class,Cnd.where("id",">","0").and("name","like","%" + searchContent + "%"));
//        }
//        //储存展示给用户最终的号码
//        List<Integer> pageList = new LinkedList<>();
//        //插入当前页面
//        pageList.add(page);
//        //特殊情况
//        if(medicineList.size() == 0){
//            request.setAttribute("page",page);
//            request.setAttribute("pageCount" , 1);
//            request.setAttribute("pageList",pageList);
//            request.setAttribute("code",1);
//            request.setAttribute("msg","没有搜索到相关图书");
//            return "jsp:doctor/select_prescription";
//        }
//        //得到当前的总页数
//        int pageCount = (resourceSize + pageSize - 1) / pageSize;
//
//        //特殊情况
//        if(page > pageCount){
//            request.setAttribute("redirect_url","select_prescription.php");
//            request.setAttribute("msg","此页面不存在");
//            return "jsp:doctor/select_prescription";
//        }
//
//        //处理特殊情况，page>pageCount
//        while (pageList.size() < 5) {
//            //插入之前节点
//            int firstNode = pageList.get(0);
//            if (firstNode > 1) {
//                pageList.add(0, firstNode - 1);
//            }
//
//            //插入之后节点
//            int lastNode = pageList.get(pageList.size() - 1);
//            if (lastNode < pageCount) {
//                pageList.add(lastNode + 1);
//            }
//
//            //判断之前节点与之后节点是否存在，若都不存在，则退出循环
//            firstNode = pageList.get(0);
//            lastNode = pageList.get(pageList.size() - 1);
//            if (firstNode == 1 && lastNode == pageCount) {
//                break;
//            }
//        }
//        //把search信息写入request
//        request.setAttribute("search_content", searchContent);
//        //页码信息写入前端
//        request.setAttribute("page", page);
//        request.setAttribute("pageCount", pageCount);
//        request.setAttribute("pageList", pageList);
//        request.setAttribute("code", 0);
//        request.setAttribute("medicineList", medicineList);
//        request.setAttribute("msg", "以下为搜索到的药方");
//
//        return "jsp:doctor/select_prescription";


    }

    /**
     * 自行调配药方
     */
    @At("doctor/DIY_prescription")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object DIYPrescriptionPage(HttpSession session,
                                      HttpServletRequest request) {
        Map<String, MaterialsStore> materialsStoreMap = new HashMap<>();

        List<MaterialsStore> stores = dao.query(MaterialsStore.class, Cnd.where("id", ">", "0").and("flag", "=", "1"));
        for (MaterialsStore m : stores) {
            materialsStoreMap.put(m.getId() + "", m);
        }
        request.setAttribute("materials_store", materialsStoreMap);
        request.setAttribute("code", 0);
        return "jsp:doctor/DIY_prescription";
    }


    //TODO 提交药方后，需要在诊断书内部修改 是否开药这个属性
    @At("doctor/DIY_prescription")
    @Ok("json")
    @Fail("http:500")
    @POST
    public Object DIYPrescription(@Param("summary") String summary,
                                  HttpSession session,
                                  HttpServletRequest request) {
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        String patientNum = (String) session.getAttribute("patient_num");
        Patient patient = dao.fetch(Patient.class, Cnd.where("id", "=", patientNum));
        Map<String, String> res = new HashMap<>();


        if (doctor == null || patient == null) {
            res.put("code", "-1");
            res.put("msg", "请求参数错误");
            return res;
        }

        Map<String, Double> materials = new HashMap<>();
        //处理字符串，我们默认药材名字不会重复
        summary = summary.replace("\n", "");
        String[] medicines = summary.split("克");
        for (String str : medicines) {
            //此处的medicine为每一味药材，而且每一个数组元素都只有两个
            String[] medicine = str.split(",");
            if (Toolkit.isDigit(medicine[0])) {
                materials.put(medicine[1], Double.parseDouble(medicine[0]));
            } else {
                materials.put(medicine[0], Double.parseDouble(medicine[1]));
            }
        }
        //保存药方信息
        MedicineCombine medicineCombine = new MedicineCombine();
        medicineCombine.setAddTime(new Date(System.currentTimeMillis()));
        medicineCombine.setDoctorIdCard(doctor.getUsername());
        medicineCombine.setPatientIdCard(patient.getIdCard());
        dao.insert(medicineCombine);
        //计算药方价格 并且保存该药方的药材信息
        double price = 0;
        //key 为药材名字
        for (String key : materials.keySet()) {
            //保存药方的药材信息
            MaterialsStore m = dao.fetch(MaterialsStore.class, Cnd.where("materialName", "=", key));
            MedicineCombineList medicineCombineList = new MedicineCombineList();
            medicineCombineList.setMaterialId(m.getId() + "");
            medicineCombineList.setMedicineId(medicineCombine.getId() + "");
            dao.insert(medicineCombineList);

            MaterialsCombine materialsCombine = new MaterialsCombine();
            materialsCombine.setMaterialName(m.getMaterialName());
            materialsCombine.setMaterialDosage(materials.get(key) + "");
            dao.insert(materialsCombine);
            //计算价格
            price += m.getPrice() * materials.get(key);

            materialsCombine.setMaterialPrice(price);
            dao.update(materialsCombine);
        }
        medicineCombine.setPrice(price);
        dao.update(medicineCombine);

        //保存开出去的药方信息
        Prescription prescription = new Prescription();
        prescription.setAddTime(medicineCombine.getAddTime());
        prescription.setPay(false);
        prescription.setPatientIdCard(patient.getIdCard());
        prescription.setDoctorIdCard(doctor.getUsername());
        prescription.setMedicineId(medicineCombine.getId() + "");
        prescription.setCombine(true);
        prescription.setStatus(1);
        dao.insert(prescription);

        res.put("code", "0");
        return res;
    }


    //TODO 提交药方后，需要在诊断书内部修改 是否开药这个属性

    /**
     * 医生为患者添加成方
     */
    @At("doctor/add_medicine")
    @Ok("json")
    @Fail("http:500")
    public Object addMedicine(@Param("medicine_id") String medicineId,
                              HttpServletRequest request,
                              HttpSession session) {
        String patientNum = (String) session.getAttribute("patient_num");
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        Map<String, String> res = new HashMap<>();
        //检测参数
        if (medicineId == null || patientNum == null || patientNum.equals("") || medicineId.equals("")) {
            res.put("code", "-1");
            res.put("msg", "参数错误，添加失败");
            return res;
        }
        Patient patient = dao.fetch(Patient.class, Cnd.where("id", "=", patientNum));

        Medicine medicine = dao.fetch(Medicine.class, Cnd.where("id", "=", medicineId));
        if (patient == null || medicine == null) {
            res.put("code", "-1");
            res.put("msg", "参数错误，添加失败");
            return res;
        }
        //添加
        Prescription prescription = new Prescription();
        prescription.setDoctorIdCard(doctor.getUsername());
        //系统内部药方
        prescription.setCombine(false);
        prescription.setMedicineId(medicineId);
        prescription.setPatientIdCard(patient.getIdCard());
        //未付钱
        prescription.setPay(false);
        prescription.setAddTime(new Date(System.currentTimeMillis()));
//        prescription.setPrice(medicine.getPrice());
        prescription.setStatus(1);
        dao.insert(prescription);

        res.put("code", "0");
        res.put("msg", "添加完成");
        return res;
    }


    /**
     * 医生已选择的药方
     */
    @At("doctor/selected_prescription")
    @Ok("re")
    @Fail("http:500")
    public Object selectedPrescription(HttpSession session,
                                       HttpServletRequest request) {
        String patientNum = (String) session.getAttribute("patient_num");
        if (patientNum == null || patientNum.equals("")) {
            request.setAttribute("code", -1);
            request.setAttribute("msg", "请求参数错误");
            return "jsp:doctor/selected_prescription";
        }
        Patient patient = dao.fetch(Patient.class, Cnd.where("id", "=", patientNum));
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        if (patient == null || doctor == null) {
            request.setAttribute("code", -1);
            request.setAttribute("msg", "请求参数错误");
            return "jsp:doctor/selected_prescription";
        }
        //将医生开出去的方子转化为具体的药方 (有效药方)
        List<Prescription> prescriptionList = dao.query(Prescription.class
                , Cnd.where("patientIdCard", "=", patient.getIdCard())
                        .and("doctorIdCard", "=", doctor.getUsername())
                        .and("status", "=", "1"));
        List<Medicine> medicineList = new LinkedList<>();//系统库内部的药方
        List<MedicineCombine> medicineCombineList = new LinkedList<>();//自己调配的药方
        //存放每一个药方所包含的每一味药材
        Map<String, List<Materials>> materialsMap = new HashMap<>();//存放系统库内部药方的材料
        Map<String, List<MaterialsCombine>> combineMaterialsMap = new HashMap<>();//存放自己调配的药方的材料
        for (Prescription prescription : prescriptionList) {


            if (!prescription.isCombine()) {
                //使用系统库的药方

                //把每个药方返回
                Medicine medicine = dao.fetch(Medicine.class, Cnd.where("id", "=", prescription.getMedicineId()));
                medicineList.add(medicine);

                //把每个药方的每味材料返回
                List<Materials> materials = new LinkedList<>();
                //药方材料的关系
                List<MedicineList> medicineLists = dao.query(MedicineList.class, Cnd.where("medicineId", "=", medicine.getId()));
                //每一味药材，加入到list里
                for (MedicineList medicineList1 : medicineLists) {
                    Materials materials1 = dao.fetch(Materials.class, Cnd.where("id", "=", medicineList1.getMaterialsId()));
                    materials.add(materials1);
                }
                //TODO 需要修改，需要修改显示的内容，即不能为id + 内容
                materialsMap.put(medicine.getId() + "", materials);
            } else {
                //自己调配的药方

                //把每个药方返回
                MedicineCombine medicineCombine = dao.fetch(MedicineCombine.class, Cnd.where("id", "=", prescription.getMedicineId()));
                medicineCombineList.add(medicineCombine);

                //把每个药方的每味药材返回
                List<MaterialsCombine> materialsCombines = new LinkedList<>();
                //药方材料的关系
                List<MedicineCombineList> medicineCombineLists = dao.query(MedicineCombineList.class, Cnd.where("medicineId", "=", medicineCombine.getId()));
                //每一味药材，加入到list里
                for (MedicineCombineList m : medicineCombineLists) {
                    MaterialsStore materialsStore = dao.fetch(MaterialsStore.class, Cnd.where("id", "=", m.getMaterialId()));
                    MaterialsCombine materialsCombine = dao.fetch(MaterialsCombine.class, Cnd.where("materialName", "=", materialsStore.getMaterialName()));
//                    Materials materials = dao.fetch(Materials.class,Cnd.where("id","=",m.getMaterialId()));
                    materialsCombines.add(materialsCombine);
                }
                //TODO 需要修改，需要修改显示的内容，即不能为id + 内容
                combineMaterialsMap.put(medicineCombine.getId() + "", materialsCombines);

            }
        }

        //把search信息写入request
        //把系统内部药方及药材信息返回
        request.setAttribute("materials", materialsMap);
        request.setAttribute("medicine_list", medicineList);

        //把自己添加的药方己药材信息返回
        request.setAttribute("medicine_combine_materials", combineMaterialsMap);
        request.setAttribute("medicine_combine_list", medicineCombineList);

        request.setAttribute("patient", patient);
        request.setAttribute("doctor", doctor);
        request.setAttribute("code", 0);
        return "jsp:doctor/selected_prescription";
    }

    /**
     * 医生删除已开药方
     */
    @At("doctor/delete_medicine")
    @Ok("json")
    @Fail("http:500")
    public Object deleteMedicine(@Param("medicine_id") String medicineId,
                                 HttpServletRequest request,
                                 HttpSession session) {
        Map<String, String> res = new HashMap<>();
        if (medicineId == null || medicineId.equals("")) {
            res.put("code", "-1");
            res.put("msg", "请球参数错误");
            return res;
        }

        String patientNum = (String) session.getAttribute("patient_num");
        if (patientNum == null || patientNum.equals("")) {
            res.put("code", "-1");
            res.put("msg", "患者挂号的号码错误");
            return res;
        }

        Patient patient = dao.fetch(Patient.class, Cnd.where("id", "=", patientNum));
        Doctor doctor = (Doctor) session.getAttribute("doctor");

        Prescription prescription = dao.fetch(Prescription.class,
                Cnd.where("patientIdCard", "=", patient.getIdCard())
                        .and("doctorIdCard", "=", doctor.getUsername())
                        .and("medicineId", "=", medicineId)
                        .and("status", "=", "1"));
        if (prescription == null) {
            res.put("code", "-5");
            res.put("msg", "药方信息错误");
            return res;
        }

        prescription.setStatus(0);
        dao.update(prescription);

        res.put("code", "0");
        res.put("msg", "删除成功");
        return res;
    }

    /**
     * 生成病历
     */
    @At("doctor/create_prescription")
    @Ok("re")
    @Fail("http:500")
    public Object createPrescrition(@Param("patient_num") String patientNum,
                                    HttpServletRequest request,
                                    HttpSession session) {
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        Map<String, String> res = new HashMap<>();
        if (patientNum == null || patientNum.equals("")) {
            res.put("code", "-1");
            res.put("msg", "请求参数错误");
            return res;
        }

        AppointmentOrRegistration appointmentOrRegistration = dao.fetch(AppointmentOrRegistration.class, Cnd.where("id", "=", patientNum));
        if (appointmentOrRegistration == null) {
            res.put("code", "-11");
            res.put("msg", "号码错误");
            return res;
        }

        String patientIdCard = appointmentOrRegistration.getPatientIdCard();
        //TODO


        return res;
    }

    /**
     * 点击缴费后，添加数据
     */
    @At("doctor/close_account")
    @Ok("json")
    @Fail("http:500")
    public Object closeAccountLogic(@Param("patient_num") String patientNum,
                                    HttpSession session,
                                    HttpServletRequest request) {
        Map<String, String> res = new HashMap<>();
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        if (patientNum == null || patientNum.equals("")) {
            res.put("code", "-1");
            res.put("msg", "患者信息错误");
            return res;
        }
        //根据患者挂号的号查出与其相关的所有信息，然后将需要的返回
        AppointmentOrRegistration appointmentOrRegistration = dao.fetch(AppointmentOrRegistration.class, Cnd.where("id", "=", patientNum));
        if (appointmentOrRegistration == null) {
            res.put("code", "-1");
            res.put("msg", "患者信息错误");
            return res;
        }
        Patient patient = dao.fetch(Patient.class, Cnd.where("IdCard", "=", appointmentOrRegistration.getPatientIdCard()));
        if (patient == null) {
            res.put("code", "-1");
            res.put("msg", "患者信息错误");
            return res;
        }
        List<Prescription> prescription = dao.query(Prescription.class, Cnd.where("patientIdCard", "=", patient.getIdCard()).and("isPay", "=", false));
        //默认每个患者只有一份可用诊断书
        Diagnosis diagnosis = dao.fetch(Diagnosis.class, Cnd.where("patientIdCard", "=", patient.getIdCard()).and("status", "=", "1"));

        session.setAttribute("patientNum", patientNum);
        session.setAttribute("patient", patient);
        session.setAttribute("appointmentOrRegistration", appointmentOrRegistration);
        session.setAttribute("prescription", prescription);
        session.setAttribute("diagnosis", diagnosis);
        res.put("code", "0");
        res.put("msg", "成功");
        return res;

    }

    /**
     * 结算页面
     */
    @At("doctor/close_prescription")
    @Ok("re")
    @Fail("http:50")
    public Object closePrescription(HttpServletRequest request,
                                    HttpSession session) {
        Patient patient = (Patient) session.getAttribute("patient");
        String patientNum = (String) session.getAttribute("patientNum");
        AppointmentOrRegistration appointmentOrRegistration = (AppointmentOrRegistration) session.getAttribute("appointmentOrRegistration");
        List<Prescription> prescription = (List<Prescription>) session.getAttribute("prescription");
        Diagnosis diagnosis = (Diagnosis) session.getAttribute("diagnosis");
        Map<String, Medicine> medicineMap = new HashMap<>();
        Map<String, MedicineCombine> medicineCombineMap = new HashMap<>();

        for (Prescription p : prescription) {
            if (p.isCombine()) {
                //医生自配
                MedicineCombine medicineCombine = dao.fetch(MedicineCombine.class, Cnd.where("id", "=", p.getMedicineId()));
                medicineCombineMap.put(p.getId() + "", medicineCombine);
            } else {
                //系统提供
                Medicine medicine = dao.fetch(Medicine.class, Cnd.where("id", "=", p.getMedicineId()));
                medicineMap.put(p.getId() + "", medicine);
            }
        }


        request.setAttribute("medicineMap", medicineMap);
        request.setAttribute("medicineCombineMap", medicineCombineMap);
        request.setAttribute("patient", patient);
        request.setAttribute("appointmentOrRegistration", appointmentOrRegistration);
        request.setAttribute("prescription", prescription);
        request.setAttribute("diagnosis", diagnosis);
        return "jsp:doctor/close_prescription";
    }

    /**
     * 在线支付挂号费
     */
    @At("doctor/pay_for_appointment")
    @Ok("json")
    @Fail("http:50")
    public Object payForAppointment(@Param("appointment_id") String appointmentId,
                                    @Param("prescription_id") String prescriptionId,
                                    HttpServletRequest request,
                                    HttpSession session) {
        Map<String, String> res = new HashMap<>();
        if (appointmentId == null || prescriptionId == null) {
            res.put("code", "-8");
            return res;
        }
        Patient patient = (Patient) session.getAttribute("patient");
        AppointmentOrRegistration appointmentOrRegistration = dao.fetch(AppointmentOrRegistration.class
                , Cnd.where("id", "=", appointmentId)
                        .and("patientIdCard", "=", patient.getIdCard()));
        Prescription prescription = dao.fetch(Prescription.class
                , Cnd.where("id", "=", prescriptionId));
        if (appointmentOrRegistration != null && prescription != null) {
            prescription.setPay(true);
            prescription.setReceiveMedicineTime(new Date(System.currentTimeMillis()));
            prescription.setStatus(2);//设置药品为已被取走，不可修改状态
            dao.update(prescription);

            appointmentOrRegistration.setRegistrationFeeState(1);
            appointmentOrRegistration.setPayForTime(new Date(System.currentTimeMillis()));
            appointmentOrRegistration.setAppointment(true);
            dao.update(appointmentOrRegistration);
            res.put("code", "0");
        } else {
            res.put("code", "-8");
        }
        return res;
    }

    /**
     * 点击查看历史后，添加数据
     */
    @At("doctor/find_history_logic")
    @Ok("json")
    @Fail("http:500")
    public Object findHistoryLogic(@Param("patient_num") String patientNum,
                                   HttpSession session,
                                   HttpServletRequest request) {
        Map<String, String> res = new HashMap<>();
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        if (patientNum == null || patientNum.equals("")) {
            res.put("code", "-1");
            res.put("msg", "患者信息错误");
            return res;
        }
        //根据患者挂号的号查出与其相关的所有信息，然后将需要的返回
        AppointmentOrRegistration appointmentOrRegistration = dao.fetch(AppointmentOrRegistration.class, Cnd.where("id", "=", patientNum));
        if (appointmentOrRegistration == null) {
            res.put("code", "-1");
            res.put("msg", "患者信息错误");
            return res;
        }
        Patient patient = dao.fetch(Patient.class, Cnd.where("IdCard", "=", appointmentOrRegistration.getPatientIdCard()));
        if (patient == null) {
            res.put("code", "-1");
            res.put("msg", "患者信息错误");
            return res;
        }
        //此处和付款页面取出的数据不同，此处的数据为全部数据
        List<Prescription> prescription = dao.query(Prescription.class, Cnd.where("patientIdCard", "=", patient.getIdCard()));
        //默认每个患者只有一份可用诊断书
        Diagnosis diagnosis = dao.fetch(Diagnosis.class, Cnd.where("patientIdCard", "=", patient.getIdCard()).and("status", "=", "1"));

        session.setAttribute("patientNum", patientNum);
        session.setAttribute("patient", patient);
        session.setAttribute("appointmentOrRegistration", appointmentOrRegistration);
        session.setAttribute("prescription", prescription);
        session.setAttribute("diagnosis", diagnosis);
        res.put("code", "0");
        res.put("msg", "成功");
        return res;
    }

    /**
     * 查看历史纪录页面
     */
    @At("doctor/find_history")
    @Ok("re")
    @Fail("http:500")
    public Object findHistory(HttpSession session,
                              HttpServletRequest request) {

        Patient patient = (Patient) session.getAttribute("patient");
        String patientNum = (String) session.getAttribute("patientNum");
        AppointmentOrRegistration appointmentOrRegistration = (AppointmentOrRegistration) session.getAttribute("appointmentOrRegistration");
        List<Prescription> prescription = (List<Prescription>) session.getAttribute("prescription");
        Diagnosis diagnosis = (Diagnosis) session.getAttribute("diagnosis");
        Map<String, Medicine> medicineMap = new HashMap<>();
        Map<String, MedicineCombine> medicineCombineMap = new HashMap<>();

        for (Prescription p : prescription) {
            if (p.isCombine()) {
                //医生自配
                MedicineCombine medicineCombine = dao.fetch(MedicineCombine.class, Cnd.where("id", "=", p.getMedicineId()));
                medicineCombineMap.put(p.getId() + "", medicineCombine);
            } else {
                //系统提供
                Medicine medicine = dao.fetch(Medicine.class, Cnd.where("id", "=", p.getMedicineId()));
                medicineMap.put(p.getId() + "", medicine);
            }
        }


        request.setAttribute("medicineMap", medicineMap);
        request.setAttribute("medicineCombineMap", medicineCombineMap);
        request.setAttribute("patient", patient);
        request.setAttribute("appointmentOrRegistration", appointmentOrRegistration);
        request.setAttribute("prescription", prescription);
        request.setAttribute("diagnosis", diagnosis);
        return "jsp:doctor/find_history";
    }

    @At("doctor/show_medicine_history")
    @Ok("re")
    @Fail("http:500")
    @GET
    public Object showMedicineHistory(HttpServletRequest request,
                                      HttpSession session) {
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        List<MedicineHistory> medicineHistories = dao.query(MedicineHistory.class, Cnd.where("doctorIdCard", "=", doctor.getUsername()));
        Map<String, String> patientNameMap = new HashMap<>();
        for (MedicineHistory medicineHistory : medicineHistories) {
            String patientIdCard = medicineHistory.getPatientIdCard();
            Patient patient = dao.fetch(Patient.class, Cnd.where("A_IDCARD", "=", patientIdCard));
            patientNameMap.put(patientIdCard, patient.getName());
        }


//        //将医生开出去的方子转化为具体的药方 (有效药方)
//        List<Prescription> prescriptionList = dao.query(Prescription.class
//                , Cnd.where("doctorIdCard", "=", doctor.getUsername())
//                        .and("status", "=", "1"));
//        List<Medicine> medicineList = new LinkedList<>();//系统库内部的药方
//        List<MedicineCombine> medicineCombineList = new LinkedList<>();//自己调配的药方
//        //存放每一个药方所包含的每一味药材
//        Map<String, List<Materials>> materialsMap = new HashMap<>();//存放系统库内部药方的材料
//        Map<String, List<MaterialsCombine>> combineMaterialsMap = new HashMap<>();//存放自己调配的药方的材料
//        for (Prescription prescription : prescriptionList) {
//
//
//            if (!prescription.isCombine()) {
//                //使用系统库的药方
//
//                //把每个药方返回
//                Medicine medicine = dao.fetch(Medicine.class, Cnd.where("id", "=", prescription.getMedicineId()));
//                medicineList.add(medicine);
//
//                //把每个药方的每味材料返回
//                List<Materials> materials = new LinkedList<>();
//                //药方材料的关系
//                List<MedicineList> medicineLists = dao.query(MedicineList.class, Cnd.where("medicineId", "=", medicine.getId()));
//                //每一味药材，加入到list里
//                for (MedicineList medicineList1 : medicineLists) {
//                    Materials materials1 = dao.fetch(Materials.class, Cnd.where("id", "=", medicineList1.getMaterialsId()));
//                    materials.add(materials1);
//                }
//                //TODO 需要修改，需要修改显示的内容，即不能为id + 内容
//                materialsMap.put(medicine.getId() + "", materials);
//            } else {
//                //自己调配的药方
//
//                //把每个药方返回
//                MedicineCombine medicineCombine = dao.fetch(MedicineCombine.class, Cnd.where("id", "=", prescription.getMedicineId()));
//                medicineCombineList.add(medicineCombine);
//
//                //把每个药方的每味药材返回
//                List<MaterialsCombine> materialsCombines = new LinkedList<>();
//                //药方材料的关系
//                List<MedicineCombineList> medicineCombineLists = dao.query(MedicineCombineList.class, Cnd.where("medicineId", "=", medicineCombine.getId()));
//                //每一味药材，加入到list里
//                for (MedicineCombineList m : medicineCombineLists) {
//                    MaterialsStore materialsStore = dao.fetch(MaterialsStore.class, Cnd.where("id", "=", m.getMaterialId()));
//                    MaterialsCombine materialsCombine = dao.fetch(MaterialsCombine.class, Cnd.where("materialName", "=", materialsStore.getMaterialName()));
////                    Materials materials = dao.fetch(Materials.class,Cnd.where("id","=",m.getMaterialId()));
//                    materialsCombines.add(materialsCombine);
//                }
//                //TODO 需要修改，需要修改显示的内容，即不能为id + 内容
//                combineMaterialsMap.put(medicineCombine.getId() + "", materialsCombines);
//
//            }
//        }
//
//        //把search信息写入request
//        //把系统内部药方及药材信息返回
//        request.setAttribute("materials", materialsMap);
//        request.setAttribute("medicine_list", medicineList);
//
//        //把自己添加的药方己药材信息返回
//        request.setAttribute("medicine_combine_materials", combineMaterialsMap);
//        request.setAttribute("medicine_combine_list", medicineCombineList);
//
//        request.setAttribute("doctor", doctor);
        //request.setAttribute("code", 0);


        request.setAttribute("patientNameMap", patientNameMap);
        request.setAttribute("medicineHistories", medicineHistories);
        request.setAttribute("code", 0);
        return "jsp:doctor/show_medicine_history";
    }

    @At("doctor/medicine_history_detail")
    @Ok("re")
    @Fail("http:500")
    public Object medicineHistoryDetailPage(@Param("patient_id_card")String patientIdCard,
                                         HttpServletRequest request,
                                         HttpSession session){
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        if(patientIdCard == null || patientIdCard.equals("")){
            request.setAttribute("code","-1");
            request.setAttribute("msg","请求参数错误！");
            request.setAttribute("redirect_url","diagnose.php");
            return "jsp:doctor/graph_jump";
        }


        Map<String,Prescription> prescriptionMap = new HashMap<>();

        //将医生开出去的方子转化为具体的药方 (有效药方)
        List<Prescription> prescriptionList = dao.query(Prescription.class
                , Cnd.where("patientIdCard", "=", patientIdCard)
                        .and("status", "=", "1"));
        List<Medicine> medicineList = new LinkedList<>();//系统库内部的药方
        List<MedicineCombine> medicineCombineList = new LinkedList<>();//自己调配的药方
        //存放每一个药方所包含的每一味药材
        Map<String, List<Materials>> materialsMap = new HashMap<>();//存放系统库内部药方的材料
        Map<String, List<MaterialsCombine>> combineMaterialsMap = new HashMap<>();//存放自己调配的药方的材料
        for (Prescription prescription : prescriptionList) {

            prescriptionMap.put(prescription.getMedicineId(),prescription);
            if (!prescription.isCombine()) {
                //使用系统库的药方

                //把每个药方返回
                Medicine medicine = dao.fetch(Medicine.class, Cnd.where("id", "=", prescription.getMedicineId()));
                medicineList.add(medicine);

                //把每个药方的每味材料返回
                List<Materials> materials = new LinkedList<>();
                //药方材料的关系
                List<MedicineList> medicineLists = dao.query(MedicineList.class, Cnd.where("medicineId", "=", medicine.getId()));
                //每一味药材，加入到list里
                for (MedicineList medicineList1 : medicineLists) {
                    Materials materials1 = dao.fetch(Materials.class, Cnd.where("id", "=", medicineList1.getMaterialsId()));
                    materials.add(materials1);
                }
                //TODO 需要修改，需要修改显示的内容，即不能为id + 内容
                materialsMap.put(medicine.getId() + "", materials);
            } else {
                //自己调配的药方

                //把每个药方返回
                MedicineCombine medicineCombine = dao.fetch(MedicineCombine.class, Cnd.where("id", "=", prescription.getMedicineId()));
                medicineCombineList.add(medicineCombine);

                //把每个药方的每味药材返回
                List<MaterialsCombine> materialsCombines = new LinkedList<>();
                //药方材料的关系
                List<MedicineCombineList> medicineCombineLists = dao.query(MedicineCombineList.class, Cnd.where("medicineId", "=", medicineCombine.getId()));
                //每一味药材，加入到list里
                for (MedicineCombineList m : medicineCombineLists) {
                    MaterialsStore materialsStore = dao.fetch(MaterialsStore.class, Cnd.where("id", "=", m.getMaterialId()));
                    MaterialsCombine materialsCombine = dao.fetch(MaterialsCombine.class, Cnd.where("materialName", "=", materialsStore.getMaterialName()));
//                    Materials materials = dao.fetch(Materials.class,Cnd.where("id","=",m.getMaterialId()));
                    materialsCombines.add(materialsCombine);
                }
                //TODO 需要修改，需要修改显示的内容，即不能为id + 内容
                combineMaterialsMap.put(medicineCombine.getId() + "", materialsCombines);

            }
        }



        //把search信息写入request
        request.setAttribute("prescriptionMap",prescriptionMap);
        //把系统内部药方及药材信息返回
        request.setAttribute("materials", materialsMap);
        request.setAttribute("medicine_list", medicineList);

        //把自己添加的药方己药材信息返回
        request.setAttribute("medicine_combine_materials", combineMaterialsMap);
        request.setAttribute("medicine_combine_list", medicineCombineList);

        request.setAttribute("doctor", doctor);
        request.setAttribute("code", 0);



        return "jsp:doctor/medicine_history_detail";
    }

}