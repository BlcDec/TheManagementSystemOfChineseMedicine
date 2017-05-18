package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import javax.xml.ws.WebServiceClient;

/**
 * 用户表
 */
@Table("AA_USERS")
public class User {
    @Id
    private int id;

    @Column("A_USRNAME")
    private String username;

    @Column("A_PASSWORD")
    private String password;

    /**
     * 0 管理员
     * 1 医生
     * 2 患者
     * */
    @Column("A_TYPE")
    private String type;

    @Column("A_AK")
    private String ak;

    public User(Patient patient,String username,String password) {
        this.username = username;
        this.password = password;
        this.type = "2";
    }

    public User() {
    }

    public String getAk() {
        return ak;
    }

    public void setAk(String ak) {
        this.ak = ak;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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
