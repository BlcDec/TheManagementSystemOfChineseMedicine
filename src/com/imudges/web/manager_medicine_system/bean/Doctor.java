package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import java.util.Date;

/**
 * 医生
 */
@Table("AAAA_DOCTOR")
public class Doctor {
    @Id
    private int id;

    @Column
    private String username;

    @Column
    private String password;

    @Column
    private String name;

    @Column
    private String recordId;//接诊记录id

    @Column
    private double salary;

    @Column
    private String sex;

    @Column
    private String num;//编号

    /**
     * 挂号 0
     * 诊断 1
     * 收款 2
     * */
    @Column("A_POSITION")
    private String position;//身份

    @Column
    private Date addTime;//进入医院时间

    /**
     * 内分泌科 1
     * 精神科  2
     * 老年科  3
     * 儿童科  4
     * 牙科   5
     * 呼吸内科 6
     * */
    @Column
    private String departmentId;//部门id

    @Column("A_DEGREE")
    private String degree;//学位

    @Column("A_USERID")
    private String userId;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRecordId() {
        return recordId;
    }

    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
