package com.forgetfulr.common.exception;

/**
 * 算法异常
 *
 */
public class AlgorithmException extends RuntimeException{

    public AlgorithmException() {

    }

    public AlgorithmException(String message) {
        super(message);
    }

    public AlgorithmException(String message, Throwable e) {
        super(message, e);
    }}
