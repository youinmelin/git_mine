package com.yujia.topbang.api.controller.web;

import com.forgetfulr.common.core.R;
import com.forgetfulr.common.exception.ParamException;
import com.forgetfulr.common.exception.UserException;
import com.yujia.topbang.api.entity.UserDO;
import com.yujia.topbang.api.service.IUserService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 登录
 *
 * @author caorui
 * @date 2020-08-31 17:29
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-31   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("webLoginController")
@RequestMapping("/api/web/login")
public class LoginController {

    /**
     * 用户
     */
    private final IUserService userService;

    // 发送短信验证码
    @PostMapping(value = "/sendPhoneCode")
    public R sendPhoneCode(@RequestBody UserDO userDO) {
        try {
            userService.sendRegSmsVeryCode(userDO);
            return R.ok();
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    // 发送找回密码短信验证码
    @PostMapping(value = "/sendForgetPhoneCode")
    public R sendForgetPhoneCode(@RequestBody UserDO userDO) {
        try {
            userService.sendForgetPhoneCode(userDO);
            return R.ok();
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    // 注册
    @PostMapping(value = "/register")
    public R register(@RequestBody UserDO userDO) {
        try {
            return R.ok().put("data", userService.register(userDO));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 用户登录
     *
     * @param userDO
     * @return
     */
    @PostMapping()
    public R login(@RequestBody UserDO userDO) {
        try {
            return R.ok().put("data", userService.userLogin(userDO));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 退出登录
     *
     * @return
     */
    @PostMapping(value = "/logout")
    public R logout() {
        try {
            userService.logout();
            return R.ok();
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 找回密码
     *
     * @param userDO
     * @return
     */
    @PostMapping(value = "/forgetPasswd")
    public R forgetPasswd(@RequestBody UserDO userDO) {
        try {
            userService.forgetPasswd(userDO);
            return R.ok();
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

}
