package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

/**
 * 构成成方的药材
 */
@Table("A_MATERIALS")
public class Materials {
    @Id
    private int id;

    @Column
    private String medicineName;//药物名称

    @Column
    private String dosage;//药物用量

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }
}
