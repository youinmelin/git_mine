package com.forgetfulr.admin.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.forgetfulr.common.core.BaseDO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.Serializable;

/**
 * <p>
 * 后台管理用户表
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("admin_user")
public class AdminUserDO extends BaseDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 密码
     */
    private String password;

    /**
     * 用户角色
     */
    private Integer roleId;

    /**
     * 角色名称
     */
    @TableField(exist = false)
    private String roleName;

    /**
     * 真实姓名
     */
    private String name;

    /**
     * 性别 0-女 1-男
     */
    private Integer sex;

    /**
     * 手机号码
     */
    private String mobile;

    /**
     * 邮箱地址
     */
    private String email;

    /**
     * 介绍
     */
    private String comment;

    /**
     * 账号状态 0-禁用 1-启用
     */
    private Integer status;

    /**
     * 注册时间
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
     * 旧密码
     */
    @TableField(exist = false)
    private String oldPassword;

    /**
     * 二次验证密码
     */
    @TableField(exist = false)
    private String confirmPassword;

    // 极验验证（暂时找不到很好的办法了，先写在这里）
    @TableField(exist = false)
    private String geetest_challenge;
    @TableField(exist = false)
    private String geetest_seccode;
    @TableField(exist = false)
    private String geetest_validate;


}
