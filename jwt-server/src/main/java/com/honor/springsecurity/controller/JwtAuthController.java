package com.honor.springsecurity.controller;

import com.honor.springsecurity.exception.AjaxResponse;
import com.honor.springsecurity.exception.CustomException;
import com.honor.springsecurity.exception.CustomExceptionType;
import com.honor.springsecurity.service.JwtAuthService;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

@RestController
public class JwtAuthController {

    @Resource
    private JwtAuthService jwtAuthService;

    @PostMapping(value = "/authentication")
    public AjaxResponse login(@RequestBody Map<String, String> map) {
        String username = map.get("username");
        String password = map.get("password");
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            return AjaxResponse.error(
                    new CustomException(
                            CustomExceptionType.USER_INPUT_ERROR,"用户名密码不能为空"));
        }
        try{
            return AjaxResponse.success(jwtAuthService.login(username, password));
        }catch(CustomException e){
            return AjaxResponse.error(e);
        }
    }

    @PostMapping(value = "/refreshtoken")
    public AjaxResponse refresh(@RequestHeader("${jwt.header}") String token) {
        return AjaxResponse.success(jwtAuthService.refreshToken(token));
    }

}
