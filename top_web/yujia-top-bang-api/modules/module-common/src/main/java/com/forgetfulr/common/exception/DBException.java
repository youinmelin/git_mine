package com.forgetfulr.common.exception;

/**
 * 数据库异常
 *
 * @author caorui
 */
public class DBException extends RuntimeException {

    /**
     * 自定义的错误码
     */
    private Integer errorCode = 899999;

    private String msg = "数据库异常";

    public DBException(Integer errorCode, String msg) {
        this.errorCode = errorCode;
        this.msg = msg;
    }

    public DBException() {

    }

    public DBException(String message) {
        super(message);
    }

    public DBException(String message, Throwable e) {
        super(message, e);
    }

    public Integer getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(Integer errorCode) {
        this.errorCode = errorCode;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
