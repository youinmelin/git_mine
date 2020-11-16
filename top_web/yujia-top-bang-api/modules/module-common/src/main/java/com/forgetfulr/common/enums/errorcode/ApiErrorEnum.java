package com.forgetfulr.common.enums.errorcode;

/**
 * API相关
 *
 * @author caorui
 * @date 2018/10/21
 */
public enum ApiErrorEnum {

    invalidToken(320001, "无效的Token"),
    ;

    ApiErrorEnum(Integer errorCode, String msg) {
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
