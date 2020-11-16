package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.IndexCategoryDO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 首页分类 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-09-25
 */
public interface IIndexCategoryService extends IService<IndexCategoryDO> {

    /**
     * 首页栏目分页
     *
     * @param indexCategoryDO
     * @return
     */
    JSONObject getMgrPageList(IndexCategoryDO indexCategoryDO);

    /**
     * 保存&修改
     *
     * @param indexCategoryDO
     */
    void indexCategorySave(IndexCategoryDO indexCategoryDO);

}
