package com.forgetfulr.common.enums.errorcode;

/**
 * 缓存相关错误信息
 *
 * @author caorui
 * @date 2018/1/8
 */
public enum RedisErrorEnum {
    obtainLockExceed(130001, "获取锁超时"),

    ;


    RedisErrorEnum(Integer errorCode, String msg) {
        this.errorCode = errorCode;
        this.msg = msg;
    }

    private final Integer errorCode;

    private final String msg;

    public Integer getErrorCode() {
        return errorCode;
    }

    public String getMsg() {
        return msg;
    }
}
