package com.xyst.fwgl.service;

import com.xyst.fwgl.model.User;

import java.util.List;

public interface UserService {
    List<User> findAll();
    User findById(Integer id);
    User findByName(String name);
}
