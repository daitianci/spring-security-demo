package com.honor.springsecurity.config;

import org.jasig.cas.client.session.SingleSignOutFilter;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.cas.web.CasAuthenticationFilter;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.authentication.logout.LogoutFilter;

import javax.annotation.Resource;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Resource
    AuthenticationEntryPoint casAuthenticationEntryPoint;
    @Resource
    AuthenticationProvider casAuthenticationProvider;
    @Resource
    SingleSignOutFilter casSingleSignOutFilter;
    @Resource
    LogoutFilter casLogoutFilter;
    @Resource
    CasAuthenticationFilter casAuthenticationFilter;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        //这个provider调用了MyUserDetailsService
        auth.authenticationProvider(casAuthenticationProvider);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors()
                .and()
                .authorizeRequests()
                .antMatchers("/login/cas").permitAll()
                .antMatchers("/","/index.html").authenticated()
                .anyRequest()
                .access("@rbacService.hasPermission(request,authentication)")
                .and()
                .exceptionHandling()
                .authenticationEntryPoint(casAuthenticationEntryPoint)
                .and()
                .addFilter(casAuthenticationFilter)
                .addFilterBefore(casSingleSignOutFilter, CasAuthenticationFilter.class)
                .addFilterBefore(casLogoutFilter, LogoutFilter.class);
    }

    @Override
    public void configure(WebSecurity web) {
        //将项目中静态资源路径开放出来
        web.ignoring().antMatchers("/css/**", "/fonts/**", "/img/**", "/js/**");
    }
}
