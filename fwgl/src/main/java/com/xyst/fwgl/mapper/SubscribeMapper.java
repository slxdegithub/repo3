package com.xyst.fwgl.mapper;

import com.xyst.fwgl.model.Subscribe;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import tk.mybatis.mapper.common.Mapper;

import java.util.Date;
import java.util.List;

public interface SubscribeMapper extends Mapper<Subscribe> {


    //获取已经订阅的服务次数
    @Select("select COUNT(*) from subscribe where status in(2,4,6)")
    Integer getSubCounts();
    //查询已经订阅成功的service_id
    @Select("select service_id from subscribe where status in(2,4,6)")
    Integer[] getServiceIds();

    //通过service_id和status状态=2查找订阅次数
    @Select("select COUNT(*) from subscribe where status in(2,4,6) and service_id =#{id}")
    Integer getSerCounts(Integer id);

    //获取当前日期往前七天内 订阅成功的条数
    @Select("select count(*) from subscribe where status in(2,4,6) and DATE_SUB(CURDATE(), INTERVAL 7 DAY)<= date(describe_time) ")
    Integer getWeekSubServiceCount();

    //查询当前七天内订阅的服务数量折线统计图
    @Select("select  count(*) from subscribe where status in(2,4,6) and TO_DAYS(NOW() ) - TO_DAYS(describe_time) = #{n}")
    Integer getEvdaySubServiceCount(Integer n);

    //查询某段时间七天内订阅的服务数量折现统计图
    @Select("select  count(*) from subscribe where status in(2,4,6) and TO_DAYS(#{chooseDate} ) - TO_DAYS(describe_time) = #{n}")
    Integer getChooseEvdaySubServiceCount(@Param("n") Integer n, @Param("chooseDate") String chooseDate);

    //用户订阅一条服务在subscriber添加信息
    @Insert("insert into subscribe(service_id,subscriber,status,apply_time)values(#{service_id},#{subscriber}, 1 ,NOW())")
    Integer SubService(@Param("service_id") Integer service_id, @Param("subscriber") String subscriber);

    //用户订阅服务在subscriberAudit添加信息
    @Insert("insert into subscribe_audit(subscribe_id,type) VALUES(#{service_id},#{subscriber},1)")
    Integer SubServiceAudit(@Param("subscribeId") Integer subscribeId);

    //查询subscribe视图中subscriber的状态
    @Select("select status from subscribe where service_id=#{service_id} and subscriber =#{subscriber} order by apply_time DESC LIMIT 1")
    Integer getfullServiceSubStatus(@Param("service_id") Integer service_id, @Param("subscriber") String subscriber);

    //用户点击取消订阅在subscriber添加信息
    @Update("update subscribe set status = 4 where service_id=#{service_id} and subscriber = #{subscriber}")
    Integer cancelSubService(@Param("service_id") Integer service_id, @Param("subscriber") String subscriber);

