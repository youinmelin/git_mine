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
 * 用户
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("user")
public class UserDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.INPUT)
    private Long id;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 姓名
     */
    private String name;

    /**
     * 头像
     */
    private String headImg;

    /**
     * 公司名
     */
    private String companyName;

    /**
     * 密码
     */
    private String passwd;

    /**
     * 二次验证密码
     */
    @TableField(exist = false)
    private String confirmPasswd;

    /**
     * 旧密码
     */
    @TableField(exist = false)
    private String oldPasswd;

    /**
     * 性别
     */
    private Integer sex;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 证件类型
     */
    private Integer idType;

    /**
     * 证件号码
     */
    private String idCard;

    /**
     * 账号角色
     */
    private Integer role;

    /**
     * 账号类型
     */
    private Integer type;

    /**
     * 注册时间
     */
    @TableField(value = "gmt_register", fill = FieldFill.INSERT)
    private String gmtRegister;

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

    /**
     * 验证码
     */
    @TableField(exist = false)
    private String veryCode;

    /**
     * 验证码Token
     */
    @TableField(exist = false)
    private String veryCodeToken;

    /**
     * 手机验证码
     */
    @TableField(exist = false)
    private String smsVeryCode;


}
