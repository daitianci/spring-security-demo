package com.honor.springsecurity.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
public class SessionController {

    @GetMapping(value="/uid")
    public String uid(HttpSession session) {
        return "sessionId:" + session.getId();
    }
}
