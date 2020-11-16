package com.forgetfulr.admin.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.admin.entity.AdminUserRoleDO;
import com.forgetfulr.admin.mapper.AdminUserRoleMapper;
import com.forgetfulr.admin.service.IAdminUserRoleService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 后台用户权限 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
@Service
public class AdminUserRoleServiceImpl extends ServiceImpl<AdminUserRoleMapper, AdminUserRoleDO> implements IAdminUserRoleService {

}
