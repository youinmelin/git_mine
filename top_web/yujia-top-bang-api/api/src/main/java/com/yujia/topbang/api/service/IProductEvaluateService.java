package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yujia.topbang.api.entity.ProductEvaluateDO;

/**
 * <p>
 * 产品评价 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
public interface IProductEvaluateService extends IService<ProductEvaluateDO> {

    /**
     * 产品评价分页
     *
     * @param productEvaluateDO
     * @return
     */
    JSONObject getMgrPageList(ProductEvaluateDO productEvaluateDO);

    /**
     * 提交评价
     *
     * @param productEvaluateDO
     */
    void productEvaluate(ProductEvaluateDO productEvaluateDO);

    /**
     * 前端页面评价分页
     *
     * @param productEvaluateDO
     * @return
     */
    JSONObject getWebPageProductEvaluate(ProductEvaluateDO productEvaluateDO);

}
