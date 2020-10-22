package com.xyst.fwgl.service;

import com.xyst.fwgl.model.Notice;

import java.util.List;

/**
 * @Author: *****
 * @Date: 2020/8/21 22:24
 */
public interface NoticeService {
    Notice findById(Integer id);
    Integer save(Notice notice);
    Integer update(Notice notice);
    Integer delete(Integer id);
    List<Notice> findAll();
}
