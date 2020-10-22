package com.xyst.fwgl.utils;

import java.io.Serializable;
import java.time.Duration;

import org.springframework.cache.CacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.cache.RedisCacheWriter;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;

/**
 * 建立redis连接
 * 
 * @author sam
 * @date 2018/05/11
 * @version 1.0.0
 */
@Configuration
public class RedisConfig {

	@Bean
	public CacheManager cacheManager(RedisConnectionFactory redisConnectionFactory) {
        RedisCacheConfiguration redisCacheConfiguration = RedisCacheConfiguration.defaultCacheConfig()
                .entryTtl( Duration.ofHours(1)); // 设置缓存有效期一小时
        return RedisCacheManager
                .builder( RedisCacheWriter.nonLockingRedisCacheWriter(redisConnectionFactory))
                .cacheDefaults(redisCacheConfiguration).build();

    }
	
    @Bean
    public RedisTemplate<Serializable, Serializable>
        serializableRedisTemplate(RedisConnectionFactory redisConnectionFactory) {
        RedisTemplate<Serializable, Serializable> template = new RedisTemplate<Serializable, Serializable>();
        template.setConnectionFactory(redisConnectionFactory);
        return template;
    }

}
