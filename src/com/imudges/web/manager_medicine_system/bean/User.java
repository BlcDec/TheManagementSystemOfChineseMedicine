package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import javax.xml.ws.WebServiceClient;

/**
 * Created by yangyang on 2017/5/16.
 */
@Table("A_USERS")
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

    @Column("A_CUSTOMERID")
    private int customerId;//用户id，可与Doctor Patient绑定

    @Column("A_AK")
    private String ak;

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

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
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
