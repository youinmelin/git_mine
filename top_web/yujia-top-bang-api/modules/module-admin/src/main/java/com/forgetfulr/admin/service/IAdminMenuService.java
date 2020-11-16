package com.forgetfulr.admin.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.forgetfulr.admin.entity.AdminMenuDO;
import com.forgetfulr.admin.entity.AdminUserMenuVO;

import java.util.List;

/**
 * <p>
 * 后台权限列表 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
public interface IAdminMenuService extends IService<AdminMenuDO> {

    /**
     * 获取用户权限菜单
     */
    List<AdminUserMenuVO> adminUserMenu(Long userId);

    /**
     * 获取权限菜单列表
     *
     * @param roleId
     * @return
     */
    JSONObject queryMenuList(Long roleId);

}
