package com.forgetfulr.admin.controller.auth;

import com.forgetfulr.admin.service.IAdminMenuService;
import com.forgetfulr.common.core.R;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.SystemUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * 后台权限菜单
 *
 * @author caorui
 * @date 2019-01-22
 */
@RestController("mgrMenuController")
@RequestMapping("/api/mgr/menu")
public class MenuController {

    /**
     * 权限菜单
     */
    @Autowired
    private final IAdminMenuService adminMenuService;

    public MenuController(IAdminMenuService adminMenuService) {
        this.adminMenuService = adminMenuService;
    }

    /**
     * 获取用户菜单
     *
     * @return
     */
    @RequestMapping(value = "/adminUserMenu", method = RequestMethod.GET)
    public R adminUserMenu() {
        try {
            Long userId = SystemUtil.manageUserId();
            return R.ok().put("data", adminMenuService.adminUserMenu(userId));
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取权限菜单列表
     *
     * @return
     */
    @RequestMapping(value = "/queryMenuList/{roleId}", method = RequestMethod.GET)
    public R queryMenuList(@PathVariable Long roleId) {
        try {
            return R.ok().put("data", adminMenuService.queryMenuList(roleId));
        } catch (Exception e) {
            return R.error();
        }
    }
}
