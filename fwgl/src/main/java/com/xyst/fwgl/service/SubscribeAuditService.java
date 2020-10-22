package com.xyst.fwgl.service;

import com.xyst.fwgl.model.SubscribeAudit;

import java.util.List;

public interface SubscribeAuditService {
    SubscribeAudit findById(Integer id);
    List<SubscribeAudit> findAll();
    Integer save(SubscribeAudit subscribeAudit);
    Integer update(SubscribeAudit subscribeAudit);
    List<SubscribeAudit> findBySubcribeId(Integer subscribeId);
    List<SubscribeAudit> findBySubcribeIdAndResult(Integer subscribeId, Integer result);
}
