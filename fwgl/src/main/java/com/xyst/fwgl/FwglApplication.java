package com.xyst.fwgl;

import com.xyst.fwgl.model.ServiceInfo;
import com.xyst.fwgl.service.impl.ServiceInfoServiceImpl;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;
import tk.mybatis.spring.annotation.MapperScan;

import java.util.List;

@MapperScan("com.xyst.fwgl.mapper")
@EnableScheduling
@SpringBootApplication
public class FwglApplication  extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(FwglApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(FwglApplication.class, args);

    }

}
