package com.yujia.topbang.api.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 产品应用行业
 * </p>
 *
 * @author caorui
 * @since 2020-09-07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("product_apply_industry")
public class ProductApplyIndustryDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 产品ID
     */
    private Long prodId;

    /**
     * 行业ID
     */
    private Long industryId;

    /**
     * 行业名称（冗余）
     */
    private String industryName;

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
