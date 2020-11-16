package com.forgetfulr.admin.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.forgetfulr.admin.entity.AdminRoleDO;

/**
 * <p>
 * 后台管理用户角色表 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
public interface IAdminRoleService extends IService<AdminRoleDO> {

    /**
     * 角色分页
     *
     * @param adminRoleDO
     * @return
     */
    JSONObject getPageList(AdminRoleDO adminRoleDO);

    /**
     * 角色增改
     *
     * @param adminRoleDO
     */
    void roleSave(AdminRoleDO adminRoleDO);
}
