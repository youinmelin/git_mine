package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.UserDO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 用户 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
public interface IUserService extends IService<UserDO> {

    /**
     * 发送手机验证码
     *
     * @param userDO
     */
    void sendRegSmsVeryCode(UserDO userDO);

    /**
     * 发送找回密码验证码
     *
     * @param userDO
     */
    void sendForgetPhoneCode(UserDO userDO);

    /**
     * 注册
     *
     * @param userDO
     * @return
     */
    JSONObject register(UserDO userDO);

    /**
     * 找回密码
     *
     * @param userDO
     */
    void forgetPasswd(UserDO userDO);

    /**
     * 用户登录
     *
     * @param userDO
     * @return
     */
    JSONObject userLogin(UserDO userDO);

    /**
     * 用户分页
     *
     * @param userDO
     * @return
     */
    JSONObject getMgrPageList(UserDO userDO);

    /**
     * 用户增改（实际只有修改）
     *
     * @param userDO
     * @return
     */
    void userSave(UserDO userDO);

    /**
     * 退出登录
     */
    void logout();

    /**
     * 获取账户安全信息
     *
     * @param userId
     * @return
     */
    JSONObject getSecurity(Long userId);

    /**
     * 修改密码
     *
     * @param userDO
     */
    void setPasswd(UserDO userDO);

}
