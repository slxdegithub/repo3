package com.xyst.fwgl.service.impl;

import com.xyst.fwgl.mapper.CategoryMapper;
import com.xyst.fwgl.model.Category;
import com.xyst.fwgl.model.TongJi;
import com.xyst.fwgl.service.CategoryService;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.List;
@Service
public class CategoryServiceImpl implements CategoryService {
    @Resource
    private CategoryMapper categoryMapper;
    @Override
    public Category findById(Integer id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Category> findByCname(String cname) {
        Example example=new Example(Category.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("cname", cname);
        List<Category> lists = categoryMapper.selectByExample(example);
        return lists;
    }

    @Override
    public List<Category> findAllFirstCategoryByStatus(Integer status) {
        Example example=new Example(Category.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("status", status);
        criteria.andEqualTo("type",1);
        List<Category> lists = categoryMapper.selectByExample(example);
        return lists;
    }

    @Override
    public Integer countAllCategory() {
        return categoryMapper.countAllCategory();
    }

    @Override
    public Integer countCategoryByName(String cname) {
        return categoryMapper.countCategoryByName(cname);
    }

    @Override
    public Integer countCategoryByRange(String startDate, String endDate) {
        return categoryMapper.countCategoryByRange(startDate, endDate);
    }

    @Override
    public List<Category> findByPage(Integer startPos,Integer endPos) {
        return categoryMapper.findByPage(startPos, endPos);
    }

    @Override
    public List<Category> findByPageAndCname(String cname, Integer startPos, Integer endPos) {
        return categoryMapper.findByPageAndCname(cname, startPos, endPos);
    }

    @Override
    public List<Category> findByPageAndRange(String startDate, String endDate, Integer startPos, Integer endPos) {
        return categoryMapper.findByPageAndRange(startDate, endDate, startPos, endPos);
    }

    @Override
    public List<Category> findAll() {
        return categoryMapper.selectAll();
    }

    @Override
    public List<Category> findByStatus(int status) {
        Example example=new Example(Category.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("status", status);
        List<Category> lists = categoryMapper.selectByExample(example);
        return lists;
    }

    @Override
    public Integer save(Category category) {
        return categoryMapper.insert(category);
    }

    @Override
    public Integer delete(Integer id) {
        return categoryMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Integer update(Category category) {
        return categoryMapper.updateByPrimaryKeySelective(category);
    }

    @Override
    public Integer getCagCount() {
        return categoryMapper.getCagCount();
    }

    @Override
    public String getCategoryName(Integer service_id) {
        return categoryMapper.getCategoryName(service_id);
    }

    @Override
    public Integer getCategoryId(Integer id) {
        return categoryMapper.getCategoryId(id);
    }

    @Override
    public String getCatName(Integer id) {
        return categoryMapper.getCatName(id);
    }

    @Override
    public Integer[] getAllCategoryId() {
        return categoryMapper.getAllCategoryId();
    }

    @Override
    public Integer nameToGetId(String name) {
        return categoryMapper.nameToGetId(name);
    }

    @Override
    public List<Category> seachCategory(String name) {
        name = "%" + name + "%";
        return categoryMapper.seachCategory(name);
    }

    @Override
    public List<TongJi> getTongJi2() {
        return categoryMapper.getTongJi2();
    }

    @Override
    public List<TongJi> getTongJi3() {
        return categoryMapper.getTongJi3();
    }

    @Override
    public List<Category> getTwoCategoryList(Integer id) {
        return categoryMapper.getTwoCategoryList(id);
    }

    @Override
    public List<Category> findAllFirstCategory() {
        Example example=new Example(Category.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("type", 1);
        criteria.andEqualTo("status", 2);
        List<Category> lists = categoryMapper.selectByExample(example);
        return lists;
    }

    @Override
    public List<Category> findAllSecondCategoryByPreId(Integer preId) {
        Example example=new Example(Category.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("preCategory", preId);
        criteria.andEqualTo("status", 2);
        criteria.andEqualTo("type", 2);
        List<Category> lists = categoryMapper.selectByExample(example);
        return lists;
    }
}
