package com.forgetfulr.admin.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.admin.entity.AdminRoleMenuDO;
import com.forgetfulr.admin.mapper.AdminRoleMenuMapper;
import com.forgetfulr.admin.service.IAdminRoleMenuService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 后台角色权限 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
@Service
public class AdminRoleMenuServiceImpl extends ServiceImpl<AdminRoleMenuMapper, AdminRoleMenuDO> implements IAdminRoleMenuService {


    /**
     * 获取角色菜单权限IDs
     *
     * @param roleId
     * @return
     */
    @Override
    public List<Long> getMenuIds(Long roleId) {
        return baseMapper.getMenuIds(roleId);
    }

    /**
     * 批量插入
     *
     * @param jsonObject
     */
    @Override
    public void batchInsert(JSONObject jsonObject) {
        try {
            List<AdminRoleMenuDO> adminRoleMenuDOList = new ArrayList<>();
            AdminRoleMenuDO adminRoleMenuDO;
            Long roleId = jsonObject.getLongValue("id");
            List<Long> tempIds = new ArrayList<>();
            List<Long> ids = new ArrayList<>();
            JSONArray jsonArray = jsonObject.getJSONArray("menuIds");
            if (jsonArray == null || jsonArray.size() <= 0) {
                tempIds.add(0L);
            } else {
                tempIds = JSONObject.parseArray(jsonArray.toJSONString(), Long.class);
            }
            // 先删除
            baseMapper.batchDelete(roleId, tempIds);
            // 然后恢复之前删除的项
            baseMapper.batchRecovery(roleId, tempIds);
            // 再查找
            List<AdminRoleMenuDO> adminRoleMenuDOS;
            adminRoleMenuDOS = baseMapper.batchSelect(roleId, tempIds);
            // 循环找到数据库中不存在的menuId
            List<Long> selectIds = new ArrayList<>();
            for (AdminRoleMenuDO itemDO : adminRoleMenuDOS) {
                selectIds.add(itemDO.getMenuId());
            }
            for (Long item : tempIds) {
                if (!selectIds.contains(item) && !item.equals(0L)) {
                    ids.add(item);
                }
            }

            // 最后更新
            for (Long item : ids) {
                adminRoleMenuDO = new AdminRoleMenuDO();
                adminRoleMenuDO.setRoleId(roleId);
                adminRoleMenuDO.setMenuId(item);
                adminRoleMenuDOList.add(adminRoleMenuDO);
            }
            if (adminRoleMenuDOList.size() > 0) {
                baseMapper.batchInsert(adminRoleMenuDOList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
