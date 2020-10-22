package com.xyst.fwgl.mapper;

import com.xyst.fwgl.model.LogInfo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface LogInfoMapper extends Mapper<LogInfo> {
    @Select("select * from log_info  order by access_time desc limit #{startPos},#{endPos}")
    List<LogInfo> findByPage(@Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select count(*) from log_info")
    Integer countAllLogInfo();
    @Select("select count(*) from log_info where access_time >=#{startDate} and access_time <=#{endDate} ")
    Integer countLogInfoByRange(@Param("startDate") String startDate,@Param("endDate") String endDate);
    @Select("select * from log_info where access_time >=#{startDate} and access_time <=#{endDate} order by access_time desc limit #{startPos},#{endPos}")
    List<LogInfo> findByRangeAndPage(@Param("startDate") String startDate,@Param("endDate") String endDate,@Param("startPos")Integer startPos,@Param("endPos") Integer endPos);


}
