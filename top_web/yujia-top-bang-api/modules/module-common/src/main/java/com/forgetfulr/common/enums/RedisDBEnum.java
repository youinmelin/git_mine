package com.forgetfulr.common.enums;

/**
 * redis数据库索引
 *
 * @author caorui
 */
public enum RedisDBEnum {

    /**
     * 通用
     */
    DB_COMMON(0),
    /**
     * 锁相关
     */
    DB_LOCK(1),
    /**
     * 自增序号
     */
    DB_SEQUENCE(2),
    /**
     * 临时用
     */
    DB_TEMP(3),
    /**
     * IP地址
     */
    DB_IP_Address(4),
    /**
     * web用户相关
     */
    DB_WEB_USER(5),

    ;

    private final int dbIndex;

    RedisDBEnum(int dbIndex) {
        this.dbIndex = dbIndex;
    }

    public int getDbIndex() {
        return dbIndex;
    }
}
