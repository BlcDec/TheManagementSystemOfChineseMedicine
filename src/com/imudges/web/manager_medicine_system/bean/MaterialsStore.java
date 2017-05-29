package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

/**
 * Created by yangyang on 2017/5/29.
 */
@Table("A_MATERIALSSTORE")
public class MaterialsStore {
    @Id
    private int id;

    @Column
    private String materialName;//名字

    @Column
    private String materialRemain;//余量

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

    public String getMaterialRemain() {
        return materialRemain;
    }

    public void setMaterialRemain(String materialRemain) {
        this.materialRemain = materialRemain;
    }
}
