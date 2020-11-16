package com.forgetfulr.admin.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.admin.entity.AdminMenuDO;
import com.forgetfulr.admin.entity.AdminUserDO;
import com.forgetfulr.admin.entity.AdminUserMenuVO;
import com.forgetfulr.admin.mapper.AdminMenuMapper;
import com.forgetfulr.admin.service.IAdminMenuService;
import com.forgetfulr.admin.service.IAdminRoleMenuService;
import com.forgetfulr.admin.service.IAdminUserService;
import com.forgetfulr.common.enums.errorcode.UserErrorEnum;
import com.forgetfulr.common.exception.UserException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * <p>
 * 后台权限列表 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
@Service
public class AdminMenuServiceImpl extends ServiceImpl<AdminMenuMapper, AdminMenuDO> implements IAdminMenuService {

    @Autowired
    private IAdminUserService adminUserService;

    @Autowired
    private IAdminRoleMenuService adminRoleMenuService;

    @Autowired
    private IAdminMenuService adminMenuService;

    /**
     * 获取用户权限菜单
     */
    @Override
    public List<AdminUserMenuVO> adminUserMenu(Long userId) {
        // 先找到当前用户权限ID
        AdminUserDO adminUserDO = adminUserService.getById(userId);
        if (adminUserDO == null) {
            throw new UserException(UserErrorEnum.invalidToken);
        }

        List<Long> menuIds = new ArrayList<>();
        menuIds = adminRoleMenuService.getMenuIds(Long.parseLong(adminUserDO.getRoleId().toString()));
        if (menuIds == null || menuIds.size() <= 0) {
            throw new UserException(UserErrorEnum.invalidToken);
        }

        List<AdminMenuDO> rootMenu = adminMenuService.listByIds(menuIds);
        // 调整排序
        Collections.sort(rootMenu);
        List<AdminMenuDO> menuList = new ArrayList<>();

        List<AdminUserMenuVO> menuListVO = new ArrayList<>();

        AdminUserMenuVO adminUserMenuVO;

        // 先找到所有的一级菜单
        for (AdminMenuDO rootMenu1 : rootMenu) {
            // 一级菜单没有parentId
            if (rootMenu1.getParentId().equals(0L)) {
                menuList.add(rootMenu1);
                adminUserMenuVO = new AdminUserMenuVO();
                adminUserMenuVO.setId(rootMenu1.getId());
                adminUserMenuVO.setName(rootMenu1.getName());
                adminUserMenuVO.setTitle(rootMenu1.getTitle());
                adminUserMenuVO.setIcon(rootMenu1.getRouteIcon());
                adminUserMenuVO.setJump(rootMenu1.getRouteUrl());
                adminUserMenuVO.setSpread(rootMenu1.getSpread().equals(1));
                menuListVO.add(adminUserMenuVO);
            }
        }
        List<Long> roleMenuIds = new ArrayList<>();
        for (AdminUserMenuVO item : menuListVO) {
            List<AdminMenuDO> adminMenuDOList = getChild(item.getId(), rootMenu, roleMenuIds);
            if (adminMenuDOList != null) {
                item.setList(adminUserMenuChild(adminMenuDOList));
            }
        }

        return menuListVO;

    }

    /**
     * 处理成LayuiAdmin菜单可以识别的格式
     * <p>
     * 详见文档说明https://fly.layui.com/docs/5/#menu
     *
     * @param adminMenuDOList
     * @return
     */
    private List<AdminUserMenuVO> adminUserMenuChild(List<AdminMenuDO> adminMenuDOList) {
        List<AdminUserMenuVO> adminUserMenuVOList = new ArrayList<>();
        AdminUserMenuVO adminUserMenuVO;
        for (AdminMenuDO item : adminMenuDOList) {
            adminUserMenuVO = new AdminUserMenuVO();
            adminUserMenuVO.setId(item.getId());
            adminUserMenuVO.setName(item.getName());
            adminUserMenuVO.setTitle(item.getTitle());
            adminUserMenuVO.setIcon(item.getRouteIcon());
            adminUserMenuVO.setJump(item.getRouteUrl());
            adminUserMenuVO.setSpread(item.getSpread().equals(1));
            adminUserMenuVOList.add(adminUserMenuVO);
        }
        return adminUserMenuVOList;
    }


    /**
     * 递归查找子菜单 * * @param id * 当前菜单id * @param rootMenu * 要查找的列表 * @return
     */
    private List<AdminMenuDO> getChild(Long id, List<AdminMenuDO> rootMenu, List<Long> roleMenuIds) {
        // 子菜单
        List<AdminMenuDO> childList = new ArrayList<>();
        for (AdminMenuDO menu : rootMenu) {
            if (menu.getParentId().equals(id)) {
                if (roleMenuIds.contains(menu.getId())) {
                    menu.setChecked(true);
                }
                childList.add(menu);
            }
        }
        // 把子菜单的子菜单再循环一遍
        for (AdminMenuDO menu : childList) {
            // 递归
            menu.setChildMenus(getChild(menu.getId(), rootMenu, roleMenuIds));
        }
        // 递归退出条件
        if (childList.size() == 0) {
            return null;
        }
        Collections.sort(childList);
        return childList;
    }

    /**
     * 获取权限菜单列表
     */
    @Override
    public JSONObject queryMenuList(Long roleId) {
        // 原始的数据
        List<AdminMenuDO> rootMenu = list();
        if (roleId == null) {
            roleId = 0L;
        }
        List<Long> roleMenuIds;
        roleMenuIds = adminRoleMenuService.getMenuIds(roleId);
        List<AdminMenuDO> menuList = new ArrayList<>();
        // 先找到所有的一级菜单
        for (AdminMenuDO rootMenu1 : rootMenu) {
            // 一级菜单没有parentId
            if (rootMenu1.getParentId().equals(0L)) {
                if (roleMenuIds.contains(rootMenu1.getId())) {
                    rootMenu1.setChecked(true);
                }
                menuList.add(rootMenu1);
            }
        }
        // 为一级菜单设置子菜单，getChild是递归调用的
        for (AdminMenuDO menu : menuList) {
            menu.setChildMenus(getChild(menu.getId(), rootMenu, roleMenuIds));
        }
        JSONObject jsonObject = new JSONObject();
        // 调整排序
        Collections.sort(menuList);
        jsonObject.put("trees", menuList);
        return jsonObject;
    }

}
