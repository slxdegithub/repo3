package com.xyst.fwgl.service.impl;

import com.xyst.fwgl.mapper.SubscribeAuditMapper;
import com.xyst.fwgl.model.SubscribeAudit;
import com.xyst.fwgl.service.SubscribeAuditService;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.List;
@Service
public class SubscribeAuditServiceImpl implements SubscribeAuditService {
    @Resource
    private SubscribeAuditMapper subscribeAuditMapper;
    @Override
    public SubscribeAudit findById(Integer id) {
        return subscribeAuditMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<SubscribeAudit> findAll() {
        return subscribeAuditMapper.selectAll();
    }

    @Override
    public Integer save(SubscribeAudit subscribeAudit) {
        return subscribeAuditMapper.insert(subscribeAudit);
    }

    @Override
    public Integer update(SubscribeAudit subscribeAudit) {
        return subscribeAuditMapper.updateByPrimaryKeySelective(subscribeAudit);
    }

    @Override
    public List<SubscribeAudit> findBySubcribeId(Integer subscribeId) {
        Example example=new Example(SubscribeAudit.class);
        example.setOrderByClause("id DESC");
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("subscribeId", subscribeId);
        List<SubscribeAudit> lists = subscribeAuditMapper.selectByExample(example);
        return lists;
    }

    @Override
    public List<SubscribeAudit> findBySubcribeIdAndResult(Integer subscribeId, Integer result) {
        Example example=new Example(SubscribeAudit.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("subscribeId", subscribeId);
        criteria.andEqualTo("result", result);
        List<SubscribeAudit> lists = subscribeAuditMapper.selectByExample(example);
        return lists;
    }
}
