package com.forgetfulr.common.exception;

import com.forgetfulr.common.utils.ObjectUtil;

/**
 * 自定义异常处理
 *
 * @author caorui
 * @date 2018/1/8
 */
public class MyException extends RuntimeException {
    /**
     * 自定义的错误码
     */
    private Integer errorCode = 999999;
    /**
     * 错误具体信息
     */
    private String msg = "系统错误";
    /**
     * HTTP 状态码
     */
    private Integer code = 400;

    public MyException() {
        super();
    }

    public MyException(String _msg) {
        super(_msg);
    }

    public MyException(Integer _errorCode, String _msg) {
        super(_msg);
        if (!ObjectUtil.isNullOrEmpty(_errorCode)) {
            errorCode = _errorCode;
        }
        if (!ObjectUtil.isNullOrEmpty(_msg)) {
            msg = _msg;
        }
    }

    MyException(Integer _errorCode, String _msg, int _code) {
        super(_msg);
        if (!ObjectUtil.isNullOrEmpty(_errorCode)) {
            errorCode = _errorCode;
        }
        if (!ObjectUtil.isNullOrEmpty(_msg)) {
            msg = _msg;
        }
        if (!ObjectUtil.isNullOrEmpty(_code)) {
            code = _code;
        }
    }


    public Integer getErrorCode() {
        return errorCode;
    }

    public String getMsg() {
        return msg;
    }

    public Integer getCode() {
        return code;
    }
}
