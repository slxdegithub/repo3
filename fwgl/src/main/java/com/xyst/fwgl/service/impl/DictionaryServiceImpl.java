package com.xyst.fwgl.service.impl;

import com.github.pagehelper.PageHelper;
import com.xyst.fwgl.mapper.DictionaryMapper;
import com.xyst.fwgl.model.Dictionary;
import com.xyst.fwgl.model.ServiceAudit;
import com.xyst.fwgl.model.ServiceInfo;
import com.xyst.fwgl.service.DictionaryService;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DictionaryServiceImpl implements DictionaryService {

    @Resource
    private DictionaryMapper dictionaryMapper;

    @Override
    public List<Dictionary> findAllDictionary(Integer page) {
        PageHelper.startPage(page, 10);
        return dictionaryMapper.findAllDictionary();
    }

    @Override
    public Integer countAllDictionary() {
        Example example=new Example(Dictionary.class);
        Integer count = dictionaryMapper.selectCountByExample(example);
        return count;
    }

    @Override
    public Integer countLikeByName(String name) {
        return dictionaryMapper.countLikeByName(name);
    }

    @Override
    public Integer countLikeByType(Integer type) {
        return dictionaryMapper.countLikeByType(type);
    }

    @Override
    public Integer countByRange(String startDate, String endDate) {
        return dictionaryMapper.countByRange(startDate, endDate);
    }

    @Override
    public List<Dictionary> findByPage(Integer startPos, Integer endPos) {
        return dictionaryMapper.findByPage(startPos, endPos);

    }

    @Override
    public List<Dictionary> findByPageAndRange(String startDate, String endDate, Integer startPos, Integer endPos) {
        return dictionaryMapper.findByPageAndRange(startDate, endDate, startPos, endPos);
    }

    @Override
    public List<Dictionary> findLikeByPageAndName(String name, Integer startPos, Integer endPos) {
        return dictionaryMapper.findLikeByPageAndName(name, startPos, endPos);
    }

    @Override
    public List<Dictionary> findLikeByPageAndType(Integer type, Integer startPos, Integer endPos) {
        return dictionaryMapper.findLikeByPageAndType(type, startPos, endPos);
    }

    @Override
    public Integer deleteDictionary(Integer id) {
        return dictionaryMapper.deleteDictionary(id);
    }

    @Override
    public Integer insertDictionary(String name, Integer type, String createTime, String description) {
        return dictionaryMapper.insertDictionary(name,type,createTime,description);
    }

    @Override
    public Integer updateDictionary(String name, Integer type, String createTime, String description, Integer id) {
        return dictionaryMapper.updateDictionary(name,type,createTime,description,id);
    }

    @Override
    public Dictionary getDictionary(Integer id) {
        return dictionaryMapper.getDictionary(id);
    }

    @Override
    public List<Dictionary> selectName(String name,Integer page) {
        name = "%" + name + "%";
        PageHelper.startPage(page, 10);
        return dictionaryMapper.selectName(name);
    }

    @Override
    public List<Dictionary> selectTime(String startDate, String endDate,Integer page) {
        PageHelper.startPage(page, 10);
        return dictionaryMapper.selectTime(startDate,endDate);
    }

    @Override
    public List<Dictionary> selectType(Integer type,Integer page) {
        PageHelper.startPage(page, 10);
        return dictionaryMapper.selectType(type);
    }

    @Override
    public List<Dictionary> findAllDictionaryByType(Integer type) {
        Example example=new Example(Dictionary.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("type", type);
        List<Dictionary> lists = dictionaryMapper.selectByExample(example);
        return lists;
    }


}
