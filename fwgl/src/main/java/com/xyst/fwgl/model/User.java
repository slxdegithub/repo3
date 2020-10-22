package com.xyst.fwgl.model;

import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Table(name="user")
public class User implements Serializable {
    @Id
    private Integer id;
    private String userName;
    private String password;
    private Integer role; //1:管理员 2：操作员 3：审核员 4：银行客户
    private String token;
    private String  transMedium;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getTransMedium() {
        return transMedium;
    }

    public void setTransMedium(String transMedium) {
        this.transMedium = transMedium;
    }
}
