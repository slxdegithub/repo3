package com.xyst.fwgl.service.impl;

import com.xyst.fwgl.mapper.ServiceAuditMapper;
import com.xyst.fwgl.mapper.ServiceInfoMapper;
import com.xyst.fwgl.model.ServiceAudit;
import com.xyst.fwgl.model.ServiceInfo;
import com.xyst.fwgl.service.ServiceAuditService;
import com.xyst.fwgl.utils.ServiceAuditUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ServiceAuditServiceImpl implements ServiceAuditService {
    @Resource
    private ServiceAuditMapper serviceAuditMapper;
    @Resource
    private ServiceInfoMapper serviceInfoMapper;

    @Override
    public ServiceAudit findById(Integer id) {
        Example example=new Example(ServiceAudit.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("id", id);
        List<ServiceAudit> lists = serviceAuditMapper.selectByExample(example);
        return lists.get(0);
    }

    @Override
    public List<ServiceAudit> findAll() {
        return serviceAuditMapper.selectAll();
    }

    @Override
    public List<ServiceAudit> findByServiceId(Integer serviceId) {
        Example example=new Example(ServiceAudit.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("serviceId", serviceId);
        List<ServiceAudit> lists = serviceAuditMapper.selectByExample(example);
        return lists;
    }

    @Override
    public Integer save(ServiceAudit serviceAudit) {
        return serviceAuditMapper.insert(serviceAudit);
    }

    @Override
    public Integer update(ServiceAudit serviceAudit) {
        return serviceAuditMapper.updateByPrimaryKeySelective(serviceAudit);
    }

    //hdd

    @Transactional
    @Override
    public int saveAudit(Integer Sid,String reason,Integer result,Integer auditType) {
        ServiceAudit audit = serviceAuditMapper.findAuditLast(Sid,auditType);
        System.out.println("对象为空？"+ StringUtils.isEmpty(audit));
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        audit.setAuditTime(sdf.format(date));
        audit.setReason(reason);
        audit.setResult(result);

        ServiceInfo serviceInfo = serviceInfoMapper.selectByPrimaryKey(Sid);
        int sta = 0;
        if(audit.getType()==1){
            if(audit.getResult()==1){
                sta = 2;
                serviceInfo.setMountTime(sdf.format(date));
            }else{
                sta = 3;
            }
        }else if(audit.getType()==2){
            if(audit.getResult()==1){
                sta = 5;
                serviceInfo.setCancelTime(sdf.format(date));
            }else{
                sta = 6;
            }
        }else if(audit.getType()==3){
            if(audit.getResult()==1){
                serviceInfo.setUnmountTime(sdf.format(date));
                sta = 8;
            }else{
                sta = 9;
            }
        }
        serviceInfo.setStatus(sta);//
        int x = serviceAuditMapper.updateByPrimaryKeySelective(audit);
        int y = serviceInfoMapper.updateByPrimaryKeySelective(serviceInfo);
        if (x>0&&y>0){
            return 1;
        }else {
            return 0;
        }
    }

    @Override
    public String unloadInfo(Integer id) {
        List<ServiceAudit> audits = serviceAuditMapper.findBySId(id);
        String set = "";
        for(ServiceAudit audit : audits){
            set = set + ",;"+audit.getReason()+",;"+audit.getAuditTime();
        }
        set = set.substring(2);
        System.out.println("set="+set);
        return set;
    }

    @Override
    public String deleteInfo(Integer id) {
        List<ServiceAudit> audits = serviceAuditMapper.findBySId3(id);
        String set = "";
        for(ServiceAudit audit : audits){
            set = set + ",;"+audit.getReason()+",;"+audit.getAuditTime();
        }
        set = set.substring(2);
        System.out.println("set="+set);
        return  set;
    }

    @Override
    public String submitInfo(Integer id) {
        List<ServiceAudit> audits = serviceAuditMapper.findBySId1(id);
        String set = "";
        for(ServiceAudit audit : audits){
            set = set + ",;"+audit.getReason()+",;"+audit.getAuditTime();
        }
        set = set.substring(2);
        System.out.println("set="+set);
        return set;
    }

    @Override
    public List<ServiceAuditUtil> flowInfo(Integer id) {
        List<ServiceAuditUtil> auditUtils = new ArrayList<>();
        List<ServiceAudit> audits = serviceAuditMapper.flowInfo(id);
        for(ServiceAudit audit : audits){
            ServiceAuditUtil auditUtil = new ServiceAuditUtil();
            if(audit.getType()==1){
                auditUtil.setOperate("挂载申请");
            }else if(audit.getType()==2){
                auditUtil.setOperate("卸载申请");
            }else{
                auditUtil.setOperate("作废申请");
            }
            if(audit.getResult()==1){
                auditUtil.setResult("成功");
            }else {
                auditUtil.setResult("失败");
            }
            auditUtil.setReason(audit.getReason());
            auditUtil.setAuditTime(audit.getAuditTime());
            auditUtil.setId(audit.getId());
            auditUtils.add(auditUtil);
        }
        return auditUtils;
    }
}
