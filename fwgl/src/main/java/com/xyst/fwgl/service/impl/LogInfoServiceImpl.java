package com.xyst.fwgl.service.impl;

import com.xyst.fwgl.mapper.LogInfoMapper;
import com.xyst.fwgl.model.LogInfo;
import com.xyst.fwgl.service.LogInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class LogInfoServiceImpl implements LogInfoService {
    @Resource
    private LogInfoMapper logInfoMapper;
    @Override
    public LogInfo findById(Integer id) {
        return logInfoMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<LogInfo> findAll() {
        return logInfoMapper.selectAll();
    }

    @Override
    public Integer countAllLogInfo() {
        return logInfoMapper.countAllLogInfo();
    }

    @Override
    public Integer save(LogInfo logInfo) {
        return logInfoMapper.insert(logInfo);
    }

    @Override
    public Integer update(LogInfo logInfo) {
        return logInfoMapper.updateByPrimaryKeySelective(logInfo);
    }

    @Override
    public List<LogInfo> findByPage(Integer startPos, Integer endPos) {
        return logInfoMapper.findByPage(startPos, endPos);
    }

    @Override
    public Integer countLogInfoByRange(String startDate, String endDate) {
        return logInfoMapper.countLogInfoByRange(startDate, endDate);
    }

    @Override
    public List<LogInfo> findByRangeAndPage(String startDate, String endDate, Integer startPos, Integer endPos) {
        return logInfoMapper.findByRangeAndPage(startDate, endDate, startPos, endPos);
    }
}
