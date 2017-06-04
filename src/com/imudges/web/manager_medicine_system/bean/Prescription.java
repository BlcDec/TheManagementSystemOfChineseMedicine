package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import java.util.Date;

/**
 * 药方，医生开出去的
 */
@Table("AAAAA_PRESCRIPTION")
public class Prescription {
    @Id
    private int id;

    @Column
    private String doctorIdCard;//医生身份证

    @Column
    private String patientIdCard;//患者身份证

    @Column
    private String medicineId;//药方Id（或为系统库内部药方，或为医生自己调配）

    /**
     * false：未付款
     * true：付款
     * */
    @Column
    private boolean isPay;//是否付款

    @Column
    private boolean isCombine;//是否为医生自行开药

    @Column
    private Date addTime;//添加时间

    @Column
    private Date receiveMedicineTime;//取药时间

    /**
     * -1：不知道什么状态
     * 0：被删除
     * 1：正常可查询状态
     * 2：已被取走，不可修改
     * */
    @Column
    private int status;//状态

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public Date getReceiveMedicineTime() {
        return receiveMedicineTime;
    }

    public void setReceiveMedicineTime(Date receiveMedicineTime) {
        this.receiveMedicineTime = receiveMedicineTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public boolean isCombine() {
        return isCombine;
    }

    public void setCombine(boolean combine) {
        isCombine = combine;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDoctorIdCard() {
        return doctorIdCard;
    }

    public void setDoctorIdCard(String doctorIdCard) {
        this.doctorIdCard = doctorIdCard;
    }

    public String getPatientIdCard() {
        return patientIdCard;
    }

    public void setPatientIdCard(String patientIdCard) {
        this.patientIdCard = patientIdCard;
    }

    public String getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(String medicineId) {
        this.medicineId = medicineId;
    }

    public boolean isPay() {
        return isPay;
    }

    public void setPay(boolean pay) {
        isPay = pay;
    }
}