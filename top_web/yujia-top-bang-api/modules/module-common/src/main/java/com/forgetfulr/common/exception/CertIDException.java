package com.forgetfulr.common.exception;

/**
 * 身份证格式异常
 */
public class CertIDException extends RuntimeException{

    public CertIDException() {

    }

    public CertIDException(String message) {
        super(message);
    }

    public CertIDException(String message, Throwable e) {
        super(message, e);
    }}
