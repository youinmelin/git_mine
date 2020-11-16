package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.ProductTrialDO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 产品试用 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-09-07
 */
public interface IProductTrialService extends IService<ProductTrialDO> {

    /**
     * 前端产品试用分页
     *
     * @param productTrialDO
     * @return
     */
    JSONObject getWebPageList(ProductTrialDO productTrialDO);

    /**
     * 产品试用审核
     *
     * @param id
     * @param status
     */
    void auditProductTrial(Long id, Integer status);

}
