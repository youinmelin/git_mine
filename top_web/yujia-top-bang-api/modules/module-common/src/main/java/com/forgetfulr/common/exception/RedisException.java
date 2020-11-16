package com.forgetfulr.common.exception;

import com.forgetfulr.common.enums.errorcode.RedisErrorEnum;

/**
 * 缓存异常
 *
 * @author caorui
 * @date 2018/1/8
 */
public class RedisException extends MyException {

    /**
     * 自定义的错误码
     */
    private static Integer errorCode = 139999;
    /**
     * 错误具体信息
     */
    private static String msg = "缓存异常";

    private static int code = 500;

    public RedisException() {
        super(errorCode, msg, code);
    }

    public RedisException(String _msg) {
        super(errorCode, _msg, code);
    }

    public RedisException(Integer _errorCode, String _msg) {
        super(_errorCode, _msg, code);
    }

    public RedisException(Integer _errorCode, String _msg, int _code) {
        super(_errorCode, _msg, _code);
    }

    public RedisException(RedisErrorEnum errorEnum) {
        super(errorEnum.getErrorCode(), errorEnum.getMsg(), code);
    }
}
