package com.xyst.fwgl.service;

import com.xyst.fwgl.model.FullServiceInfo;
import com.xyst.fwgl.model.ServiceInfo;
import com.xyst.fwgl.utils.ServiceUtil;
import org.apache.ibatis.annotations.Select;

import java.util.Date;
import java.util.List;

public interface ServiceInfoService {
    ServiceInfo findById(Integer id);
    List<ServiceInfo> findAll();
    List<ServiceInfo> findByName(String name);
    Integer countAllServiceInfo();
    Integer countServiceInfoByStatus(Integer status);
    Integer countServiceInfoByName(String name);
    Integer countServiceInfoByCategory(String cname);
    Integer countServiceInfoByRange(String startDate,String endDate);
    Integer save(ServiceInfo serviceInfo);
    Integer delete(Integer id);
    Integer update(ServiceInfo serviceInfo);
    List<ServiceInfo> findByPage(Integer startPos, Integer endPos);
    List<ServiceInfo> findByPageAndStatus(Integer status,Integer startPos, Integer endPos);
    List<ServiceInfo> findByPageAndName(String name,Integer startPos, Integer endPos);
    List<ServiceInfo> findByPageAndCategory(String cname,Integer startPos, Integer endPos);
    List<ServiceInfo> findByPageAndRange(String startDate,String endDate,Integer startPos, Integer endPos);

    /* *****************  hdd 2020-8-11  ************ */

    int findTypeSubmitNum();

    List<ServiceUtil> findTypeSubmit(Integer begin, Integer pageSize);

    int findTypeUnloadNum();

    List<ServiceUtil> findTypeUnload(Integer begin,Integer pageSize);

    int applyService(Integer id,Integer type);

    int findTypeDeleteNum();

    List<ServiceUtil> findTypeDelete(Integer begin, Integer pageSize);

    int findAllServiceNum();

    List<ServiceUtil> findAllService(Integer begin,Integer pageSize);

    /* submit 模糊查询 */
    int findSubmitByNameNum(String name);

    List<ServiceUtil> findSubmitByName(String name,Integer begin, Integer pageSize);

    int findSubmitByCnameNum(String name);

    List<ServiceUtil> findSubmitByCname(String name,Integer begin, Integer pageSize);

    int findSubmitByTimeNum(String time1,String time2);

    List<ServiceUtil> findSubmitByTime(String time1,String time2,Integer begin, Integer pageSize);


    /* unload 模糊查询 */
    int findUnloadByNameNum(String name);

    List<ServiceUtil> findUnloadByName(String name,Integer begin, Integer pageSize);

    int findUnloadByCnameNum(String name);

    List<ServiceUtil> findUnloadByCname(String name,Integer begin, Integer pageSize);

    int findUnloadByTimeNum(String time1,String time2);

    List<ServiceUtil> findUnloadByTime(String time1,String time2,Integer begin, Integer pageSize);

    /* delete 模糊查询 */
    int findDeleteByNameNum(String name);

    List<ServiceUtil> findDeleteByName(String name,Integer begin, Integer pageSize);

    int findDeleteByCnameNum(String name);

    List<ServiceUtil> findDeleteByCname(String name,Integer begin, Integer pageSize);

    int findDeleteByTimeNum(String time1,String time2);

    List<ServiceUtil> findDeleteByTime(String time1,String time2,Integer begin, Integer pageSize);

    /* all 全部 8-22*/
    int findAllByNameNum(String name);

    List<ServiceUtil> findAllByName(String name,Integer begin,Integer pageSize);

    int findAllByCnameNum(String name);

    List<ServiceUtil> findAllByCname(String name,Integer begin,Integer pageSize);

    int findAllByTimeNum(String time1,String time2);

    List<ServiceUtil> findAllByTime(String time1,String time2,Integer begin,Integer pageSize);

    /* *****************  hdd 2020-8-11 (结束) ************ */


    //自定义方法

    //已经注册的服务数量
    Integer getRegServiceCounts();

    //注册且已经发布的数量
    Integer getPbuServiceCounts();

    //服务调用的总次数
    Integer getCalServiceCounts();

    //申请服务的总次数
    Integer getAplServiceCounts();

    //获取服务资源类别数量
    Integer getTypServiceCounts();

    //根据时间降序排序查询数据库表
    List<ServiceInfo> getNewDateService();

    //获取当前日期往前七天内注册的条数
    Integer getWeekRegServiceCounts();

    //获取当前日期往前七天内发布的条数
    Integer getWeekPubServiceCounts();

    //通过调用访问次数的服务名称找到本数据库的数据  -热门资源排序
    ServiceInfo getHotService(String serviceName);

    //通过category_id查询同一个服务的次数
    Integer getCateCounts(Integer id);

    //查询所有的category_id
    Integer[] getCategoryIds();

    //查询近七天内注册的服务数量曲线统计图
    Integer getdayNRegCounts(Integer n);

    //通过category_id查询已经注册的服务数量
    Integer getCagToRegServiceCount(Integer id);

    //通过category_id查询已经发布服务数量
    Integer getCagToPubServiceCount(Integer id) ;

    //通过category_id查询所有该类别下的服务
    List<ServiceInfo> getALLServiceInfo(Integer id);

    //获取所有已发布的服务
    List<ServiceInfo> getServices(Integer page);


    //获取所有已发布的服务 不分页
    List<ServiceInfo> getAllServices();

    //更新排序获取服务
    List<ServiceInfo> getUpdateServices(Integer page);

    //通过category_id查询已经发布的所有服务
    List<ServiceInfo> caNamegetServices(Integer page, String name);

    //通过category_id查询已经发布的所有服务 不分页
    List<ServiceInfo> caNamegetServices(Integer id);

    //通过category_id查询根据时间排序的发布所有服务
    List<ServiceInfo> caNamegetUpdateServices(Integer page, String name);

    //通过category_id查询根据时间排序的发布所有服务
    List<ServiceInfo> cNamegetUpdateServices( String name);

    //通过搜索框数据模糊查询service_info表的数据
    List<ServiceInfo> searchServiceList(String  name,Integer page);

    //通过搜索框数据模糊查询所有的service_info数据，进行订阅次数后再分页
    List<ServiceInfo> searchAllServiceList(String name);

    //通过搜索框模糊查询service_info表的数据 再对其进行时间排序
    List<ServiceInfo> searchServiceListDesc(String name,Integer page);

    //查询近七天内发布的服务数量曲线统计图
    Integer getdayNPubCounts(Integer n);

    //查询所有的FullService视图信息
    List<FullServiceInfo> getAllfullServiceInfo(Integer page);

    //查询所有的FullService视图信息 根据mountTime时间降序排序
    List<FullServiceInfo> getDateDescfullServiceInfo(Integer page);
    /***龙龙8.14 15.25 整合*****/

    //查询某段时间 注册的服务数量曲线统计图
    Integer getChoosedayNRegCounts(Integer n, String  chooseDate);

    //查询某段时间内 发布的服务数量曲线统计图
    Integer getChoosedayNPubCounts(Integer n, String chooseDate);
}
