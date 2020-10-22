package com.xyst.fwgl.service;

import com.xyst.fwgl.model.Category;
import com.xyst.fwgl.model.TongJi;

import java.util.List;

public interface CategoryService {
    Category findById(Integer id);
    List<Category> findByCname(String cname);
    List<Category> findAllFirstCategoryByStatus(Integer status);
    Integer countAllCategory();
    Integer countCategoryByName(String cname);
    Integer countCategoryByRange(String startDate,String endDate);
    List<Category> findByPage(Integer startPos, Integer endPos);
    List<Category> findByPageAndCname(String cname,Integer startPos, Integer endPos);
    List<Category> findByPageAndRange(String startDate,String endDate,Integer startPos, Integer endPos);
    List<Category> findAll();
    List<Category> findByStatus(int status);
    Integer save(Category category);
    Integer delete(Integer id);
    Integer update(Category category);

    //获取所有服务的总数量
    Integer getCagCount();

    //通过service_id查找到category表的服务类型名字Name
    String getCategoryName(Integer service_id);

    //通过service_id查找category_id
    Integer getCategoryId(Integer id);

    //通过category_id查询name
    String getCatName(Integer id);

    //获取所有的category_id
    Integer[] getAllCategoryId();

    //根据name查询id
    Integer nameToGetId(String name);

    //根据name模糊查询服务类别
    List<Category> seachCategory(String name);

    //统计图2查询tongji2视图
    List<TongJi> getTongJi2();

    //统计图2查询tongji3视图
    List<TongJi> getTongJi3();

    //通过category_id查询所有type为1且pre_category 等于 category_id 的二级目录
    List<Category> getTwoCategoryList(Integer id);
    List<Category> findAllFirstCategory();
    List<Category> findAllSecondCategoryByPreId(Integer preId);
}
