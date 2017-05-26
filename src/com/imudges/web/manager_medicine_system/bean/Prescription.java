package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

/**
 * 药方，医生开出去的
 */
@Table("AA_PRESCRIPTION")
public class Prescription {
    @Id
    private int id;

    @Column
    private String diagnosisId;//诊断书id，一个诊断书可能有多个药方

    @Column
    private String patientIdCard;//患者身份证

    @Column
    private String medicineId;//药方Id

    @Column
    private String price;//价格

    @Column
    private boolean isPay;//是否付款

    @Column
    private boolean isCombine;//是否为医生自行开药

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

    public String getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(String medicineId) {
        this.medicineId = medicineId;
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