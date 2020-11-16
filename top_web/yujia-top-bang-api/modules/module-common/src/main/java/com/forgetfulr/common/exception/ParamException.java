package com.forgetfulr.common.exception;

import com.forgetfulr.common.utils.ObjectUtil;

/**
 * 参数异常
 *
 * @author caorui
 */
public class ParamException extends MyException {

    /**
     * 自定义的错误码
     */
    private Integer errorCode = 199999;
    /**
     * 错误具体信息
     */
    private String msg = "参数异常";

    public ParamException(Integer _errorCode, String _msg) {
        super(_msg);
        if (!ObjectUtil.isNullOrEmpty(_errorCode)) {
            errorCode = _errorCode;
        }
        if (!ObjectUtil.isNullOrEmpty(_msg)) {
            msg = _msg;
        }
    }

    public ParamException() {

    }

    public ParamException(String message) {
        super(message);
        this.msg = message;
    }

    @Override
    public Integer getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(Integer errorCode) {
        this.errorCode = errorCode;
    }

    @Override
    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
