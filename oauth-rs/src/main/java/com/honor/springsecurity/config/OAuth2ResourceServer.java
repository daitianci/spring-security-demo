package com.honor.springsecurity.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.DefaultTokenServices;
import org.springframework.security.oauth2.provider.token.RemoteTokenServices;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.security.oauth2.provider.token.store.JdbcTokenStore;
import org.springframework.security.oauth2.provider.token.store.redis.RedisTokenStore;

import javax.annotation.Resource;
import javax.sql.DataSource;

/**
 * OAuth2ResourceServer
 *
 * @author daitianci
 * @date 2021/4/18
 */
@Configuration
@EnableResourceServer
public class OAuth2ResourceServer extends ResourceServerConfigurerAdapter {

    //*************************资源服务器的RemoteTokenServices校验机制开始***************************
    // @Primary
    // @Bean
    // public RemoteTokenServices tokenServices() {
    //     final RemoteTokenServices tokenService = new RemoteTokenServices();
    //     tokenService.setCheckTokenEndpointUrl("http://localhost:8001/oauth/check_token");
    //     tokenService.setClientId("client1");
    //     tokenService.setClientSecret("123456");
    //     return tokenService;
    // }
    //
    // @Override
    // public void configure(ResourceServerSecurityConfigurer resources) {
    //     resources.tokenServices(tokenServices());
    // }
    //*************************资源服务器的token校验机制结束***************************


    //*************************资源服务器的JdbcTokenStore校验机制开始***************************
    // @Resource
    // private DataSource dataSource;
    //
    // @Bean
    // public TokenStore tokenStore() {
    //     return new JdbcTokenStore(dataSource);
    // }
    @Resource
    private RedisConnectionFactory connectionFactory;

    @Bean
    public TokenStore tokenStore() {
        RedisTokenStore redis = new RedisTokenStore(connectionFactory);
        return redis;
    }

    @Bean
    @Primary
    public DefaultTokenServices tokenServices() {
        DefaultTokenServices defaultTokenServices = new DefaultTokenServices();
        defaultTokenServices.setTokenStore(tokenStore());
        return defaultTokenServices;
    }

    @Override
    public void configure(ResourceServerSecurityConfigurer resources)  {
        resources.tokenServices(tokenServices());
    }
    //*************************资源服务器的JdbcTokenStore校验机制结束***************************

    @Override
    public void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .anyRequest().authenticated()
                .and()
                .requestMatchers()
                .antMatchers("/api/**");
    }

}