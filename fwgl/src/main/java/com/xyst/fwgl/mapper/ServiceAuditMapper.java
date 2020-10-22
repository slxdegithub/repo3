package com.xyst.fwgl.mapper;

import com.xyst.fwgl.model.ServiceAudit;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ServiceAuditMapper extends Mapper<ServiceAudit> {


    @Select("select reason,audit_time from service_audit where service_id = #{id} and type=3 and result = 2")
    List<ServiceAudit> findBySId(Integer id);

    @Select("select reason,audit_time from service_audit where service_id = #{id} and type=2 and result = 2")
    List<ServiceAudit> findBySId3(Integer id);

    @Select("select reason,audit_time from service_audit where service_id = #{id} and type=1 and result = 2")
    List<ServiceAudit> findBySId1(Integer id);

    @Select("select * from service_audit where service_id = #{Sid} and type=#{auditType} and result = 0")
    ServiceAudit findAuditLast(@Param("Sid") Integer Sid, @Param("auditType")Integer auditType);

    @Select("select * from service_audit where service_id = #{id} and result in (1,2)")
    List<ServiceAudit> flowInfo(Integer id);

}
