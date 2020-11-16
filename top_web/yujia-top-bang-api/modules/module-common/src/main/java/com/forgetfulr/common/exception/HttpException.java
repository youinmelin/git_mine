package com.forgetfulr.common.exception;

/**
 * HTTP协议异常
 *
 * @author caorui
 * @date 2018/1/8
 */
public class HttpException extends RuntimeException {

    public HttpException() {

    }

    public HttpException(String message) {
        super(message);
    }

    public HttpException(String message, Throwable e) {
        super(message, e);
    }

}
