package com.honor.springsecurity.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;

import javax.annotation.Resource;

/**
 * OAuth2AuthorizationServer
 *
 * @author daitianci
 * @date 2021/4/17
 */
@Configuration
@EnableAuthorizationServer
public class OAuth2AuthorizationServer extends AuthorizationServerConfigurerAdapter {

    @Resource
    PasswordEncoder passwordEncoder;

    //这个位置我们将Client客户端注册信息写死，后面章节我们会讲解动态实现
    @Override
    public void configure(ClientDetailsServiceConfigurer clients) throws Exception {
        System.out.println(passwordEncoder.encode("123456"));

        clients.inMemory()
                .withClient("client1").secret(passwordEncoder.encode("123456")) // Client 账号、密码。
                .redirectUris("http://localhost:8888/callback") // 配置回调地址，选填。
                .authorizedGrantTypes("authorization_code") // 授权码模式
                .scopes("all"); // 可授权的 Scope
    }

    @Override
    public void configure(AuthorizationServerSecurityConfigurer oauthServer) throws Exception {
        oauthServer
                .tokenKeyAccess("permitAll()")
                .checkTokenAccess("permitAll()")
                .allowFormAuthenticationForClients();
    }

}
