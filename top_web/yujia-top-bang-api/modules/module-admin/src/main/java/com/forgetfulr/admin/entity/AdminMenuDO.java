package com.forgetfulr.admin.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * 后台权限列表
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("admin_menu")
public class AdminMenuDO implements Serializable, Comparable<AdminMenuDO> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 父级ID
     */
    private Long parentId;

    /**
     * 名称（与视图的文件夹名称和路由路径对应）
     */
    private String name;

    /**
     * 类型0菜单1按钮
     */
    private Integer type;

    /**
     * 标题
     */
    private String title;

    /**
     * 描述
     */
    private String description;

    /**
     * 后台页面小图标
     */
    private String routeIcon;

    /**
     * 后台页面路由
     */
    private String routeUrl;

    /**
     * 接口请求url
     */
    private String requestUrl;

    /**
     * 接口请求方式GET/POST/PUT/DELETE
     */
    private String requestMethod;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 默认是否展开，仅二级目录有效
     */
    private Integer spread;

    /**
     * 当前层级（冗余）
     */
    private Integer level;

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
     * 逻辑删除标识
     */
    @TableLogic
    private Integer isDeleted;

    /**
     * 是否默认选中
     */
    @TableField(exist = false)
    private Boolean checked;

    /**
     * 是否禁止选择
     */
    @TableField(exist = false)
    private Boolean disabled;

    @TableField(exist = false)
    private List<AdminMenuDO> childMenus;

    /**
     * 自定义Sort升序
     *
     * @param arg0
     * @return
     */
    @Override
    public int compareTo(AdminMenuDO arg0) {
        return this.getSort().compareTo(arg0.getSort());
    }
}
