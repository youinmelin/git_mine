package com.yujia.topbang.api.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.forgetfulr.common.core.BaseDO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * <p>
 * 用户证件表
 * </p>
 *
 * @author caorui
 * @since 2020-09-02
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("user_card")
public class UserCardDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Long userId;

    private String name;

    /**
     * 证件号码
     */
    private String cardno;

    private String imageUrl;

    private String imageUrl2;

    /**
     * 有效时间起
     */
    private String validStart;

    /**
     * 有效时间止
     */
    private String validEnd;

    /**
     * 证件类型
     */
    private Integer type;

    /**
     * 审核状态
     */
    private Integer status;

    @TableField(value = "gmt_create", fill = FieldFill.INSERT)
    private String gmtCreate;

    @TableField(value = "gmt_modified", fill = FieldFill.INSERT_UPDATE)
    private String gmtModified;

    @TableLogic
    private Integer isDeleted;


}
