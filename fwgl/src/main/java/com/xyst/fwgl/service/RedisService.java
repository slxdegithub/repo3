package com.xyst.fwgl.service;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.BoundListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.TimeUnit;


/**
 * Title: RedisServiceImpl.java Description: redis操作实现类 Copyright: Copyright (c) 2017 Company: lakala
 * 
 * @author heyukun
 * @date 2017年10月19日
 * @version 1.0
 * @email 1071431066@qq.com
 */
@Service("redisService")
public class RedisService {

    private static final Logger logger = LoggerFactory.getLogger(RedisService.class);

    private RedisTemplate<String, Object> redisTemplate;

    @Resource
    private StringRedisTemplate strRedisTemplate;
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@Autowired
    public void setRedisTemplate(RedisTemplate redisTemplate) {
        RedisSerializer<String> stringSerializer = new StringRedisSerializer();
        redisTemplate.setKeySerializer(stringSerializer);
        redisTemplate.setValueSerializer(stringSerializer);
        redisTemplate.setHashKeySerializer(stringSerializer);
        redisTemplate.setHashValueSerializer(stringSerializer);
        this.redisTemplate = redisTemplate;
    }

    /**
     * 操作hash:添加key，value
     * */
    public void setHash(String hash, String key, Object value) {
        BoundHashOperations<String, String, Object> hashRedisTemplate = redisTemplate.boundHashOps(hash);
        hashRedisTemplate.put(key, value);
    }

    /**
     * 操作hash:通过key，获得value
     * */
    public String getHash(String hash, String key) {
        BoundHashOperations<String, String, String> hashRedisTemplate = redisTemplate.boundHashOps(hash);
        return hashRedisTemplate.get(key);
    }

    /**
     * 操作hash:通过key，删除给定的哈希hashKeys
     * */
    public boolean deleteHash(String hash, String key) {
        return redisTemplate.opsForHash().delete(hash, key) > 0;
    }

    /**
     * 操作hash:通过key，确定哈希hashKey是否存在
     * */
    public boolean hasKeyHash(String hash, String key) {
        return redisTemplate.opsForHash().hasKey(hash, key);
    }

    /**
     * 操作string:通过key，获得value
     */
    public String getString(String key) {
        return strRedisTemplate.opsForValue().get(key);
    }

    /**
     * 操作string:添加key，value
     */
    public void setString(String key, String value) {
        strRedisTemplate.opsForValue().set(key, value);
    }

    /**
     * 操作string:添加key，value
     */
    public void setString(String key, String value, long timeout, TimeUnit timeUnit) {
        strRedisTemplate.opsForValue().set(key, value);
     // 获取key的有效剩余时间
        Long expire = redisTemplate.getExpire(key);
        if (expire < 0) {
            redisTemplate.expire(key, timeout, timeUnit); // 当超时时间过期时，重新设置超时时间秒 第三个参数控制时间单位，详情查看TimeUnit
        }
    }

    /**
     * 通过key，删除所以类型下的value
     */
    public void delete(String key) {
        redisTemplate.delete(key);
    }

    /**
     * 操作hash:添加key，value
     * 
     * @param key
     * @param value
     * @param timeout 超时时间
     * @param timeUnit 超时时间单位
     * @return
     */
    public void setHash(String hash, String key, Object value, long timeout, TimeUnit timeUnit) {
        redisTemplate.opsForHash().put(hash, key, value);// 存值
        // 获取key的有效剩余时间
        Long expire = redisTemplate.getExpire(hash);
        if (expire < 0) {
            redisTemplate.expire(hash, timeout, timeUnit); // 当超时时间过期时，重新设置超时时间秒 第三个参数控制时间单位，详情查看TimeUnit
        }
    }

    /**
     * 
     * <p>
     * Title: getLists
     * </p>
     * <p>
     * Description: 获取lists类型下所有的数据
     * </p>
     * 
     * @param Key
     */
    public List<String> getLists(String key) {
        BoundListOperations<String, String> listRedisTemplate = strRedisTemplate.boundListOps(key);
        return listRedisTemplate.range(0, -1);
    }

    /**
     * 
     * @Title: setLists
     * @Description: 添加lists类型的数据
     * @param: @param key
     * @param: @param values
     */
    public void setLists(String key, String... values) {
        if (StringUtils.isEmpty(key) || values == null || values.length == 0) {
            logger.error("setLists error at the key or values is empty");
            return;
        }
        BoundListOperations<String, String> listRedisTemplate = strRedisTemplate.boundListOps(key);
        listRedisTemplate.leftPushAll(values);
    }

    /**
     * 
     * @Title: setLists
     * @Description: 添加lists类型的数据
     * @param: @param key
     * @param: @param values
     */
    public void setLists(String key, List<String> values) {
        if (StringUtils.isEmpty(key) || CollectionUtils.isEmpty(values)) {
            logger.error("setLists error at the key or values is empty");
            return;
        }
        setLists(key, values.toArray(new String[values.size()]));
    } 
    
    public boolean tryLock(String key) {
    	String currentValue = (String)strRedisTemplate.opsForValue().get(key);
    	return StringUtils.isNotEmpty(currentValue) && Long.parseLong(currentValue) < System.currentTimeMillis();
    }
    
    /**
     * 加锁
     * @param key 锁唯一标志
     * @param timeout 超时时间
     * @return
     */
    public boolean lock(String key, long timeout){
        String value = String.valueOf(timeout + System.currentTimeMillis());
        if(strRedisTemplate.opsForValue().setIfAbsent(key,value)){
            return true;
        }
        //判断锁超时,防止死锁
        String currentValue = (String)strRedisTemplate.opsForValue().get(key);
        //如果锁过期
        if(StringUtils.isNotEmpty(currentValue) && Long.parseLong(currentValue) < System.currentTimeMillis()){
            //获取上一个锁的时间value
            String oldValue = (String) strRedisTemplate.opsForValue().getAndSet(key,value);
            if(StringUtils.isNotEmpty(oldValue) && oldValue.equals(currentValue) ){
                //校验是不是上个对应的商品时间戳,也是防止并发
                return true;
            }
        }
        return false;
    }
    /**
     * 解锁
     * @param key
     * @param value
     */
    public void unlock(String key){
        try {
            String currentValue =  (String) strRedisTemplate.opsForValue().get(key);
            if(!StringUtils.isEmpty(currentValue)){
                strRedisTemplate.opsForValue().getOperations().delete(key);//删除key
                logger.info("unlock success");
            }
        } catch (Exception e) {
        	logger.error("unlock error", e);
        }
    }

}
