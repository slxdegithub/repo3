package com.xyst.fwgl.service;

import com.xyst.fwgl.model.Subscribe;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.Date;
import java.util.List;

public interface SubscribeService {
    Subscribe findById(Integer id);
    List<Subscribe> findAll();
    Integer save(Subscribe subscribe);
    Integer delete(Integer id);
    Integer update(Subscribe subscribe);
    Integer countByStatus(Integer status);
    Integer countDistinctByStatus(Integer status);
    Subscribe getActiveSubByIdAndSubscriber(Integer serviceId,String subscriber);
    //根据用户名称查询已订阅过（已申请订阅过）的所有服务数量
    Integer countBySubscriber(String subscriber);
    Integer countAuditSubscribe();//统计所有已处理过的订阅或者取消订阅服务数量
    Integer countBySubscriberAndStatus(String subscriber, Integer status);
    Integer countLikeByNameAndStatus(String name, Integer status);
    Integer countDistinctLikeByNameAndStatus(String name, Integer status);
    Integer countLikeByName(String name);
    Integer countLikeBySubscriberAndNameAndStatus(String subscriber,String name, Integer status);
    Integer countLikeByCnameAndStatus(String cname, Integer status);
    Integer countDistinctLikeByCnameAndStatus(String cname, Integer status);
    Integer countLikeByCname(String cname);
    Integer countLikeBySubscriberAndCnameAndStatus(String subscriber,String cname, Integer status);
    Integer countLikeBySubscriberAndCname(String subscriber,String cname);
    Integer countLikeBySubscriberAndName(String subscriber,String name);
    Integer countByRangeAndStatus(String startDate,String endDate, Integer status);
    Integer countDistinctByRangeAndStatus(String startDate,String endDate, Integer status);
    Integer countByRange(String startDate,String endDate);
    Integer countBySubscriberAndRangeAndStatus(String subscriber,String startDate,String endDate, Integer status);
    Integer countBySubscriberAndRange(String subscriber,String startDate,String endDate);
    List<Subscribe> findDistinctByPageAndStatus(Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findByPageAndStatus(Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findByPageAndSubscriber(String subscriber, Integer startPos, Integer endPos);
    List<Subscribe> findByPageAndSubscriberAndStatus(String subscriber,Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findLikeByPageAndNameAndStatus(String name,Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findDistinctLikeByPageAndNameAndStatus(String name,Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findLikeByPageAndName(String name,Integer startPos, Integer endPos);
    List<Subscribe> findLikeByPageAndSubscriberAndName(String subscriber,String name, Integer startPos, Integer endPos);
    List<Subscribe> findLikeByPageAndSubscriberAndNameAndStatus(String subscriber,String name,Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findByPageAndRangeAndStatus(String startDate,String endDate,Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findDistinctByPageAndRangeAndStatus(String startDate,String endDate,Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findByPageAndRange(String startDate,String endDate, Integer startPos, Integer endPos);
    List<Subscribe> findByPageAndSubscriberAndRangeAndStatus(String subscriber,String startDate,String endDate,Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findLikeByPageAndSubscriberAndRange(String subscriber,String startDate,String endDate, Integer startPos, Integer endPos);
    List<Subscribe> findLikeByPageAndCnameAndStatus(String cname,Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findDistinctLikeByPageAndCnameAndStatus(String cname,Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findLikeByPageAndCname(String cname, Integer startPos, Integer endPos);
    List<Subscribe> findLikeByPageAndSubscriberAndCnameAndStatus(String subscriber,String cname,Integer status, Integer startPos, Integer endPos);
    List<Subscribe> findLikeByPageAndSubscriberAndCname(String subscriber,String cname, Integer startPos, Integer endPos);
    List<Subscribe> findAuditSubByPage(Integer startPos, Integer endPos);
    List<Subscribe> findByServiceIdAndSubscriberAndStatus(Integer serviceId, String subscriber, Integer status);
    List<Subscribe> findByServiceIdAndSubscriber(Integer serviceId, String subscriber);

    //获取已订阅的服务次数
    Integer getSubCounts();

    //查询已经订阅成功的service_id
    Integer[] getServiceIds();

    //通过service_id和status状态=2查找订阅次数
    Integer getSerCounts(Integer id);

    //获取当前日期往前七天内 订阅成功的条数
    Integer getWeekSubServiceCount();


    //七天内订阅的服务数量  折线图
    Integer getEvdaySubServiceCount(Integer n);

    //查询某段时间七天内订阅的服务数量折现统计图
    Integer getChooseEvdaySubServiceCount(Integer n, String chooseDate);

   /* //用户订阅一条服务
    Integer SubService(Integer service_id , Integer subscriber );*/

    //查询subscribe视图中subscriber的状态
    Integer getfullServiceSubStatus(Integer service_id, String subscriber);

    //用户取消订阅某条服务
    Integer cancelSubService(Integer service_id, String subscriber);
}
