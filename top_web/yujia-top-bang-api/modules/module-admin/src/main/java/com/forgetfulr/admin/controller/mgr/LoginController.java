package com.forgetfulr.admin.controller.mgr;

import com.forgetfulr.admin.entity.AdminUserDO;
import com.forgetfulr.admin.service.IAdminUserService;
import com.forgetfulr.common.core.R;
import com.forgetfulr.common.exception.UserException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 管理后台登录
 *
 * @author caorui
 * @date 2019-02-21
 */
@RestController("mgrLoginController")
@RequestMapping("/api/mgr")
public class LoginController {

    /**
     * 管理后台用户
     */
    @Autowired
    private IAdminUserService adminUserService;

    /**
     * 管理后台登录
     *
     * @param adminUserDO
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public R login(@RequestBody AdminUserDO adminUserDO) {
        try {
            return R.ok().put("data", adminUserService.adminLogin(adminUserDO,
                    adminUserDO.getGeetest_challenge(),
                    adminUserDO.getGeetest_seccode(),
                    adminUserDO.getGeetest_validate()));
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 管理员退出登录
     *
     * @return
     */
    @PostMapping(value = "/logout")
    public R logout() {
        adminUserService.logout();
        return R.ok();
    }
}
