package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.ObjectUtil;
import com.yujia.topbang.api.entity.UserCompanyDO;
import com.yujia.topbang.api.mapper.UserCompanyMapper;
import com.yujia.topbang.api.service.IUserCompanyService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 用户公司信息 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
@Slf4j
@Service
public class UserCompanyServiceImpl extends ServiceImpl<UserCompanyMapper, UserCompanyDO> implements IUserCompanyService {

    /**
     * 企业实名信息
     *
     * @param userCompanyDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(UserCompanyDO userCompanyDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<UserCompanyDO> page = new Page<>();
            page.setCurrent(userCompanyDO.getPage());
            page.setSize(userCompanyDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<UserCompanyDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 处理前端参数问题
            if (ObjectUtil.isNullOrEmpty(userCompanyDO.getUserId())) {
                userCompanyDO.setUserId(null);
            }
            if (ObjectUtil.isNullOrEmpty(userCompanyDO.getName())) {
                userCompanyDO.setName(null);
            }
            page(page, lambdaQueryWrapper);
            List<UserCompanyDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get userCompany page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 企业实名信息审核
     *
     * @param userCompanyDO
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void auditCompany(UserCompanyDO userCompanyDO) {
        if (ObjectUtil.isNullOrEmpty(userCompanyDO.getId())) {
            throw new UserException("ID不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(userCompanyDO.getStatus())) {
            throw new UserException("审核状态不能为空");
        }
        // 先找到这条记录
        UserCompanyDO userCompanyModel = getById(userCompanyDO.getId());
        if (userCompanyModel == null) {
            throw new UserException("未找到待审核的实名信息");
        }
        // 先修改当前记录
        updateById(userCompanyDO);
    }

    /**
     * 获取企业用户信息
     *
     * @param userId
     * @return
     */
    @Override
    public UserCompanyDO getCompanyInfo(Long userId) {
        LambdaQueryWrapper<UserCompanyDO> companyDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        companyDOLambdaQueryWrapper.eq(UserCompanyDO::getUserId, userId);
        return getOne(companyDOLambdaQueryWrapper);
    }

    /**
     * 修改公司简介
     *
     * @param userCompanyDO
     */
    @Override
    public void updateCompanyContent(UserCompanyDO userCompanyDO) {
        LambdaUpdateWrapper<UserCompanyDO> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(UserCompanyDO::getUserId, userCompanyDO.getUserId());
        updateWrapper.set(UserCompanyDO::getContent, userCompanyDO.getContent());
        update(updateWrapper);
    }

}
