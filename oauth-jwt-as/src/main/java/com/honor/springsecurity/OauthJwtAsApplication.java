package com.honor.springsecurity;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@MapperScan(basePackages = {"com.honor"})
@ComponentScan(basePackages = {"com.honor"})
public class OauthJwtAsApplication {

    public static void main(String[] args) {
        SpringApplication.run(OauthJwtAsApplication.class, args);
    }

}
