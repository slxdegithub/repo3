package com.xyst.fwgl.service;

import com.xyst.fwgl.model.LogInfo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface LogInfoService {
    LogInfo findById(Integer id);
    List<LogInfo> findAll();
    Integer countAllLogInfo();
    Integer save(LogInfo logInfo);
    Integer update(LogInfo logInfo);
    List<LogInfo> findByPage(Integer startPos, Integer endPos);
    Integer countLogInfoByRange(String startDate, String endDate);
    List<LogInfo> findByRangeAndPage(String startDate,String endDate,Integer startPos,Integer endPos);
}
