package com.honor.springsecurity.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "cas.server")
public class CASServerProperties {
    private String  baseurl;
    private String  loginurl;
    private String  logouturl;

    public String getBaseurl() {
        return baseurl;
    }

    public void setBaseurl(String baseurl) {
        this.baseurl = baseurl;
    }

    public String getLoginurl() {
        return loginurl;
    }

    public void setLoginurl(String loginurl) {
        this.loginurl = loginurl;
    }

    public String getLogouturl() {
        return logouturl;
    }

    public void setLogouturl(String logouturl) {
        this.logouturl = logouturl;
    }
}
