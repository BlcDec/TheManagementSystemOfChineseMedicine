package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;
import org.nutz.ioc.loader.annotation.IocBean;

import javax.websocket.OnClose;
import java.util.Date;

/**
 * 医生描述患者的病情
 */
@Table("A_DIAGNOSIS")
public class Diagnosis {
    @Id
    private int id;

    @Column
    private String patientIdCard;//患者的身份证

    @Column
    private String doctorIdCard;//医生的身份证

    @Column
    private String diseaseSummary;//医生对于病情的描述

    @Column
    private Date addTime;//医生提交时间

    @Column
    private boolean giveMedicineOrNot;//是否开药

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

    public String getDiseaseSummary() {
        return diseaseSummary;
    }

    public void setDiseaseSummary(String diseaseSummary) {
        this.diseaseSummary = diseaseSummary;
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
