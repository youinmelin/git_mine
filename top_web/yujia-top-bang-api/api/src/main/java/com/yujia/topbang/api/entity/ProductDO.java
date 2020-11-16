package com.yujia.topbang.api.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.forgetfulr.common.core.BaseDO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * <p>
 * 产品
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("product")
public class ProductDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 视频封面
     */
    private String videoImgUrl;

    /**
     * 视频时长
     */
    private Integer duration;

    /**
     * 视频时长字符串
     */
    @TableField(exist = false)
    private String strDuration;

    /**
     * 行业ID
     */
    private Integer industryId;

    /**
     * 行业名称（冗余）
     */
    private String industryName;

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
     * 状态
     */
    private Integer status;

    /**
     * 产品名称
     */
    private String name;

    /**
     * 产品文字说明
     */
    private String description;

    /**
     * 评分
     */
    private BigDecimal score;

    /**
     * 价格
     */
    private BigDecimal price;

    /**
     * 库存
     */
    private Long stock;

    /**
     * 内容，预留
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

    /**
     * 产品应用行业
     */
    @TableField(exist = false)
    private Collection<Integer> industryList;

    /**
     * 产品标签列表
     */
    @TableField(exist = false)
    private Collection<Integer> tagList;

    /**
     * 产品视频列表
     */
    @TableField(exist = false)
    private Collection<String> videoList;

    /**
     * 收藏量
     */
    private Integer collectionNum;

    /**
     * 播放量
     */
    private Integer playNum;


}
