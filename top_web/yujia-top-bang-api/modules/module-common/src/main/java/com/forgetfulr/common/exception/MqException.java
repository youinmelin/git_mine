package com.forgetfulr.common.exception;

/**
 * MQ消息异常
 *
 * @author caorui
 */
public class MqException extends RuntimeException {

    public MqException() {

    }

    public MqException(String message) {
        super(message);
    }

    public MqException(String message, Throwable e) {
        super(message, e);
    }

}
