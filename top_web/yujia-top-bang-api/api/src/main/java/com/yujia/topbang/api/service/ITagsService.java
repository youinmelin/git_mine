package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.TagsDO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 标签 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-10
 */
public interface ITagsService extends IService<TagsDO> {

    /**
     * 标签分页
     *
     * @param tagsDO
     * @return
     */
    JSONObject getMgrPageList(TagsDO tagsDO);

}
