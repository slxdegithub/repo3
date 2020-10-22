package com.xyst.fwgl.service;

import com.xyst.fwgl.model.Dictionary;
import java.util.List;

public interface DictionaryService {


    List<Dictionary> findAllDictionary(Integer page);
    Integer countAllDictionary();
    Integer countLikeByName(String name);
    Integer countLikeByType(Integer type);
    Integer countByRange(String  startDate,String endDate);
    List<Dictionary> findByPage(Integer startPos,Integer endPos);
    List<Dictionary> findByPageAndRange(String  startDate,String endDate,Integer startPos,Integer endPos);
    List<Dictionary> findLikeByPageAndName(String name,Integer startPos,Integer endPos);
    List<Dictionary> findLikeByPageAndType(Integer type,Integer startPos,Integer endPos);

    Integer deleteDictionary(Integer id);

    Integer insertDictionary(String name, Integer type, String createTime, String description);

    Integer updateDictionary(String name, Integer type, String createTime, String description, Integer id);

    Dictionary getDictionary(Integer id);

    List<Dictionary> selectName(String name, Integer page);

    List<Dictionary> selectTime(String startDate, String endDate, Integer page);

    List<Dictionary> selectType(Integer type, Integer page);
    List<Dictionary> findAllDictionaryByType(Integer type);


}
