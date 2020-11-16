package com.yujia.topbang.api.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;
import java.io.Serializable;

import com.forgetfulr.common.core.BaseDO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 消息发送列表
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("notice_send")
public class NoticeSendDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 消息内容ID
     */
    private Long contentId;

    /**
     * 消息标题
     */
    @TableField(exist = false)
    private String title;

    /**
     * 消息内容
     */
    @TableField(exist = false)
    private String content;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 接收对象
     */
    private String receiveObject;

    /**
     * 消息类型 1站内信2邮件3短信5微信6推送
     */
    private Integer type;

    /**
     * 创建时间
     */
    @TableField(value = "gmt_create", fill = FieldFill.INSERT)
    private String gmtCreate;

    /**
     * 发送时间
     */
    private String gmtSend;

    /**
     * 是否已发送
     */
    private Integer isSend;

    /**
     * 接收时间
     */
    private String gmtReceived;

    /**
     * 阅读时间
     */
    private String gmtRead;

    /**
     * 是否已读
     */
    private Integer isRead;

    /**
     * 用户删除标记
     */
    private Integer userDeleted;

    /**
     * 修改时间
     */
    @TableField(value = "gmt_modified", fill = FieldFill.INSERT_UPDATE)
    private String gmtModified;

    /**
     * 逻辑删除标记
     */
    @TableLogic
    private Integer isDeleted;


}
