package com.xyst.fwgl.controller;

import com.xyst.fwgl.model.Category;
import com.xyst.fwgl.model.Dictionary;
import com.xyst.fwgl.model.LogInfo;
import com.xyst.fwgl.model.User;
import com.xyst.fwgl.service.CategoryService;
import com.xyst.fwgl.service.DictionaryService;
import com.xyst.fwgl.service.LogInfoService;
import com.xyst.fwgl.utils.PageData;
import com.xyst.fwgl.utils.PageHelp;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author hyl
 * @Date 2020/7/21 9:40
 */
@Controller
@RequestMapping("/category")
public class CategoryController {
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private LogInfoService logInfoService;
    @Autowired
    private DictionaryService dictionaryService;
    /**
     * @description 分页展示服务类别信息
     * @param request
     * @return mv 当前页面的分类信息
     */
    @RequestMapping("/findByPage")
    @Transactional
    public ModelAndView findByPage(HttpServletRequest request){
        ModelAndView mv=new ModelAndView();
        int pageNo=Integer.parseInt(request.getParameter("pageNo"));
        System.out.println("pageNo="+pageNo);
        int totalNum=categoryService.countAllCategory();
        System.out.println("totalNum="+totalNum);
        int pageSize=12;
        PageData pageData= PageHelp.getPageData(pageNo,pageSize,totalNum);
        System.out.println("startPos="+pageData.getStartPos());
        System.out.println("endPos="+pageData.getEndPos());
        List<Category> categoryList=categoryService.findByPage(pageData.getStartPos(),pageData.getEndPos());
        mv.addObject("curPage",pageData.getPageNo());
        mv.addObject("pageSize",pageData.getPageSize());
        mv.addObject("totalPage",pageData.getTotalPageNo());
        mv.addObject("categoryList",categoryList);
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("查看第"+pageNo+"页服务分类信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent(loginUser.getUserName()+"查看第"+pageNo+"页服务分类信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        mv.setViewName("category");
        return mv;
    }

    /**
     * @description 添加服务分类信息
     * @param request 通过request 获取分类的属性值 name,description
     *                以及添加的用户名,最后添加到数据库
     * @param response 如果数据库中存在相同的类别名称返回2;添加成功返回1;添加失败返回0
     */
    @RequestMapping("/addCategory")
    public void addCategory(HttpServletRequest request, HttpServletResponse response){
        System.out.println("----addCategory-----------");
        String result;
        String name=request.getParameter("cname");
        String description=request.getParameter("desc");
        Integer type=Integer.parseInt(request.getParameter("type"));
        Integer preCategory=0;
        if(type==2){
            preCategory=Integer.parseInt(request.getParameter("preCategory"));
        }
        User user=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime=sdf.format(new Date());
        LogInfo logInfo=new LogInfo();
        String creator="";
        if(user!=null){
            creator =user.getUserName();
            logInfo.setUserName(creator);
        }else{
            logInfo.setUserName("匿名用户");
        }
        logInfo.setAccessTime(createTime);
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfo.setContent("创建服务分类信息");
        logInfoService.save(logInfo);
        List<Category> categoryList=categoryService.findByCname(name);
        if(categoryList.size()>0){
            result="2";
        }else {
            Category category = new Category();
            category.setCreateTime(createTime);
            category.setType(type);
            category.setPreCategory(preCategory);
            category.setDescription(description);
            category.setCname(name);
            category.setStatus(0);
            Integer flag = categoryService.save(category);
            if (flag>0) {
                result = "1";
            } else {
                result = "0";
            }
        }
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write("{\"msg\":\""+result+"\"}");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    /**
     * @description 删除服务分类信息
     * @param request 获取分类的id值
     * @param response 删除成功返回1;否则返回0
     */
    @RequestMapping("/delCategory")
    public void delCategory(HttpServletRequest request, HttpServletResponse response){
        String result;
        int id=Integer.parseInt(request.getParameter("id"));
        System.out.println("id="+id);
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("删除服务分类信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("删除服务分类信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        int flag=categoryService.delete(id);
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
     * @description 提交服务分类审核
     * @param request 获取分类的id值
     * @param response 提交成功返回1;否则返回0
     */
    @RequestMapping("/submitCategory")
    public void submitCategory(HttpServletRequest request, HttpServletResponse response){
        String result;
        int id=Integer.parseInt(request.getParameter("id"));
        System.out.println("id="+id);
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("提交审核服务分类信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("提交审核服务分类信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        Category category=categoryService.findById(id);
        category.setStatus(1);
        int flag=categoryService.update(category);
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
     * @description 通过分类id 获取分类信息
     * @param request 获取分类id
     * @param response 如果存在则返回分类对象;否则返回null
     */
    @ResponseBody
    @RequestMapping("/getCategory")
    public void getCategory(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        System.out.println("---getCategory----");
        System.out.println("id="+id);
        Category category=categoryService.findById(id);

        JSONObject json=new JSONObject();
        List<Category> firstCategoryList=categoryService.findAllFirstCategoryByStatus(2);
        if(category.getType()==2) {
            Category preCategory = categoryService.findById(category.getPreCategory());
            json.put("preCategory",preCategory);
        }
        json.put("firstCategoryList",firstCategoryList);
        json.put("category",category);
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("获取id为"+id+"服务分类信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("获取id为"+id+"服务分类信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    /**
     * @description 通过分类id 获取分类信息
     * @param request 获取分类id
     * @param response 如果存在则返回分类对象;否则返回null
     */
    @ResponseBody
    @RequestMapping("/getFirstCategoryList")
    public void getFirstCategoryList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("---------getFirstCategoryList-----------------");
        List<Category> firstCategoryList=categoryService.findAllFirstCategory();
        System.out.println("firstCategoryList.size="+firstCategoryList.size());
        List<Dictionary> serviceTypeList=dictionaryService.findAllDictionaryByType(1);
        List<Dictionary> protocalTypeList=dictionaryService.findAllDictionaryByType(2);
        JSONObject json=new JSONObject();
        json.put("firstCategoryList",firstCategoryList);
        json.put("serviceTypeList",serviceTypeList);
        json.put("protocalTypeList",protocalTypeList);
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("获取所有的一级目录信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("获取所有的一级目录信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    @ResponseBody
    @RequestMapping("/getSecondCategoryByFirst")
    public void getSecondCategoryByFirst(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("---------getSecondCategoryByFirst-----------------");
        Integer firstId=Integer.parseInt(request.getParameter("firstId"));
        List<Category> secondCategoryList=categoryService.findAllSecondCategoryByPreId(firstId);
        System.out.println("secondCategoryList.size="+secondCategoryList.size());
        JSONObject json=new JSONObject();
        json.put("secondCategoryList",secondCategoryList);
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String recordTime=sdf.format(new Date());
        logInfo.setAccessTime(recordTime);
        if(loginUser==null){
            logInfo.setContent("根据ID获取所有的二级目录信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("根据ID获取所有的二级目录信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        try{
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json.toString());
        }catch(Exception e){
            e.printStackTrace();
        }
    }


    /**
     * @description 更新服务分类信息
     * @param request 获取分类的最新属性值,获取更新时间后保存到数据库
     * @param response 更新成功返回1;否则返回0
     */
    @RequestMapping("/updateCategory")
    public void updateCategory(HttpServletRequest request, HttpServletResponse response){
        String result;
        int id=Integer.parseInt(request.getParameter("id"));
        String name=request.getParameter("cname");
        Integer type=Integer.parseInt(request.getParameter("type"));
        Integer preCategory=0;
        if(type==2){
            preCategory=Integer.parseInt(request.getParameter("preCategory"));
        }
        String description=request.getParameter("desc");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime=sdf.format(new Date());
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        logInfo.setAccessTime(createTime);
        if(loginUser==null){
            logInfo.setContent("更新id为"+id+"服务分类信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("更新id为"+id+"服务分类信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfoService.save(logInfo);
        Category category=categoryService.findById(id);
        category.setCname(name);
        category.setType(type);
        category.setPreCategory(preCategory);
        category.setDescription(description);
        category.setCreateTime(createTime);
        int flag=categoryService.update(category);
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
     * @description 更新服务分类信息
     * @param request 获取分类的最新属性值,获取更新时间后保存到数据库
     * @param response 更新成功返回1;否则返回0
     */
    @RequestMapping("/auditCategory")
    public void auditCategory(HttpServletRequest request, HttpServletResponse response){
        String result;
        int id=Integer.parseInt(request.getParameter("id"));
        String reason=request.getParameter("reason");
        int auditResult=Integer.parseInt(request.getParameter("result"));
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime=sdf.format(new Date());
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        LogInfo logInfo=new LogInfo();
        logInfo.setAccessTime(createTime);
        if(loginUser==null){
            logInfo.setContent("更新id为"+id+"服务分类信息");
            logInfo.setUserName("匿名用户");
        }else{
            logInfo.setContent("更新id为"+id+"服务分类信息");
            logInfo.setUserName(loginUser.getUserName());
        }
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfoService.save(logInfo);
        Category category=categoryService.findById(id);
        if(auditResult==1){
            category.setResult("同意");
            category.setStatus(2);
        }else{
            category.setResult("拒绝");
            category.setReason(reason);
            category.setStatus(3);
        }
        category.setAuditTime(createTime);
        int flag=categoryService.update(category);
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
     * @description 获取一级分类信息
     * @param response 成功返回一级分类列表;添加失败返回null
     */
    @RequestMapping("/getFirstCategory")
    @ResponseBody
    public String getFirstCategory(HttpServletRequest request, HttpServletResponse response){
        System.out.println("----getFirstCategory-----------");
        User user=(User)request.getSession().getAttribute("loginUser");
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime=sdf.format(new Date());
        LogInfo logInfo=new LogInfo();
        String creator="";
        if(user!=null){
            creator =user.getUserName();
            logInfo.setUserName(creator);
        }else{
            logInfo.setUserName("匿名用户");
        }
        logInfo.setAccessTime(createTime);
        logInfo.setIpAddress(request.getRemoteAddr());
        logInfo.setContent("获取一级分类信息");
        logInfoService.save(logInfo);
        List<Category> categoryList=categoryService.findAllFirstCategoryByStatus(2);
        System.out.println(categoryList.size());
        JSONObject json=new JSONObject();
        json.put("categoryList",categoryList);
        return json.toString();
    }
}
