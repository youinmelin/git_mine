package com.forgetfulr.admin.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.admin.entity.AdminRoleDO;
import com.forgetfulr.admin.mapper.AdminRoleMapper;
import com.forgetfulr.admin.service.IAdminRoleService;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.utils.ObjectUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 后台管理用户角色表 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
@Slf4j
@Service
public class AdminRoleServiceImpl extends ServiceImpl<AdminRoleMapper, AdminRoleDO> implements IAdminRoleService {

    /**
     * 角色分页
     *
     * @param adminRoleDO
     * @return
     */
    @Override
    public JSONObject getPageList(AdminRoleDO adminRoleDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<AdminRoleDO> page = new Page<>();
            page.setCurrent(adminRoleDO.getPage());
            page.setSize(adminRoleDO.getLimit());
            page(page);
            List<AdminRoleDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get adminRole page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 角色增改
     *
     * @param adminRoleDO
     */
    @Override
    public void roleSave(AdminRoleDO adminRoleDO) {
        // 描述
        if (ObjectUtil.isNullOrEmpty(adminRoleDO.getDescription())) {
            adminRoleDO.setDescription("");
        }
        // 排序
        if (ObjectUtil.isNullOrEmpty(adminRoleDO.getSort())) {
            adminRoleDO.setSort(0);
        }
        saveOrUpdate(adminRoleDO);
    }

}
