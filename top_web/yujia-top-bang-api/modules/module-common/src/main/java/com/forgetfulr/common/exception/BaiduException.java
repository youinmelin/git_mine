package com.forgetfulr.common.exception;

/**
 * 百度接口异常
 *
 * @author caorui
 * @date 2018/9/6
 */
public class BaiduException extends MyException {
    /**
     * 自定义的错误码
     */
    private static Integer errorCode = 319999;
    /**
     * 错误具体信息
     */
    private static String msg = "百度接口异常";
    /**
     * HTTP 状态码
     */
    private static int code = 400;

    /**
     * 默认把子类的自定义值赋值给父类
     */
    public BaiduException() {
        super(errorCode, msg, code);
    }

    public BaiduException(String _msg) {
        super(errorCode, _msg, code);
    }

    public BaiduException(Integer _errorCode, String _msg) {
        super(_errorCode, _msg, code);
    }

    public BaiduException(Integer _errorCode, String _msg, int _code) {
        super(_errorCode, _msg, _code);
    }
}
