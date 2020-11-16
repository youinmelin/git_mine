package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.VideoDO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 视频管理 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-14
 */
public interface IVideoService extends IService<VideoDO> {

    /**
     * 视频管理分页
     *
     * @param videoDO
     * @return
     */
    JSONObject getMgrPageList(VideoDO videoDO);

}
