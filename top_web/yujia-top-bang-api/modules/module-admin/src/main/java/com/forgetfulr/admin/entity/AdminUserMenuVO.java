package com.forgetfulr.admin.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

import java.util.List;

/**
 * 用户权限菜单
 *
 * @author caorui
 * @date 2019-02-28
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AdminUserMenuVO {

    @TableField(exist = false)
    private Long id;
    /**
     * 名称
     */
    @TableField(exist = false)
    private String name;
    /**
     * 标题
     */
    @TableField(exist = false)
    private String title;
    /**
     * 图标样式
     */
    @TableField(exist = false)
    private String icon;
    /**
     * 路由地址
     */
    @TableField(exist = false)
    private String jump;
    /**
     * 是否默认展开子菜单
     */
    @TableField(exist = false)
    private Boolean spread;
    /**
     * 下级菜单
     */
    @TableField(exist = false)
    private List<AdminUserMenuVO> list;
}
