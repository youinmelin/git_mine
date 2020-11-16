package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.VideoLiveDO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 视频直播 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-09-05
 */
public interface IVideoLiveService extends IService<VideoLiveDO> {

    /**
     * 视频直播分页
     *
     * @param videoLiveDO
     * @return
     */
    JSONObject getMgrPageList(VideoLiveDO videoLiveDO);

    /**
     * 直播审核
     *
     * @param videoLiveDO
     */
    void auditVideoLive(VideoLiveDO videoLiveDO);

    /**
     * 前端视频直播分页
     *
     * @param videoLiveDO
     * @return
     */
    JSONObject getWebPageList(VideoLiveDO videoLiveDO);

    /**
     * 获取直播详情
     *
     * @param videoLiveId
     * @return
     */
    JSONObject getVideoLiveInfo(Long videoLiveId);

    /**
     * 删除直播
     *
     * @param userId
     * @param videoLiveId
     */
    void deleteVideoLive(Long userId, Long videoLiveId);

}
