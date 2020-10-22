package com.xyst.fwgl.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xyst.fwgl.config.SystemConfig;
import com.xyst.fwgl.model.*;
import com.xyst.fwgl.model.Dictionary;
import com.xyst.fwgl.service.*;
import com.xyst.fwgl.utils.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;


@Controller
public class LoginController {
    @Autowired
    private UserService userService;
    @Autowired
    private LogInfoService logInfoService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ServiceInfoService serviceInfoService;
    @Autowired
    private SubscribeService subscribeService;
    @Autowired
    private NoticeService noticeService;
    @Autowired
    private GuideService guideService;
    @Autowired
    private DictionaryService dictionaryService;    @Autowired
    private RedisService redisService;


    private static Logger logger = LoggerFactory.getLogger(LoginController.class);

    //登录界面
    @RequestMapping("/login")
    public ModelAndView toLogin(HttpServletRequest request){
        ModelAndView mv=new ModelAndView();
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        logInfo.setUserName("匿名用户");
        logInfo.setContent("进入登录页面");
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        mv.setViewName("login");
        return mv;//返回登录界面
    }
    @RequestMapping("/loginsys")
    public ModelAndView loginSystem(HttpServletRequest request, HttpSession session)throws Exception{
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        request.getSession().setAttribute("username", username);
        ModelAndView mv=new ModelAndView();
        if(username.equals("")||password.equals("")){
            mv.addObject("info", "用户名或密码不能为空");
            mv.setViewName("login");
        }else{
            password = MD5Util.getMD5Str(password);
            String applicationKey = "xt2";
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("applicationKey",applicationKey);
            jsonObject.put("userName",username);
            jsonObject.put("password",password);
            String url = SystemConfig.url+"/shiro/auth/token";//登录
                    PostToJson postToJson = new PostToJson();
            String result = postToJson.send(url,jsonObject,"utf-8","");
            JSONObject object = (JSONObject) JSONObject.parse(result);
            String messageCode = String.valueOf(object.get("messageCode"));
            String message = String.valueOf(object.get("message"));
            System.out.println(result);
            System.out.println("messageCode="+messageCode);
            if(message.equals("用户名或密码输入错误!")||message.equals("登录用户不存在!")){
                mv.addObject("loginType","0");
                mv.addObject("info", "用户名或密码不正确");
                mv.setViewName("login");
            }else{
                if(messageCode.equals("601")){ //返回修改密码界面   创建user
                    session.setAttribute("userName",username);
                    mv.addObject("loginType","1");
                    //mv.addObject("info", "请修改密码");
                    mv.setViewName("login");
                }else{

                    JSONObject resultJson = (JSONObject)JSONObject.parse(String.valueOf(object.get("result")));
                    String token = String.valueOf(resultJson.get("token"));//&*
                    /*  访问后台获取用户角色信息  */
                    String url2 = SystemConfig.url+"/shiro/user/current";//获取用户信息
                    String result2 = postToJson.send(url2,jsonObject,"utf-8",token);
                    System.out.println(result2);
                    JSONObject object2 = (JSONObject) JSONObject.parse(result2);
                    JSONObject object2Result = (JSONObject) JSONObject.parse(object2.get("result").toString());
                    JSONObject objectUser = (JSONObject) JSONObject.parse(object2Result.get("user").toString());
                    String transMedium = objectUser.get("transMedium").toString();
                    System.out.println("transMedium="+transMedium);
                    System.out.println("object2Result="+object2Result);
                    JSONArray roles = JSONArray.parseArray(object2Result.get("role").toString());
                    Integer role = 0;
                    for (int i=0; i<roles.size();i++){
                        JSONObject roleArray = (JSONObject) roles.get(i);
                        System.out.println("json数组：产生="+roleArray);
                        String applicationKey2 = roleArray.get("applicationKey").toString();
                        if(applicationKey2.equals("xt2")){
                            String roleName = roleArray.get("roleName").toString();
                            if(roleName.equals("超级管理员")){
                                role = 1;
                            }else if(roleName.equals("操作员")){
                                role = 2;
                            }else if(roleName.equals("审核员")){
                                role = 3;
                            }else {
                                role = 4;
                            }
                        }
                    }
                    User user = new User();
                    user.setPassword(password);
                    user.setUserName(username);
                    user.setRole(role);
                    user.setToken(token);
                    user.setTransMedium(transMedium);
                    session.setAttribute("loginUser",user);
                    redisService.setHash(RedisConstants.REDIS_PHJR_SSO_TOKEN,username,token,3600000, TimeUnit.MICROSECONDS);
                    System.out.println("========="+redisService.getHash(RedisConstants.REDIS_PHJR_SSO_TOKEN,username));
                    mv.setViewName("userCenter");//登录成功！
                }
            }
        }
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        LogInfo logInfo=new LogInfo();
        logInfo.setAccessTime(recordTime);
        if(StringUtils.isEmpty(loginUser)){
            logInfo.setContent("登录系统");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("登录系统");
            logInfo.setUserName(username);
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        return mv;
    }

    @RequestMapping("/updatePassword")
    public ModelAndView updatePassword(HttpServletRequest request,HttpSession session)throws Exception{
        ModelAndView mv = new ModelAndView();
        String password1=request.getParameter("new_password1");
        String password2=request.getParameter("new_password2");
        if(password1.equals(password2)){
            String userName = (String) session.getAttribute("userName");
            String password = MD5Util.getMD5Str(password1);
            String applicationKey = "xt2";
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("applicationKey",applicationKey);
            jsonObject.put("userName",userName);
            jsonObject.put("password",password);
            String url = SystemConfig.url+"/shiro/auth/firstLogin";//获取用户信息
            PostToJson postToJson = new PostToJson();
            String result = postToJson.send(url,jsonObject,"utf-8","");
            JSONObject object = (JSONObject) JSONObject.parse(result);
            String messageCode = String.valueOf(object.get("messageCode"));
            //System.out.println("修改密码messageCode="+messageCode);
            if(messageCode.equals("200")){
                mv.addObject("loginType","0");//修改成功！
//                mv.addObject("info", "系统错误");
                mv.setViewName("login");
            }else {
                mv.addObject("loginType","1");
                mv.addObject("info", "系统错误");
                mv.setViewName("login");
            }

        }else {
            mv.addObject("loginType","1");
            mv.addObject("info", "两次密码不相同");
            mv.setViewName("login");
        }
        return mv;
    }

    @RequestMapping("/loginout")
    public ModelAndView loginout(HttpServletRequest request, HttpSession session)throws Exception{
        ModelAndView mv=new ModelAndView();
        User loginUser=(User)session.getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        if(loginUser!=null) {
            System.out.println("loginUser.name=" + loginUser.getUserName());
            logInfo.setUserName(loginUser.getUserName());
        }else{
            logInfo.setUserName("匿名用户");
        }
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());

        logInfo.setAccessTime(recordTime);
        logInfo.setIpAddress(request.getRemoteAddr());

        logInfo.setContent("退出登录系统");
        logInfoService.save(logInfo);
        if(loginUser!=null) {
            String userName = loginUser.getUserName();
            JSONObject object = new JSONObject();
            object.put("userName", userName);
            PostToJson postToJson = new PostToJson();
            String url = SystemConfig.url + "/shiro/auth/logout";
            String result = postToJson.send(url, object, "utf-8", loginUser.getToken());
            JSONObject loginOut = (JSONObject) JSONObject.parse(result);
            String messageCode = loginOut.get("messageCode").toString();
            System.out.println("退出登录执行结果：" + messageCode);
            if (messageCode.equals("200")) {
                redisService.deleteHash(RedisConstants.REDIS_PHJR_SSO_TOKEN,loginUser.getUserName());
                session.removeAttribute("loginUser");
                session.invalidate();
            }
        }
        mv.setViewName("redirect:/index");
        return mv;
    }
    @RequestMapping("/main")
    public ModelAndView main(HttpServletRequest request){
        ModelAndView mv=new ModelAndView();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        LogInfo logInfo=new LogInfo();
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("进入index页面");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("进入main页面");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        mv.setViewName("login");
        return mv;
    }

