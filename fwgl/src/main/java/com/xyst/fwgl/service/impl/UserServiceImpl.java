package com.xyst.fwgl.service.impl;

import com.xyst.fwgl.mapper.UserMapper;
import com.xyst.fwgl.model.User;
import com.xyst.fwgl.service.UserService;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.List;
@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;
    @Override
    public List<User> findAll() {
        return userMapper.selectAll();
    }

    @Override
    public User findById(Integer id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public User findByName(String name) {
        Example example=new Example(User.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("userName", name);
        List<User> lists = userMapper.selectByExample(example);
        return lists.get(0);
    }
}
