package com.xyst.fwgl.service;

import com.xyst.fwgl.model.ServiceAudit;
import com.xyst.fwgl.utils.ServiceAuditUtil;

import java.util.List;

public interface ServiceAuditService {
    ServiceAudit findById(Integer id);
    List<ServiceAudit> findAll();
    List<ServiceAudit> findByServiceId(Integer serviceId);
    Integer save(ServiceAudit serviceAudit);
    Integer update(ServiceAudit serviceAudit);
    //hdd
    int saveAudit(Integer Sid,String reason,Integer result,Integer auditType);

    String unloadInfo(Integer id);

    String deleteInfo(Integer id);

    String submitInfo(Integer id);

    List<ServiceAuditUtil> flowInfo(Integer id);

}
