package com.xyst.fwgl.mapper;

import com.xyst.fwgl.model.Dictionary;
import org.apache.ibatis.annotations.*;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface DictionaryMapper extends Mapper<Dictionary> {

    @Select("select * from dictionary")
    List<Dictionary> findAllDictionary();
    @Select("select count(*) from dictionary where name like '%${name}%'")
    Integer countLikeByName(String name);
    @Select("select count(*) from dictionary where create_time>=#{startDate} and create_time<=#{endDate}")
    Integer countByRange(@Param("startDate")String  startDate,@Param("endDate")String endDate);
    @Select("select count(*) from dictionary where type=#{type}")
    Integer countLikeByType(Integer type);
    @Select("select * from dictionary limit #{startPos},#{endPos}")
    List<Dictionary> findByPage(@Param("startPos")Integer startPos,@Param("endPos") Integer endPos);
    @Select("select * from dictionary where name like '%${name}%' limit #{startPos},#{endPos}")
    List<Dictionary> findLikeByPageAndName(@Param("name")String name,@Param("startPos")Integer startPos,@Param("endPos")Integer endPos);
    @Select("select * from dictionary where type=#{type} limit #{startPos},#{endPos}")
    List<Dictionary> findLikeByPageAndType(@Param("type")Integer type,@Param("startPos")Integer startPos,@Param("endPos")Integer endPos);
    @Select("select * from dictionary where create_time>=#{startDate} and create_time<=#{endDate} limit #{startPos},#{endPos}")
    List<Dictionary> findByPageAndRange(@Param("startDate")String  startDate,@Param("endDate")String endDate,@Param("startPos")Integer startPos,@Param("endPos")Integer endPos);

    @Delete("delete from dictionary where id = #{id}")
    Integer deleteDictionary(Integer id);

    @Insert("insert into dictionary(name,type,create_time,description) values(#{name},#{type},#{createTime},#{description})")
    Integer insertDictionary(@Param("name") String name, @Param("type") Integer type, @Param("createTime") String createTime, @Param("description") String description);

    @Update("update dictionary set name=#{name} ,type = #{type} , create_time = #{createTime} , description = #{description} where id = #{id}")
    Integer updateDictionary(@Param("name") String name, @Param("type") Integer type, @Param("createTime") String createTime, @Param("description") String description, @Param("id") Integer id);

    @Select("select * from dictionary where id = #{id}")
    Dictionary getDictionary(Integer id);

    @Select("select * from dictionary where name like #{name}")
    List<Dictionary> selectName(String name);

    @Select("select * from dictionary where type = #{type}")
    List<Dictionary> selectType(Integer type);

    @Select("select * from dictionary where  create_time>=#{startDate} and create_time<=#{endDate} ")
    List<Dictionary> selectTime(@Param("startDate") String startDate, @Param("endDate") String endDate);
}
