package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.BannerGroupDO;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * Banner组 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-06
 */
public interface IBannerGroupService extends IService<BannerGroupDO> {

    /**
     * Banner 分组
     *
     * @param bannerGroupDO
     * @return
     */
    JSONObject getMgrPageList(BannerGroupDO bannerGroupDO);

    /**
     * Banner 分组增改
     *
     * @param bannerGroupDO
     */
    void bannerGroupSave(BannerGroupDO bannerGroupDO);

}
