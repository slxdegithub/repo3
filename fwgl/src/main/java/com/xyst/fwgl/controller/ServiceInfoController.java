package com.xyst.fwgl.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xyst.fwgl.model.Category;
import com.xyst.fwgl.model.Notice;
import com.xyst.fwgl.model.ServiceInfo;
import com.xyst.fwgl.model.TongJi;
import com.xyst.fwgl.service.CategoryService;
import com.xyst.fwgl.service.NoticeService;
import com.xyst.fwgl.service.ServiceInfoService;
import com.xyst.fwgl.service.SubscribeService;
import com.xyst.fwgl.utils.PostToJson1;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

//@Component
@Controller
public class ServiceInfoController {

    @Autowired
    private ServiceInfoService serviceInfoService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private SubscribeService subscribeService;
    @Autowired
    private NoticeService noticeService;


    //    @PostConstruct  //让项目启动的时候就执行
    @RequestMapping
    public String toIndex() throws IOException, ParseException {
        return "redirect:/index";
    }

    /*
        首页
     */

    @RequestMapping(value = "/index")
    public ModelAndView jpIndex() throws IOException, ParseException {
        System.out.println("-----index-------");
        ModelAndView model = PubModel(); //调用公共统计数据方法并返回model
        List<Notice> noticeList = noticeService.findAll();
        if (noticeList != null && noticeList.size() > 0) {
            model.addObject("notice", noticeList.get(0));
        }
        model.setViewName("index");  //
        return model;
    }


    /*
        统计分析
     */
    @RequestMapping("/about")
    public ModelAndView jpAbout(Date chooDate) throws IOException, ParseException {
        ModelAndView model = AboutModel(chooDate); //调用公共统计数据方法并返回model
        model.setViewName("about");
        return model;
    }

