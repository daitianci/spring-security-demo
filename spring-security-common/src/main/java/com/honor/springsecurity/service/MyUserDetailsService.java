package com.honor.springsecurity.service;

import com.honor.springsecurity.dao.MyUserDetailsServiceMapper;
import com.honor.springsecurity.model.MyUserDetails;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class MyUserDetailsService implements UserDetailsService {

    @Resource
    private MyUserDetailsServiceMapper myUserDetailsServiceMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        MyUserDetails userDetails = myUserDetailsServiceMapper.findByUserName(username);

        if (userDetails == null) {
            throw new UsernameNotFoundException("用户名不存在");
        }

        //获得用户角色列表
        List<String> roleCodes = myUserDetailsServiceMapper.findRoleByUserName(username);

        //通过角色列表获取权限列表
        List<String> authorities = myUserDetailsServiceMapper.findAuthorityByRoleCodes(roleCodes);

        //为角色标识加上ROLE_前缀（Spring Security规范）
        roleCodes = roleCodes.stream()
                .map(rc -> "ROLE_" + rc)
                .collect(Collectors.toList());

        //角色是一种特殊的权限，所以合并
        authorities.addAll(roleCodes);
        //转成用逗号分隔的字符串，为用户设置权限标识
        userDetails.setAuthorities(
                AuthorityUtils.commaSeparatedStringToAuthorityList(
                        String.join(",", authorities)
                )
        );

        return userDetails;
    }
}
