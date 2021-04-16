package com.honor.springsecurity.config;

import com.honor.springsecurity.service.MyUserDetailsService;
import org.jasig.cas.client.session.SingleSignOutFilter;
import org.jasig.cas.client.validation.Cas20ProxyTicketValidator;
import org.jasig.cas.client.validation.TicketValidator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.cas.ServiceProperties;
import org.springframework.security.cas.authentication.CasAuthenticationProvider;
import org.springframework.security.cas.web.CasAuthenticationEntryPoint;
import org.springframework.security.cas.web.CasAuthenticationFilter;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.authentication.logout.LogoutFilter;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Configuration
public class CASSecurityConfig {

    @Resource
    CASClientProperties casClientProperties;
    @Resource
    CASServerProperties casServerProperties;
    @Resource
    MyUserDetailsService myUserDetailsService;

    @Bean
    ServiceProperties casServiceProperties() {
        ServiceProperties serviceProperties = new ServiceProperties();
        serviceProperties.setService(casClientProperties.getBaseurl() + casClientProperties.getLoginurl());
        return serviceProperties;
    }

    @Bean
    AuthenticationEntryPoint casAuthenticationEntryPoint() {
        CasAuthenticationEntryPoint entryPoint = new CasAuthenticationEntryPoint();
        entryPoint.setLoginUrl(casServerProperties.getBaseurl() + casServerProperties.getLoginurl());
        entryPoint.setServiceProperties(casServiceProperties());
        return entryPoint;
    }

    @Bean
    TicketValidator ticketValidator() {
        return new Cas20ProxyTicketValidator(casServerProperties.getBaseurl());
    }

    @Bean
    CasAuthenticationProvider casAuthenticationProvider() {
        CasAuthenticationProvider provider = new CasAuthenticationProvider();
        provider.setServiceProperties(casServiceProperties());
        provider.setTicketValidator(ticketValidator());
        provider.setUserDetailsService(myUserDetailsService);
        provider.setKey("zimug-secret");  //并不重要，唯一即可
        return provider;
    }

    @Bean
    CasAuthenticationFilter casAuthenticationFilter(AuthenticationProvider authenticationProvider) {
        CasAuthenticationFilter filter = new CasAuthenticationFilter();
        filter.setServiceProperties(casServiceProperties());
        List<AuthenticationProvider> providers = new ArrayList<>();
        providers.add(authenticationProvider);
        filter.setAuthenticationManager(new ProviderManager(providers));
        return filter;
    }

    @Bean
    SingleSignOutFilter casSingleSignOutFilter() {
        SingleSignOutFilter sign = new SingleSignOutFilter();
        sign.setIgnoreInitConfiguration(true);
        return sign;
    }

    @Bean
    LogoutFilter casLogoutFilter() {
        String logoutRedirectPath = casServerProperties.getBaseurl() + casServerProperties.getLogouturl() + "?service=" +
                casClientProperties.getBaseurl();
        LogoutFilter filter = new LogoutFilter(logoutRedirectPath, new SecurityContextLogoutHandler());
        filter.setFilterProcessesUrl(casClientProperties.getLogouturl());
        return filter;
    }
}