    //用户取消订阅在subscriberAudit添加信息
    @Insert("update subscribe_audit set type = 2 where service_id=#{service_id} and subscriber = #{subscriber}")
    Integer cancelSubServiceAudit(@Param("service_id") Integer service_id, @Param("subscriber") String subscriber);
    @Select("select count(*) from subscribe where status=#{status}")
    Integer countByStatus(Integer status);
    @Select("select count(distinct(service_id)) from subscribe where status=#{status}")
    Integer countDistinctByStatus(Integer status);
    @Select("select count(distinct service_id) from subscribe where subscriber=#{subscriber}")
    Integer countBySubscriber(String subscriber);
    @Select("select count(distinct service_id) from subscribe where subscriber=#{subscriber} and status=#{status}")
    Integer countBySubscriberAndStatus(@Param("subscriber") String subscriber,@Param("status")Integer status);
    @Select("select count(*) from subscribe where service_id in (select id from service_info where name like '%${name}%')  and status=#{status}")
    Integer countLikeByNameAndStatus(@Param("name") String name,@Param("status")Integer status);
    @Select("select count(service_id) from subscribe where service_id in (select id from service_info where name like '%${name}%')  and status=#{status}")
    Integer countDistinctLikeByNameAndStatus(@Param("name") String name,@Param("status")Integer status);
    @Select("select count(*) from subscribe where service_id in (select id from service_info where name like '%${name}%')")
    Integer countLikeByName(String name);
    @Select("select count(distinct service_id) from subscribe where subscriber=#{subscriber} and service_id in (select id from service_info where name like '%${name}%')  and status=#{status}")
    Integer countLikeBySubscriberAndNameAndStatus(@Param("subscriber") String subscriber,@Param("name") String name,@Param("status")Integer status);
    @Select("select count(distinct service_id) from subscribe where subscriber=#{subscriber} and service_id in (select id from service_info where category_id in (select id from category where cname like '%${cname}%') )  and status=#{status}")
    Integer countLikeBySubscriberAndCnameAndStatus(@Param("subscriber") String subscriber,@Param("cname") String cname,@Param("status")Integer status);
    @Select("select count(distinct service_id) from subscribe where subscriber=#{subscriber} and service_id in (select id from service_info where category_id in (select id from category where cname like '%${cname}%') ) ")
    Integer countLikeBySubscriberAndCname(@Param("subscriber") String subscriber,@Param("cname") String cname);
    @Select("select count(distinct service_id) from subscribe where subscriber=#{subscriber} and service_id in (select id from service_info where name like '%${name}%')")
    Integer countLikeBySubscriberAndName(@Param("subscriber") String subscriber,@Param("name") String name);
    @Select("select count(distinct service_id) from subscribe where service_id in (select id from service_info where category_id in (select id from category where cname like '%${cname}%') )  and status=#{status}")
    Integer countDistinctLikeByCnameAndStatus(@Param("cname") String cname,@Param("status")Integer status);
    @Select("select count(*) from subscribe where service_id in (select id from service_info where category_id in (select id from category where cname like '%${cname}%') )  and status=#{status}")
    Integer countLikeByCnameAndStatus(@Param("cname") String cname,@Param("status")Integer status);
    @Select("select count(*) from subscribe where service_id in (select id from service_info where category_id in (select id from category where cname like '%${cname}%') )")
    Integer countLikeByCname(String cname);
    @Select("select count(*) from subscribe where apply_time>=#{startDate} and apply_time<=#{endDate} and status=#{status}")
    Integer countLikeByRangeAndStatus(@Param("startDate") String startDate,@Param("endDate") String endDate,@Param("status")Integer status);
    @Select("select count(distinct service_id) from subscribe where apply_time>=#{startDate} and apply_time<=#{endDate} and status=#{status}")
    Integer countDistinctLikeByRangeAndStatus(@Param("startDate") String startDate,@Param("endDate") String endDate,@Param("status")Integer status);
    @Select("select count(*) from subscribe where apply_time>=#{startDate} and apply_time<=#{endDate}")
    Integer countLikeByRange(@Param("startDate") String startDate,@Param("endDate") String endDate);
    @Select("select count(distinct service_id) from subscribe where subscriber=#{subscriber} and apply_time>=#{startDate} and apply_time<=#{endDate} and status=#{status}")
    Integer countBySubscriberAndRangeAndStatus(@Param("subscriber") String subscriber,@Param("startDate") String startDate,@Param("endDate") String endDate,@Param("status")Integer status);
    @Select("select count(distinct service_id) from subscribe where subscriber=#{subscriber} and apply_time>=#{startDate} and apply_time<=#{endDate}")
    Integer countBySubscriberAndRange(@Param("subscriber") String subscriber,@Param("startDate") String startDate,@Param("endDate") String endDate);
    @Select("select count(*) from subscribe")
    Integer countAuditSubscribe();
    @Select("select * from subscribe where status=#{status} group by service_id order by apply_time  desc limit #{startPos},#{endPos}")
    List<Subscribe> findDistinctByPageAndStatus(@Param("status") Integer status, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where status=#{status} order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findByPageAndStatus(@Param("status") Integer status, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where subscriber=#{subscriber}  order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findByPageAndSubscriber(@Param("subscriber") String subscriber, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where apply_time>=#{startDate} and apply_time<=#{endDate} and status=#{status} order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findByPageAndRangeAndStatus(@Param("startDate") String startDate, @Param("endDate") String endDate,@Param("status") Integer status,@Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where apply_time>=#{startDate} and apply_time<=#{endDate} and status=#{status} order by apply_time desc group by service_id limit #{startPos},#{endPos}")
    List<Subscribe> findDistinctByPageAndRangeAndStatus(@Param("startDate") String startDate, @Param("endDate") String endDate,@Param("status") Integer status,@Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where apply_time>=#{startDate} and apply_time<=#{endDate}  order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findByPageAndRange(@Param("startDate") String startDate, @Param("endDate") String endDate,@Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where subscriber=#{subscriber} and describe_time>=#{startDate} and describe_time<=#{endDate} and status=#{status}  group by service_id order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findLikeByPageAndSubscriberAndRangeAndStatus(@Param("subscriber") String subscriber,@Param("startDate") String startDate, @Param("endDate") String endDate,@Param("status") Integer status,@Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where subscriber=#{subscriber} and apply_time>=#{startDate} and apply_time<=#{endDate} group by service_id order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findLikeByPageAndSubscriberAndRange(@Param("subscriber") String subscriber,@Param("startDate") String startDate, @Param("endDate") String endDate,@Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where subscriber=#{subscriber} and status=#{status} order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findByPageAndSubscriberAndStatus(@Param("subscriber") String subscriber,@Param("status") Integer status, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where status=#{status} and service_id in (select id from service_info where name like '%${name}%') order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findLikeByPageAndNameAndStatus(@Param("name") String name,@Param("status") Integer status, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where status=#{status} and service_id in (select id from service_info where name like '%${name}%') order by apply_time desc group by service_id limit #{startPos},#{endPos}")
    List<Subscribe> findDistinctLikeByPageAndNameAndStatus(@Param("name") String name,@Param("status") Integer status, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where  service_id in (select id from service_info where name like '%${name}%') order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findLikeByPageAndName(@Param("name") String name, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where subscriber=#{subscriber} and status=#{status} and service_id in (select id from service_info where name like '%${name}%') group by service_id order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findLikeByPageAndSubscriberAndNameAndStatus(@Param("subscriber") String subscriber,@Param("name") String name,@Param("status") Integer status, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where subscriber=#{subscriber} and service_id in (select id from service_info where name like '%${name}%') group by service_id order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findLikeByPageAndSubscriberAndName(@Param("subscriber") String subscriber,@Param("name") String name, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where status=#{status} and service_id in (select id from service_info where category_id in(select id from category where cname like '%${cname}%' )) order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findLikeByPageAndCnameAndStatus(@Param("cname") String cname,@Param("status") Integer status, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where status=#{status} and service_id in (select id from service_info where category_id in(select id from category where cname like '%${cname}%' )) order by apply_time desc group by service_id limit #{startPos},#{endPos}")
    List<Subscribe> findDistinctLikeByPageAndCnameAndStatus(@Param("cname") String cname,@Param("status") Integer status, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where service_id in (select id from service_info where category_id in(select id from category where cname like '%${cname}%' ))  order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findLikeByPageAndCname(@Param("cname") String cname, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where subscriber=#{subscriber} and status=#{status} and service_id in (select id from service_info where category_id in(select id from category where cname like '%${cname}%' )) group by service_id order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findLikeByPageAndSubscriberAndCnameAndStatus(@Param("subscriber") String subscriber,@Param("cname") String cname,@Param("status") Integer status, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where subscriber=#{subscriber} and service_id in (select id from service_info where category_id in(select id from category where cname like '%${cname}%' )) group by service_id order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findLikeByPageAndSubscriberAndCname(@Param("subscriber") String subscriber,@Param("cname") String cname, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe order by apply_time desc limit #{startPos},#{endPos}")
    List<Subscribe> findAuditSubByPage(@Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from subscribe where status in (2,4,6) and service_id=#{serviceId}  and subscriber=#{subscriber}")
    Subscribe getActiveSubByIdAndSubscriber(@Param("serviceId")Integer serviceId,@Param("subscriber")String subscriber);
}
