package com.honor.springsecurity.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * HelloController
 *
 * @author daitianci
 * @date 2021/4/18
 */
@RestController
@RequestMapping("/api")
public class HelloController {

    @RequestMapping("/hello")
    public String hello() {
        return "Hello Oauth2 Resource Server";
    }

}