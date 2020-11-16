package com.yujia.topbang.api.entity;

import java.math.BigDecimal;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;
import java.io.Serializable;

import com.forgetfulr.common.core.BaseDO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 视频直播
 * </p>
 *
 * @author caorui
 * @since 2020-09-05
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("video_live")
public class VideoLiveDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 标题
     */
    private String title;

    /**
     * 直播平台ID
     */
    private Integer platformId;

    /**
     * 直播平台名称（冗余）
     */
    private String platformName;

    /**
     * 直播链接
     */
    private String liveLink;

    /**
     * 视频封面
     */
    private String videoImgUrl;

    /**
     * 行业ID
     */
    private Integer industryId;

    /**
     * 行业名称（冗余）
     */
    private String industryName;

    /**
     * 价格
     */
    private BigDecimal price;

    /**
     * 是否支持定制
     */
    private Integer isCustom;

    /**
     * 购买链接
     */
    private String buyUrl;

    /**
     * 试用下载链接
     */
    private String downloadUrl;

    /**
     * 商品描述
     */
    private String content;

    /**
     * 状态
     */
    private Integer status;

    /**
     * 创建时间
     */
    @TableField(value = "gmt_create", fill = FieldFill.INSERT)
    private String gmtCreate;

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
