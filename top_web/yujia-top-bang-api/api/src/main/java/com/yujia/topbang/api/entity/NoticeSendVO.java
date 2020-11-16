package com.yujia.topbang.api.entity;

import lombok.Data;

/**
 * 消息发送接收参数
 *
 * @author caorui
 * @date 2019-02-19
 */
@Data
public class NoticeSendVO {
    /**
     * 用户ID
     */
    private String userId;
    /**
     * 接收者（有可能用户ID是0，无法读取到信息的情况，比如注册）
     */
    private String receiveObject;
    /**
     * 站内信
     */
    private String write;
    /**
     * 邮件
     */
    private String mail;
    /**
     * 手机
     */
    private String phone;
    /**
     * 微信公众号
     */
    private String weixin;
    /**
     * APP推送
     */
    private String app;
    /**
     * 标题
     */
    private String title;
    /**
     * 内容
     */
    private String content;
    /**
     * APP跳转地址
     */
    private String appUrl;

}
