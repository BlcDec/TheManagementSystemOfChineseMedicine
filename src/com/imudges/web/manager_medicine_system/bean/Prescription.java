package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

/**
 * 药方
 */
@Table("A_PRESCRIPTION")
public class Prescription {
    @Id
    private int id;

    @Column
    private String diagnosisId;//诊断书

    @Column
    private String patientIdCard;//患者身份证

    @Column
    private String[] prescriptionSummary;//药方内容

    @Column
    private String price;//价格

    @Column
    private boolean isPay;//是否付款

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDiagnosisId() {
        return diagnosisId;
    }

    public void setDiagnosisId(String diagnosisId) {
        this.diagnosisId = diagnosisId;
    }

    public String getPatientIdCard() {
        return patientIdCard;
    }

    public void setPatientIdCard(String patientIdCard) {
        this.patientIdCard = patientIdCard;
    }

    public String[] getPrescriptionSummary() {
        return prescriptionSummary;
    }

    public void setPrescriptionSummary(String[] prescriptionSummary) {
        this.prescriptionSummary = prescriptionSummary;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public boolean isPay() {
        return isPay;
    }

    public void setPay(boolean pay) {
        isPay = pay;
    }
}
