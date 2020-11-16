package com.forgetfulr.admin.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.forgetfulr.admin.entity.AdminRoleMenuDO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 后台角色权限 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
public interface IAdminRoleMenuService extends IService<AdminRoleMenuDO> {

    /**
     * 查询角色菜单IDs
     *
     * @param roleId
     * @return
     */
    List<Long> getMenuIds(@Param("roleId") Long roleId);

    /**
     * 批量插入
     *
     * @param jsonObject
     */
    void batchInsert(JSONObject jsonObject);

}
