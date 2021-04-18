package com.honor.springsecurity.controller;

import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

/**
 * HelloController
 *
 * @author daitianci
 * @date 2021/4/18
 */
@RestController
@RequestMapping("/api")
public class HelloController {
    @Resource
    TokenStore tokenStore;

    @RequestMapping("/hello")
    public String hello(OAuth2Authentication authentication) {
        Map<String, Object> map = getExtraInfo(authentication);
        return "Hello Oauth2 Resource Server";
    }

    /**
     * 获取jwt token里的载荷信息
     * @param auth
     * @return
     */
    public Map<String, Object> getExtraInfo(OAuth2Authentication auth) {
        OAuth2AuthenticationDetails details
                = (OAuth2AuthenticationDetails) auth.getDetails();
        OAuth2AccessToken accessToken = tokenStore
                .readAccessToken(details.getTokenValue());
        return accessToken.getAdditionalInformation();
    }
}