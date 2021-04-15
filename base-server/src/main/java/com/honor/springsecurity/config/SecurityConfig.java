package com.honor.springsecurity.config;

import com.honor.springsecurity.service.MyUserDetailsService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import javax.annotation.Resource;
import javax.sql.DataSource;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Resource
    private MyAuthenticationSuccessHandler myAuthenticationSuccessHandler;
    @Resource
    private MyAuthenticationFailureHandler myAuthenticationFailureHandler;
    @Resource
    private MyAuthenticationEntryPoint myAuthenticationEntryPoint;
    @Resource
    private MyAccessDeniedHandler myAccessDeniedHandler;
    @Resource
    private MyUserDetailsService myUserDetailsService;
    @Resource
    private CaptchaCodeFilter captchaCodeFilter;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                //.addFilterBefore(captchaCodeFilter, UsernamePasswordAuthenticationFilter.class)//验证码登录拦截
                .logout()
                .logoutSuccessUrl("/login.html");
        //用户多次登陆，踢下一个或者禁止登陆
        //http.sessionManagement()
        //        .maximumSessions(1)
        //        .maxSessionsPreventsLogin(false)
        //        .expiredSessionStrategy(new CustomExpiredSessionStrategy());
        http.csrf().disable() //禁用跨站csrf攻击防御，后面的章节会专门讲解
                .formLogin()
                .loginPage("/login.html")//一旦用户的请求没有权限就跳转到这个页面
                .loginProcessingUrl("/login")//登录表单form中action的地址，也就是处理认证请求的路径
                .defaultSuccessUrl("/")//登录认证成功后默认转跳的路径
                .successHandler(myAuthenticationSuccessHandler)
                .failureHandler(myAuthenticationFailureHandler)
                .and()
                .rememberMe()//记住密码，下次免登陆
                .tokenRepository(persistentTokenRepository())
                //.and()
                //.exceptionHandling()
                //.authenticationEntryPoint(myAuthenticationEntryPoint)//未登录访问资源处理
                //.accessDeniedHandler(myAccessDeniedHandler)//没权限访问资源处理
                .and()
                .authorizeRequests()//配置权限过滤
                .antMatchers("/login.html", "/login", "/kaptcha").permitAll()//不需要通过登录验证就可以被访问的资源路径,登录页面跟登录请求处理都要放开限制
                //.antMatchers("/", "/biz1", "/biz2") //资源路径匹配
                //.hasAnyAuthority("ROLE_user", "ROLE_admin")  //user角色和admin角色都可以访问
                //.antMatchers("/syslog", "/sysuser")  //资源路径匹配
                //.hasAnyRole("admin")  //admin角色可以访问
                //.antMatchers("/syslog").hasAuthority("sys:log")
                //.antMatchers("/sysuser").hasAuthority("sys:user")
                //.anyRequest().authenticated();
                .antMatchers("/").authenticated()
                .anyRequest().access("@rbacService.hasPermission(request,authentication)");
    }

    @Override
    public void configure(AuthenticationManagerBuilder builder) throws Exception {
        builder.userDetailsService(myUserDetailsService)
                .passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Resource
    private DataSource dataSource;

    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
        tokenRepository.setDataSource(dataSource);
        return tokenRepository;
    }


    @Override
    public void configure(WebSecurity web) {
        //将项目中静态资源路径开放出来
        web.ignoring().antMatchers("/css/**", "/fonts/**", "/img/**", "/js/**");
    }
}
