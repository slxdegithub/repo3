package com.xyst.fwgl.mapper;

import com.xyst.fwgl.model.Category;
import com.xyst.fwgl.model.TongJi;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface CategoryMapper extends Mapper<Category> {
    @Select("select count(*) from category")
    Integer countAllCategory();
    @Select("select count(*) from category where cname like '%${cname}%'")
    Integer countCategoryByName(String cname);
    @Select("select count(*) from category where create_time>=#{startDate} and create_time<=#{endDate}")
    Integer countCategoryByRange(@Param("startDate") String startDate, @Param("endDate") String endDate);
    @Select("select * from category order by create_time desc limit #{startPos},#{endPos} ")
    List<Category> findByPage(@Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from category where cname like '%${cname}%' order by create_time desc limit #{startPos},#{endPos} ")
    List<Category> findByPageAndCname(@Param("cname") String cname, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from category where create_time>=#{startDate} and create_time<=#{endDate} order by create_time desc limit #{startPos},#{endPos} ")
    List<Category> findByPageAndRange(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    //获取服务所有类型的数量
    @Select("select count(*) from category where status=2 ")
    Integer getCagCount();

    //通过service_id来查询category_id,进而查询category_id对应的名称，
    @Select("select `cname` FROM category where id =(select category_id FROM service_info where id =#{service_id}) and status = 2")
    String getCategoryName(Integer service_id);

    //通过service_id查询category_id
    @Select("select category_id from service_info where id = #{id} and status = 2")
    Integer getCategoryId(Integer id);

    //通过category_id查询name
    @Select("select cname from category where id = #{id} and status = 2")
    String getCatName(Integer id);

    //获取所有的category_id
    @Select("select id from category where status = 2  and type = 1")
    Integer[] getAllCategoryId();

    //根据name查询id
    @Select("select id from category where cname = #{name} and status = 2")
    Integer nameToGetId(String name);

    //根据name模糊查询服务类别
    @Select("select * from category where `cname` like  #{name} and status =2  and type = 1")
    List<Category> seachCategory(String name);

    //统计图2查询tongji2视图
    @Select("select * from tongji2")
    List<TongJi> getTongJi2();

    //统计图2查询tongji3视图
    @Select("select * from tongji3")
    List<TongJi> getTongJi3();

    //通过category_id查询所有type为1且pre_category 等于 category_id 的二级目录
    @Select("select * from category where status = 2 and type = 2 and pre_category = #{id}")
    List<Category> getTwoCategoryList(Integer id);

}
