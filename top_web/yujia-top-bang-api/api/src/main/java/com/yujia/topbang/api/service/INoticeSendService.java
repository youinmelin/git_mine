package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.NoticeSendDO;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yujia.topbang.api.entity.NoticeSendVO;

/**
 * <p>
 * 消息发送列表 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
public interface INoticeSendService extends IService<NoticeSendDO> {

    /**
     * 新增消息
     *
     * @param noticeSendVO
     * @return
     */
    void noticeSend(NoticeSendVO noticeSendVO);

    /**
     * 消息列表
     *
     * @param noticeSendDO
     * @return
     */
    JSONObject getMgrPageList(NoticeSendDO noticeSendDO);

    /**
     * 前端消息列表
     *
     * @param noticeSendDO
     * @return
     */
    JSONObject getWebPageList(NoticeSendDO noticeSendDO);

}
