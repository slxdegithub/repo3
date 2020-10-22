package com.xyst.fwgl.model;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
@Table(name="subscribe_audit")
public class SubscribeAudit implements Serializable {
    @Id
    private Integer id;
    private Integer subscribeId;
    private Integer type;
    private String auditTime;
    private String reason;
    private Integer result;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(String auditTime) {
        this.auditTime = auditTime;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Integer getResult() {
        return result;
    }

    public void setResult(Integer result) {
        this.result = result;
    }

    public Integer getSubscribeId() {
        return subscribeId;
    }

    public void setSubscribeId(Integer subscribeId) {
        this.subscribeId = subscribeId;
    }
}
