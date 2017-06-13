package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

/**
 * 药材仓库
 */
@Table("AAAA_MATERIALSSTORE")
public class MaterialsStore {
    @Id
    private int id;

    @Column
    private String materialName;

    @Column
    private double materialRemain;//余量

    @Column
    private double price;//单价

    @Column
    private String  flag;//0表示已经删除掉，1表示生效

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

    public double getMaterialRemain() {
        return materialRemain;
    }

    public void setMaterialRemain(double materialRemain) {
        this.materialRemain = materialRemain;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }
}
