package com.xyst.fwgl.utils;

import java.io.Serializable;

public class ServiceUtil implements Serializable {

    private Integer id;
    private String name;
    private Integer serviceType;
    private Integer openType;
    private String address;
    private String version;
    private Integer status;
    private Integer categoryId;
    private String createTime;
    private String mountTime;
    private String cancelTime;
    private String unmountTime;
    private String categoryName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getServiceType() {
        return serviceType;
    }

    public void setServiceType(Integer serviceType) {
        this.serviceType = serviceType;
    }

    public Integer getOpenType() {
        return openType;
    }

    public void setOpenType(Integer openType) {
        this.openType = openType;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getMountTime() {
        return mountTime;
    }

    public void setMountTime(String mountTime) {
        this.mountTime = mountTime;
    }

    public String getCancelTime() {
        return cancelTime;
    }

    public void setCancelTime(String cancelTime) {
        this.cancelTime = cancelTime;
    }

    public String getUnmountTime() {
        return unmountTime;
    }

    public void setUnmountTime(String unmountTime) {
        this.unmountTime = unmountTime;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @Override
    public String toString() {
        return "ServiceUtil{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", serviceType=" + serviceType +
                ", openType=" + openType +
                ", address='" + address + '\'' +
                ", version='" + version + '\'' +
                ", status=" + status +
                ", categoryId=" + categoryId +
                ", createTime='" + createTime + '\'' +
                ", mountTime='" + mountTime + '\'' +
                ", cancelTime='" + cancelTime + '\'' +
                ", unmountTime='" + unmountTime + '\'' +
                ", categoryName='" + categoryName + '\'' +
                '}';
    }
}
