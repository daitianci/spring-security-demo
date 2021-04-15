package com.honor.springsecurity.vo;

import java.time.LocalDateTime;

public class CaptchaImageVO {
    //验证码文字
    private String code;
    //验证码失效时间
    private LocalDateTime expireTime;

    public CaptchaImageVO(String code, int expireAfterSeconds){
        this.code = code;
        this.expireTime = LocalDateTime.now().plusSeconds(expireAfterSeconds);
    }

    //验证码是否失效
    public boolean isExpried() {
        return LocalDateTime.now().isAfter(expireTime);
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public LocalDateTime getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(LocalDateTime expireTime) {
        this.expireTime = expireTime;
    }
}
