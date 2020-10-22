package com.xyst.fwgl.service.impl;

import com.github.pagehelper.PageHelper;
import com.xyst.fwgl.mapper.CategoryAndServiceMapper;
import com.xyst.fwgl.mapper.ServiceAuditMapper;
import com.xyst.fwgl.mapper.ServiceInfoMapper;
import com.xyst.fwgl.model.Category;
import com.xyst.fwgl.model.FullServiceInfo;
import com.xyst.fwgl.model.ServiceAudit;
import com.xyst.fwgl.model.ServiceInfo;
import com.xyst.fwgl.service.CategoryService;
import com.xyst.fwgl.service.ServiceInfoService;
import com.xyst.fwgl.utils.ServiceUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Service
public class ServiceInfoServiceImpl implements ServiceInfoService {
    @Resource
    private ServiceInfoMapper serviceInfoMapper;
    @Resource
    private ServiceAuditMapper serviceAuditMapper;

    @Resource
    private CategoryService categoryService;
    @Resource
    private CategoryAndServiceMapper categoryAndService;

    @Override
    public ServiceInfo findById(Integer id) {
        return serviceInfoMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<ServiceInfo> findAll() {
        return serviceInfoMapper.selectAll();
    }

    @Override
    public List<ServiceInfo> findByName(String name) {
        Example example=new Example(ServiceInfo.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("name", name);
        List<ServiceInfo> lists = serviceInfoMapper.selectByExample(example);
        return lists;
    }

    @Override
    public Integer countAllServiceInfo() {
        return serviceInfoMapper.countAllServiceInfo();
    }

    @Override
    public Integer countServiceInfoByStatus(Integer status) {
        Example example=new Example(ServiceInfo.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("status", status);
        Integer count = serviceInfoMapper.selectCountByExample(example);
        return count;
    }

    @Override
    public Integer countServiceInfoByName(String name) {
        return serviceInfoMapper.countServiceInfoByName(name);
    }

    @Override
    public Integer countServiceInfoByCategory(String cname) {
        return serviceInfoMapper.countServiceInfoByCategory(cname);
    }

    @Override
    public Integer countServiceInfoByRange(String startDate, String endDate) {
        return serviceInfoMapper.countServiceInfoByRange(startDate, endDate);
    }

    @Override
    public Integer save(ServiceInfo serviceInfo) {
        return serviceInfoMapper.insert(serviceInfo);
    }

    @Override
    public Integer delete(Integer id) {
        return serviceInfoMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Integer update(ServiceInfo serviceInfo) {
        return serviceInfoMapper.updateByPrimaryKey(serviceInfo);
    }

    @Override
    public List<ServiceInfo> findByPage(Integer startPos, Integer endPos) {
        return serviceInfoMapper.findByPage(startPos, endPos);
    }

    @Override
    public List<ServiceInfo> findByPageAndStatus(Integer status, Integer startPos, Integer endPos) {
        return serviceInfoMapper.findByPageAndStatus(status, startPos, endPos);
    }

    @Override
    public List<ServiceInfo> findByPageAndName(String name, Integer startPos, Integer endPos) {
        return serviceInfoMapper.findByPageAndName(name, startPos, endPos);
    }

    @Override
    public List<ServiceInfo> findByPageAndCategory(String cname, Integer startPos, Integer endPos) {
        return serviceInfoMapper.findByPageAndCategory(cname, startPos, endPos);
    }

    @Override
    public List<ServiceInfo> findByPageAndRange(String startDate, String endDate, Integer startPos, Integer endPos) {
        return serviceInfoMapper.findByPageAndRange(startDate, endDate, startPos, endPos);
    }

    /* *****************  hdd 2020-8-11  ************ */

    @Override
    public int findTypeSubmitNum() {
        return serviceInfoMapper.findTypeSubmitNum();
    }

    @Override
    public List<ServiceUtil> findTypeSubmit(Integer begin, Integer pageSize) {
        System.out.println("begin="+begin+";pageSize="+pageSize);
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findTypeSubmit(begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findTypeUnloadNum() {
        return serviceInfoMapper.findTypeUnloadNum();
    }

    @Override
    public List<ServiceUtil> findTypeUnload(Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findTypeUnload(begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findTypeDeleteNum() {
        return serviceInfoMapper.findTypeDeleteNum();
    }

    @Override
    public List<ServiceUtil> findTypeDelete(Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findTypeDelete(begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findAllServiceNum() {
        return serviceInfoMapper.findAllServiceNum();
    }

    @Override
    public List<ServiceUtil> findAllService(Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findAllService(begin,pageSize));
        return serviceUtils;
    }

    /*
     * 创建service_audit
     * 修改 service 状态
     * */
    @Transactional
    @Override
    public int applyService(Integer id, Integer type) {
        ServiceInfo serviceInfo = serviceInfoMapper.selectByPrimaryKey(id);
        int sType = 0;
        if(type==2){   //卸载发出申请
            sType = 4;//作废申请
        }else if(type ==1){//挂载发出申请
            sType = 1;
        }else if(type ==3){//挂载发出申请
            sType = 7;
        }
        ServiceAudit audit = new ServiceAudit();
        audit.setResult(0);
        audit.setType(type);
        audit.setServiceId(id);
        int x = serviceAuditMapper.insertSelective(audit);
        serviceInfo.setStatus(sType);
        int y = serviceInfoMapper.updateByPrimaryKeySelective(serviceInfo);
        if(x>0&&y>0){
            System.out.println("申请执行成功！");
            return 1;
        }else{
            return 0;
        }
    }

    /* submit 模糊查询   2020/8/11 21:59 */
    @Override
    public int findSubmitByNameNum(String name) {
        return serviceInfoMapper.findSubmitByNameNum(name);
    }

    @Override
    public List<ServiceUtil> findSubmitByName(String name, Integer begin, Integer pageSize) {
        System.out.println("begin="+begin+";pageSize="+pageSize);
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findSubmitByName(name,begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findSubmitByCnameNum(String name) {
        return categoryAndService.findSubmitByCnameNum(name);
    }

    @Override
    public List<ServiceUtil> findSubmitByCname(String name, Integer begin, Integer pageSize) {
        System.out.println(" 多表查询 begin="+begin+";pageSize="+pageSize);
        List<ServiceUtil> serviceUtils = infoToUtil(categoryAndService.findSubmitByCname(name,begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findSubmitByTimeNum(String time1, String time2) {
        return serviceInfoMapper.findSubmitByTimeNum(time1,time2);
    }

    @Override
    public List<ServiceUtil> findSubmitByTime(String time1, String time2, Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findSubmitByTime(time1,time2,begin,pageSize));
        return serviceUtils;
    }
    /* unload 模糊查询 */
    @Override
    public int findUnloadByNameNum(String name) {
        return serviceInfoMapper.findUnloadByNameNum(name);
    }

    @Override
    public List<ServiceUtil> findUnloadByName(String name, Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findUnloadByName(name,begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findUnloadByCnameNum(String name) {
        return categoryAndService.findUnloadByCnameNum(name);
    }

    @Override
    public List<ServiceUtil> findUnloadByCname(String name, Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(categoryAndService.findUnloadByCname(name,begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findUnloadByTimeNum(String time1, String time2) {
        return serviceInfoMapper.findUnloadByTimeNum(time1,time2);
    }

    @Override
    public List<ServiceUtil> findUnloadByTime(String time1, String time2, Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findUnloadByTime(time1,time2,begin,pageSize));
        return serviceUtils;
    }
    /* delete 模糊查询 */
    @Override
    public int findDeleteByNameNum(String name) {
        return serviceInfoMapper.findDeleteByNameNum(name);
    }

    @Override
    public List<ServiceUtil> findDeleteByName(String name, Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findDeleteByName(name,begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findDeleteByCnameNum(String name) {
        return categoryAndService.findDeleteByCnameNum(name);
    }

    @Override
    public List<ServiceUtil> findDeleteByCname(String name, Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(categoryAndService.findDeleteByCname(name,begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findDeleteByTimeNum(String time1, String time2) {
        return serviceInfoMapper.findDeleteByTimeNum(time1,time2);
    }

    @Override
    public List<ServiceUtil> findDeleteByTime(String time1, String time2, Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findDeleteByTime(time1,time2,begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findAllByNameNum(String name) {
        return serviceInfoMapper.findAllByNameNum(name);
    }

    @Override
    public List<ServiceUtil> findAllByName(String name, Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findAllByName(name,begin,pageSize));
        return serviceUtils;
    }

    @Override
    public int findAllByCnameNum(String name) {
        return categoryAndService.findAllByCnameNum(name);
    }

    @Override
    public List<ServiceUtil> findAllByCname(String name, Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(categoryAndService.findAllByCname(name, begin, pageSize));
        return serviceUtils;
    }

    @Override
    public int findAllByTimeNum(String time1, String time2) {
        return serviceInfoMapper.findAllByTimeNum(time1,time2);
    }

    @Override
    public List<ServiceUtil> findAllByTime(String time1, String time2, Integer begin, Integer pageSize) {
        List<ServiceUtil> serviceUtils = infoToUtil(serviceInfoMapper.findAllByTime(time1, time2, begin, pageSize));
        return serviceUtils;
    }

    public List<ServiceUtil> infoToUtil(List<ServiceInfo> serviceInfoList){
        List<ServiceUtil> utilList = new ArrayList<>();
        for (ServiceInfo serviceInfo :serviceInfoList){
            ServiceUtil serviceUtil = new ServiceUtil();
            serviceUtil.setId(serviceInfo.getId());
            serviceUtil.setName(serviceInfo.getName());
            serviceUtil.setServiceType(serviceInfo.getServiceType());
            serviceUtil.setOpenType(serviceInfo.getOpenType());
            serviceUtil.setAddress(serviceInfo.getAddress());
            serviceUtil.setVersion(serviceInfo.getVersion());
            serviceUtil.setStatus(serviceInfo.getStatus());
            serviceUtil.setCreateTime(serviceInfo.getCreateTime());
            serviceUtil.setMountTime(serviceInfo.getMountTime());
            serviceUtil.setCancelTime(serviceInfo.getCancelTime());
            serviceUtil.setUnmountTime(serviceInfo.getUnmountTime());
            Category category = categoryService.findById(serviceInfo.getCategoryId());
            serviceUtil.setCategoryName(category.getCname());

            utilList.add(serviceUtil);
        }
        return utilList;
    }

    /* *****************  hdd 2020-8-11 (结束) ************ */

    //获得已注册服务数量
    @Override
    public Integer getRegServiceCounts() {
        return serviceInfoMapper.getRegServiceCounts();
    }

    //获得已发布服务数量
    @Override
    public Integer getPbuServiceCounts() {
        return serviceInfoMapper.getPbuServiceCounts();
    }

    @Override
    public Integer getCalServiceCounts() {
        return null;
    }

    @Override
    public Integer getAplServiceCounts() {
        return null;
    }

    @Override
    public Integer getTypServiceCounts() {
        return null;
    }

    //按日期从最新开始排序，抽取前面的资源最新更新
    @Override
    public List<ServiceInfo> getNewDateService() {

        return serviceInfoMapper.getNewDateService();
    }

    @Override
    public Integer getWeekRegServiceCounts() {
        return serviceInfoMapper.getWeekRegServiceCounts();
    }

    @Override
    public Integer getWeekPubServiceCounts() {
        return serviceInfoMapper.getWeekPubServiceCounts();
    }

    @Override
    public ServiceInfo getHotService(String serviceName) {
        return serviceInfoMapper.getHotService(serviceName);
    }

    @Override
    public Integer getCateCounts(Integer id) {
        return serviceInfoMapper.getCateCounts(id);
    }

    @Override
    public Integer[] getCategoryIds() {
        return serviceInfoMapper.getCategoryIds();
    }

    @Override
    public Integer getdayNRegCounts(Integer n) {
        return serviceInfoMapper.getdayNRegCounts(n);
    }

    @Override
    public Integer getCagToRegServiceCount(Integer id) {
        return serviceInfoMapper.getCagToRegServiceCount(id);
    }

    @Override
    public Integer getCagToPubServiceCount(Integer id) {
        return serviceInfoMapper.getCagToPubServiceCount(id);
    }

    @Override
    public List<ServiceInfo> getALLServiceInfo(Integer id) {
        return serviceInfoMapper.getALLServiceInfo(id);
    }

    @Override
    public List<ServiceInfo> getServices(Integer page) {
        PageHelper.startPage(page, 5);
        return serviceInfoMapper.getServices();
    }

    @Override
    public List<ServiceInfo> getAllServices() {
        return serviceInfoMapper.getServices();
    }

    @Override
    public List<ServiceInfo> getUpdateServices(Integer page) {
        PageHelper.startPage(page, 5);
        return serviceInfoMapper.getUpdateService();
    }



    @Override
    public List<ServiceInfo> caNamegetServices(Integer page, String name) {
        Integer id = categoryService.nameToGetId(name);
        PageHelper.startPage(page, 5);
        List<ServiceInfo> serviceInfos = serviceInfoMapper.caNamegetServices(id);
        return serviceInfos;
    }

    @Override
    public List<ServiceInfo> caNamegetServices(Integer id) {
        return serviceInfoMapper.caNamegetServices(id);
    }

    @Override
    public List<ServiceInfo> caNamegetUpdateServices(Integer page, String name) {
        Integer id = categoryService.nameToGetId(name);
        PageHelper.startPage(page, 5);
        List<ServiceInfo> serviceInfos = serviceInfoMapper.caNamegetUpdateServices(id);
        return serviceInfos;
    }


    @Override
    public List<ServiceInfo> cNamegetUpdateServices(String name) {
        Integer id = categoryService.nameToGetId(name);
        List<ServiceInfo> serviceInfos = serviceInfoMapper.caNamegetServices(id);
        return serviceInfos;
    }

    @Override
    public List<ServiceInfo> searchServiceList(String name, Integer page) {
        PageHelper.startPage(page, 5);
        name = "%" + name + "%";
        //System.out.println("size="+serviceInfoMapper.searchServiceList(name).size());

//        System.out.println(name);
        return serviceInfoMapper.searchServiceList(name);
    }

    @Override
    public List<ServiceInfo> searchAllServiceList(String name) {
        name = "%" + name + "%";
        return serviceInfoMapper.searchServiceList(name);

    }

    @Override
    public List<ServiceInfo> searchServiceListDesc(String name, Integer page) {
        PageHelper.startPage(page, 5);
        name = "%" + name + "%";
        return serviceInfoMapper.searchServiceListDesc(name);
    }

    @Override
    public Integer getdayNPubCounts(Integer n) {
        return serviceInfoMapper.getdayNPubCounts(n);
    }

    @Override
    public List<FullServiceInfo> getAllfullServiceInfo(Integer page) {
        PageHelper.startPage(page, 5);
        return serviceInfoMapper.getAllfullServiceInfo();
    }

    @Override
    public List<FullServiceInfo> getDateDescfullServiceInfo(Integer page) {
        PageHelper.startPage(page, 5);
        return serviceInfoMapper.getDateDescfullServiceInfo(page);
    }

    @Override
    public Integer getChoosedayNRegCounts(Integer n, String chooseDate) {
        return serviceInfoMapper.getChoosedayNRegCounts(n,chooseDate);
    }

    @Override
    public Integer getChoosedayNPubCounts(Integer n, String chooseDate) {
        return serviceInfoMapper.getChoosedayNPubCounts(n,chooseDate);

    }

}
