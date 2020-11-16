package com.forgetfulr.common.exception;

/**
 * 文件异常
 *
 * @author caorui
 * @date 2018/10/15
 */
public class FileException extends MyException {
    /**
     * 自定义的错误码
     */
    private static Integer errorCode = 169999;
    /**
     * 错误具体信息
     */
    private static String msg = "文件异常";
    /**
     * HTTP 状态码
     */
    private static int code = 400;

    /**
     * 默认把子类的自定义值赋值给父类
     */
    public FileException() {
        super(errorCode, msg, code);
    }

    public FileException(String _msg) {
        super(errorCode, _msg, code);
    }

    public FileException(Integer _errorCode, String _msg) {
        super(_errorCode, _msg, code);
    }

    public FileException(Integer _errorCode, String _msg, int _code) {
        super(_errorCode, _msg, _code);
    }
}
