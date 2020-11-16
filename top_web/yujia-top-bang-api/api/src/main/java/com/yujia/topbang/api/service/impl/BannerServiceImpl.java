package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.common.enums.DateFormatEnum;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.DateUtil;
import com.forgetfulr.common.utils.ObjectUtil;
import com.yujia.topbang.api.entity.BannerDO;
import com.yujia.topbang.api.mapper.BannerMapper;
import com.yujia.topbang.api.service.IBannerService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * Banner图 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-06
 */
@Slf4j
@Service
public class BannerServiceImpl extends ServiceImpl<BannerMapper, BannerDO> implements IBannerService {

    /**
     * Banner
     *
     * @param bannerDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(BannerDO bannerDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<BannerDO> page = new Page<>();
            page.setCurrent(bannerDO.getPage());
            page.setSize(bannerDO.getLimit());
            // 由于前端问题，有些参数，传进来会是""，但是实际上没值，这里直接把所有的需要查询的条件都赋值null
            LambdaQueryWrapper<BannerDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 标题
            if (!ObjectUtil.isNullOrEmpty(bannerDO.getTitle())) {
                lambdaQueryWrapper.like(BannerDO::getTitle, bannerDO.getTitle());
            }
            // 用户ID
            if (!ObjectUtil.isNullOrEmpty(bannerDO.getUserId())) {
                lambdaQueryWrapper.eq(BannerDO::getUserId, bannerDO.getUserId());
            }
            lambdaQueryWrapper.orderByDesc(BannerDO::getId);
            page(page, lambdaQueryWrapper);
            List<BannerDO> list = page.getRecords();
            // put()方法的第一个参数为key值，必须为String类型，
            //            第二个参数为value，可以为boolean、double、int、long、Object、Map以及Collection等。
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get banner page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * Banner 增改
     *
     * @param bannerDO
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void bannerSave(BannerDO bannerDO) {
        saveOrUpdate(bannerDO);
    }

    /**
     * Banner审核
     *
     * @param bannerDO
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void auditBanner(BannerDO bannerDO) {
        if (ObjectUtil.isNullOrEmpty(bannerDO.getId())) {
            throw new UserException("ID不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(bannerDO.getStatus())) {
            throw new UserException("审核状态不能为空");
        }
        // 先找到这条记录
        BannerDO bannerModel = getById(bannerDO.getId());
        if (bannerModel == null) {
            throw new UserException("未找到待审核的Banner信息");
        }
        // 计算时间周期（之前是提交就计算，现在改到审核才计算到期时间）
        if (!ObjectUtil.isNullOrEmpty(bannerDO.getCycle())){
            if (bannerDO.getCycle() == 0) {
                bannerDO.setGmtDue(DateUtil.getDateAddDay(bannerDO.getCycleNum(), DateFormatEnum.DATEFORMAT_yyyy_MM_dd_HH_mm_ss));
            } else if (bannerDO.getCycle() == 1) {
                bannerDO.setGmtDue(DateUtil.getDateAddMonth(bannerDO.getCycleNum(), DateFormatEnum.DATEFORMAT_yyyy_MM_dd_HH_mm_ss));
            }
        }

        // 先修改当前记录
        updateById(bannerDO);
    }

    /**
     * 购买banner
     *
     * @param bannerDO
     */
    @Override
    public void buyBanner(BannerDO bannerDO) {
        // 默认（强制？）为显示状态
        bannerDO.setUsed(1);
        save(bannerDO);
    }

    /**
     * 前端推广banner列表
     *
     * @param bannerDO
     * @return
     */
    @Override
    public JSONObject marketBannerList(BannerDO bannerDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<BannerDO> page = new Page<>();
            page.setCurrent(bannerDO.getPage());
            page.setSize(bannerDO.getLimit());
            // 由于前端问题，有些参数，传进来会是""，但是实际上没值，这里直接把所有的需要查询的条件都赋值null
            LambdaQueryWrapper<BannerDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 设置条件构造器
            lambdaQueryWrapper.orderByDesc(BannerDO::getId);
            // 分页查询
            this.page(page, lambdaQueryWrapper);
            List<BannerDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get banner page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

}
