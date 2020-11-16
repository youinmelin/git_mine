package com.yujia.topbang.api.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.forgetfulr.common.core.BaseDO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * <p>
 * 文章
 * </p>
 *
 * @author caorui
 * @since 2020-09-24
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("posts")
public class PostsDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 标题
     */
    private String title;

    /**
     * 文章分类ID
     */
    private Long categoryId;

    /**
     * 类型
     */
    private Integer type;

    /**
     * 是否置顶
     */
    private Integer isTop;

    /**
     * 是否推荐
     */
    private Integer isRecommend;

    /**
     * 文章主图
     */
    private String imgUrl;

    /**
     * 文章简介
     */
    private String description;

    /**
     * 文章内容
     */
    private String content;

    /**
     * SEO标题
     */
    private String seoTitle;

    /**
     * SEO网站内容描述)
     */
    private String seoDescription;

    /**
     * SEO关键字
     */
    private String seoKeywords;

    /**
     * 发布时间
     */
    private String publishAt;

    /**
     * 排序
     */
    private Long sort;

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
