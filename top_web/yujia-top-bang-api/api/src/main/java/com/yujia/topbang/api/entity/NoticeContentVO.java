package com.yujia.topbang.api.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.forgetfulr.common.core.BaseDO;
import lombok.Data;

/**
 * 消息列表内容
 *
 * @author caorui
 * @date 2019-02-27
 */
@Data
public class NoticeContentVO extends BaseDO {
    /**
     *
     */
    @TableField(exist = false)
    private Long id;

    /**
     * 用户ID
     */
    @TableField(exist = false)
    private Long userId;

    /**
     * 消息接收者
     */
    @TableField(exist = false)
    private String receiveObject;


    /**
     * 消息类型 1站内信2邮件3短信5微信6推送
     */
    @TableField(exist = false)
    private Integer type;


    /**
     * 创建时间
     */
    @TableField(exist = false)
    private String gmtCreate;


    /**
     * 发送时间
     */
    @TableField(exist = false)
    private String gmtSend;


    /**
     * 是否已发送
     */
    @TableField(exist = false)
    private Integer isSend;


    /**
     * 接收时间
     */
    @TableField(exist = false)
    private String gmtReceived;


    /**
     * 阅读时间
     */
    @TableField(exist = false)
    private String gmtRead;


    /**
     * 是否已读
     */
    @TableField(exist = false)
    private Integer isRead;


    /**
     * 用户删除标记
     */
    @TableField(exist = false)
    private Integer userDeleted;

    /**
     * 标题
     */
    @TableField(exist = false)
    private String title;

    /**
     * 消息内容
     */
    @TableField(exist = false)
    private String content;

    /**
     * APP跳转地址
     */
    @TableField(exist = false)
    private String appUrl;

}
