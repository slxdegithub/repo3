package com.xyst.fwgl.controller;

import com.google.gson.Gson;
import com.xyst.fwgl.model.LogInfo;
import com.xyst.fwgl.model.ServiceAudit;
import com.xyst.fwgl.model.ServiceInfo;
import com.xyst.fwgl.model.User;
import com.xyst.fwgl.service.LogInfoService;
import com.xyst.fwgl.service.ServiceAuditService;
import com.xyst.fwgl.service.ServiceInfoService;
import com.xyst.fwgl.utils.ServiceAuditUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @Author: hyl
 * @Date: 2020/7/21 10:31
 */
@RestController
@RequestMapping("serviceAudit")
public class ServiceAuditController {
    @Autowired
    private ServiceAuditService serviceAuditService;
    @Autowired
    private ServiceInfoService serviceInfoService;
    @Autowired
    private LogInfoService logInfoService;

    private static Logger logger = LoggerFactory.getLogger(ServiceAuditController.class);
    /**
     * @description   提交发布审核
     * @param request 通过request 获取服务的id,在service_audit表中创建一条发布审核
     *                记录,创建成功后更新service_info的status为1
     * @param response 提交成功返回1;提交失败返回0
     */
    @RequestMapping("/applyRelease")
    @Transactional
    public void applyRelease(HttpServletRequest request, HttpServletResponse response){
        String result;
        LogInfo logInfo=new LogInfo();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("匿名用户申请发布服务");
        }else{
            logInfo.setContent(loginUser.getUserName()+"申请发布服务");
        }
        logInfoService.save(logInfo);
        Integer id=Integer.parseInt(request.getParameter("id"));
        ServiceAudit serviceAudit=new ServiceAudit();
        serviceAudit.setServiceId(id);
        serviceAudit.setType(1);
        Integer flag=serviceAuditService.save(serviceAudit);
        if (flag>0) {
            ServiceInfo serviceInfo=serviceInfoService.findById(id);
            serviceInfo.setStatus(1);
            flag=serviceInfoService.update(serviceInfo);
            if(flag>0) {
                result = "1";
            }else{
                result="0";
            }
        } else {
            result = "0";
        }
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"msg\":\""+result+"\"}");
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    /**
     * @description   审核服务发布
     * @param request 通过request 获取服务审核的id以及审核结果,将相应值更新service_audit表
     *                相应记录;更新成功后,如果auditResult为1,再更新service_info的status为2,否则为3
     * @param response 审核成功返回1;审核失败返回0
     */
    @RequestMapping("/releaseAudit")
    @Transactional
    public void releaseAudit(HttpServletRequest request, HttpServletResponse response){
        String result;
        LogInfo logInfo=new LogInfo();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("匿名用户审核服务发布");
        }else{
            logInfo.setContent(loginUser.getUserName()+"审核服务发布");
        }
        logInfoService.save(logInfo);
        Integer id=Integer.parseInt(request.getParameter("id"));
        Integer auditResult=Integer.parseInt(request.getParameter("auditResult"));
        ServiceAudit serviceAudit=serviceAuditService.findById(id);
        serviceAudit.setResult(auditResult);
        if(auditResult>1){
            String reason=request.getParameter("reason");
            serviceAudit.setReason(reason);
        }
        serviceAudit.setAuditTime(recordTime);
        Integer flag=serviceAuditService.update(serviceAudit);
        if (flag>0) {
            ServiceInfo serviceInfo=serviceInfoService.findById(serviceAudit.getServiceId());
            if(auditResult==1){
                serviceInfo.setStatus(2);
            }else{
                serviceInfo.setStatus(3);
            }
            flag=serviceInfoService.update(serviceInfo);
            if(flag>0) {
                result = "1";
            }else{
                result="0";
            }
        } else {
            result = "0";
        }
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"msg\":\""+result+"\"}");
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    /**
     * @description 展示指定服务的审核记录
     * @param request
     * @return mv 指定服务的审核记录信息
     */
    @RequestMapping("/findByServiceId")
    public ModelAndView findByServiceId(HttpServletRequest request){
        ModelAndView mv=new ModelAndView();
        Integer id=Integer.parseInt(request.getParameter("id"));
        LogInfo logInfo=new LogInfo();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("匿名用户获取id为"+id+"的服务审核信息");
        }else{
            logInfo.setContent(loginUser.getUserName()+"获取id为"+id+"的服务审核信息");
        }
        logInfoService.save(logInfo);
        List<ServiceAudit> serviceAuditList=serviceAuditService.findByServiceId(id);
        mv.addObject("serviceAuditList",serviceAuditList);
        mv.setViewName("serviceAuditList");
        return mv;
    }
    /**
     * @description   提交服务作废审核
     * @param request 通过request 获取服务的id,在service_audit表中创建一条服务作废审核
     *                记录,创建成功后更新service_info的status为4
     * @param response 提交成功返回1;提交失败返回0
     */
    @RequestMapping("/applyCancel")
    @Transactional
    public void applyCancel(HttpServletRequest request, HttpServletResponse response){
        String result;
        LogInfo logInfo=new LogInfo();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("匿名用户申请发布作废");
        }else{
            logInfo.setContent(loginUser.getUserName()+"申请发布作废");
        }
        logInfoService.save(logInfo);
        Integer id=Integer.parseInt(request.getParameter("id"));
        ServiceAudit serviceAudit=new ServiceAudit();
        serviceAudit.setServiceId(id);
        serviceAudit.setType(2);
        Integer flag=serviceAuditService.save(serviceAudit);
        if (flag>0) {
            ServiceInfo serviceInfo=serviceInfoService.findById(id);
            serviceInfo.setStatus(4);
            flag=serviceInfoService.update(serviceInfo);
            if(flag>0) {
                result = "1";
            }else{
                result="0";
            }
        } else {
            result = "0";
        }
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"msg\":\""+result+"\"}");
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    /**
     * @description   审核服务作废
     * @param request 通过request 获取服务审核的id以及审核结果,将相应值更新service_audit表
     *                相应记录;更新成功后,如果auditResult为1,再更新service_info的status为5,否则为6
     * @param response 审核成功返回1;审核失败返回0
     */
    @RequestMapping("/cancelAudit")
    @Transactional
    public void cancelAudit(HttpServletRequest request, HttpServletResponse response){
        String result;
        LogInfo logInfo=new LogInfo();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("审核服务作废");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("审核服务作废");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        Integer id=Integer.parseInt(request.getParameter("id"));
        Integer auditResult=Integer.parseInt(request.getParameter("auditResult"));
        ServiceAudit serviceAudit=serviceAuditService.findById(id);
        serviceAudit.setResult(auditResult);
        if(auditResult>1){
            String reason=request.getParameter("reason");
            serviceAudit.setReason(reason);
        }
        serviceAudit.setAuditTime(recordTime);
        Integer flag=serviceAuditService.update(serviceAudit);
        if (flag>0) {
            ServiceInfo serviceInfo=serviceInfoService.findById(serviceAudit.getServiceId());
            if(auditResult==1){
                serviceInfo.setStatus(5);
            }else{
                serviceInfo.setStatus(6);
            }
            flag=serviceInfoService.update(serviceInfo);
            if(flag>0) {
                result = "1";
            }else{
                result="0";
            }
        } else {
            result = "0";
        }
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"msg\":\""+result+"\"}");
        }catch(Exception e){
            e.printStackTrace();
        }
    }


    /* 黄东东 2020-8-10  审批*/
    @RequestMapping("/saveAudit")
    public String saveAudit(Integer Sid,String reason,Integer result,Integer auditType){
        logger.info("审批：sid="+Sid+";reason="+reason+";result="+result+";auditType="+auditType);
        String sta = "1";
        int x = serviceAuditService.saveAudit(Sid,reason,result,auditType);
        if(x<0){
            sta="0";
        }
        return sta;
    }

    @RequestMapping("/unloadInfo")
    public String unloadInfo(Integer id){
        String sta= serviceAuditService.unloadInfo(id);
        logger.info("信息："+sta);
        return sta;
    }

    @RequestMapping("/deleteInfo")
    public String deleteInfo(Integer id){
        String sta= serviceAuditService.deleteInfo(id);
        return sta;
    }

    @RequestMapping("/submitInfo")
    public String submitInfo(Integer id){
        String sta = serviceAuditService.submitInfo(id);
        return sta;
    }

    @RequestMapping("/flowInfo")
    public String flowInfo(Integer id,HttpServletResponse response){
        List<ServiceAuditUtil> auditUtils =  serviceAuditService.flowInfo(id);
        String jsons = "";
        for (ServiceAuditUtil auditUtil : auditUtils){
            Gson gson = new Gson();
            String json = gson.toJson(auditUtil);
            logger.info("json="+json);
            jsons = jsons +";;;"+json;
        }
        jsons = jsons.substring(3);
        logger.info("jsons="+jsons);

        return jsons;
    }


    /* 黄东东结束 */

}
