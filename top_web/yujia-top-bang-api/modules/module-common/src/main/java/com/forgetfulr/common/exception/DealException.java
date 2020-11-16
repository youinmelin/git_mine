package com.forgetfulr.common.exception;

import com.forgetfulr.common.enums.errorcode.UserErrorEnum;

/**
 * 交易异常
 *
 * @author caorui
 * @date 2019-03-07
 */
public class DealException extends MyException {
    /**
     * 自定义的错误码
     */
    private static Integer errorCode = 209999;
    /**
     * 错误具体信息
     */
    private static String msg = "交易异常";
    /**
     * HTTP 状态码
     */
    private static int code = 400;

    /**
     * 默认把子类的自定义值赋值给父类
     */
    public DealException() {
        super(errorCode, msg, code);
    }

    public DealException(String _msg) {
        super(errorCode, _msg, code);
    }

    public DealException(Integer _errorCode, String _msg) {
        super(_errorCode, _msg, code);
    }

    public DealException(Integer _errorCode, String _msg, int _code) {
        super(_errorCode, _msg, _code);
    }

    public DealException(UserErrorEnum errorEnum) {
        super(errorEnum.getErrorCode(), errorEnum.getMsg(), code);
    }
}