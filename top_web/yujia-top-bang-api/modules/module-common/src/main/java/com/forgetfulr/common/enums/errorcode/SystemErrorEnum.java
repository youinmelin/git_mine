package com.forgetfulr.common.enums.errorcode;

/**
 * 系统默认返回code枚举
 *
 * @author caorui
 */
public enum SystemErrorEnum {
    //成功
    success(0, "成功"),
    unknownError(999999, "未知错误");

    SystemErrorEnum(Integer errorCode, String msg) {
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
