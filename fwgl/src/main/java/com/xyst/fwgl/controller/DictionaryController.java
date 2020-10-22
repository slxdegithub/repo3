package com.xyst.fwgl.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.xyst.fwgl.model.Dictionary;
import com.xyst.fwgl.service.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author slx
 * @Date 2020/8/28 8:56
 */
@Controller
@RequestMapping("/dictionary")
public class DictionaryController {

    @Autowired
    private DictionaryService dictionaryService;

    @RequestMapping("/select")
    @ResponseBody
    public ModelAndView selectAllDictionary(Integer page){
        ModelAndView model = new ModelAndView();
        List<Dictionary> allDictionary = dictionaryService.findAllDictionary(page);
//        System.out.println(allDictionary.get(1).getType().equals(1));
        PageInfo<Dictionary> appsPageInfo = null;
        appsPageInfo = new PageInfo<>(allDictionary);

        System.out.println(appsPageInfo.getTotal() + "aaa" + appsPageInfo.getPageNum());
        model.addObject("Dictionary",appsPageInfo);
        model.setViewName("dictionary");
        return model;
    }

    @RequestMapping("/insert")
    @ResponseBody
    public void insertIntoDictionary(String name, Integer type, String description, HttpServletRequest request, HttpServletResponse response) throws IOException {
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime = dateFormat.format(date.getTime());
        System.out.println(createTime);

        Integer status = dictionaryService.insertDictionary(name, type, createTime, description);
        System.out.println("description" + description);
//        System.out.println("status为"+status);
        JSONObject json=new JSONObject();
        json.put("status",status);
        response.getWriter().write(json.toString());
    }


    @RequestMapping("/update")
    public void updateDictionary(String name, Integer type,  String description,Integer id,HttpServletRequest request, HttpServletResponse response) throws IOException {
        Date date = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime = dateFormat.format(date.getTime());
        Integer status = dictionaryService.updateDictionary(name, type, createTime, description, id);

        JSONObject json=new JSONObject();
        json.put("status",status);
        response.getWriter().write(json.toString());
    }

    @RequestMapping("/delete")
    @ResponseBody
    public void deleteDictionary(Integer id,HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer status = dictionaryService.deleteDictionary(id);
        System.out.println(status);
        JSONObject json=new JSONObject();
        json.put("status",status);
        response.getWriter().write(json.toString());
    }

    @RequestMapping("/getDictionaryInfo")
    @ResponseBody
    public void getDictionaryInfo(Integer id, HttpServletResponse response) throws IOException {
        Dictionary dictionary = dictionaryService.getDictionary(id);

        JSONObject json=new JSONObject();

        json.put("dictionary",dictionary);
        response.setContentType("text/html;charset=utf-8");
        response.getWriter().write(json.toString());

    }
    
    /** 
    * @Description: 根据名称模糊查询词典
    * @Param:  
    * @return:  
    * @Author: 龙龙 
    * @Date  
    */
    @RequestMapping("selectName")
    public ModelAndView selectNameDictionary(String name,Integer page,HttpServletRequest request){
        ModelAndView model = new ModelAndView();
        List<Dictionary> dictionaries = dictionaryService.selectName(name,page);

        PageInfo<Dictionary> appsPageInfo = null;
        appsPageInfo = new PageInfo<>(dictionaries);

        String findType=request.getParameter("findType");
        System.out.println(findType);

        model.addObject("findType",findType);
        model.addObject("Dictionary",appsPageInfo);
        model.addObject("selectDictionaryName",name);
        model.setViewName("dictionary");
        return model;
    }

    /** 
    * @Description: 根据 时间模糊查询
    * @Param:  
    * @return:  
    * @Author: 龙龙 
    * @Date  
    */
    @RequestMapping("/selectTime")
    public ModelAndView selectTimeDictionary(Integer page, HttpServletRequest request) throws ParseException {
        ModelAndView model = new ModelAndView();

        String range=request.getParameter("range");
        String findType=request.getParameter("findType");
        System.out.println(findType);

//        String pages=request.getParameter("page");
//        System.out.println("range=" + range);
//        System.out.println( "page=" + page);
//        System.out.println( "pages=" + pages);
//        System.out.println("range="+range);
        String startDate=range.substring(0,10);
        String endDate=range.substring(13);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        Date date= sdf.parse(endDate);
        calendar.setTime(date);
        int day=calendar.get(Calendar.DATE);
        calendar.set(Calendar.DATE,day+1);
        endDate = sdf.format(calendar.getTime());

        System.out.println(startDate);
        System.out.println(endDate);
        List<Dictionary> dictionaries = dictionaryService.selectTime(startDate, endDate, page);
        PageInfo<Dictionary> appsPageInfo = null;
        appsPageInfo = new PageInfo<>(dictionaries);

        model.addObject("findType",findType);
        model.addObject("Dictionary",appsPageInfo);
        model.addObject("selectDictionaryTime",range);

        model.setViewName("dictionary");
        return model;
    }
    /** 
    * @Description: 根据类型查询
    * @Param:  
    * @return:  
    * @Author: 龙龙 
    * @Date  
    */
    @RequestMapping("selectType")
    public ModelAndView selectTypeDictionary(String name,Integer page,HttpServletRequest request){
        ModelAndView model = new ModelAndView();
        if ("服务类型".contains(name)){
            List<Dictionary> dictionaries = dictionaryService.selectType(1, page);
            PageInfo<Dictionary> appsPageInfo = null;
            appsPageInfo = new PageInfo<>(dictionaries);
            model.addObject("Dictionary",appsPageInfo);

        }else if ("协议类型".contains(name)){
            List<Dictionary> dictionaries = dictionaryService.selectType(2, page);
            PageInfo<Dictionary> appsPageInfo = null;
            appsPageInfo = new PageInfo<>(dictionaries);
            model.addObject("Dictionary",appsPageInfo);
        }

        String findType=request.getParameter("findType");
        System.out.println(findType);

        model.addObject("findType",findType);
        model.addObject("selectDictionaryName",name);

        model.setViewName("dictionary");
        return model;
    }


}
