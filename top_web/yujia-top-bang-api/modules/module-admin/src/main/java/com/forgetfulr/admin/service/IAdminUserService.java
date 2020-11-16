package com.forgetfulr.admin.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.forgetfulr.admin.entity.AdminUserDO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <p>
 * 后台管理用户表 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
public interface IAdminUserService extends IService<AdminUserDO> {

    /**
     * 管理后台登录
     *
     * @param adminUserDO
     * @return
     */
    JSONObject adminLogin(AdminUserDO adminUserDO,
                          String challenge,
                          String seccode,
                          String validate);

    /**
     * 管理后台退出
     */
    void logout();

    /**
     * 管理用户分页
     *
     * @param adminUserDO
     * @return
     */
    JSONObject getPageList(AdminUserDO adminUserDO);

    /**
     * 用户增改
     *
     * @param adminUserDO
     */
    void userSave(AdminUserDO adminUserDO);

    /**
     * 修改密码
     *
     * @param adminUserDO
     */
    void setPassword(AdminUserDO adminUserDO);

}
