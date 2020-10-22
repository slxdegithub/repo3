package com.xyst.fwgl.controller;

import com.xyst.fwgl.config.SystemConfig;
import com.xyst.fwgl.model.*;
import com.xyst.fwgl.service.*;
import com.xyst.fwgl.utils.PostToJson;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author: hyl
 * @Date: 2020/7/21 17:23
 */
@Controller
@RequestMapping("/sub")
public class SubscribeController {
    @Autowired
    private SubscribeService subscribeService;
    @Autowired
    private LogInfoService logInfoService;
    @Autowired
    private SubscribeAuditService subscribeAuditService;
    @Autowired
    private ServiceInfoService serviceInfoService;
    /**
     * @description   申请订阅服务
     * @param request 通过request 获取服务的id,在session中获取申请者的Id,在subscribe以及subscribe_audit表中分别
     *                生成相应的记录
     * @param response 提交成功返回1;提交失败返回0
     */
    @RequestMapping("/applySub")
    @Transactional
    public void applySub(HttpServletRequest request, HttpServletResponse response){
        String result;
        LogInfo logInfo=new LogInfo();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("申请订阅服务");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("申请订阅服务");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        Integer id=Integer.parseInt(request.getParameter("id"));
        Subscribe subscribe;
        List<Subscribe> subscribeList=subscribeService.findByServiceIdAndSubscriber(id,loginUser.getUserName());
        Integer flag;
        if(subscribeList!=null&&subscribeList.size()>0){
            subscribe=subscribeList.get(0);
            subscribe.setApplyTime(recordTime);
            subscribe.setServiceId(id);
            subscribe.setStatus(1);
            subscribe.setSubscriber(loginUser.getUserName());
            System.out.println(loginUser.getTransMedium());
            subscribe.setTransMedium(loginUser.getTransMedium());
            flag=subscribeService.update(subscribe);
        }else {
            subscribe = new Subscribe();
            subscribe.setApplyTime(recordTime);
            subscribe.setServiceId(id);
            subscribe.setStatus(1);
            subscribe.setSubscriber(loginUser.getUserName());
            subscribe.setTransMedium(loginUser.getTransMedium());
            flag=subscribeService.save(subscribe);
        }
        if (flag>0) {
            Subscribe subscribe1=subscribeService.findByServiceIdAndSubscriberAndStatus(subscribe.getServiceId(),subscribe.getSubscriber(),subscribe.getStatus()).get(0);
            SubscribeAudit subscribeAudit=new SubscribeAudit();
            subscribeAudit.setSubscribeId(subscribe1.getId());
            subscribeAudit.setType(1);
            subscribeAudit.setResult(0);
            flag=subscribeAuditService.save(subscribeAudit);
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
     * @description   申请取消订阅服务
     * @param request 通过request 获取服务的id,在session中获取申请者的Id,更新subscribe记录以及在subscribe_audit表中
     *                生成相应的记录
     * @param response 提交成功返回1;提交失败返回0
     */
    @RequestMapping("/cancelSub")
    @ResponseBody
    @Transactional
    public String cancelSub(HttpServletRequest request, HttpServletResponse response){
        System.out.println("--------cancelSub---------");
        String result;
        LogInfo logInfo=new LogInfo();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("申请取消订阅服务");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("申请取消订阅服务");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        Integer id=Integer.parseInt(request.getParameter("id"));
        List<Subscribe> subscribeList=subscribeService.findByServiceIdAndSubscriberAndStatus(id,loginUser.getUserName(),2);
        if(subscribeList!=null&&subscribeList.size()>0) {
        }else{
            subscribeList=subscribeService.findByServiceIdAndSubscriberAndStatus(id,loginUser.getUserName(),6);
        }
        Subscribe subscribe=subscribeList.get(0);
        System.out.println();
        subscribe.setStatus(4);
        subscribe.setApplyTime(recordTime);
        Integer flag=subscribeService.update(subscribe);
        if (flag>0) {
            SubscribeAudit subscribeAudit=new SubscribeAudit();
            subscribeAudit.setSubscribeId(subscribe.getId());
            subscribeAudit.setType(2);
            subscribeAudit.setResult(0);
            flag=subscribeAuditService.save(subscribeAudit);
            if(flag>0) {
                result = "1";
            }else{
                result="0";
            }
        } else {
            result = "0";
        }
        System.out.println("result="+result);
        JSONObject json=new JSONObject();
        json.put("result",result);
        return json.toString();
    }
    /**
     * @description   审核服务订阅申请
     * @param request 通过request 获取服务订阅申请的id以及审核结果,将相应值更新subscribe_audit表
     *                相应记录;更新成功后,如果auditResult为1,再更新subscribe的status为2,否则为3
     * @param response 审核成功返回1;审核失败返回0
     */
    @RequestMapping("/subAudit")
    @Transactional
    public void subAudit(HttpServletRequest request, HttpServletResponse response) throws Exception{
        System.out.println("-----------subAudit--------------");
        String result="";
        LogInfo logInfo=new LogInfo();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("审核服务订阅申请");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("审核服务订阅申请");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfoService.save(logInfo);
        Integer id=Integer.parseInt(request.getParameter("Sid"));
        System.out.println("Sid="+id);
        Integer auditResult=Integer.parseInt(request.getParameter("result"));
        SubscribeAudit subscribeAudit=subscribeAuditService.findBySubcribeIdAndResult(id,0).get(0);
        System.out.println("------------subscribeAudit-------------------------");
        System.out.println();
        subscribeAudit.setResult(auditResult);
        if(auditResult>1){
            String reason=request.getParameter("reason");
            subscribeAudit.setReason(reason);
        }
        subscribeAudit.setAuditTime(recordTime);
        Integer flag=subscribeAuditService.update(subscribeAudit);
        if (flag>0) {
            Subscribe subscribe=subscribeService.findById(subscribeAudit.getSubscribeId());
            ServiceInfo serviceInfo=serviceInfoService.findById(subscribe.getServiceId());
            if(auditResult==1){
                String url = SystemConfig.url+"/bus/service/subscription";//登录
                com.alibaba.fastjson.JSONObject jsonObject = new com.alibaba.fastjson.JSONObject();
                jsonObject.put("serviceCode","service"+serviceInfo.getId());
                jsonObject.put("serviceName",serviceInfo.getName());
                jsonObject.put("transMedium",subscribe.getTransMedium());
                jsonObject.put("expiryDate","");
                PostToJson postToJson = new PostToJson();
                String pResult = postToJson.send(url,jsonObject,"utf-8",loginUser.getToken());
                com.alibaba.fastjson.JSONObject object = (com.alibaba.fastjson.JSONObject) com.alibaba.fastjson.JSONObject.parse(pResult);
                String messageCode = String.valueOf(object.get("messageCode"));
                System.out.println("messageCode="+messageCode);
                if(messageCode.equals("200")) {
                    subscribe.setStatus(2);
                    subscribe.setDescribeTime(recordTime);
                    flag=subscribeService.update(subscribe);
                }else{
                    flag=0;
                }
            }else{
                subscribe.setStatus(3);
                flag=subscribeService.update(subscribe);
            }
            if(flag>0) {
                result = "1";
            }else{
                result="0";
            }
        } else {
            result = "0";
        }
        System.out.println("result="+result);
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"msg\":\""+result+"\"}");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    /**
     * @description   审核取消服务订阅申请
     * @param request 通过request 获取取消服务订阅申请的id以及审核结果,将相应值更新subscribe_audit表
     *                相应记录;更新成功后,如果auditResult为1,再更新subscribe的status为2,否则为3
     * @param response 审核成功返回1;审核失败返回0
     */
    @RequestMapping("/cancelSubAudit")
    @Transactional
    public void cancelSubAudit(HttpServletRequest request, HttpServletResponse response)throws Exception{
        String result;
        LogInfo logInfo=new LogInfo();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("审核取消服务订阅申请");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("审核取消服务订阅申请");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        Integer id=Integer.parseInt(request.getParameter("Sid"));
        Integer auditResult=Integer.parseInt(request.getParameter("result"));
        SubscribeAudit subscribeAudit=subscribeAuditService.findBySubcribeIdAndResult(id,0).get(0);
        subscribeAudit.setResult(auditResult);
        if(auditResult>1){
            String reason=request.getParameter("reason");
            subscribeAudit.setReason(reason);
        }
        subscribeAudit.setAuditTime(recordTime);
        Integer flag=subscribeAuditService.update(subscribeAudit);
        if (flag>0) {
            Subscribe subscribe=subscribeService.findById(subscribeAudit.getSubscribeId());
            ServiceInfo serviceInfo=serviceInfoService.findById(subscribe.getServiceId());
            if(auditResult==1){
                String url = SystemConfig.url+"/bus/service/cancel";//登录
                com.alibaba.fastjson.JSONObject jsonObject = new com.alibaba.fastjson.JSONObject();
                jsonObject.put("serviceCode","service"+serviceInfo.getId());
                jsonObject.put("serviceName",serviceInfo.getName());
                jsonObject.put("transMedium",subscribe.getTransMedium());
                PostToJson postToJson = new PostToJson();
                String pResult = postToJson.send(url,jsonObject,"utf-8",loginUser.getToken());
                com.alibaba.fastjson.JSONObject object = (com.alibaba.fastjson.JSONObject) com.alibaba.fastjson.JSONObject.parse(pResult);
                String messageCode = String.valueOf(object.get("messageCode"));
                System.out.println("messageCode="+messageCode);
                if(messageCode.equals("200")) {
                    subscribe.setStatus(5);
                    subscribe.setCancelTime(recordTime);
                }
            }else{
                subscribe.setStatus(6);
            }
            flag=subscribeService.update(subscribe);
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
    @ResponseBody
    @RequestMapping("/getSubscribeAuditList")
    public void getComplaint(HttpServletRequest request, HttpServletResponse response){
        System.out.println("----getSubscribeAuditList------");
        int id=Integer.parseInt(request.getParameter("id"));
        List<SubscribeAudit> subscribeAuditList=subscribeAuditService.findBySubcribeId(id);
        JSONObject json=new JSONObject();
        json.put("subscribeAuditList",subscribeAuditList);
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
    }

}
