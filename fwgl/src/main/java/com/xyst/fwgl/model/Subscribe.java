package com.xyst.fwgl.model;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
@Table(name="subscribe")
public class Subscribe implements Serializable {
    @Id
    private Integer id;
    private Integer serviceId;
    private String subscriber;
    private Integer status;
    private String applyTime;
    private String describeTime;
    private String cancelTime;
    private String transMedium;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getServiceId() {
        return serviceId;
    }

    public void setServiceId(Integer serviceId) {
        this.serviceId = serviceId;
    }

    public String getSubscriber() {
        return subscriber;
    }

    public void setSubscriber(String subscriber) {
        this.subscriber = subscriber;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(String applyTime) {
        this.applyTime = applyTime;
    }

    public String getDescribeTime() {
        return describeTime;
    }

    public void setDescribeTime(String describeTime) {
        this.describeTime = describeTime;
    }

    public String getCancelTime() {
        return cancelTime;
    }

    public void setCancelTime(String cancelTime) {
        this.cancelTime = cancelTime;
    }

    public String getTransMedium() {
        return transMedium;
    }

    public void setTransMedium(String transMedium) {
        this.transMedium = transMedium;
    }
}
