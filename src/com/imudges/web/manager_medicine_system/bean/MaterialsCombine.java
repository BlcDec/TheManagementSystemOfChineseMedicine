package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

/**
 * 医生自己调配的药材信息
 */
@Table("AA_MATERIALSCOMBINE")
public class MaterialsCombine {
    @Id
    private int id;

    @Column
    private String materialName;//名字

    @Column
    private String materialDosage;//用量

    @Column
    private Double materialPrice;//总价格

    public Double getMaterialPrice() {
        return materialPrice;
    }

    public void setMaterialPrice(Double materialPrice) {
        this.materialPrice = materialPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public String getMaterialDosage() {
        return materialDosage;
    }

    public void setMaterialDosage(String materialDosage) {
        this.materialDosage = materialDosage;
    }
}
