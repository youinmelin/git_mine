package com.yujia.topbang.api.enums;

/**
 * 消息类型
 *
 * @author caorui
 * @date 2019-02-20
 */
public enum NoticeTypeEnum {
    /**
     * 站内信
     */
    write(1),
    /**
     * 邮件
     */
    mail(2),
    /**
     * 手机短信
     */
    phone(3),
    /**
     * 微信公众号
     */
    weixin(5),
    /**
     * APP
     */
    app(6),

    ;

    private final Integer type;

    NoticeTypeEnum(Integer type) {
        this.type = type;
    }

    public Integer getType() {
        return type;
    }
}
