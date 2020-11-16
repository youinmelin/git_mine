package com.forgetfulr.admin.controller.mgr;

import com.alibaba.fastjson.JSONObject;
import com.forgetfulr.admin.entity.AdminRoleDO;
import com.forgetfulr.admin.entity.AdminUserDO;
import com.forgetfulr.admin.service.IAdminMenuService;
import com.forgetfulr.admin.service.IAdminRoleMenuService;
import com.forgetfulr.admin.service.IAdminRoleService;
import com.forgetfulr.admin.service.IAdminUserService;
import com.forgetfulr.common.core.R;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.SystemUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 后台管理相关
 *
 * @author caorui
 * @date 2019-01-25
 */
@RestController("mgrAdminController")
@RequestMapping("/api/mgr/admin")
public class AdminController {

    /**
     * 管理用户
     */
    @Autowired
    private IAdminUserService adminUserService;
    /**
     * 角色
     */
    @Autowired
    private IAdminRoleService adminRoleService;
    /**
     * 权限菜单
     */
    @Autowired
    private IAdminMenuService adminMenuService;
    /**
     * 角色权限菜单
     */
    @Autowired
    private IAdminRoleMenuService adminRoleMenuService;

    /**
     * 获取后台用户列表
     *
     * @return
     */
    @RequestMapping(value = "/getUserList", method = RequestMethod.POST)
    public R getAdminUserList(@RequestBody AdminUserDO adminUserDO) {
        try {
            return R.ok().put("data", adminUserService.getPageList(adminUserDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 管理用户增改
     *
     * @param adminUserDO
     * @return
     */
    @RequestMapping(value = "/userSave", method = RequestMethod.POST)
    public R userSave(@RequestBody AdminUserDO adminUserDO) {
        try {
            adminUserService.userSave(adminUserDO);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 用户删除
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/userDelete/{id}", method = RequestMethod.DELETE)
    public R userDelete(@PathVariable Long id) {
        try {
            adminUserService.removeById(id);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取用户信息
     *
     * @return
     */
    @RequestMapping(value = "/userInfo", method = RequestMethod.GET)
    public R userInfo() {
        try {
            return R.ok().put("data", adminUserService.getById(SystemUtil.manageUserId()));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 修改密码
     *
     * @return
     */
    @RequestMapping(value = "/setPassword", method = RequestMethod.PUT)
    public R setPassword(@RequestBody AdminUserDO adminUserDO) {
        try {
            adminUserDO.setId(SystemUtil.manageUserId());
            adminUserService.setPassword(adminUserDO);
            return R.ok();
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 判断用户名是否有重复的
     *
     * @return
     */
//    @RequestMapping(value = "/getUserNameCount", method = RequestMethod.POST)
//    public ResponseDO getUserNameCount(String userName) {
//        ResponseDO responseDO = new ResponseDO();
//        try {
//            responseDO.setData(adminUserService.getUniqueCount(userName));
//        } catch (Exception e) {
//            responseDO.setCode(SystemErrorEnum.unknownError.getErrorCode());
//            responseDO.setMsg(SystemErrorEnum.unknownError.getMsg());
//        }
//        return responseDO;
//    }

    /**
     * 获取角色列表
     *
     * @return
     */
    @RequestMapping(value = "/getRoleList", method = RequestMethod.POST)
    public R getAdminRoleList(@RequestBody AdminRoleDO adminRoleDO) {
        try {
            return R.ok().put("data", adminRoleService.getPageList(adminRoleDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取全部角色列表
     *
     * @return
     */
    @RequestMapping(value = "/getRole", method = RequestMethod.GET)
    public R getAdminRole() {
        try {
            return R.ok().put("data", adminRoleService.list());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 角色添加
     *
     * @param adminRoleDO
     * @return
     */
    @RequestMapping(value = "/roleSave", method = RequestMethod.POST)
    public R roleInsert(@RequestBody AdminRoleDO adminRoleDO) {
        try {
            adminRoleService.roleSave(adminRoleDO);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 角色删除
     *
     * @param roleId
     * @return
     */
    @RequestMapping(value = "/roleDelete/{roleId}", method = RequestMethod.DELETE)
    public R roleDelete(@PathVariable Long roleId) {
        try {
            adminRoleService.removeById(roleId);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 角色权限菜单批量插入
     *
     * @param jsonObject
     * @return
     */
    @RequestMapping(value = "/roleMenuBatchInsert", method = RequestMethod.POST)
    public R roleMenuBatchInsert(@RequestBody JSONObject jsonObject) {
        try {
            adminRoleMenuService.batchInsert(jsonObject);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }
}
