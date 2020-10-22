package com.xyst.fwgl.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.xyst.fwgl.model.CatalogList;
import com.xyst.fwgl.model.Category;
import com.xyst.fwgl.model.ServiceInfo;
import com.xyst.fwgl.model.User;
import com.xyst.fwgl.service.CategoryService;
import com.xyst.fwgl.service.ServiceInfoService;
import com.xyst.fwgl.service.SubscribeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Controller
public class CateLogServiceController {


    @Autowired
    private ServiceInfoService serviceInfoService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private SubscribeService subscribeService;

    @RequestMapping("/fuwu")
    public ModelAndView jpfuwu(HttpServletRequest request,Integer page, Integer flag, String name,String search,String leftsearch) throws IOException, ParseException {
        ModelAndView model = CatelogSerach(request,page, flag, name,search,leftsearch); //调用公共统计数据方法并返回model
        model.setViewName("fuwu");
        return model;
    }

    @RequestMapping("/fuwuUserServiceist")
    public ModelAndView fuwuUserServiceist(HttpServletRequest request,Integer page, Integer flag, String name,String search,String leftsearch) throws IOException, ParseException {
        ModelAndView model = CatelogSerach(request,page, flag, name,search,leftsearch); //调用公共统计数据方法并返回model
        model.setViewName("serviceList");
        return model;
    }

    @RequestMapping("/amtest")
    public ModelAndView amtest(HttpServletRequest request,Integer page, Integer flag, String name,String search,String leftsearch) throws IOException, ParseException {
//        ModelAndView model = getCatalogProportion(request,page, flag, name,search,leftsearch); //调用公共统计数据方法并返回model
        ModelAndView model = CatelogSerach(request,page, flag, name,search,leftsearch); //调用公共统计数据方法并返回model

        model.setViewName("catalogList");
        return model;
    }




