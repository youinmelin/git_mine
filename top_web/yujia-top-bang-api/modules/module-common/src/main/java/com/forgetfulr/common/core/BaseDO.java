package com.forgetfulr.common.core;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

/**
 * 基础DO
 *
 * @author caorui
 */
@Data
public class BaseDO {

    /**
     * 索引页
     */
    @TableField(exist = false)
    private Integer page = 1;

    /**
     * 每页条数
     */
    @TableField(exist = false)
    private Integer limit = 10;

    /**
     * 搜索条件
     */
    @TableField(exist = false)
    private String strSearch = "";

    /**
     * 开始时间
     */
    @TableField(exist = false)
    private String strBeginTime;

    /**
     * 结束时间
     */
    @TableField(exist = false)
    private String strEndTime;

    /**
     * 自定义排序
     */
    @TableField(exist = false)
    private String orderBy = "id desc";
}
