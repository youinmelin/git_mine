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
 * 视频管理
 * </p>
 *
 * @author caorui
 * @since 2020-08-14
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("video")
public class VideoDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 产品ID
     */
    private Long prodId;

    /**
     * 用户ID（冗余）
     */
    private Long userId;

    /**
     * 视频地址
     */
    private String videoUrl;

    /**
     * 图片地址
     */
    private String imgUrl;

    /**
     * 视频时长
     */
    private Long duration;

    /**
     * 视频大小
     */
    private Long size;

    /**
     * 描述介绍
     */
    private String content;

    /**
     * 创建时间
     */
    @TableField(value = "gmt_create", fill = FieldFill.INSERT)
    private String gmtCreate;

    /**
     * 更新时间
     */
    @TableField(value = "gmt_modified", fill = FieldFill.INSERT_UPDATE)
    private String gmtModified;

    /**
     * 逻辑删除
     */
    @TableLogic
    private Integer isDeleted;


}
