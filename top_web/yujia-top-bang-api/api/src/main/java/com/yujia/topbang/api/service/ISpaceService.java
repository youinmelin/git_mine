package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.SpaceDO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 空间管理 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-14
 */
public interface ISpaceService extends IService<SpaceDO> {

    /**
     * 空间管理分页
     *
     * @param spaceDO
     * @return
     */
    JSONObject getMgrPageList(SpaceDO spaceDO);

}
