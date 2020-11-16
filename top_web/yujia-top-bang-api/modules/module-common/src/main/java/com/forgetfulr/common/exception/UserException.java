package com.forgetfulr.common.exception;

import com.forgetfulr.common.enums.errorcode.UserErrorEnum;

/**
 * @author caorui
 */
public class UserException extends MyException {
    /**
     * 自定义的错误码
     */
    private static final Integer errorCode = 109999;
    /**
     * 错误具体信息
     */
    private static final String msg = "系统错误";
    /**
     * HTTP 状态码
     */
    private static final int code = 400;

    /**
     * 默认把子类的自定义值赋值给父类
     */
    public UserException() {
        super(errorCode, msg, code);
    }

    public UserException(String _msg) {
        super(errorCode, _msg, code);
    }

    public UserException(Integer _errorCode, String _msg) {
        super(_errorCode, _msg, code);
    }

    public UserException(Integer _errorCode, String _msg, int _code) {
        super(_errorCode, _msg, _code);
    }

    public UserException(UserErrorEnum errorEnum) {
        super(errorEnum.getErrorCode(), errorEnum.getMsg(), code);
    }
}
