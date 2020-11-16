package com.yujia.topbang.api.entity;

import java.math.BigDecimal;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;
import java.io.Serializable;
import java.util.Collection;

import com.forgetfulr.common.core.BaseDO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 产品评价
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("product_evaluate")
public class ProductEvaluateDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 商品ID
     */
    private Long productId;

    /**
     * 试用ID
     */
    private Long trialId;

    /**
     * 产品名称（冗余）
     */
    private String productName;

    /**
     * 产品用户ID（冗余）
     */
    private Long productUserId;

    /**
     * 公司ID
     */
    @TableField(exist = false)
    private Long companyId;
    /**
     * 公司名
     */
    @TableField(exist = false)
    private String companyName;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 评分
     */
    private BigDecimal score;

    /**
     * 内容
     */
    private String content;

    /**
     * 图片、视频地址
     */
    private String imgUrl;

    /**
     * 是否带图
     */
    private Integer isImg;

    /**
     * 是否带视频
     */
    private Integer isVideo;

    /**
     * 是否追评
     */
    private Integer isReview;

    /**
     * 好1中2差3评价
     */
    private Integer status;

    /**
     * 回复内容
     */
    private String replyContent;

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
     * 回复时间
     */
    private String gmtReply;

    /**
     * 逻辑删除
     */
    @TableLogic
    private Integer isDeleted;

    /**
     * 图片列表
     */
    @TableField(exist = false)
    private Collection<String> imgList;


}
