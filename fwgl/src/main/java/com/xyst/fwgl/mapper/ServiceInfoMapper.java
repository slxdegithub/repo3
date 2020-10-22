package com.xyst.fwgl.mapper;

import com.xyst.fwgl.model.FullServiceInfo;
import com.xyst.fwgl.model.ServiceInfo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ServiceInfoMapper extends Mapper<ServiceInfo> {
    @Select("select * from service_info order by create_time desc limit #{startPos},#{endPos}")
    List<ServiceInfo> findByPage(@Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from service_info where status=#{status} order by create_time desc limit #{startPos},#{endPos}")
    List<ServiceInfo> findByPageAndStatus(@Param("status") Integer status,@Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from service_info where name like '%${name}%' order by create_time desc limit #{startPos},#{endPos}")
    List<ServiceInfo> findByPageAndName(@Param("name") String name, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from service_info where category_id in (select id from category where cname like '%${cname}%') order by create_time desc limit #{startPos},#{endPos}")
    List<ServiceInfo> findByPageAndCategory(@Param("cname") String cname, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select * from service_info where create_time>=#{startDate} and create_time<=#{endDate} order by create_time desc limit #{startPos},#{endPos}")
    List<ServiceInfo> findByPageAndRange(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("startPos") Integer startPos, @Param("endPos") Integer endPos);
    @Select("select count(*) from service_info")
    Integer countAllServiceInfo();
    @Select("select count(*) from service_info where name like '%${name}%'")
    Integer countServiceInfoByName(String name);
    @Select("select count(*) from service_info where category_id in (select id from category where cname like '%${cname}%' )")
    Integer countServiceInfoByCategory(String cname);
    @Select("select count(*) from service_info where create_time>=#{startDate} and create_time<=#{endDate}")
    Integer countServiceInfoByRange(@Param("startDate") String startDate, @Param("endDate") String endDate);


    /***************  黄东东 开始 ***************/

    @Select("select count(*) from service_info where status in (0,1,3)")
    int findTypeSubmitNum();

    /* 申请挂载1 已挂载2 拒绝卸载9 =>修改  申请挂载1 已创建 0 已拒绝 3*/
    @Select("select * from service_info where status in (0,1,3) order by status desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findTypeSubmit(@Param("begin") Integer begin, @Param("pageSize") Integer pageSize);

    @Select("select count(*) from service_info where status in (7,2,9)")
    int findTypeUnloadNum();

    /* 申请卸载7 已挂载2 拒绝卸载9 */
    @Select("select * from service_info where status in (7,2,9) order by status desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findTypeUnload(@Param("begin") Integer begin, @Param("pageSize") Integer pageSize);

    @Select("select count(*) from service_info where status in (4,8,6)")
    int findTypeDeleteNum();

    /* 申请作废4  拒绝作废6 已卸载8 */
    @Select("select * from service_info where status in (4,8,6) order by status asc limit #{begin},#{pageSize}")
    List<ServiceInfo> findTypeDelete(@Param("begin") Integer begin, @Param("pageSize") Integer pageSize);

    /* 查询全部 */
    @Select("select count(*) from service_info")
    int findAllServiceNum();

    @Select("select * from service_info  order by create_time desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findAllService(@Param("begin") Integer begin, @Param("pageSize") Integer pageSize);

    /* submit 挂载 模糊查询 2020/8/11 21:59 */
    @Select("select count(*) from service_info where status in (0,1,3) and name like CONCAT('%',#{name},'%')")
    int findSubmitByNameNum(String name);

    @Select("select * from service_info where status in (0,1,3) and name like CONCAT('%',#{name},'%') order by status desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findSubmitByName(@Param("name") String name, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);
    /* 时间查询 */
    @Select("select count(*) from service_info where status in (0,1,3) and create_time >#{time1} and create_time<#{time2} order by create_time desc")
    int findSubmitByTimeNum(@Param("time1") String time1, @Param("time2") String time2);

    @Select("select * from service_info where status in (0,1,3) and create_time >#{time1} and create_time<#{time2} order by create_time desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findSubmitByTime(@Param("time1") String time1, @Param("time2") String time2, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);

    /* unload 卸载 作废模糊查询 */
    @Select("select count(*) from service_info where status in (7,2,9) and name like CONCAT('%',#{name},'%')")
    int findUnloadByNameNum(String name);

    @Select("select * from service_info where status in (7,2,9) and name like CONCAT('%',#{name},'%') order by status desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findUnloadByName(@Param("name") String name, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);
    /* 时间查询 */
    @Select("select count(*) from service_info where status in (7,2,9) and create_time >#{time1} and create_time<#{time2} order by create_time desc")
    int findUnloadByTimeNum(@Param("time1") String time1, @Param("time2") String time2);

    @Select("select * from service_info where status in (7,2,9) and create_time >#{time1} and create_time<#{time2} order by create_time desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findUnloadByTime(@Param("time1") String time1, @Param("time2") String time2, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);


    /* delete 作废模糊查询 */
    @Select("select count(*) from service_info where status in (4,8,6) and name like CONCAT('%',#{name},'%')")
    int findDeleteByNameNum(String name);

    @Select("select * from service_info where status in (4,8,6) and name like CONCAT('%',#{name},'%') order by status desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findDeleteByName(@Param("name") String name, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);
    /* 时间查询 */
    @Select("select count(*) from service_info where status in (4,6,8) and create_time >#{time1} and create_time<#{time2} order by create_time desc")
    int findDeleteByTimeNum(@Param("time1") String time1, @Param("time2") String time2);

    @Select("select * from service_info where status in (4,6,8) and create_time >#{time1} and create_time<#{time2} order by create_time desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findDeleteByTime(@Param("time1") String time1, @Param("time2") String time2, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);


    /* all 全部模糊查询 */
    @Select("select count(*) from service_info where name like CONCAT('%',#{name},'%')")
    int findAllByNameNum(String name);

    @Select("select * from service_info where name like CONCAT('%',#{name},'%') order by create_time desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findAllByName(@Param("name") String name, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);
    /* 时间查询 */
    @Select("select count(*) from service_info where create_time >#{time1} and create_time<#{time2} order by create_time desc")
    int findAllByTimeNum(@Param("time1") String time1, @Param("time2") String time2);

    @Select("select * from service_info where create_time >#{time1} and create_time<#{time2} order by create_time desc limit #{begin},#{pageSize}")
    List<ServiceInfo> findAllByTime(@Param("time1") String time1, @Param("time2") String time2, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);

    /************  黄东东 结束   ***********/


    //已经注册的服务数量
    @Select("select COUNT(*) from service_info where status in(0,1,2,3,7,9)")
    Integer getRegServiceCounts();

    //注册且已经发布的数量
    @Select("select COUNT(*) from service_info where status in(2,7,9)")
    Integer getPbuServiceCounts();

    //服务调用的总次数
    @Select("")
    Integer getCalServiceCounts();

    //申请服务的总次数
    @Select("")
    Integer getAplServiceCounts();

    //获取服务资源类别数量
    @Select("")
    Integer getTypServiceCounts();

    //根据时间降序排序查询数据库表
    @Select("select * from service_info where status in(2,7,9) order by mount_time desc ")
    List<ServiceInfo> getNewDateService();

    //获取当前日期往前七天内注册的总条数
    @Select("select count(*) from service_info  where  DATE_SUB(CURDATE(), INTERVAL 7 DAY)<= date(create_time)")
    Integer getWeekRegServiceCounts();

    //获取当前日期往前七天内发布的总条数
    @Select("select count(*) from service_info  where  DATE_SUB(CURDATE(), INTERVAL 7 DAY)<= date(mount_time)")
    Integer getWeekPubServiceCounts();

    //通过调用访问次数的服务名称找到本数据库的数据  -热门资源排序
    @Select("select * from service_info where name = #{serviceName}")
    ServiceInfo getHotService(String serviceName);

    //通过category_id查询同一个服务的次数
    @Select("select count(*) from service_info where category_id =#{id}")
    Integer getCateCounts(Integer id);

    //查询所有的category_id
    @Select("select category_id from service_info where status in(2,7,9)")
    Integer[] getCategoryIds();

    //查询近七天内注册的服务数量曲线统计图
    @Select("SELECT count(*) FROM service_info WHERE TO_DAYS( NOW( ) ) - TO_DAYS( create_time) = #{n} and status in(0,1,2,3,7,9)")
    Integer getdayNRegCounts(Integer n);

    //查询近七天内发布的服务数量曲线统计图
    @Select("SELECT count(*) FROM service_info WHERE TO_DAYS( NOW( ) ) - TO_DAYS( mount_time) = #{n} and status in(2,7,9)")
    Integer getdayNPubCounts(Integer n);

    //查询某段时间 注册的服务数量曲线统计图
    @Select("SELECT count(*) FROM service_info WHERE TO_DAYS( #{chooseDate} ) - TO_DAYS( create_time) = #{n} and status in(0,1,2,3,7,9)")
    Integer getChoosedayNRegCounts(@Param("n") Integer n, @Param("chooseDate") String chooseDate);

    //查询某段时间内 发布的服务数量曲线统计图
    @Select("SELECT count(*) FROM service_info WHERE TO_DAYS( #{chooseDate} ) - TO_DAYS( mount_time) = #{n} and status in(2,7,9)")
    Integer getChoosedayNPubCounts(@Param("n") Integer n, @Param("chooseDate") String chooseDate);


    //通过category_id查询已经注册的服务数量
    @Select("select COUNT(*) from service_info where status in(0,1,2,3,7,9) and category_id = #{id}")
    Integer getCagToRegServiceCount(Integer id);

    //通过category_id查询已经发布服务数量
    @Select("select COUNT(*) from service_info where status in(2,7,9) and category_id = #{id}")
    Integer getCagToPubServiceCount(Integer id) ;

    //通过category_id查询所有该类别下的服务
    @Select("select * from service_info where status in(2,7,9) and category_id = #{id}")
    List<ServiceInfo> getALLServiceInfo(Integer id);

    //获取所有已发布的服务
    @Select("select * from service_info where status in(2,7,9)")
    List<ServiceInfo> getServices();

    //根据时间降序排序查询数据库表
    @Select("select * from service_info where status in(2,7,9) order by create_time desc ")
    List<ServiceInfo> getUpdateService();

    //通过category_id查询已经发布的所有服务
    @Select("select * from service_info where status in (2,7,9) and category_id = #{id}")
    List<ServiceInfo> caNamegetServices(Integer id);

    //通过category_id查询根据时间排序的发布所有服务
    @Select("select * from service_info where status in(2,7,9) and category_id = #{id} order by mount_time desc")
    List<ServiceInfo> caNamegetUpdateServices(Integer id);

    //通过搜索框数据模糊查询service_info表的数据'  '%' || #{name} || '%'
    @Select("select * from service_info where `name` like  #{name} and status in(2,7,9) ")
    List<ServiceInfo> searchServiceList(String name);

    //通过搜索框模糊查询service_info表的数据 再对其进行时间排序
    @Select("select * from service_info where `name` like  #{name} and status in(2,7,9) order by mount_time desc")
    List<ServiceInfo> searchServiceListDesc(String name);

    //查询所有的FullService表信息
    @Select("select * from fullService where status in(2,7,9)")
    List<FullServiceInfo> getAllfullServiceInfo();

    //查询所有的FullService视图信息 根据mountTime时间降序排序
    @Select("select * from fullService where status in(2,7,9) order by mountTime desc")
    List<FullServiceInfo> getDateDescfullServiceInfo(Integer page);

}
