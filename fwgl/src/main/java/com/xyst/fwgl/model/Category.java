package com.xyst.fwgl.model;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
@Table(name="category")
public class Category implements Serializable {
    @Id
    private Integer id;
    private String cname;
    private String description;
    private String createTime;
    private String auditTime;
    private String result;
    private String reason;
    private Integer status;
    private Integer type;
    private Integer preCategory;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(String auditTime) {
        this.auditTime = auditTime;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getPreCategory() {
        return preCategory;
    }

    public void setPreCategory(Integer preCategory) {
        this.preCategory = preCategory;
    }
}
