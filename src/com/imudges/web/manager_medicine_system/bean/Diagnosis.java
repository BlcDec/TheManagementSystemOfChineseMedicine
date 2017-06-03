package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;
import java.util.Date;

/**
 * 诊断书
 */
@Table("AAA_DIAGNOSIS")
public class Diagnosis {
    @Id
    private int id;

    @Column
    private String patientIdCard;//患者的身份证

    @Column
    private String doctorIdCard;//医生的身份证

    @Column
    private String patientSummary;//患者自述

    @Column
    private String doctorSummary;//医生对于病情的描述

    @Column
    private Date addTime;//医生提交时间

    @Column
    private boolean giveMedicineOrNot;//是否开药


    /**
     * -1：不知道什么状态
     * 0：被删除
     * 1：正常状态
     * */
    @Column
    private int status;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPatientIdCard() {
        return patientIdCard;
    }

    public void setPatientIdCard(String patientIdCard) {
        this.patientIdCard = patientIdCard;
    }

    public String getDoctorIdCard() {
        return doctorIdCard;
    }

    public void setDoctorIdCard(String doctorIdCard) {
        this.doctorIdCard = doctorIdCard;
    }

    public String getPatientSummary() {
        return patientSummary;
    }

    public void setPatientSummary(String patientSummary) {
        this.patientSummary = patientSummary;
    }

    public String getDoctorSummary() {
        return doctorSummary;
    }

    public void setDoctorSummary(String doctorSummary) {
        this.doctorSummary = doctorSummary;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public boolean isGiveMedicineOrNot() {
        return giveMedicineOrNot;
    }

    public void setGiveMedicineOrNot(boolean giveMedicineOrNot) {
        this.giveMedicineOrNot = giveMedicineOrNot;
    }
}
