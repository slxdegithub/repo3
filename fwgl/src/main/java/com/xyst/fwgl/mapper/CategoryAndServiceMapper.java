package com.xyst.fwgl.mapper;

import com.xyst.fwgl.model.ServiceInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CategoryAndServiceMapper {

    int findSubmitByCnameNum(String name);

    List<ServiceInfo> findSubmitByCname(@Param("name") String name, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);

    int findUnloadByCnameNum(String name);

    List<ServiceInfo> findUnloadByCname(@Param("name") String name, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);

    int findDeleteByCnameNum(String name);

    List<ServiceInfo> findDeleteByCname(@Param("name") String name, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);

    int findAllByCnameNum(String name);

    List<ServiceInfo> findAllByCname(@Param("name") String name, @Param("begin") Integer begin, @Param("pageSize") Integer pageSize);

}