    /*
        统计页面的数据统计
     */
    public ModelAndView AboutModel(Date chooDate) throws IOException, ParseException {
        ModelAndView model = new ModelAndView();
  /*
            获取服务资源个数
            @reg 已注册的服务数量
            @pub 已发布的服务数量

         */
        Integer regServiceCounts = serviceInfoService.getRegServiceCounts();
        Integer pubServiceCounts = serviceInfoService.getPbuServiceCounts();
        model.addObject("reg", regServiceCounts);
        model.addObject("pub", pubServiceCounts);

        //已订阅的服务数量
        Integer subCounts = subscribeService.getSubCounts();
        model.addObject("subCounts", subCounts);

        //服务类别数量
        Integer cagCounts = categoryService.getCagCount();
        model.addObject("cag", cagCounts);


          /*
            获取服务的访问总次数
         */
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("", "");    //服务资源访问次数
        String url = "http://47.96.154.180:8030/shiro/calltimes/all";       //服务资源访问次数

        PostToJson1 postToJson = new PostToJson1();
        String send = postToJson.send(url, jsonObject, "utf-8");  //发送json格式的url和指令，返回json格式内容
        JSONObject json = (JSONObject) JSONObject.parse(send);  //将返回值转为json格式

        JSONArray result = json.getJSONArray("result");

        int total = 0;  //服务调用总次数

        for (int i = 0; i < result.size(); i++) {  //for循环从JsonArray中取出需要的数据
            JSONObject jsonObject1 = result.getJSONObject(i);
            Integer count = jsonObject1.getInteger("times");  //服务的次数
            total = total + count;  //所有服务的总次数
        }
        model.addObject("total", total);//访问总次数
        //            获取服务的访问总次数  完


        /**
         * @Description: 订阅的服务类别占比  统计图1
         * @Param:
         * @return:
         * @Author: 龙龙
         * @Date
         */

        List<TongJi> tongJi3 = categoryService.getTongJi3();
        ArrayList<Map<String, String>> OneList = new ArrayList<>();
        Integer[] allCategoryId = categoryService.getAllCategoryId();
        Integer[] countList = new Integer[allCategoryId.length];
        for (int i = 0; i < allCategoryId.length; i++) {  //初始化数组
            countList[i] = 0;
        }

        if (tongJi3 != null) {
            for (TongJi ji3 : tongJi3) {
                Integer cid = ji3.getCid();
                String count = ji3.getCount();

                Category byId1 = categoryService.findById(cid);

                if (byId1.getType() == 2) {
                    Integer preCategoryId = byId1.getPreCategory();

                    for (int i = 0; i < allCategoryId.length; i++) {
                        if (allCategoryId[i] == preCategoryId) {
                            countList[i] = countList[i] + Integer.parseInt(count);
                            System.out.println(Integer.parseInt(count));
                            System.out.println(allCategoryId[i]);
                        }
                    }
                } else {
                    for (int i = 0; i < allCategoryId.length; i++) {
                        if (allCategoryId[i] == ji3.getCid()) {
                            countList[i] = countList[i] + Integer.parseInt(count);
                            System.out.println(Integer.parseInt(count));
                            System.out.println(ji3.getCid());
                        }
                    }
                }
            }
            Integer count = 0;

            for (int i = 0; i <allCategoryId.length ; i++) {
                String catName = categoryService.getCatName(allCategoryId[i]);
                count = countList[i];

                if (count == 0){
                    continue;
                }

                HashMap<String, String> map = new HashMap<>();
                map.put("name", catName);
                map.put("value", count.toString());
                OneList.add(map);

            }

            String OnePie = JSON.toJSONString(OneList);//把格式转换成json格式数据给饼状图
            model.addObject("OnePie", OnePie);
        }

        /**
         * @Description:已发布的所有服务类别 统计图2
         * @Param:
         * @return:
         * @Author: 龙龙
         * @Date
         */
        ArrayList<Map<String, String>> TwoList = new ArrayList<>();
        Integer[] allCategoryIds = categoryService.getAllCategoryId();
        for (Integer integer : allCategoryIds) {
            List<Category> twoCategoryList = categoryService.getTwoCategoryList(integer);
            Integer pubCount = 0;
            for (Category category : twoCategoryList) {
                List<ServiceInfo> serviceInfos = serviceInfoService.caNamegetServices(category.getId());
                pubCount = pubCount + serviceInfos.size();
            }
            String catName = categoryService.getCatName(integer);

            List<ServiceInfo> serviceInfos = serviceInfoService.caNamegetServices(integer);
            pubCount = pubCount + serviceInfos.size();

            if (pubCount == 0) {
                continue;
            }
            HashMap<String, String> map = new HashMap<>();
            map.put("name", catName);
            map.put("value", pubCount.toString());
            TwoList.add(map);
        }
        String TolPie = JSON.toJSONString(TwoList);//把格式转换成json格式数据给饼状图
        model.addObject("TolPie", TolPie);


         /*
            折线图数据统计
         */

        if (chooDate == null) {
            Integer dayNcounts;
            Integer subCount;
            Integer pubCount;
            for (int i = 0; i < 7; i++) {
                dayNcounts = serviceInfoService.getdayNRegCounts(i);
                model.addObject("dayCount" + i, dayNcounts.toString());    //每天注册的字数

                subCount = subscribeService.getEvdaySubServiceCount(i);
                model.addObject("subCount" + i, subCount);     //每天订阅的次数

                pubCount = serviceInfoService.getdayNPubCounts(i);
                model.addObject("pubCount" + i, pubCount);     //每天发布的次数

            }
//        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']  date所需要的格式
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd ");
            ArrayList daylist = new ArrayList<>();
            Calendar c = Calendar.getInstance();

            String today = dateFormat.format(c.getTime());
            System.out.println(c.getTime());
            daylist.add(today);

            for (int i = 0; i < 6; i++) {  //实时更新折线图的日期
                c.add(Calendar.DATE, -1);  //天数减一
                String format1 = dateFormat.format(c.getTime());  //通过循环获取以当前时间前七天作为坐标轴
//            System.out.println(format1);
                daylist.add(format1);
            }
//        System.out.println(daylist);
            String days = JSON.toJSONString(daylist);
            model.addObject("daylist", days);  //封装好对应日期格式给折线图
            //折线图完
        } else {  //chooseDate 不为空，即选择了查询某段时间七天内的折线图

            Integer dayNcount;
            Integer subCount;
            Integer pubCount;

            ArrayList daylist = new ArrayList<>();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd ");
            String chooseDate = dateFormat.format(chooDate);  //转化为Sting类型 传值给后台sql语句查询
            Date dt = chooDate;  //获取传过来的时间
            long oneDayTime = 1000 * 3600 * 24;  //一天的毫秒值
            //实时更新折线图横坐标的日期
            for (int i = 0; i < 7; i++) {  //实时更新折线图的日期
                Date nowTime = new Date(dt.getTime() - oneDayTime * (i));  //循环日期减一
                String format1 = dateFormat.format(nowTime);  //通过循环获取以当前时间前七天作为坐标轴
                daylist.add(format1);  //添加到list数组
            }
            System.out.println(daylist);

            //获取每天的各种次数
            for (int i = 0; i < 7; i++) {  //以当前日期 七天内的
                dayNcount = serviceInfoService.getChoosedayNRegCounts(i, chooseDate);
                model.addObject("dayCount" + i, dayNcount);    //选择某天后 注册的次数

                subCount = subscribeService.getChooseEvdaySubServiceCount(i, chooseDate);
                model.addObject("subCount" + i, subCount);     //选择某天后 订阅的次数

                pubCount = serviceInfoService.getChoosedayNPubCounts(i, chooseDate);
                model.addObject("pubCount" + i, pubCount);     //选择某天后 发布的次数
            }

            String days = JSON.toJSONString(daylist);  //
            model.addObject("daylist", days);  //封装好对应日期格式给折线图   [07-28 , 07-27 , 07-26 , 07-25 , 07-24 , 07-23 , 07-22 ]

        }

        return model;
    }

