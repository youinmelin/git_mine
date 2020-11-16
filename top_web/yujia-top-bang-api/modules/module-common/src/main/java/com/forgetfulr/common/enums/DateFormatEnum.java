package com.forgetfulr.common.enums;

/**
 * @author caorui
 */
public enum DateFormatEnum {

    DATEFORMAT_yyyy_MM_dd_HH_mm_ss("yyyy-MM-dd HH:mm:ss"),
    DATEFORMAT_yyyy_MM_dd("yyyy-MM-dd"),
    DATEFORMAT_HH_mm_ss("HH:mm:ss"),
    DATEFORMAT_yyyyMMdd("yyyyMMdd"),
    DATEFORMAT_yyyy_MM_dd_00_00_00("yyyy-MM-dd 00:00:00"),
    DATEFORMAT_yyyy_MM_dd_23_59_59("yyyy-MM-dd 23:59:59"),
    DATEFORMAT_yyyy("yyyy"),
    DATEFORMAT_MM("MM"),
    DATEFORMAT_dd("dd"),
    DATEFORMAT_HH("HH"),
    DATEFORMAT_mm("mm"),
    DATEFORMAT_ss("ss"),
    DATEFORMAT_yyyy_MM("yyyy-MM"),
    DATEFORMAT_yyyyMMddHHmm("yyyyMMddHHmm"),
    DATEFORMAT_yyyyMMddHH("yyyyMMddHH"),
    DATEFORMAT_MMdd("M.d"),
    ;


    private final String format;

    DateFormatEnum(String format) {

        this.format = format;
    }


    public String getFormat() {
        return format;
    }
}
