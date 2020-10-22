package com.xyst.fwgl.model;

import java.util.List;

public class CatalogList {

    private String name;
    private Integer regCount;
    private Integer pubCount;
    private Integer status;
    private List<Category> categories;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getRegCount() {
        return regCount;
    }

    public void setRegCount(Integer regCount) {
        this.regCount = regCount;
    }

    public Integer getPubCount() {
        return pubCount;
    }

    public void setPubCount(Integer pubCount) {
        this.pubCount = pubCount;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public List<Category> getCategories() {
        return categories;
    }

    public void setCategories(List<Category> categories) {
        this.categories = categories;
    }
}
