package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.IndexCategoryDO;

import java.util.List;

/**
 * 首页
 *
 * @author caorui
 * @date 2020-09-08 15:14
 * Revision History
 * Date      		Programmer       Notes
 * 2020-09-08   	 caorui		     Initial
 */
public interface IIndexService {

    /**
     * 首页大接口
     *
     * @return
     */
    JSONObject index();

    /**
     * 单独获取首页分类
     *
     * @return
     */
    List<IndexCategoryDO> getIndexCategory();
}
