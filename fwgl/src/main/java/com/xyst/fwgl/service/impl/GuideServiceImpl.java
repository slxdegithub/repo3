package com.xyst.fwgl.service.impl;

import com.xyst.fwgl.mapper.GuideMapper;
import com.xyst.fwgl.model.Guide;
import com.xyst.fwgl.service.GuideService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: *****
 * @Date: 2020/8/21 22:30
 */
@Service
public class GuideServiceImpl implements GuideService {
    @Resource
    private GuideMapper guideMapper;
    @Override
    public Guide findById(Integer id) {
        return guideMapper.selectByPrimaryKey(id);
    }

    @Override
    public Integer save(Guide guide) {
        return guideMapper.insertSelective(guide);
    }

    @Override
    public Integer update(Guide guide) {
        return guideMapper.updateByPrimaryKey(guide);
    }

    @Override
    public Integer delete(Integer id) {
        return guideMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Guide> findAll() {
        return guideMapper.selectAll();
    }
}
