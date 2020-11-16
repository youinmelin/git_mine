package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yujia.topbang.api.entity.UserCardDO;

/**
 * <p>
 * 用户证件表 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-09-02
 */
public interface IUserCardService extends IService<UserCardDO> {

    /**
     * 用户实名信息
     *
     * @param userCardDO
     * @return
     */
    JSONObject getMgrPageList(UserCardDO userCardDO);

    /**
     * 用户实名信息审核
     *
     * @param userCardDO
     */
    void auditUserCard(UserCardDO userCardDO);

}
