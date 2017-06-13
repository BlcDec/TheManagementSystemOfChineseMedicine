package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import java.util.Date;

/**
 * 病历
 * TODO 提交诊断书后生成。如果需要开药方，在付款之后继续向病历添加处方信息
 */
@Table("AA_MEDICINEHISTORY")
public class MedicineHistory {
    @Id
    private int Id;

    @Column
    private String patientIdCard;

    @Column
    private String doctorIdCard;

    @Column
    private String patientSummary;

    @Column
    private String doctorSummary;

    @Column
    private Date createTime;//生成病历时间

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        Id = id;
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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
