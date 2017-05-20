package com.imudges.web.manager_medicine_system.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;

import java.util.Date;

/**
 * 预约/挂号信息
 */
@Table("AAAA_APPONITMENT")
public class AppointmentOrRegistration {
    @Id
    private int id;

    /**
     * 预约/挂号患者身份证
     * */
    @Column
    private String patientIdCard;

    /**
     * 预约/挂号时间
     * */
    @Column
    private Date addTime;

    /**
     * 患者预约/挂号的科室
     * */
    @Column
    private String department;

    /**
     * 患者症状出现的时间
     */
    @Column
    private String appearTime;

    /**
     * 患者是否支付挂号费
     * 1：已支付
     * 0：未支付
     * PS：患者有两种方式支付挂号费
     * */
    @Column
    private int registrationFeeState;

    /**
     * 缴纳预约费用时间
     * */
    @Column
    private Date payForTime;


    /**
     * 在线预约还是现场挂号
     * true：在线预约
     * false：现场挂号
     * */
    @Column
    private boolean isAppointment;

    public Date getPayForTime() {
        return payForTime;
    }

    public void setPayForTime(Date payForTime) {
        this.payForTime = payForTime;
    }

    public AppointmentOrRegistration() {
    }

    public AppointmentOrRegistration(boolean isAppointment) {
        this.isAppointment = isAppointment;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPatientIdCard() {
        return patientIdCard;
    }

    public void setPatientIdCard(String patientIdCard) {
        this.patientIdCard = patientIdCard;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getAppearTime() {
        return appearTime;
    }

    public void setAppearTime(String appearTime) {
        this.appearTime = appearTime;
    }

    public int getRegistrationFeeState() {
        return registrationFeeState;
    }

    public void setRegistrationFeeState(int registrationFeeState) {
        this.registrationFeeState = registrationFeeState;
    }

    public boolean isAppointment() {
        return isAppointment;
    }

    public void setAppointment(boolean appointment) {
        isAppointment = appointment;
    }
}
