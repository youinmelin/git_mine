package com.forgetfulr.common.exception;

import com.forgetfulr.common.utils.ObjectUtil;

/**
 * API接口异常处理
 *
 * @author caorui
 * @date 2018/9/23
 */
public class ApiException extends MyException {
    /**
     * 自定义的错误码
     */
    private static Integer errorCode = 329999;
    /**
     * 错误具体信息
     */
    private static String msg = "接口异常";
    /**
     * HTTP 状态码
     */
    private static int code = 400;

    public ApiException() {
        super("接口异常");
    }

    public ApiException(String _msg) {
        super(errorCode, _msg, code);
    }

    public ApiException(Integer _errorCode, String _msg) {
        super(_msg);
        if (!ObjectUtil.isNullOrEmpty(_errorCode)) {
            errorCode = _errorCode;
        }
        if (!ObjectUtil.isNullOrEmpty(_msg)) {
            msg = _msg;
        }
    }

    public ApiException(Integer _errorCode, String _msg, int _code) {
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
}
