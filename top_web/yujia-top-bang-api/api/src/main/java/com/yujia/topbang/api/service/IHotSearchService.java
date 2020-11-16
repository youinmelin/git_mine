package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.HotSearchDO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 热门搜索 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-09-10
 */
public interface IHotSearchService extends IService<HotSearchDO> {

    /**
     * 热门搜索分页
     *
     * @param hotSearchDO
     * @return
     */
    JSONObject getMgrPageList(HotSearchDO hotSearchDO);

}