    @RequestMapping("/catalog")
    public ModelAndView getCatalogProportion(HttpServletRequest request,Integer page, Integer flag, String name,String search,String leftsearch) {
        ModelAndView model = new ModelAndView();
        User loginUser=(User)request.getSession().getAttribute("loginUser");
        //获取所有已发布的服务
        List<ServiceInfo> services;
        PageInfo<ServiceInfo> appsPageInfo = null;
        System.out.println("--------getCatalogProportion------------------");

        List<ServiceInfo> serviceInfos;
        if (name != null) {
//          如果有name的情况下
            if (flag == null || flag ==0) {  //默认排序
                services = serviceInfoService.caNamegetServices(page, name);
                appsPageInfo = new PageInfo<>(services);
                System.out.println(name);
                List<ServiceInfo> list = appsPageInfo.getList();
//                System.out.println("list.size="+list.size());
                for (ServiceInfo serviceInfo : list) {
                    Integer categoryId = serviceInfo.getCategoryId();
                    String catName = categoryService.getCatName(categoryId);  //服务目录名称
                    Integer serviceInfoId = serviceInfo.getId(); //先获取serviceId
                    Integer serCounts = subscribeService.getSerCounts(serviceInfoId);   //该服务订阅的次数

                    Category byId = categoryService.findById(categoryId);
                    if (byId.getType() == 2){
                        Category OneCate = categoryService.findById(byId.getPreCategory());
                        String cname = OneCate.getCname();
                        catName = cname + "-" + catName;
                    }

                    if (loginUser!=null){
                        Integer status = subscribeService.getfullServiceSubStatus(serviceInfoId, loginUser.getUserName());
                        serviceInfo.setCategoryId(status);          //将订阅状态暂存到service_info的setCategoryId中
                    }else {
                        serviceInfo.setCategoryId(0);
                    }

                    serviceInfo.setCancelTime(catName);  //将服务类别名称存到CancelTime中
                    serviceInfo.setUnmountTime(serCounts.toString());  //将服务订阅次数暂存到Version中
                }

            } else if (flag == 1) {  //时间排序
                services = serviceInfoService.caNamegetUpdateServices(page, name);
                appsPageInfo = new PageInfo<>(services);

                List<ServiceInfo> list = appsPageInfo.getList();
                for (ServiceInfo serviceInfo : list) {
                    Integer categoryId = serviceInfo.getCategoryId();
                    String catName = categoryService.getCatName(categoryId);  //服务类别名称
                    Integer serviceInfoId = serviceInfo.getId(); //先获取serviceId
                    Integer serCounts = subscribeService.getSerCounts(serviceInfoId);   //该服务订阅的次数

                    Category byId = categoryService.findById(categoryId);
                    if (byId.getType() == 2){
                        Category OneCate = categoryService.findById(byId.getPreCategory());
                        String cname = OneCate.getCname();
                        catName = cname + "-" + catName;
                    }


                    if (loginUser!=null){
                        Integer status = subscribeService.getfullServiceSubStatus(serviceInfoId, loginUser.getUserName());
                        serviceInfo.setCategoryId(status);//将订阅状态暂存到service_info的status中
                    }else {
                        serviceInfo.setCategoryId(0);
                    }
                    serviceInfo.setCancelTime(catName);  //将服务类别名称存到CancelTime中
                    serviceInfo.setUnmountTime(serCounts.toString());  //将服务订阅次数暂存到Version中
                }


            } else if (flag == 2) {  //根据订阅次数排序
                services = serviceInfoService.cNamegetUpdateServices(name);
                for (ServiceInfo service : services) {
                    Integer categoryId = service.getCategoryId();
                    String catName = categoryService.getCatName(categoryId); //服务类别名称
                    Integer serviceId = service.getId();
                    Integer serCounts = subscribeService.getSerCounts(serviceId);//服务订阅次数

                    Category byId = categoryService.findById(categoryId);
                    if (byId.getType() == 2){
                        Category OneCate = categoryService.findById(byId.getPreCategory());
                        String cname = OneCate.getCname();
                        catName = cname + "-" + catName;
                    }

                    service.setCancelTime(catName);                 //将服务类别名称暂存到canceltime中
                    service.setUnmountTime(serCounts.toString());  //将订阅次数暂存到ummountTime中
                    System.out.println();
                    if (loginUser!=null){
                        Integer status = subscribeService.getfullServiceSubStatus(serviceId, loginUser.getUserName());
                        service.setCategoryId(status);//将订阅状态暂存到service_info的CategoryId中
                    }else {
                        service.setCategoryId(0);
                    }
                }//对订阅次数进行排序
                Collections.sort(services, new Comparator<ServiceInfo>() {
                    @Override
                    public int compare(ServiceInfo o1, ServiceInfo o2) {
                        Integer value1 = Integer.valueOf(o1.getUnmountTime());
                        Integer value2 = Integer.valueOf(o2.getUnmountTime());
                        return value2 - value1;
                    }
                });

                List<ServiceInfo> serviceInfoList = services;
                if ( services.size() > ((page-1)*5 + 5) ){
                    serviceInfos = serviceInfoList.subList((page-1) * 5, ((page-1) * 5) + 5);

                }else{
                    serviceInfos = serviceInfoList.subList((page-1) * 5,services.size());
                }

                appsPageInfo = new PageInfo<>(serviceInfos,5);
                appsPageInfo.setTotal(services.size());
                appsPageInfo.setPageSize(5);
                appsPageInfo.setPages(services.size()/5 + 1);
                appsPageInfo.setPageNum(page);


            }
        }else if (search != null ){
            if (flag == 0 || flag ==null){
                //搜索框的模糊查询
                services = serviceInfoService.searchServiceList(search, page);
                appsPageInfo = new PageInfo<>(services);

                List<ServiceInfo> list = appsPageInfo.getList();
                for (ServiceInfo serviceInfo : list) {
                    Integer categoryId = serviceInfo.getCategoryId();
                    String catName = categoryService.getCatName(categoryId);  //服务类别名称
                    System.out.println("模糊查询" +serviceInfo.getName());

                    Integer serviceInfoId = serviceInfo.getId(); //先获取serviceId
                    Integer serCounts = subscribeService.getSerCounts(serviceInfoId);   //该服务订阅的次数

                    Category byId = categoryService.findById(categoryId);
                    if (byId.getType() == 2){
                        Category OneCate = categoryService.findById(byId.getPreCategory());
                        String cname = OneCate.getCname();
                        catName = cname + "-" + catName;
                    }

                    if (loginUser!=null){
                        Integer status = subscribeService.getfullServiceSubStatus(serviceInfoId, loginUser.getUserName());
                        serviceInfo.setCategoryId(status);//将订阅状态暂存到service_info的status中
                    }else {
                        serviceInfo.setCategoryId(0);
                    }

                    serviceInfo.setCancelTime(catName);  //将服务类别名称存到CancelTime中
                    serviceInfo.setUnmountTime(serCounts.toString());  //将服务订阅次数暂存到Version中
                }
            }else if (flag ==1){
                services = serviceInfoService.searchServiceListDesc(search,page);
                appsPageInfo = new PageInfo<>(services);
                List<ServiceInfo> list = appsPageInfo.getList();
                for (ServiceInfo serviceInfo : list) {
                    Integer categoryId = serviceInfo.getCategoryId();
                    String catName = categoryService.getCatName(categoryId);  //服务类别名称
                    Integer serviceInfoId = serviceInfo.getId(); //先获取serviceId
                    Integer serCounts = subscribeService.getSerCounts(serviceInfoId);   //该服务订阅的次数

                    Category byId = categoryService.findById(categoryId);
                    if (byId.getType() == 2){
                        Category OneCate = categoryService.findById(byId.getPreCategory());
                        String cname = OneCate.getCname();
                        catName = cname + "-" + catName;
                    }

                    if (loginUser!=null){
                        Integer status = subscribeService.getfullServiceSubStatus(serviceInfoId, loginUser.getUserName());
                        serviceInfo.setCategoryId(status);//将订阅状态暂存到service_info的CategoryId中
                    }else {
                        serviceInfo.setCategoryId(0);
                    }
                    serviceInfo.setCancelTime(catName);  //将服务类别名称存到CancelTime中
                    System.out.println();
                    serviceInfo.setUnmountTime(serCounts.toString());  //将服务订阅次数暂存到UnmountTime中
                }

            }else if (flag == 2){
                //搜索框的模糊查询
                services = serviceInfoService.searchAllServiceList(search);
                for (ServiceInfo service : services) {
                    Integer categoryId = service.getCategoryId();
                    String catName = categoryService.getCatName(categoryId); //服务类别名称

                    Integer serviceId = service.getId();
                    Integer serCounts = subscribeService.getSerCounts(serviceId);//服务订阅次数
                    service.setUnmountTime(serCounts.toString());

                    Category byId = categoryService.findById(categoryId);
                    if (byId.getType() == 2){
                        Category OneCate = categoryService.findById(byId.getPreCategory());
                        String cname = OneCate.getCname();
                        catName = cname + "-" + catName;
                    }
                    service.setCancelTime(catName);                 //

                    if (loginUser!=null){
                        Integer status = subscribeService.getfullServiceSubStatus(serviceId, loginUser.getUserName());
                        service.setCategoryId(status);//将订阅状态暂存到service_info的CategoryId中
                    }else {
                        service.setCategoryId(0);
                    }


                }//对订阅次数进行排序
                Collections.sort(services, new Comparator<ServiceInfo>() {
                    @Override
                    public int compare(ServiceInfo o1, ServiceInfo o2) {
                        Integer value1 = Integer.valueOf(o1.getUnmountTime());
                        Integer value2 = Integer.valueOf(o2.getUnmountTime());
                        return value2 - value1;
                    }
                });

//                PageHelper.startPage(page, 5);

                List<ServiceInfo> serviceInfoList = services;
                if ( services.size() > ((page-1)*5 + 5) ){
                    serviceInfos = serviceInfoList.subList((page-1) * 5, ((page-1) * 5) + 5);

                }else{
                    serviceInfos = serviceInfoList.subList((page-1) * 5,services.size());
                }

                appsPageInfo = new PageInfo<>(serviceInfos,5);
                appsPageInfo.setTotal(services.size());
                appsPageInfo.setPageSize(5);
                appsPageInfo.setPages(services.size()/5 + 1);
                appsPageInfo.setPageNum(page);
/*
//                    应该先查出来 然后调用到所有数据 然后再进行分页
                services = serviceInfoService.searchServiceList(search, page);
//                System.out.println(services.size());
                appsPageInfo = new PageInfo<>(services);

                List<ServiceInfo> list = appsPageInfo.getList();
                for (ServiceInfo serviceInfo : list) {
                    Integer categoryId = serviceInfo.getCategoryId();
                    String catName = categoryService.getCatName(categoryId);  //服务类别名称
//                    System.out.println("模糊查询" +serviceInfo.getName());

                    Integer serviceInfoId = serviceInfo.getId(); //先获取serviceId
                    System.out.println();
                    Integer serCounts = subscribeService.getSerCounts(serviceInfoId);   //该服务订阅的次数

                    if (loginUser!=null){
                        Integer status = subscribeService.getfullServiceSubStatus(serviceInfoId, loginUser.getId());
                        serviceInfo.setStatus(status);//将订阅状态暂存到service_info的status中
                    }else {
                        serviceInfo.setStatus(0);
                    }

                    serviceInfo.setCancelTime(catName);  //将服务类别名称存到CancelTime中
                    serviceInfo.setVersion(serCounts.toString());  //将服务订阅次数暂存到Version中
                }
                //对订阅次数进行排序
                Collections.sort(list, new Comparator<ServiceInfo>() {
                    @Override
                    public int compare(ServiceInfo o1, ServiceInfo o2) {
                        Integer value1 = Integer.valueOf(o1.getVersion());
                        Integer value2 = Integer.valueOf(o2.getVersion());
                        return value2 - value1;
                    }
                });*/
            }
        }
//        else if (){
//
//        }


       /* List<ServiceInfo> services = serviceInfoService.getServices(page);
        PageInfo<ServiceInfo> appsPageInfo = new PageInfo<>(services);

        List<ServiceInfo> list = appsPageInfo.getList();
        for (ServiceInfo serviceInfo : list) {
            Integer categoryId = serviceInfo.getCategoryId();
            String catName = categoryService.getCatName(categoryId);  //服务类别名称
            System.out.println(catName);

            Integer serviceInfoId = serviceInfo.getId(); //先获取serviceId
            Integer serCounts = subscribeService.getSerCounts(serviceInfoId);   //该服务订阅的次数
            System.out.println(serCounts);
            serviceInfo.setAddress(catName);  //将服务类别名称存到address中
            serviceInfo.setCancelTime(serCounts.toString());  //将服务订阅次数暂存到canceltime中
        }*/

//        appsPageInfo = (PageInfo<ServiceInfo>) list;


            model.addObject("services", appsPageInfo);


        return model;

    }

