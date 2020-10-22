package com.xyst.fwgl.controller;

import com.alibaba.fastjson.JSON;
import com.xyst.fwgl.config.SystemConfig;
import com.xyst.fwgl.model.*;
import com.xyst.fwgl.service.*;
import com.xyst.fwgl.utils.PageData;
import com.xyst.fwgl.utils.PageHelp;
import com.xyst.fwgl.utils.PostToJson;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


/**
 * @Author: hyl
 * @Date: 2020/7/21 9:49
 *
 */
@RestController
@RequestMapping("service")
public class ServiceController {
    @Autowired
    private ServiceInfoService serviceInfoService;
    @Autowired
    private LogInfoService logInfoService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private SubscribeService subscribeService;
    @Autowired
    private DictionaryService dictionaryService;
    /**
     * @description 分页展示服务概要信息
     * @param request
     * @return mv 当前页面的服务概要信息
     */
    @RequestMapping("/findByPage")
    public ModelAndView findByPage(HttpServletRequest request){
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        int totalNum=serviceInfoService.countAllServiceInfo();
        int pageSize=15;
        PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
        List<ServiceInfo> serviceInfoList=serviceInfoService.findByPage(pageData.getStartPos(),pageData.getEndPos());
        mv.addObject("curPage",pageData.getPageNo());
        mv.addObject("pageSize",pageData.getPageSize());
        mv.addObject("totalPage",pageData.getTotalPageNo());
        mv.addObject("serviceInfoList",serviceInfoList);
        mv.setViewName("serviceInfoList");
        return mv;
    }
    /**
     * @description 添加服务信息
     * @param request 通过request 获取服务的属性值,最后添加到数据库
     * @param response 如果数据库中存在相同的服务名称返回2;添加成功返回1;添加失败返回0
     */
    @RequestMapping("/addServiceInfo")
    @ResponseBody
    public String addServiceInfo(HttpServletRequest request, HttpServletResponse response){
        String result;
        String name=request.getParameter("cname");
        Integer serviceType=Integer.parseInt(request.getParameter("stype"));
        Integer openType=Integer.parseInt(request.getParameter("otype"));
        String address=request.getParameter("address");
        String version=request.getParameter("version");
        String reqParams=request.getParameter("reqParams");
        String respParams=request.getParameter("respParams");
        Integer protocolType=Integer.parseInt(request.getParameter("ptype"));
        String reqMethod=request.getParameter("rtype");
        String desc=request.getParameter("desc");
        Integer firstId=Integer.parseInt(request.getParameter("firstId"));
        Integer secondId=Integer.parseInt(request.getParameter("secondId"));
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime=sdf.format(new Date());
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        logInfo.setAccessTime(createTime);
        if(loginUser==null){
            logInfo.setContent("添加名为"+name+"的服务信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent(loginUser.getUserName()+"添加名为"+name+"的服务信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        List<ServiceInfo> serviceInfoList=serviceInfoService.findByName(name);
        if(serviceInfoList.size()>0){
            result="2";
        }else {
            String uploadFolderName = "C:\\upload\\";
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            MultipartFile file = multipartRequest.getFile("uploadFile");
            String innerName = String.valueOf(System.currentTimeMillis());
            String fileType = FilenameUtils.getExtension(file.getOriginalFilename()).toLowerCase();
            String path = uploadFolderName + innerName + "." + fileType;
            try{
                FileUtils.copyInputStreamToFile(file.getInputStream(), new File(uploadFolderName, innerName + "." + fileType));
            }catch(Exception e){
                e.printStackTrace();
            }
            ServiceInfo serviceInfo = new ServiceInfo();
            serviceInfo.setName(name);
            serviceInfo.setAddress(address);
            serviceInfo.setCreateTime(createTime);
            if(secondId!=0){
                serviceInfo.setCategoryId(secondId);
            }else{
                serviceInfo.setCategoryId(firstId);
            }
            serviceInfo.setFileName(file.getOriginalFilename());
            serviceInfo.setFilePath(path);
            serviceInfo.setOpenType(openType);
            serviceInfo.setStatus(0);
            serviceInfo.setVersion(version);
            serviceInfo.setReqMethod(reqMethod);
            serviceInfo.setReqParams(reqParams);
            serviceInfo.setResParams(respParams);
            serviceInfo.setServiceType(serviceType);
            serviceInfo.setProtocolType(protocolType);
            serviceInfo.setDescription(desc);
            Integer flag = serviceInfoService.save(serviceInfo);
            if (flag>0) {
                result = "1";
            } else {
                result = "0";
            }
        }
        return result;
    }
    /**
     * @description 删除服务信息
     * @param request 获取服务的id值
     * @param response 删除成功返回1;否则返回0
     */
    @RequestMapping("/delServiceInfo")
    public void delServiceInfo(HttpServletRequest request, HttpServletResponse response){
        String result;
        int id=Integer.parseInt(request.getParameter("id"));
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("删除id为"+id+"的服务信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("删除id为"+id+"的服务信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        int flag=serviceInfoService.delete(id);
        if(flag>0){
            result="1";
        }else{
            result="0";
        }
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"msg\":\""+result+"\"}");
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    /**
     * @description 通过服务id 获取服务信息
     * @param request 获取服务id
     * @param response 如果存在则返回服务对象;否则返回null
     */
    @ResponseBody
    @RequestMapping("/getServiceInfo")
    public void getServiceInfo(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("----------getServiceInfo-------------------------");
        int id = Integer.parseInt(request.getParameter("id"));
        System.out.println("id="+id);
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("获取服务信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent(loginUser.getUserName()+"获取服务信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        ServiceInfo serviceInfo=serviceInfoService.findById(id);
        System.out.println("serviceInfo.name="+serviceInfo.getName());
        Category category=categoryService.findById(serviceInfo.getCategoryId());
        Category firstCategory;
        Category secondCategory;
        List<Category> firstCategoryList=categoryService.findAllFirstCategory();
        System.out.println("firstCategoryList.size="+firstCategoryList.size());
        List<Category> secondCategoryList=new ArrayList<>();
        if(category.getType()==2){
            secondCategory=category;
            firstCategory=categoryService.findById(category.getPreCategory());
            secondCategoryList=categoryService.findAllSecondCategoryByPreId(category.getPreCategory());
        }else{
            firstCategory=category;
            secondCategory=null;
        }
        for(Category category1:secondCategoryList){
         System.out.println("category1.cname="+category1.getCname());
        }
        JSONObject json=new JSONObject();
        String subFlag = "0";
        if(loginUser!=null) {
            if(loginUser.getRole()==4) {
                Subscribe subscribe = subscribeService.getActiveSubByIdAndSubscriber(id, loginUser.getUserName());
                if (subscribe != null) {
                    subFlag = "1";
                }
            }else{
                subFlag = "1";
            }
        }
        Dictionary serviceType=dictionaryService.getDictionary(serviceInfo.getServiceType());
        List<Dictionary> serviceTypeList=dictionaryService.findAllDictionaryByType(1);
        Dictionary protocalType=dictionaryService.getDictionary(serviceInfo.getProtocolType());
        List<Dictionary> protocalTypeList=dictionaryService.findAllDictionaryByType(2);
        json.put("serviceInfo",serviceInfo);
        System.out.println("subFlag="+subFlag);
        json.put("subFlag",subFlag);
        json.put("secondCategoryList",secondCategoryList);
        json.put("firstCategoryList",firstCategoryList);
        json.put("firstCategory",firstCategory);
        json.put("secondCategory",secondCategory);
        json.put("serviceType",serviceType);
        System.out.println("serviceType.name="+serviceType.getName());
        json.put("serviceTypeList",serviceTypeList);
        json.put("pType",protocalType);
        System.out.println("pType.name="+protocalType.getName());
        json.put("protocalTypeList",protocalTypeList);
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    /**
     * @description 更新服务信息
     * @param request 获取服务的最新属性值,获取更新时间后保存到数据库
     * @param response 更新成功返回1;否则返回0
     */
    @RequestMapping("/updateServiceInfo")
    @ResponseBody
    public String updateServiceInfo(HttpServletRequest request, HttpServletResponse response){
        String result;
        int id=Integer.parseInt(request.getParameter("id"));
        String name=request.getParameter("cname");
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("更新名为"+name+"的服务信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("更新名为"+name+"的服务信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        Integer serviceType=Integer.parseInt(request.getParameter("stype"));
        Integer openType=Integer.parseInt(request.getParameter("otype"));
        String address=request.getParameter("address");
        String version=request.getParameter("version");
        Integer firstId=Integer.parseInt(request.getParameter("firstCtype"));
        Integer secondId=Integer.parseInt(request.getParameter("secondCtype"));
        Integer protocolType=Integer.parseInt(request.getParameter("ptype"));
        String requestMethod=request.getParameter("rtype");
        String desc=request.getParameter("desc");
        String reqParams=request.getParameter("reqParams");
        String resParams=request.getParameter("resParams");
        String uploadFolderName = "C:\\upload\\";
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        MultipartFile file = multipartRequest.getFile("uploadFile");
        ServiceInfo serviceInfo=serviceInfoService.findById(id);
        if(file!=null&&file.getSize()>0){
            File orignFile=new File(serviceInfo.getFilePath());
            if (orignFile.isFile()) {  // 为文件时调用删除文件方法
                orignFile.delete();
            }
            String innerName = String.valueOf(System.currentTimeMillis());
            String fileType = FilenameUtils.getExtension(file.getOriginalFilename()).toLowerCase();
            String path = uploadFolderName + innerName + "." + fileType;
            try{
                FileUtils.copyInputStreamToFile(file.getInputStream(), new File(uploadFolderName, innerName + "." + fileType));
            }catch(Exception e){
                e.printStackTrace();
            }
            serviceInfo.setFilePath(path);
            serviceInfo.setFileName(file.getOriginalFilename());
        }
        serviceInfo.setName(name);
        serviceInfo.setAddress(address);
        if(secondId!=0){
            serviceInfo.setCategoryId(secondId);
        }else{
            serviceInfo.setCategoryId(firstId);
        }
        serviceInfo.setAddress(address);
        serviceInfo.setDescription(desc);
        serviceInfo.setResParams(resParams);
        serviceInfo.setReqParams(reqParams);
        serviceInfo.setReqMethod(requestMethod);
        serviceInfo.setProtocolType(protocolType);
        serviceInfo.setCreateTime(recordTime);
        serviceInfo.setName(name);
        serviceInfo.setOpenType(openType);
        serviceInfo.setStatus(0);
        serviceInfo.setVersion(version);
        serviceInfo.setServiceType(serviceType);
        int flag=serviceInfoService.update(serviceInfo);
        if(flag>0){
            result="1";
        }else{
            result="0";
        }
       return result;
    }
    @RequestMapping("/downServiceFile")
    public void downServiceFile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        /**
         * 前提：客户端已经进行了权限验证。
         * 为防止从地址栏下载文件，服务器端应先检查当前用户是否有相应的下载权限。
         */
        int id= Integer.parseInt(request.getParameter("id"));
        ServiceInfo serviceInfo=serviceInfoService.findById(id);
        //获得请求文件名
        String filename =serviceInfo.getFileName();
        //设置文件MIME类型
        response.reset();
        response.setContentType("application/x-msdownload");
        response.setHeader("Content-Type", "application/octet-stream");
        String agent = request.getHeader("User-Agent").toUpperCase(); //获得浏览器信息并转换为大写
        System.out.println("浏览器类型:"+agent);
        if (agent.indexOf("EDGE") > 0 ||agent.indexOf("MSIE") > 0 || (agent.indexOf("GECKO")>0 && agent.indexOf("RV:11")>0)) {  //IE浏览器和Edge浏览器
            filename = URLEncoder.encode(filename, "UTF-8");
        } else {  //其他浏览器
            filename = new String(filename.getBytes("UTF-8"), "iso-8859-1");
        }
        response.setHeader("content-disposition", "attachment;filename=" + filename);
        String fullFileName = serviceInfo.getFilePath();
        //System.out.println(fullFileName);
        //读取文件
        InputStream in = new FileInputStream(fullFileName);
        OutputStream out = response.getOutputStream();

        //写文件
        int b;
        while((b=in.read())!= -1)
        {
            out.write(b);
        }

        in.close();
        out.close();
    }
    /* 黄东东 2020-8-9  查看信息*/
    @RequestMapping("/serviceInfo")
    public ServiceInfo serviceInfo(Integer id){
        ServiceInfo serviceInfo = serviceInfoService.findById(id);
        return serviceInfo;
    }

    /* 申请卸载/作废 */
    @RequestMapping("/applyService")
    public String applyService(Integer id,Integer type){
        System.out.println("id="+id+";type="+type);
        String sta = "1";
        int x = serviceInfoService.applyService(id,type);
        if(x<0){
            sta = "0";
        }
        return sta;
    }
    /**
     * @description 通过服务地址获取服务的调用详情
     * @param request 获取服务地址
     * @param response 如果存在则返回服务对象;否则返回null
     */
    @ResponseBody
    @RequestMapping("/getAccessNumByAddress")
    public void getAccessNumByAddress(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("----------getAccessNumByAddress-------------------------");
        String address = request.getParameter("address");
        com.alibaba.fastjson.JSONObject jsonObject = new com.alibaba.fastjson.JSONObject();
        String url = SystemConfig.url+"/shiro/calltimes/all";//查询所有服务调用次数
        PostToJson postToJson = new PostToJson();
        String send = postToJson.send(url,jsonObject,"utf-8","");
        jsonObject=(com.alibaba.fastjson.JSONObject) com.alibaba.fastjson.JSONObject.parse(send);
        String result=jsonObject.get("result").toString();
        List<HashMap> list = JSON.parseArray(result, HashMap.class);
        List<String> userNameList=new ArrayList<>();
        List<Integer> times=new ArrayList<>();
        for(int i=0;i<list.size();i++){
            if(list.get(i).get("serviceUrl").equals(address)){
                //System.out.println("serviceUrl="+list.get(i).get("serviceUrl"));
                userNameList.add(list.get(i).get("userName").toString());
                times.add(Integer.parseInt(list.get(i).get("times").toString()));
            }
        }
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("获取服务信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent(loginUser.getUserName()+"获取服务信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        JSONObject json=new JSONObject();
        for(String userName:userNameList){
            System.out.println(userName);
        }
        for(Integer time:times){
            System.out.println(time);
        }
        json.put("userNameList",userNameList);
        json.put("times",times);
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
