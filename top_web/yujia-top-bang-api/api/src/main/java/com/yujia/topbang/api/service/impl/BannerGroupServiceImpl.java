package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.forgetfulr.admin.entity.AdminUserDO;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.utils.ArithmeticUtil;
import com.forgetfulr.common.utils.ObjectUtil;
import com.yujia.topbang.api.entity.BannerDO;
import com.yujia.topbang.api.entity.BannerGroupDO;
import com.yujia.topbang.api.mapper.BannerGroupMapper;
import com.yujia.topbang.api.service.IBannerGroupService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * Banner组 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-06
 */
@Slf4j
@Service
public class BannerGroupServiceImpl extends ServiceImpl<BannerGroupMapper, BannerGroupDO> implements IBannerGroupService {

    /**
     * Banner 分组
     *
     * @param bannerGroupDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(BannerGroupDO bannerGroupDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<BannerGroupDO> page = new Page<>();
            page.setCurrent(bannerGroupDO.getPage());
            page.setSize(bannerGroupDO.getLimit());
            // 由于前端问题，有些参数，传进来会是""，但是实际上没值，这里直接把所有的需要查询的条件都赋值null
            LambdaQueryWrapper<BannerGroupDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 分组名
            if (!ObjectUtil.isNullOrEmpty(bannerGroupDO.getName())) {
                lambdaQueryWrapper.like(BannerGroupDO::getName, bannerGroupDO.getName());
            }
            lambdaQueryWrapper.orderByDesc(BannerGroupDO::getId);
            page(page, lambdaQueryWrapper);
            List<BannerGroupDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get bannerGroup page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * Banner 分组增改
     *
     * @param bannerGroupDO
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void bannerGroupSave(BannerGroupDO bannerGroupDO) {
        saveOrUpdate(bannerGroupDO);
    }

}