    //登录界面
    @RequestMapping("/userCenter")
    public ModelAndView toUserCenter(HttpServletRequest request){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("userCenter");
        return mv;//返回登录界面

    }

    @RequestMapping("/categoryList")
    @Transactional
    public ModelAndView categoryList(HttpServletRequest request) throws Exception{
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        String type=request.getParameter("findType");
        int findType;
        if(type==null||type.equals("")){
            findType=0;
        }else{
            findType=Integer.parseInt(type);
        }
        String size = request.getParameter("pageSize");
        int pageSize;
        if(size==null||size.equals("")){
            pageSize=0;
        }else{
            pageSize=Integer.parseInt(size);
        }
        if(findType==0) {
            System.out.println("pageNo=" + pageNo);
            int totalNum = categoryService.countAllCategory();
            System.out.println("totalNum=" + totalNum);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Category> categoryList = categoryService.findByPage(pageData.getStartPos(), pageData.getEndPos());
            List<Category> firstCategoryList=new ArrayList<>();
            for(Category category:categoryList){
                firstCategoryList.add(categoryService.findById(category.getPreCategory()));
            }
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("categoryList", categoryList);
            mv.addObject("firstCategoryList", firstCategoryList);
            mv.addObject("findType", findType);
        }else if(findType==1){
            String searchName=request.getParameter("searchName");
            int totalNum = categoryService.countCategoryByName(searchName);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Category> categoryList = categoryService.findByPageAndCname(searchName,pageData.getStartPos(), pageData.getEndPos());
            List<Category> firstCategoryList=new ArrayList<>();
            for(Category category:categoryList){
                firstCategoryList.add(categoryService.findById(category.getPreCategory()));
            }
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("name", searchName);
            mv.addObject("categoryList", categoryList);
            mv.addObject("firstCategoryList", firstCategoryList);
            mv.addObject("findType", findType);
        }else{
            String range=request.getParameter("range");
            System.out.println("range="+range);
            String startDate=range.substring(0,10);
            String endDate=range.substring(13);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            Date date= sdf.parse(endDate);
            calendar.setTime(date);
            int day=calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE,day+1);
            endDate = sdf.format(calendar.getTime());
            int totalNum=categoryService.countCategoryByRange(startDate,endDate);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            List<Category> categoryList=categoryService.findByPageAndRange(startDate,endDate,pageData.getStartPos(),pageData.getEndPos());
            List<Category> firstCategoryList=new ArrayList<>();
            for(Category category:categoryList){
                firstCategoryList.add(categoryService.findById(category.getPreCategory()));
            }
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalPage",pageData.getTotalPageNo());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("time",range);
            mv.addObject("categoryList",categoryList);
            mv.addObject("firstCategoryList",firstCategoryList);
            mv.addObject("findType", findType);
        }
            User loginUser = (User) request.getSession().getAttribute("loginUser");
            LogInfo logInfo = new LogInfo();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String recordTime = sdf.format(new Date());
            logInfo.setAccessTime(recordTime);
            logInfo.setIpAddress(request.getRemoteAddr());
            if (loginUser == null) {
                logInfo.setContent("查看服务分类信息");
                logInfo.setUserName("匿名用户");
            } else {
                logInfo.setContent("查看服务分类信息");
                logInfo.setUserName(loginUser.getUserName());
            }
            logInfoService.save(logInfo);
        mv.setViewName("category");
        return mv;
    }
    //登录界面
    @RequestMapping("/serviceInfoList")
    public ModelAndView serviceInfoList(HttpServletRequest request) throws  Exception{
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        String type=request.getParameter("findType");
        int findType;
        if(type==null||type.equals("")){
            findType=0;
        }else{
            findType=Integer.parseInt(type);
        }
        String size = request.getParameter("pageSize");
        int pageSize;
        if(size==null||size.equals("")){
            pageSize=0;
        }else{
            pageSize=Integer.parseInt(size);
        }
        if(findType==0) {
            int totalNum = serviceInfoService.countServiceInfoByStatus(0);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<ServiceInfo> serviceInfoList = serviceInfoService.findByPageAndStatus(0,pageData.getStartPos(), pageData.getEndPos());
            List<Category> categoryList = new ArrayList<>();
            for (ServiceInfo serviceInfo : serviceInfoList) {
                categoryList.add(categoryService.findById(serviceInfo.getCategoryId()));
            }
            List<Category> categories = categoryService.findByStatus(2);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("categories", categories);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType",findType);
        }else if(findType==1){
            String searchName=request.getParameter("name");
            int totalNum = serviceInfoService.countServiceInfoByName(searchName);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<ServiceInfo> serviceInfoList = serviceInfoService.findByPageAndName(searchName,pageData.getStartPos(), pageData.getEndPos());
            List<Category> categoryList = new ArrayList<>();
            for (ServiceInfo serviceInfo : serviceInfoList) {
                categoryList.add(categoryService.findById(serviceInfo.getCategoryId()));
            }
            List<Category> categories = categoryService.findByStatus(2);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("categories", categories);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType",findType);
            mv.addObject("name",searchName);

        }else if(findType==2){
            String cname=request.getParameter("name");
            int totalNum = serviceInfoService.countServiceInfoByCategory(cname);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<ServiceInfo> serviceInfoList = serviceInfoService.findByPageAndCategory(cname,pageData.getStartPos(), pageData.getEndPos());
            List<Category> categoryList = new ArrayList<>();
            for (ServiceInfo serviceInfo : serviceInfoList) {
                categoryList.add(categoryService.findById(serviceInfo.getCategoryId()));
            }
            List<Category> categories = categoryService.findByStatus(2);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("categories", categories);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType",findType);
            mv.addObject("name",cname);
        }else{
            String range=request.getParameter("range");
            String startDate=range.substring(0,10);
            String endDate=range.substring(13);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            Date date= sdf.parse(endDate);
            calendar.setTime(date);
            int day=calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE,day+1);
            endDate = sdf.format(calendar.getTime());
            int totalNum=serviceInfoService.countServiceInfoByRange(startDate,endDate);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            List<ServiceInfo> serviceInfoList=serviceInfoService.findByPageAndRange(startDate,endDate,pageData.getStartPos(),pageData.getEndPos());
            List<Category> categoryList = new ArrayList<>();
            for (ServiceInfo serviceInfo : serviceInfoList) {
                categoryList.add(categoryService.findById(serviceInfo.getCategoryId()));
            }
            List<Category> categories = categoryService.findByStatus(2);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalPage",pageData.getTotalPageNo());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("time",range);
            mv.addObject("serviceInfoList",serviceInfoList);
            mv.addObject("findType", findType);
            mv.addObject("time",range);
            mv.addObject("categoryList", categoryList);
            mv.addObject("categories", categories);
        }
        mv.setViewName("serviceInfoList");
        return mv;//返回登录界面
    }

    /*
     *  2020-8-9 黄东东     2020-8-11
     * */
    @RequestMapping("/submitService")
    public ModelAndView submitService(Integer pageSize,Integer pageNo,Integer findType,String name,String time){
        logger.info("挂载服务:pageNo="+pageNo+";findType="+findType+";name="+name+";time="+time);
        ModelAndView mv = new ModelAndView();
        List<ServiceUtil> serviceUtils = new ArrayList<>();
        if(findType ==0){
            int totalNum=serviceInfoService.findTypeSubmitNum();
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            serviceUtils = serviceInfoService.findTypeSubmit(begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType == 1){
            int totalNum=serviceInfoService.findSubmitByNameNum(name);
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            serviceUtils = serviceInfoService.findSubmitByName(name,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("name",name);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType == 2){
            int totalNum=serviceInfoService.findSubmitByCnameNum(name);
            logger.info(" 手动mapper totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            serviceUtils = serviceInfoService.findSubmitByCname(name,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("name",name);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType == 3){
            String time1 = time.substring(0,10);
            String time2 = time.substring(13);
            logger.info("time1="+time1+";time2="+time2);
            time1 = time1 + " 00:00:00";
            time2 = time2 + " 00:00:00";
            int totalNum=serviceInfoService.findSubmitByTimeNum(time1,time2);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            serviceUtils = serviceInfoService.findSubmitByTime(time1,time2,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("time",time);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }

        mv.addObject("serviceInfoList",serviceUtils);
        mv.setViewName("service/submitService");
        return mv;
    }

    @RequestMapping("/unloadService")
    public ModelAndView unloadService(Integer pageSize,Integer pageNo,Integer findType,String name,String time){
        logger.info("卸载服务:pageNo="+pageNo+";findType="+findType+";name="+name+";time="+time);
        ModelAndView mv = new ModelAndView();
        //int pageSize=10;
        if(findType == 0){
            int totalNum=serviceInfoService.findTypeUnloadNum();
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findTypeUnload(begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType == 1){
            int totalNum=serviceInfoService.findUnloadByNameNum(name);
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findUnloadByName(name,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("name",name);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType == 2){
            int totalNum=serviceInfoService.findUnloadByCnameNum(name);
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findUnloadByCname(name,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("name",name);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType == 3){
            String time1 = time.substring(0,10);
            String time2 = time.substring(13);
            logger.info("time1="+time1+";time2="+time2);
            time1 = time1 + " 00:00:00";
            time2 = time2 + " 00:00:00";
            int totalNum=serviceInfoService.findUnloadByTimeNum(time1,time2);
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findUnloadByTime(time1,time2,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("time",time);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }

        mv.setViewName("service/unloadService");
        return mv;
    }

    @RequestMapping("/deleteService")
    public ModelAndView deleteService(Integer pageSize,Integer pageNo,Integer findType,String name,String time){
        logger.info("作废服务:pageNo="+pageNo+";findType="+findType+";name="+name+";time="+time);
        ModelAndView mv = new ModelAndView();
        if(findType == 0){
            int totalNum=serviceInfoService.findTypeDeleteNum();
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findTypeDelete(begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType == 1){
            int totalNum=serviceInfoService.findDeleteByNameNum(name);
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findDeleteByName(name,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("name",name);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType == 2){
            int totalNum=serviceInfoService.findDeleteByCnameNum(name);
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findDeleteByCname(name,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("name",name);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType == 3){
            String time1 = time.substring(0,10);
            String time2 = time.substring(13);
            time1 = time1 + " 00:00:00";
            time2 = time2 + " 00:00:00";
            logger.info("时间2：time1="+time1+";time2="+time2);
            int totalNum=serviceInfoService.findDeleteByTimeNum(time1,time2);
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findDeleteByTime(time1,time2,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("time",time);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }
        mv.setViewName("service/deleteService");
        return mv;
    }

    @RequestMapping("/allService")
    public ModelAndView allService(Integer pageSize,Integer pageNo,Integer findType,String name,String time){
        ModelAndView mv = new ModelAndView();
        if(findType==0){
            int totalNum = serviceInfoService.findAllServiceNum();
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findAllService(begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("name",name);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType==1){
            int totalNum=serviceInfoService.findAllByNameNum(name);
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findAllByName(name,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("name",name);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType==2){
            int totalNum=serviceInfoService.findAllByCnameNum(name);
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findAllByCname(name,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("name",name);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }else if(findType==3){
            String time1 = time.substring(0,10);
            String time2 = time.substring(13);
            time1 = time1 + " 00:00:00";
            time2 = time2 + " 00:00:00";
            logger.info("时间2：time1="+time1+";time2="+time2);
            int totalNum=serviceInfoService.findAllByTimeNum(time1,time2);
            logger.info("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            int begin = pageData.getStartPos();
            List<ServiceUtil> serviceUtils = serviceInfoService.findAllByTime(time1,time2,begin,pageSize);
            mv.addObject("findType",findType);
            mv.addObject("time",time);
            mv.addObject("serviceInfoList",serviceUtils);
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("totalPage",pageData.getTotalPageNo());
        }
        mv.setViewName("service/allService");
        return mv;
    }

    /* ***********  黄东东 2020-8-11 （结束）  *********** */

    @RequestMapping("/logInfoList")
    @Transactional
    public ModelAndView logInfoList(HttpServletRequest request) throws Exception{
        ModelAndView mv=new ModelAndView();
        String range=request.getParameter("range");
        System.out.println("range="+range);
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        String size = request.getParameter("pageSize");
        int pageSize;
        if(size==null||size.equals("")){
            pageSize=0;
        }else{
            pageSize=Integer.parseInt(size);
        }
        if(range!=null&&!range.equals("")){
            String startDate=range.substring(0,10);
            String endDate=range.substring(13);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            Date date= sdf.parse(endDate);
            calendar.setTime(date);
            int day=calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE,day+1);
            endDate = sdf.format(calendar.getTime());
            int totalNum=logInfoService.countLogInfoByRange(startDate,endDate);
           // int pageSize=10;
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            List<LogInfo> logInfoList=logInfoService.findByRangeAndPage(startDate,endDate,pageData.getStartPos(),pageData.getEndPos());
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalPage",pageData.getTotalPageNo());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("time",range);
            mv.addObject("logInfoList",logInfoList);
        }else{
            int totalNum=logInfoService.countAllLogInfo();
            System.out.println("totalNum="+totalNum);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            List<LogInfo> logInfoList=logInfoService.findByPage(pageData.getStartPos(),pageData.getEndPos());
            mv.addObject("curPage",pageData.getPageNo());
            mv.addObject("pageSize",pageData.getPageSize());
            mv.addObject("totalPage",pageData.getTotalPageNo());
            mv.addObject("totalNum",pageData.getTotalNum());
            mv.addObject("time","");
            mv.addObject("logInfoList",logInfoList);
        }
        mv.setViewName("logInfoList");
        return mv;
    }
    @RequestMapping("/subscribeList")
    public ModelAndView subscribeList(HttpServletRequest request)throws Exception{
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        String type=request.getParameter("findType");
        int findType;
        if(type==null||type.equals("")){
            findType=0;
        }else{
            findType=Integer.parseInt(type);
        }
        System.out.println("findType="+findType);
        String size = request.getParameter("pageSize");
        int pageSize;
        if(size==null||size.equals("")){
            pageSize=0;
        }else{
            pageSize=Integer.parseInt(size);
        }
        //int pageSize=10;
        if(findType==0) {
            int totalNum = subscribeService.countByStatus(1);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findByPageAndStatus(1, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            //List<User> userList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
        }else if(findType==1){
            String searchName=request.getParameter("name");
            System.out.println("searchName="+searchName);
            int totalNum = subscribeService.countLikeByNameAndStatus(searchName,1);
            System.out.println("totalNum="+totalNum);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndNameAndStatus(searchName,1, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("name", searchName);
        }else if(findType==2){
            String cname=request.getParameter("name");
            System.out.println("cname="+cname);
            int totalNum = subscribeService.countLikeByCnameAndStatus(cname,1);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndCnameAndStatus(cname,1, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("name", cname);
        }else{
            String range=request.getParameter("range");
            System.out.println("range="+range);
            String startDate=range.substring(0,10);
            String endDate=range.substring(13);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            Date date= sdf.parse(endDate);
            calendar.setTime(date);
            int day=calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE,day+1);
            endDate = sdf.format(calendar.getTime());
            System.out.println("startDate="+startDate);
            System.out.println("endDate="+endDate);
            int totalNum = subscribeService.countByRangeAndStatus(startDate,endDate,1);
            System.out.println("totalNum="+totalNum);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findByPageAndRangeAndStatus(startDate,endDate,1,pageData.getStartPos(),pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            List<User> userList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("time", range);
        }
        mv.addObject("findType",findType);
        mv.setViewName("subscribeList");
        return mv;//返回登录界面
    }
    @RequestMapping("/unSubscribeList")
    public ModelAndView unSubscribeList(HttpServletRequest request) throws Exception{
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        String type=request.getParameter("findType");
        int findType;
        if(type==null||type.equals("")){
            findType=0;
        }else{
            findType=Integer.parseInt(type);
        }
        System.out.println("findType="+findType);
        String size = request.getParameter("pageSize");
        int pageSize;
        if(size==null||size.equals("")){
            pageSize=0;
        }else{
            pageSize=Integer.parseInt(size);
        }
        //int pageSize=10;
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        if(loginUser==null){
            mv.setViewName("redirect:/login");
            return mv;
        }
        if(findType==0) {
            int totalNum = subscribeService.countByStatus(4);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findByPageAndStatus(4, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
        }else if(findType==1){
            String searchName=request.getParameter("name");
            int totalNum = subscribeService.countLikeByNameAndStatus(searchName,4);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndNameAndStatus(searchName,4, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("name", searchName);

        }else if(findType==2){
            String cname=request.getParameter("name");
            int totalNum = subscribeService.countLikeByCnameAndStatus(cname,4);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndCnameAndStatus(cname,4, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("name", cname);
        }else{
            String range=request.getParameter("range");
            String startDate=range.substring(0,10);
            String endDate=range.substring(13);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            Date date= sdf.parse(endDate);
            calendar.setTime(date);
            int day=calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE,day+1);
            endDate = sdf.format(calendar.getTime());
            int totalNum = subscribeService.countByRangeAndStatus(startDate,endDate,4);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findByPageAndRangeAndStatus(startDate,endDate,4, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("time",range);

        }
        mv.addObject("findType",findType);
        mv.setViewName("cancelSubscribeList");
        return mv;//返回登录界面
    }
    @RequestMapping("/mySubscribeList")
    public ModelAndView mySubscribeList(HttpServletRequest request, HttpServletResponse response) throws Exception{
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        String type=request.getParameter("findType");
        int findType;
        if(type==null||type.equals("")){
            findType=0;
        }else{
            findType=Integer.parseInt(type);
        }
        System.out.println("findType="+findType);
        String size = request.getParameter("pageSize");
        int pageSize;
        if(size==null||size.equals("")){
            pageSize=0;
        }else{
            pageSize=Integer.parseInt(size);
        }
        //int pageSize=10;
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        if(loginUser==null){
            mv.setViewName("redirect:/relogin");
            return mv;
        }
        if(findType==0) {
            int totalNum = subscribeService.countBySubscriber(loginUser.getUserName());
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findByPageAndSubscriber(loginUser.getUserName(), pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
        }else if(findType==1){
            String searchName=request.getParameter("name");
            int totalNum = subscribeService.countLikeBySubscriberAndName(loginUser.getUserName(),searchName);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndSubscriberAndName(loginUser.getUserName(),searchName, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("name", searchName);
        }else if(findType==2){
            String cname=request.getParameter("name");
            int totalNum = subscribeService.countLikeBySubscriberAndCname(loginUser.getUserName(),cname);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndSubscriberAndCname(loginUser.getUserName(),cname, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("name", cname);

        }else{
            String range=request.getParameter("range");
            String startDate=range.substring(0,10);
            String endDate=range.substring(13);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            Date date= sdf.parse(endDate);
            calendar.setTime(date);
            int day=calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE,day+1);
            endDate = sdf.format(calendar.getTime());
            int totalNum = subscribeService.countBySubscriberAndRange(loginUser.getUserName(),startDate,endDate);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndSubscriberAndRange(loginUser.getUserName(),startDate,endDate, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("time", range);
        }
        mv.addObject("findType",findType);
        mv.setViewName("mySubscribeList");
        return mv;//返回登录界面
    }
    @RequestMapping("/mySubscribeAuditList")
    public ModelAndView mySubscribeAuditList(HttpServletRequest request) throws Exception{
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        String type=request.getParameter("findType");
        int findType;
        if(type==null||type.equals("")){
            findType=0;
        }else{
            findType=Integer.parseInt(type);
        }
        System.out.println("findType="+findType);
        String size = request.getParameter("pageSize");
        int pageSize;
        if(size==null||size.equals("")){
            pageSize=0;
        }else{
            pageSize=Integer.parseInt(size);
        }
        if(findType==0) {
            int totalNum = subscribeService.countAuditSubscribe();
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findAuditSubByPage(pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
        }else if(findType==1){
            String searchName=request.getParameter("name");
            int totalNum = subscribeService.countLikeByName(searchName);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndName(searchName,pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("name", searchName);
        }else if(findType==2){
            String cname=request.getParameter("name");
            int totalNum = subscribeService.countLikeByCname(cname);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndCname(cname,pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("name", cname);
        }else{
            String range=request.getParameter("range");
            String startDate=range.substring(0,10);
            String endDate=range.substring(13);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            Date date= sdf.parse(endDate);
            calendar.setTime(date);
            int day=calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE,day+1);
            endDate = sdf.format(calendar.getTime());
            int totalNum = subscribeService.countByRange(startDate,endDate);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findByPageAndRange(startDate,endDate,pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                serviceInfoList.add(serviceInfoService.findById(subscribe.getServiceId()));
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("time", range);
        }
        mv.addObject("findType",findType);
        mv.setViewName("mySubscribeAuditList");
        return mv;//返回登录界面
    }
    @RequestMapping("/noticeList")
    public ModelAndView noticeList(HttpServletRequest request){
        ModelAndView mv=new ModelAndView();
        List<Notice> noticeList=noticeService.findAll();
        mv.addObject("noticeList",noticeList);
        mv.setViewName("noticeList");
        return mv;//返回登录界面
    }
    @RequestMapping("/guideList")
    public ModelAndView guideList(HttpServletRequest request){
        ModelAndView mv=new ModelAndView();
        List<Guide> guideList=guideService.findAll();
        mv.addObject("guideList",guideList);
        mv.setViewName("guideList");
        return mv;//返回登录界面
    }
    @RequestMapping("/myAnalysis")
    public ModelAndView toAnalysis(HttpServletRequest request) throws Exception{
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        System.out.println("-----companyAnalysis-----");
        System.out.println("pageNo="+pageNo);
        String type=request.getParameter("findType");
        int findType;
        if(type==null||type.equals("")){
            findType=0;
        }else{
            findType=Integer.parseInt(type);
        }
        System.out.println("findType="+findType);
        String size = request.getParameter("pageSize");
        int pageSize;
        if(size==null||size.equals("")){
            pageSize=0;
        }else{
            pageSize=Integer.parseInt(size);
        }
        //int pageSize = 10;
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        if(loginUser==null){
            mv.setViewName("redirect:/login");
            return mv;
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("userName",loginUser.getUserName());
        String url = SystemConfig.url+"/shiro/calltimes/byUser";//通过客户名查询服务调用次数
        PostToJson postToJson = new PostToJson();
        String send = postToJson.send(url,jsonObject,"utf-8","");
        jsonObject=(JSONObject)JSONObject.parse(send);
        String result=jsonObject.get("result").toString();
        List<HashMap> list = JSON.parseArray(result, HashMap.class);
        if(findType==0) {
            int totalNum = subscribeService.countBySubscriberAndStatus(loginUser.getUserName(), 2);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findByPageAndSubscriberAndStatus(loginUser.getUserName(), 2, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            List<Integer> times=new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                ServiceInfo serviceInfo=serviceInfoService.findById(subscribe.getServiceId());
                serviceInfoList.add(serviceInfo);
                for(int i=0;i<list.size();i++){
                    if(list.get(i).get("serviceUrl").equals(serviceInfo.getAddress())){
                        times.add(Integer.parseInt(list.get(i).get("times").toString()));
                    }else{
                        times.add(0);
                    }
                }
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("times", times);
        }else if(findType==1){
            String searchName=request.getParameter("name");
            int totalNum = subscribeService.countLikeBySubscriberAndNameAndStatus(loginUser.getUserName(),searchName, 2);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndSubscriberAndNameAndStatus(loginUser.getUserName(),searchName, 2, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            List<Integer> times=new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                ServiceInfo serviceInfo=serviceInfoService.findById(subscribe.getServiceId());
                serviceInfoList.add(serviceInfo);
                for(int i=0;i<list.size();i++){
                    if(list.get(i).get("serviceUrl").equals(serviceInfo.getAddress())){
                        times.add(Integer.parseInt(list.get(i).get("times").toString()));
                    }else{
                        times.add(0);
                    }
                }
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType", findType);
            mv.addObject("name", searchName);
            mv.addObject("times", times);
        }else if(findType==2){
            String searchName=request.getParameter("name");
            int totalNum = subscribeService.countLikeBySubscriberAndCnameAndStatus(loginUser.getUserName(),searchName, 2);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findLikeByPageAndSubscriberAndCnameAndStatus(loginUser.getUserName(),searchName, 2, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            List<Integer> times=new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                ServiceInfo serviceInfo=serviceInfoService.findById(subscribe.getServiceId());
                serviceInfoList.add(serviceInfo);
                for(int i=0;i<list.size();i++){
                    if(list.get(i).get("serviceUrl").equals(serviceInfo.getAddress())){
                        times.add(Integer.parseInt(list.get(i).get("times").toString()));
                    }else{
                        times.add(0);
                    }
                }
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType", findType);
            mv.addObject("name", searchName);
            mv.addObject("times", times);
        }else{
            String range=request.getParameter("range");
            String startDate=range.substring(0,10);
            String endDate=range.substring(13);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            Date date= sdf.parse(endDate);
            calendar.setTime(date);
            int day=calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE,day+1);
            endDate = sdf.format(calendar.getTime());
            int totalNum = subscribeService.countBySubscriberAndRangeAndStatus(loginUser.getUserName(),startDate,endDate, 2);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findByPageAndSubscriberAndRangeAndStatus(loginUser.getUserName(), startDate,endDate,2, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            List<Integer> times=new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                ServiceInfo serviceInfo=serviceInfoService.findById(subscribe.getServiceId());
                serviceInfoList.add(serviceInfo);
                for(int i=0;i<list.size();i++){
                    if(list.get(i).get("serviceUrl").equals(serviceInfo.getAddress())){
                        times.add(Integer.parseInt(list.get(i).get("times").toString()));
                    }else{
                        times.add(0);
                    }
                }
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType", findType);
            mv.addObject("time", range);
            mv.addObject("times", times);
        }
        mv.setViewName("myAnalysis");
        return mv;//返回登录界面

    }
    //公司统计分析界面
    @RequestMapping("/companyAnalysis")
    public ModelAndView companyAnalysis(HttpServletRequest request) throws Exception{
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        System.out.println("-----companyAnalysis-----");
        System.out.println("pageNo="+pageNo);
        String type=request.getParameter("findType");
        int findType;
        if(type==null||type.equals("")){
            findType=0;
        }else{
            findType=Integer.parseInt(type);
        }
        System.out.println("findType="+findType);
        String size = request.getParameter("pageSize");
        int pageSize;
        if(size==null||size.equals("")){
            pageSize=0;
        }else{
            pageSize=Integer.parseInt(size);
        }
        System.out.println("pagesize="+pageSize);
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        if(loginUser==null){
            mv.setViewName("redirect:/login");
            return mv;
        }
        JSONObject jsonObject = new JSONObject();
        String url = SystemConfig.url+"/shiro/calltimes/all";//查询所有服务调用次数
        PostToJson postToJson = new PostToJson();
        String send = postToJson.send(url,jsonObject,"utf-8","");
        jsonObject=(JSONObject)JSONObject.parse(send);
        String result=jsonObject.get("result").toString();
        List<HashMap> list = JSON.parseArray(result, HashMap.class);
        if(findType==0) {
            System.out.println("------findType(1)------------------");
            int totalNum = subscribeService.countDistinctByStatus(2);
            System.out.println("totalNum="+totalNum);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findDistinctByPageAndStatus(2, pageData.getStartPos(), pageData.getEndPos());
            System.out.println("subscribeList.size="+subscribeList.size());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            List<Integer> times = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                ServiceInfo serviceInfo=serviceInfoService.findById(subscribe.getServiceId());
                serviceInfoList.add(serviceInfo);
                for(int i=0;i<list.size();i++){
                    if(list.get(i).get("serviceUrl").equals(serviceInfo.getAddress())){
                        times.add(Integer.parseInt(list.get(i).get("times").toString()));
                    }else{
                        times.add(0);
                    }
                }
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("times", times);
            mv.addObject("findType", findType);
        }else if(findType==1){
            String searchName=request.getParameter("name");
            int totalNum = subscribeService.countDistinctLikeByNameAndStatus(searchName,2);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findDistinctLikeByPageAndNameAndStatus(searchName,2, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            List<Integer> times = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                ServiceInfo serviceInfo=serviceInfoService.findById(subscribe.getServiceId());
                serviceInfoList.add(serviceInfo);
                for(int i=0;i<list.size();i++){
                    if(list.get(i).get("serviceUrl").equals(serviceInfo.getAddress())){
                        times.add(Integer.parseInt(list.get(i).get("times").toString()));
                    }else{
                        times.add(0);
                    }
                }
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType", findType);
            mv.addObject("times", times);
            mv.addObject("name", searchName);

        }else if(findType==2){
            String searchName=request.getParameter("name");
            int totalNum = subscribeService.countDistinctLikeByCnameAndStatus(searchName,2);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Subscribe> subscribeList = subscribeService.findDistinctLikeByPageAndCnameAndStatus(searchName,2, pageData.getStartPos(), pageData.getEndPos());
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Category> categoryList = new ArrayList<>();
            List<Integer> times = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                ServiceInfo serviceInfo=serviceInfoService.findById(subscribe.getServiceId());
                serviceInfoList.add(serviceInfo);
                for(int i=0;i<list.size();i++){
                    if(list.get(i).get("serviceUrl").equals(serviceInfo.getAddress())){
                        times.add(Integer.parseInt(list.get(i).get("times").toString()));
                    }else{
                        times.add(0);
                    }
                }
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType", findType);
            mv.addObject("times", times);
            mv.addObject("name", searchName);
        }else{
            String range=request.getParameter("range");
            String startDate=range.substring(0,10);
            String endDate=range.substring(13);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            Date date= sdf.parse(endDate);
            calendar.setTime(date);
            int day=calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE,day+1);
            endDate = sdf.format(calendar.getTime());
            int totalNum=subscribeService.countDistinctByRangeAndStatus(startDate,endDate,2);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            List<Subscribe> subscribeList=subscribeService.findDistinctByPageAndRangeAndStatus(startDate,endDate,2,pageData.getStartPos(),pageData.getEndPos());
            List<Category> categoryList = new ArrayList<>();
            List<ServiceInfo> serviceInfoList = new ArrayList<>();
            List<Integer> times = new ArrayList<>();
            for (Subscribe subscribe : subscribeList) {
                ServiceInfo serviceInfo=serviceInfoService.findById(subscribe.getServiceId());
                serviceInfoList.add(serviceInfo);
                for(int i=0;i<list.size();i++){
                    if(list.get(i).get("serviceUrl").equals(serviceInfo.getAddress())){
                        times.add(Integer.parseInt(list.get(i).get("times").toString()));
                    }else{
                        times.add(0);
                    }
                }
                categoryList.add(categoryService.findById(serviceInfoService.findById(subscribe.getServiceId()).getCategoryId()));
            }
            mv.addObject("subscribeList", subscribeList);
            mv.addObject("serviceInfoList", serviceInfoList);
            mv.addObject("categoryList", categoryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType", findType);
            mv.addObject("times", times);
            mv.addObject("time", range);
        }
        mv.setViewName("companyAnalysis");
        return mv;//返回登录界面

    }
    //词典管理界面
    @RequestMapping("/dictionaryList")
    public ModelAndView dictionaryList(HttpServletRequest request) throws Exception{
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        System.out.println("-----dictionaryList-----");
        System.out.println("pageNo="+pageNo);
        String type=request.getParameter("findType");
        int findType;
        if(type==null||type.equals("")){
            findType=0;
        }else{
            findType=Integer.parseInt(type);
        }
        System.out.println("findType="+findType);
        String size = request.getParameter("pageSize");
        int pageSize;
        if(size==null||size.equals("")){
            pageSize=0;
        }else{
            pageSize=Integer.parseInt(size);
        }
        //int pageSize = 10;
       /* User loginUser=(User)request.getSession().getAttribute("loginUser");
        if(loginUser==null){
            mv.setViewName("redirect:/relogin");
            return mv;
        }*/
        if(findType==0) {
            int totalNum =dictionaryService.countAllDictionary();
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Dictionary> dictionaryList = dictionaryService.findByPage(pageData.getStartPos(), pageData.getEndPos());
            mv.addObject("dictionaryList", dictionaryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType", findType);
        }else if(findType==1){
            String searchName=request.getParameter("name");
            int totalNum = dictionaryService.countLikeByName(searchName);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Dictionary> dictionaryList = dictionaryService.findLikeByPageAndName(searchName, pageData.getStartPos(), pageData.getEndPos());
            mv.addObject("dictionaryList", dictionaryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType", findType);
            mv.addObject("name", searchName);

        }else if(findType==3){
            String searchName=request.getParameter("name");
            int searchType=0;
            if ("服务类型".contains(searchName)){
                searchType=1;
            }else if ("协议类型".contains(searchName)){
                searchType=2;
            }
            System.out.println("findType="+findType);
            System.out.println("searchType="+searchType);
            System.out.println("searchName="+searchName);
            int totalNum = dictionaryService.countLikeByType(searchType);
            PageData pageData = PageHelp.getPageData(pageNo, pageSize, totalNum);
            List<Dictionary> dictionaryList = dictionaryService.findLikeByPageAndType(searchType, pageData.getStartPos(), pageData.getEndPos());
            mv.addObject("dictionaryList", dictionaryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType", findType);
            mv.addObject("name", searchName);
        }else{
            String range=request.getParameter("range");
            String startDate=range.substring(0,10);
            String endDate=range.substring(13);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            Date date= sdf.parse(endDate);
            calendar.setTime(date);
            int day=calendar.get(Calendar.DATE);
            calendar.set(Calendar.DATE,day+1);
            endDate = sdf.format(calendar.getTime());
            int totalNum=dictionaryService.countByRange(startDate,endDate);
            PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
            List<Dictionary> dictionaryList=dictionaryService.findByPageAndRange(startDate,endDate,pageData.getStartPos(),pageData.getEndPos());
            mv.addObject("dictionaryList", dictionaryList);
            mv.addObject("curPage", pageData.getPageNo());
            mv.addObject("pageSize", pageData.getPageSize());
            mv.addObject("totalNum", pageData.getTotalNum());
            mv.addObject("totalPage", pageData.getTotalPageNo());
            mv.addObject("findType", findType);
            mv.addObject("time", range);

        }
        mv.setViewName("dictionary");
        return mv;//返回登录界面

    }
    @RequestMapping("/relogin")
    public ModelAndView relogin(HttpServletRequest request){
        ModelAndView mv=new ModelAndView();
        List<Guide> guideList=guideService.findAll();
        mv.addObject("guideList",guideList);
        mv.setViewName("relogin");
        return mv;//返回登录界面
    }

}
