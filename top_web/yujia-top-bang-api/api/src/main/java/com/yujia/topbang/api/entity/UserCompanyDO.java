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
 * 用户公司信息
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("user_company")
public class UserCompanyDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 企业名称
     */
    private String unitName;

    /**
     * 统一社会信用代码
     */
    private String socialCreditCode;

    /**
     * 注册资本
     */
    private String regCapital;

    /**
     * 成立日期
     */
    private String establishDate;

    /**
     * 营业期限
     */
    private String expirationDate;

    /**
     * 注册地址
     */
    private String regAddress;

    /**
     * 营业执照图片地址
     */
    private String imgUrl;

    /**
     * 员工规模
     */
    private String staffSize;

    /**
     * 业务范畴
     */
    private String businessScope;

    /**
     * 客户群体
     */
    private String customerBase;

    /**
     * 简介
     */
    private String content;

    /**
     * 法人姓名
     */
    private String name;

    /**
     * 法人证件号
     */
    private String cardNo;

    /**
     * 法人证件正面图片地址
     */
    private String justImgUrl;

    /**
     * 法人证件签发机关
     */
    private String signOrg;

    /**
     * 法人证件有效期开始时间
     */
    private String validStart;

    /**
     * 法人证件结束时间
     */
    private String validEnd;

    /**
     * 法人证件背面图片地址
     */
    private String backImgUrl;

    /**
     * 审核状态
     */
    private Integer status;

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
