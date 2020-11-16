package com.yujia.topbang.api.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.forgetfulr.common.core.BaseDO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * <p>
 * Banner图
 * </p>
 *
 * @author caorui
 * @since 2020-08-06
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("banner")
public class BannerDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 组ID
     */
    @TableField(value = "group_id")
    private Integer groupId;

    /**
     * 用户ID
     */
    @TableField(value = "user_id")
    private Long userId;

    /**
     * 标题
     */
    private String title;

    /**
     * 描述
     */
    private String description;

    /**
     * 图片地址
     */
    @TableField(value = "img_url")
    private String imgUrl;

    /**
     * 点击跳转地址
     */
    @TableField(value = "link_url")
    private String linkUrl;

    /**
     * 周期
     */
    private Integer cycle;

    /**
     * 周期时长
     */
    @TableField(value = "cycle_num")
    private Integer cycleNum;

    /**
     * 到期时间
     */
    private String gmtDue;

    /**
     * 状态
     */
    private Integer status;

    /**
     * 是否启用
     */
    private Integer used;

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
     * 逻辑删除标记
     */
    @TableLogic
    private Integer isDeleted;


}
