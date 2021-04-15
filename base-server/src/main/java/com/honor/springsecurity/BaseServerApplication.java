package com.honor.springsecurity;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;

@SpringBootApplication
@MapperScan(basePackages = {"com.honor"})
@ComponentScan(basePackages = {"com.honor"})
@EnableRedisHttpSession(maxInactiveIntervalInSeconds = 30 * 60 * 1000)
public class BaseServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(BaseServerApplication.class, args);
    }

}
