package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.ProductDO;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yujia.topbang.api.entity.UserProductBrowseHistoryDO;
import com.yujia.topbang.api.entity.UserProductCollectionDO;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 产品 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
public interface IProductService extends IService<ProductDO> {

    /**
     * 产品分页
     *
     * @param productDO
     * @return
     */
    JSONObject getMgrPageList(ProductDO productDO);

    /**
     * 产品审核
     *
     * @param productDO
     */
    void auditProduct(ProductDO productDO);

    /**
     * 前端产品分页
     *
     * @param productDO
     * @return
     */
    JSONObject getWebPageList(ProductDO productDO);

    /**
     * 产品发布
     *
     * @param productDO
     */
    void releaseProduct(ProductDO productDO);

    /**
     * 获取产品详情
     *
     * @param prodId
     * @return
     */
    JSONObject getProductInfo(Long prodId);

    /**
     * 编辑时获取产品详情
     *
     * @param prodId
     * @return
     */
    JSONObject getEditProductInfo(Long prodId);

    /**
     * 删除产品
     *
     * @param userId
     * @param prodId
     */
    void deleteProduct(Long userId, Long prodId);

    /**
     * 获取卖家管理中心首页
     *
     * @param userId
     * @return
     */
    JSONObject getSellerIndex(Long userId);

    /**
     * 获取买家管理中心首页
     *
     * @param userId
     * @return
     */
    JSONObject getBuyerIndex(Long userId);

    /**
     * 产品试用申请
     *
     * @param prodId
     * @param userId
     */
    void productGiveTrial(Long prodId, Long userId);

    /**
     * 获取企业用户信息
     *
     * @param userId
     * @return
     */
    JSONObject getCompanyInfo(Long userId);

    /**
     * 前端产品浏览记录分页
     *
     * @param userProductBrowseHistoryDO
     * @return
     */
    JSONObject getWebProductHistoryList(UserProductBrowseHistoryDO userProductBrowseHistoryDO);

    /**
     * 前端产品收藏分页
     *
     * @param userProductCollectionDO
     * @return
     */
    JSONObject getWebProductCollectionList(UserProductCollectionDO userProductCollectionDO);

    /**
     * 行业产品
     *
     * @param id
     * @return
     */
    JSONObject getIndustryProdList(Long id);

}
