package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yujia.topbang.api.entity.PostsDO;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 文章 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-09-24
 */
public interface IPostsService extends IService<PostsDO> {

    /**
     * 文章分页
     *
     * @param postsDO
     * @return
     */
    JSONObject getMgrPageList(PostsDO postsDO);

    /**
     * 文章 增改
     *
     * @param postsDO
     */
    void postsSave(PostsDO postsDO);

    /**
     * 文章前端分页
     *
     * @param postsDO
     * @return
     */
    JSONObject getWebPageList(PostsDO postsDO);

}
