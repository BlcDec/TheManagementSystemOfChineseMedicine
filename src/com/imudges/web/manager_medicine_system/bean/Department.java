package com.imudges.web.manager_medicine_system.bean;


import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

/**
 * 部门实体
 */
@Table("A_DEPARTMENT")
public class Department {
    @Id
    private int id;

    @Column
    private String departmentName;//科室名

    @Column
    private int num;//科室人数

    @Column
    private String location;//科室所在位置

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
