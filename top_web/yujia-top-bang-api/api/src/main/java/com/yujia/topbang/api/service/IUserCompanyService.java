package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.UserCompanyDO;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 用户公司信息 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
public interface IUserCompanyService extends IService<UserCompanyDO> {

    /**
     * 企业实名信息
     *
     * @param userCompanyDO
     * @return
     */
    JSONObject getMgrPageList(UserCompanyDO userCompanyDO);

    /**
     * 企业实名信息审核
     *
     * @param userCompanyDO
     */
    void auditCompany(UserCompanyDO userCompanyDO);

    /**
     * 获取企业用户信息
     *
     * @param userId
     * @return
     */
    UserCompanyDO getCompanyInfo(Long userId);

    /**
     * 修改公司简介
     *
     * @param userCompanyDO
     */
    void updateCompanyContent(UserCompanyDO userCompanyDO);

}
