package com.forgetfulr.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.forgetfulr.admin.entity.AdminUserDO;

import java.util.List;

/**
 * <p>
 * 后台管理用户表 Mapper 接口
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
public interface AdminUserMapper extends BaseMapper<AdminUserDO> {

    /**
     * 登录
     *
     * @param adminUserDO
     * @return
     */
    List<AdminUserDO> getLogin(AdminUserDO adminUserDO);

}