    /*
      首页的展示统计数据方法
   */
    public ModelAndView PubModel() throws IOException, ParseException {
        ModelAndView model = new ModelAndView();
        List<ServiceInfo> newDateService = serviceInfoService.getNewDateService();

        /*
            根据时间排序认三个最新资源更新默
         */
        ServiceInfo new0 = null;
        ServiceInfo new1 = null;
        ServiceInfo new2 = null;
        ArrayList<ServiceInfo> serviceInfos = new ArrayList<>();
        if (newDateService != null && newDateService.size() != 0) {
            if (newDateService.size() == 1) {
                new0 = newDateService.get(0);
                serviceInfos = new ArrayList<>();
                serviceInfos.add(new0);

            } else if (newDateService.size() == 2) {
                new0 = newDateService.get(0);
                new1 = newDateService.get(1);

                serviceInfos = new ArrayList<>();
                serviceInfos.add(new0);
                serviceInfos.add(new1);

            } else if (newDateService.size() >= 3) {
                new0 = newDateService.get(0);
                new1 = newDateService.get(1);
                new2 = newDateService.get(2);

                serviceInfos = new ArrayList<>();
                serviceInfos.add(new0);
                serviceInfos.add(new1);
                serviceInfos.add(new2);

            }

        }
        for (ServiceInfo serviceInfo : serviceInfos) {
            Integer categoryId = serviceInfo.getCategoryId();
            String catName = categoryService.getCatName(categoryId);
            serviceInfo.setCancelTime(catName);  //将服务的类别名称暂存到canceltime中 用作数据展示

            Integer id = serviceInfo.getId();
            Integer serCounts = subscribeService.getSerCounts(id);
            serviceInfo.setUnmountTime(serCounts.toString());  //讲订阅次数 暂时存在serCount中 用作数据展示

        }

        model.addObject("new0", new0);
        model.addObject("new1", new1);
        model.addObject("new2", new2);


        /*
            获取服务资源个数
            @reg 已注册的服务数量
            @pub 已发布的服务数量

         */
        Integer regServiceCounts = serviceInfoService.getRegServiceCounts();
        Integer pubServiceCounts = serviceInfoService.getPbuServiceCounts();
        model.addObject("reg", regServiceCounts);
        model.addObject("pub", pubServiceCounts);

        //订阅次数
        Integer subCounts = subscribeService.getSubCounts();
        model.addObject("subCounts", subCounts);

        //服务类别数量
        Integer cagCounts = categoryService.getCagCount();
        model.addObject("cag", cagCounts);



          /*
            获取服务的访问总次数
         */
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("", "");    //服务资源访问次数
        String url = "http://47.96.154.180:8030/shiro/calltimes/all";       //服务资源访问次数

        PostToJson1 postToJson = new PostToJson1();
        String send = postToJson.send(url, jsonObject, "utf-8");  //发送json格式的url和指令，返回json格式内容
        JSONObject json = (JSONObject) JSONObject.parse(send);  //将返回值转为json格式

        JSONArray result = json.getJSONArray("result");
        System.out.println(result);
        int total = 0;  //服务调用总次数

        for (int i = 0; i < result.size(); i++) {  //for循环从JsonArray中取出需要的数据
            JSONObject jsonObject1 = result.getJSONObject(i);
            Integer count = jsonObject1.getInteger("times");  //服务的次数
            total = total + count;  //所有服务的总次数
        }
        model.addObject("total", total);//访问总次数
        //            获取服务的访问总次数  完


        List<ServiceInfo> all = serviceInfoService.getAllServices();
        for (ServiceInfo serviceInfo : all) {
            Integer categoryId = serviceInfo.getCategoryId();
            String catName = categoryService.getCatName(categoryId); //服务类别名称
            serviceInfo.setCancelTime(catName);                 //类别名称暂存在CancelTime中
            System.out.println();
            Integer serviceId = serviceInfo.getId();
            Integer serCounts = subscribeService.getSerCounts(serviceId);//服务订阅次数
            serviceInfo.setUnmountTime(serCounts.toString());  //订阅次数暂存在UnmountTime中
        }
        Collections.sort(all, new Comparator<ServiceInfo>() {
            @Override
            public int compare(ServiceInfo o1, ServiceInfo o2) {
                Integer value1 = Integer.valueOf(o1.getUnmountTime());
                Integer value2 = Integer.valueOf(o2.getUnmountTime());
                return value2 - value1;
            }
        });
        if (all.size() <= 7 && all.size() != 0) {
            for (int i = 0; i < all.size(); i++) {
                ServiceInfo serviceInfo = all.get(i);
                model.addObject("hotService" + i, serviceInfo);

            }
        } else if (all.size() >= 7) {
            for (int i = 0; i < 7; i++) {
                ServiceInfo serviceInfo = all.get(i);
                model.addObject("hotService" + i, serviceInfo);

            }
        }
        model.addObject("total", total);//访问总次数

//        model.addObject("HotService", list);
//        System.out.println(list);


/*
        Integer[] serviceIds = subscribeService.getServiceIds();
        //将获取的serviceIds去重遍历
        HashSet hashSet = new HashSet(Arrays.asList(serviceIds));
        ArrayList arrayList = new ArrayList(hashSet);
        Integer[] array = (Integer[]) arrayList.toArray(new Integer[arrayList.size()]);
//        System.out.println(array.toString());

        ArrayList<Map<String, String>> Caglist = new ArrayList<>();
        for (Integer serviceId : array) {  //遍历所有的serviceID
            Integer serCounts = subscribeService.getSerCounts(serviceId);  //通过serviceId获取订阅的总次数

            String categoryName = categoryService.getCategoryName(serviceId); //通过serviceId获取服务的名字

            int flag = 0, i = 0;  //flag为判定是否具有相同服务名，i为获取相同服务名的map索引
            for (Map<String, String> tmap : Caglist) { //如果包含有相同服务名，让数值相加。（不同的服务可能同属于相同的服务类型
                if (categoryName.equals(tmap.get("name"))) {
//                    System.out.println("找到了");
                    String value = tmap.get("value");
                    Integer intss = Integer.valueOf(value);
                    serCounts = serCounts + intss;
//                    System.out.println(serCounts);
                    i = Caglist.indexOf(tmap);
//                    System.out.println("重设之前的集合为"+Caglist);
                    flag = 1;  //修改状态，让CagList直接重新赋值而不是添加
                    break;  //阿西吧
                }
            }
            if (flag == 1) {  //有相同的那啥，所以直接重新set
                HashMap<String, String> Cagmap = new HashMap<>();
                Cagmap.put("name", categoryName);
                Cagmap.put("value", serCounts.toString());
                Caglist.set(i, Cagmap);
//                System.out.println("重设之后的集合为"+Caglist);
            } else {   //没有那啥，直接添加新值
                HashMap<String, String> Cagmap = new HashMap<>();
                Cagmap.put("name", categoryName);
                Cagmap.put("value", serCounts.toString());
                Caglist.add(Cagmap);  //转换为饼状图的格式添加到list集合
            }
        }

        //ArrayList<Map<String,String>> newList = new ArrayList<Map<String,String>>(new HashSet(Caglist));
        //将集合去重后 传给前端饼状图
//        System.out.println( "去重后的集合： " + newList);

        String CagPie = JSON.toJSONString(Caglist);
        model.addObject("CagPie", CagPie);
//        System.out.println(newList);
        //完*/


       /* Integer[] categoryIds = serviceInfoService.getCategoryIds();
//        System.out.println("*********" + categoryIds);
        HashSet hashSet1 = new HashSet(Arrays.asList(categoryIds));
        ArrayList arrayList1 = new ArrayList(hashSet1);
        Integer[] array1 = (Integer[]) arrayList1.toArray(new Integer[arrayList1.size()]);

        ArrayList<Map<String, String>> TolList = new ArrayList<>();
        for (Integer categoryId : array1) {
            String catName = categoryService.getCatName(categoryId);
//            System.out.println(catName);
            Integer cateCounts = serviceInfoService.getCateCounts(categoryId);
//            System.out.println(cateCounts);


            int flag = 0, i = 0; //flag为判定是否具有相同的服务名，i为获取相同服务名的索引
            for (Map<String, String> map : TolList) {
                if (catName.equals(map.get("name"))) {
//                    System.out.println("找到了" + catName);
                    String value = map.get("value");  //将数字value转换为integer
                    Integer valu = Integer.valueOf(value);
                    cateCounts = cateCounts + valu;
                    i = TolList.indexOf(map);
                    flag = 1;
                    break;
                }
            }
            if (flag == 1) { //找到相同的服务类型，值累加后重新set
                HashMap<String, String> Cmap = new HashMap<>();
//                System.out.println("有那啥");
                Cmap.put("name", catName);
                Cmap.put("value", cateCounts.toString());
                TolList.set(i, Cmap);
            } else {   //没有那啥，直接添加新值
//                System.out.println("没有那啥");
                HashMap<String, String> Cmap = new HashMap<>();
                Cmap.put("name", catName);
                Cmap.put("value", cateCounts.toString());
                TolList.add(Cmap);  //转换为饼状图的格式添加到list集合
            }
        }

        String TolPie = JSON.toJSONString(TolList);
        model.addObject("TolPie", TolPie);*/

/*        Integer weekRegSerCounts = serviceInfoService.getWeekRegServiceCounts();
//        System.out.println("最近七日内注册的服务数量"+weekRegSerCounts);
        model.addObject("WkRegCounts", weekRegSerCounts);

        Integer weekPubSerCounts = serviceInfoService.getWeekPubServiceCounts();
//        System.out.println("最近七日内发布的服务数量"+weekPubSerCounts);
        model.addObject("WkPubCounts", weekPubSerCounts);

        Integer weekSubSerCount = subscribeService.getWeekSubServiceCount();
//        System.out.println("最近七日内订阅的服务数量" + weekSubSerCount);
        model.addObject("WkSubCounts", weekSubSerCount);*/


//        model.addObject("serviceCounts", service.size());  //服务的总个数


        return model;
    }

}
