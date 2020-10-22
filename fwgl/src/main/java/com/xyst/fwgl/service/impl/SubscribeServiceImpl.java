package com.xyst.fwgl.service.impl;

import com.xyst.fwgl.mapper.SubscribeMapper;
import com.xyst.fwgl.model.Subscribe;
import com.xyst.fwgl.model.SubscribeAudit;
import com.xyst.fwgl.service.SubscribeService;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
@Service
public class SubscribeServiceImpl implements SubscribeService {
   @Resource
   private SubscribeMapper subscribeMapper;
    @Override
    public Subscribe findById(Integer id) {
        return subscribeMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Subscribe> findAll() {
        return subscribeMapper.selectAll();
    }

    @Override
    public Integer save(Subscribe subscribe) {
        return subscribeMapper.insert(subscribe);
    }

    @Override
    public Integer delete(Integer id) {
        return subscribeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Integer update(Subscribe subscribe) {
        return subscribeMapper.updateByPrimaryKey(subscribe);
    }

    @Override
    public Integer countByStatus(Integer status) {
        return subscribeMapper.countByStatus(status);
    }

    @Override
    public Integer countDistinctByStatus(Integer status) {
        return subscribeMapper.countDistinctByStatus(status);
    }

    @Override
    public Subscribe getActiveSubByIdAndSubscriber(Integer serviceId, String subscriber) {
        return subscribeMapper.getActiveSubByIdAndSubscriber(serviceId, subscriber);
    }

    @Override
    public Integer countBySubscriber(String subscriber) {
        return subscribeMapper.countBySubscriber(subscriber);
    }

    @Override
    public Integer countAuditSubscribe() {
        return subscribeMapper.countAuditSubscribe();
    }

    @Override
    public Integer countBySubscriberAndStatus(String subscriber, Integer status) {
        return subscribeMapper.countBySubscriberAndStatus(subscriber,status);
    }

    @Override
    public Integer countLikeByNameAndStatus(String name, Integer status) {
        return subscribeMapper.countLikeByNameAndStatus(name,status);
    }

    @Override
    public Integer countDistinctLikeByNameAndStatus(String name, Integer status) {
        return subscribeMapper.countDistinctLikeByNameAndStatus(name, status);
    }

    @Override
    public Integer countLikeByName(String name) {
        return subscribeMapper.countLikeByName(name);
    }

    @Override
    public Integer countLikeBySubscriberAndNameAndStatus(String subscriber, String name, Integer status) {
        return subscribeMapper.countLikeBySubscriberAndNameAndStatus(subscriber, name, status);
    }

    @Override
    public Integer countLikeByCnameAndStatus(String cname, Integer status) {
        return subscribeMapper.countLikeByCnameAndStatus(cname, status);
    }

    @Override
    public Integer countDistinctLikeByCnameAndStatus(String cname, Integer status) {
        return subscribeMapper.countDistinctLikeByCnameAndStatus(cname, status);
    }

    @Override
    public Integer countLikeByCname(String cname) {
        return subscribeMapper.countLikeByCname(cname);
    }

    @Override
    public Integer countLikeBySubscriberAndCnameAndStatus(String subscriber, String cname, Integer status) {
        return subscribeMapper.countLikeBySubscriberAndCnameAndStatus(subscriber, cname, status);
    }

    @Override
    public Integer countLikeBySubscriberAndCname(String subscriber, String cname) {
        return subscribeMapper.countLikeBySubscriberAndCname(subscriber, cname);
    }

    @Override
    public Integer countLikeBySubscriberAndName(String subscriber, String name) {
        return subscribeMapper.countLikeBySubscriberAndName(subscriber, name);
    }

    @Override
    public Integer countByRangeAndStatus(String startDate, String endDate, Integer status) {
        return subscribeMapper.countLikeByRangeAndStatus(startDate, endDate, status);
    }

    @Override
    public Integer countDistinctByRangeAndStatus(String startDate, String endDate, Integer status) {
        return subscribeMapper.countDistinctLikeByRangeAndStatus(startDate, endDate, status);
    }

    @Override
    public Integer countByRange(String startDate, String endDate) {
        return subscribeMapper.countLikeByRange(startDate,endDate);
    }

    @Override
    public Integer countBySubscriberAndRangeAndStatus(String subscriber, String startDate, String endDate, Integer status) {
        return subscribeMapper.countBySubscriberAndRangeAndStatus(subscriber, startDate, endDate, status);
    }

    @Override
    public Integer countBySubscriberAndRange(String subscriber, String startDate, String endDate) {
        return subscribeMapper.countBySubscriberAndRange(subscriber, startDate, endDate);
    }

    @Override
    public List<Subscribe> findDistinctByPageAndStatus(Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findDistinctByPageAndStatus(status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findByPageAndStatus(Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findByPageAndStatus(status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findByPageAndSubscriber(String subscriber, Integer startPos, Integer endPos) {
        return subscribeMapper.findByPageAndSubscriber(subscriber,startPos,endPos);
    }

    @Override
    public List<Subscribe> findByPageAndSubscriberAndStatus(String subscriber, Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findByPageAndSubscriberAndStatus(subscriber, status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findLikeByPageAndNameAndStatus(String name, Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findLikeByPageAndNameAndStatus(name, status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findDistinctLikeByPageAndNameAndStatus(String name, Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findDistinctLikeByPageAndNameAndStatus(name, status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findLikeByPageAndName(String name, Integer startPos, Integer endPos) {
        return subscribeMapper.findLikeByPageAndName(name, startPos, endPos);
    }

    @Override
    public List<Subscribe> findLikeByPageAndSubscriberAndName(String subscriber, String name, Integer startPos, Integer endPos) {
        return subscribeMapper.findLikeByPageAndSubscriberAndName(subscriber, name, startPos, endPos);
    }

    @Override
    public List<Subscribe> findLikeByPageAndSubscriberAndNameAndStatus(String subscriber, String name, Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findLikeByPageAndSubscriberAndNameAndStatus(subscriber, name, status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findByPageAndRangeAndStatus(String startDate, String endDate, Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findByPageAndRangeAndStatus(startDate, endDate, status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findDistinctByPageAndRangeAndStatus(String startDate, String endDate, Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findDistinctByPageAndRangeAndStatus(startDate, endDate, status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findByPageAndRange(String startDate, String endDate, Integer startPos, Integer endPos) {
        return subscribeMapper.findByPageAndRange(startDate, endDate, startPos, endPos);
    }

    @Override
    public List<Subscribe> findByPageAndSubscriberAndRangeAndStatus(String subscriber, String startDate, String endDate, Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findLikeByPageAndSubscriberAndRangeAndStatus(subscriber, startDate, endDate, status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findLikeByPageAndSubscriberAndRange(String subscriber, String startDate, String endDate, Integer startPos, Integer endPos) {
        return subscribeMapper.findLikeByPageAndSubscriberAndRange(subscriber, startDate, endDate, startPos, endPos);
    }

    @Override
    public List<Subscribe> findLikeByPageAndCnameAndStatus(String cname, Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findLikeByPageAndCnameAndStatus(cname, status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findDistinctLikeByPageAndCnameAndStatus(String cname, Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findDistinctLikeByPageAndCnameAndStatus(cname, status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findLikeByPageAndCname(String cname, Integer startPos, Integer endPos) {
        return subscribeMapper.findLikeByPageAndCname(cname, startPos, endPos);
    }

    @Override
    public List<Subscribe> findLikeByPageAndSubscriberAndCnameAndStatus(String subscriber, String cname, Integer status, Integer startPos, Integer endPos) {
        return subscribeMapper.findLikeByPageAndSubscriberAndCnameAndStatus(subscriber, cname, status, startPos, endPos);
    }

    @Override
    public List<Subscribe> findLikeByPageAndSubscriberAndCname(String subscriber, String cname, Integer startPos, Integer endPos) {
        return subscribeMapper.findLikeByPageAndSubscriberAndCname(subscriber, cname, startPos, endPos);
    }

    @Override
    public List<Subscribe> findAuditSubByPage(Integer startPos, Integer endPos) {
        return subscribeMapper.findAuditSubByPage(startPos, endPos);
    }


    @Override
    public List<Subscribe> findByServiceIdAndSubscriberAndStatus(Integer serviceId, String subscriber, Integer status) {
        Example example=new Example(Subscribe.class);
        Example.Criteria criteria=example.createCriteria();
        example.setOrderByClause("apply_time DESC");
        criteria.andEqualTo("serviceId", serviceId);
        criteria.andEqualTo("subscriber", subscriber);
        criteria.andEqualTo("status", status);
        List<Subscribe> lists = subscribeMapper.selectByExample(example);
        return lists;
    }

    @Override
    public List<Subscribe> findByServiceIdAndSubscriber(Integer serviceId, String subscriber) {
        Example example=new Example(Subscribe.class);
        Example.Criteria criteria=example.createCriteria();
        example.setOrderByClause("apply_time DESC");
        criteria.andEqualTo("serviceId", serviceId);
        criteria.andEqualTo("subscriber", subscriber);
        List<Subscribe> lists = subscribeMapper.selectByExample(example);
        return lists;
    }

    //服务订阅次数
    @Override
    public Integer getSubCounts() {
        return subscribeMapper.getSubCounts();
    }

    @Override
    public Integer[] getServiceIds() {
        return subscribeMapper.getServiceIds();
    }

    @Override
    public Integer getSerCounts(Integer id) {
        return subscribeMapper.getSerCounts(id);
    }

    @Override
    public Integer getWeekSubServiceCount() {
        return subscribeMapper.getWeekSubServiceCount();
    }

    @Override
    public Integer getEvdaySubServiceCount(Integer n) {
        return subscribeMapper.getEvdaySubServiceCount(n);
    }

    @Override
    public Integer getChooseEvdaySubServiceCount(Integer n, String chooseDate) {
        return subscribeMapper.getChooseEvdaySubServiceCount(n,chooseDate);
    }

    @Override
    public Integer getfullServiceSubStatus(Integer service_id, String subscriber) {
        return subscribeMapper.getfullServiceSubStatus(service_id,subscriber);
    }

    @Override
    public Integer cancelSubService(Integer service_id, String subscriber) {
        subscribeMapper.cancelSubService(service_id,subscriber);
        return subscribeMapper.cancelSubServiceAudit(service_id,subscriber);
    }
}
