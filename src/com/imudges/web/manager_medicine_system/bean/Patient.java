package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;
import org.nutz.ioc.loader.annotation.IocBean;

import java.util.Date;

/**
 * 患者
 */
@Table("AA_PATIENTS")
public class Patient {

    @Id
    private int id;

    @Column("A_NAME")
    private String name;

    @Column("A_NUM")
    private String num;//患者编号

    @Column("A_SEX")
    private String sex;

    @Column("A_RECORDID")
    private String recordId;//接诊单id

    @Column("A_ADDTIME")
    private Date addTime;//住院时间

    @Column("A_IDCARD")
    private String IdCard;//身份证

    @Column("A_PHONENUM")
    private String phoneNum;//电话号

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

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getRecordId() {
        return recordId;
    }

    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getIdCard() {
        return IdCard;
    }

    public void setIdCard(String idCard) {
        IdCard = idCard;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }
}
