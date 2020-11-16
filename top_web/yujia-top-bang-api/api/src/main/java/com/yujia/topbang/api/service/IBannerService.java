package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.BannerDO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * Banner图 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-06
 */
public interface IBannerService extends IService<BannerDO> {

    /**
     * Banner
     *
     * @param bannerDO
     * @return
     */
    JSONObject getMgrPageList(BannerDO bannerDO);

    /**
     * Banner 增改
     *
     * @param bannerDO
     */
    void bannerSave(BannerDO bannerDO);

    /**
     * Banner审核
     *
     * @param bannerDO
     */
    void auditBanner(BannerDO bannerDO);

    /**
     * 购买banner
     *
     * @param bannerDO
     */
    void buyBanner(BannerDO bannerDO);

    /**
     * 前端推广banner列表
     *
     * @param bannerDO
     * @return
     */
    JSONObject marketBannerList(BannerDO bannerDO);

}