    //服务取消订阅
    @RequestMapping("cancelServiceSub")
    @ResponseBody
    public void CancelServiceSub(HttpServletRequest request, HttpServletResponse response) throws IOException {

        Integer service_id = Integer.parseInt(request.getParameter("ServiceId"));
        User loginUser=(User)request.getSession().getAttribute("loginUser");

        Integer integer = subscribeService.cancelSubService(service_id, loginUser.getUserName());

        Integer status = subscribeService.getfullServiceSubStatus(service_id, loginUser.getUserName());
        JSONObject json=new JSONObject();
        json.put("status",status);
        response.getWriter().write(json.toString());
    }

    //左侧服务类别栏目
    @RequestMapping("/catelogSerach")
    public ModelAndView CatelogSerach(HttpServletRequest request,Integer page, Integer flag, String name,String search,String leftsearch){
        ModelAndView model = getCatalogProportion(request,page, flag, name,search,leftsearch);

        if (name != null){
            List<Category> categories = categoryService.seachCategory(name);
                //模糊查询到所有type为0的一级目录 开始遍历

            ArrayList arrayList = new ArrayList();

            for (Category category : categories) {
                CatalogList catalogList = new CatalogList();
                Integer regCounts = 0;
                Integer pubCounts = 0;

                Integer id = category.getId();
                String catName = categoryService.getCatName(id);

                //查询二级目录
                List<Category> twoCategoryList = categoryService.getTwoCategoryList(id);
                if (twoCategoryList !=null && twoCategoryList.size() != 0){
                    for (Category categorys : twoCategoryList) {
                        Integer regCount = serviceInfoService.getCagToRegServiceCount(categorys.getId());
                        Integer pubCount = serviceInfoService.getCagToPubServiceCount(categorys.getId());

                        categorys.setStatus(regCount);
                        categorys.setType(pubCount);

                        regCounts = regCounts + regCount;
                        pubCounts = pubCounts + pubCount ;
                        System.out.println();
                    }
                    catalogList.setPubCount(pubCounts);
                    catalogList.setRegCount(regCounts);
                    catalogList.setName(catName);
                    catalogList.setCategories(twoCategoryList);
                    catalogList.setStatus(2);

                }else {
                    catalogList.setStatus(1);
                    Integer cagToRegServiceCount = serviceInfoService.getCagToRegServiceCount(id);
                    Integer cagToPubServiceCount = serviceInfoService.getCagToPubServiceCount(id);
                    catalogList.setName(catName);
                    System.out.println();
                    catalogList.setPubCount(cagToPubServiceCount);
                    catalogList.setRegCount(cagToRegServiceCount);

                }


                arrayList.add(catalogList);
            }
            model.addObject("catalogList", arrayList);
            //模糊查询

        }else {
            Integer[] allId = categoryService.getAllCategoryId();
            //查询到所有type为0的一级目录 开始遍历

            List<CatalogList> arrayList = new ArrayList();


            for (Integer id : allId) {
                Integer regCounts = 0;
                Integer pubCounts = 0;

                String catName = categoryService.getCatName(id);
                CatalogList catalogList = new CatalogList();

                //查询二级目录

                List<Category> twoCategoryList = categoryService.getTwoCategoryList(id);
                if (twoCategoryList !=null && twoCategoryList.size() != 0){
                    for (Category category : twoCategoryList) {
                        Integer regCount = serviceInfoService.getCagToRegServiceCount(category.getId());
                        Integer pubCount = serviceInfoService.getCagToPubServiceCount(category.getId());
                        category.setStatus(regCount);
                        category.setType(pubCount);

                        regCounts = regCounts + regCount;
                        pubCounts = pubCounts + pubCount ;
                    }
                    catalogList.setCategories(twoCategoryList);
                    catalogList.setStatus(2);
                    catalogList.setName(catName);
                    catalogList.setPubCount(pubCounts);
                    catalogList.setRegCount(regCounts);
                }else {
                    catalogList.setStatus(1);
                    Integer cagToRegServiceCount = serviceInfoService.getCagToRegServiceCount(id);
                    Integer cagToPubServiceCount = serviceInfoService.getCagToPubServiceCount(id);
                    catalogList.setName(catName);
                    catalogList.setPubCount(cagToPubServiceCount);
                    catalogList.setRegCount(cagToRegServiceCount);
                }

                arrayList.add(catalogList);
            }

//            System.out.println(arrayList);
            model.addObject("catalogList", arrayList);
        }

            return model;
    }

}
