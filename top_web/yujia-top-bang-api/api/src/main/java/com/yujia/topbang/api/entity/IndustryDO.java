package com.yujia.topbang.api.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 行业分类
 * </p>
 *
 * @author caorui
 * @since 2020-09-21
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("industry")
public class IndustryDO implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 代码
     */
    private String code;

    /**
     * 类别名称
     */
    private String name;

    /**
     * 说明
     */
    private String content;

    /**
     * 左值
     */
    private Long lId;

    /**
     * 右值
     */
    private Long rId;

    /**
     * 父级ID
     */
    private Long parentId;

    /**
     * 当前层级
     */
    private Integer currentLevel;


}
