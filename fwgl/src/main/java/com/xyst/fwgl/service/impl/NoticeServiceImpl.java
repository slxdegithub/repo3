package com.xyst.fwgl.service.impl;

import com.xyst.fwgl.mapper.NoticeMapper;
import com.xyst.fwgl.model.Notice;
import com.xyst.fwgl.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: *****
 * @Date: 2020/8/21 22:26
 */
@Service
public class NoticeServiceImpl implements NoticeService {
    @Resource
    private NoticeMapper noticeMapper;
    @Override
    public Notice findById(Integer id) {
        return noticeMapper.selectByPrimaryKey(id);
    }

    @Override
    public Integer save(Notice notice) {
        return noticeMapper.insertSelective(notice);
    }

    @Override
    public Integer update(Notice notice) {
        return noticeMapper.updateByPrimaryKey(notice);
    }

    @Override
    public Integer delete(Integer id) {
        return noticeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Notice> findAll() {
        return noticeMapper.selectAll();
    }
}
