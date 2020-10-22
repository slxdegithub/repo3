package com.xyst.fwgl.service;

import com.xyst.fwgl.model.Guide;
import com.xyst.fwgl.model.Notice;

import java.util.List;

/**
 * @Author: *****
 * @Date: 2020/8/21 22:24
 */
public interface GuideService {
    Guide findById(Integer id);
    Integer save(Guide guide);
    Integer update(Guide guide);
    Integer delete(Integer id);
    List<Guide> findAll();
}
