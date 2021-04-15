package com.honor.springsecurity.config;

import com.honor.springsecurity.dao.MyUserDetailsServiceMapper;
import com.honor.springsecurity.model.MyUserDetails;
import es.moki.ratelimitj.core.limiter.request.RequestLimitRule;
import es.moki.ratelimitj.core.limiter.request.RequestRateLimiter;
import es.moki.ratelimitj.redis.request.RedisRateLimiterFactory;
import io.lettuce.core.RedisClient;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.Duration;
import java.util.Collections;
import java.util.Set;

@Component
public class MyAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

    @Resource
    MyUserDetailsServiceMapper myUserDetailsServiceMapper;

    RedisRateLimiterFactory factory = new RedisRateLimiterFactory(RedisClient.create("redis://localhost"));

    //规则定义：1小时之内5次机会，第6次失败就触发限流行为（禁止访问）
    Set<RequestLimitRule> rules =
            Collections.singleton(RequestLimitRule.of(Duration.ofMinutes(60),5));
    RequestRateLimiter limiter = factory.getInstance(rules);

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        System.out.println("custom MyAuthenticationFailureHandler");

        //从request或request.getSession中获取登录用户名
        String userName = request.getParameter("username");

        MyUserDetails userDetails = myUserDetailsServiceMapper.findByUserName(userName);

        //默认提示信息
        String errorMsg;
        if(exception instanceof LockedException){ //账户被锁定了
            errorMsg = "您已经多次登陆失败，账户已被锁定，请稍后再试！";
        }else if(exception instanceof SessionAuthenticationException){
            errorMsg = exception.getMessage();
        }else{
            errorMsg = "请检查您的用户名和密码输入是否正确";
        }

        if (userDetails != null) {
            if (userDetails.isAccountNonLocked()) {
                errorMsg = "您多次登陆失败，账户已被锁定，请稍后再试！";
                limiter.resetLimit(userName);
            }else {
                //每次登陆失败计数器加1，并判断该用户是否已经到了触发了锁定规则
                boolean reachLimit = limiter.overLimitWhenIncremented(userName);
                if(reachLimit){ //如果触发了锁定规则，修改数据库 accountNonLocked字段锁定用户
                    myUserDetailsServiceMapper.updateLockedByUserId(userName);
                    errorMsg = "您多次登陆失败，账户已被锁定，请稍后再试！";
                }
            }
        }

        System.out.println(errorMsg);

        super.onAuthenticationFailure(request, response, exception);
    }
}
