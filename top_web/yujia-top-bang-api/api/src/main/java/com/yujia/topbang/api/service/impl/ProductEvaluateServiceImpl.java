package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.ObjectUtil;
import com.yujia.topbang.api.entity.*;
import com.yujia.topbang.api.mapper.ProductEvaluateMapper;
import com.yujia.topbang.api.service.*;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * <p>
 * 产品评价 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
@Slf4j
@Service
@AllArgsConstructor
public class ProductEvaluateServiceImpl extends ServiceImpl<ProductEvaluateMapper, ProductEvaluateDO> implements IProductEvaluateService {

    /**
     * 评价图片
     */
    private final IProductEvaluateImgService productEvaluateImgService;

    /**
     * 产品试用
     */
    private final IProductTrialService productTrialService;

    /**
     * 产品
     */
    private final IProductService productService;

    /**
     * 公司
     */
    private final IUserCompanyService userCompanyService;

    /**
     * 产品评价分页
     *
     * @param productEvaluateDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(ProductEvaluateDO productEvaluateDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<ProductEvaluateDO> page = new Page<>();
            page.setCurrent(productEvaluateDO.getPage());
            page.setSize(productEvaluateDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<ProductEvaluateDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();

            page(page, lambdaQueryWrapper);
            List<ProductEvaluateDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get productEvaluate page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 提交评价
     *
     * @param productEvaluateDO
     */
    @Override
    public void productEvaluate(ProductEvaluateDO productEvaluateDO) {
        // 查一下产品，冗余
        ProductDO productDO = productService.getById(productEvaluateDO.getProductId());
        if (productDO == null) {
            throw new UserException("获取产品信息失败");
        }
        productEvaluateDO.setProductName(productDO.getName());
        if (productEvaluateDO.getImgList() != null && !productEvaluateDO.getImgList().isEmpty()) {
            productEvaluateDO.setIsImg(1);
            // 暂时处理不了带视频的
        }
        // 状态修改为和试用一样
        productEvaluateDO.setStatus(3);
        // 先保存评价内容
        save(productEvaluateDO);
        Long evelId = productEvaluateDO.getId();
        // 循环添加视频链接
        if (productEvaluateDO.getImgList() != null && !productEvaluateDO.getImgList().isEmpty()) {
            List<ProductEvaluateImgDO> productEvaluateImgDOList = new ArrayList<>();
            for (String item : productEvaluateDO.getImgList()) {
                ProductEvaluateImgDO productEvaluateImgDO = new ProductEvaluateImgDO();
                productEvaluateImgDO.setEvalId(evelId);
                productEvaluateImgDO.setImgUrl(item);
                productEvaluateImgDOList.add(productEvaluateImgDO);
            }
            productEvaluateImgService.saveBatch(productEvaluateImgDOList);
        }
        // 评价完成要修改试用记录
        LambdaUpdateWrapper<ProductTrialDO> productTrialDOLambdaUpdateWrapper = new LambdaUpdateWrapper<>();
        productTrialDOLambdaUpdateWrapper.eq(ProductTrialDO::getId, productEvaluateDO.getTrialId());
        productTrialDOLambdaUpdateWrapper.set(ProductTrialDO::getStatus, 3);
        productTrialService.update(productTrialDOLambdaUpdateWrapper);
    }

    /**
     * 前端页面评价分页
     *
     * @param productEvaluateDO
     * @return
     */
    @Override
    public JSONObject getWebPageProductEvaluate(ProductEvaluateDO productEvaluateDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<ProductEvaluateDO> page = new Page<>();
            page.setCurrent(productEvaluateDO.getPage());
            page.setSize(productEvaluateDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<ProductEvaluateDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 产品ID
            if (!ObjectUtil.isNullOrEmpty(productEvaluateDO.getProductId())) {
                lambdaQueryWrapper.eq(ProductEvaluateDO::getProductId, productEvaluateDO.getProductId());
            }
            // 用户ID
            if (!ObjectUtil.isNullOrEmpty(productEvaluateDO.getUserId())) {
                lambdaQueryWrapper.eq(ProductEvaluateDO::getUserId, productEvaluateDO.getUserId());
            }
            // 状态
            if (!ObjectUtil.isNullOrEmpty(productEvaluateDO.getStatus())) {
                lambdaQueryWrapper.eq(ProductEvaluateDO::getStatus, productEvaluateDO.getStatus());
            }

            page(page, lambdaQueryWrapper);
            List<ProductEvaluateDO> list = page.getRecords();
            // 涉及到有图片，这里要循环查询出来
            for (ProductEvaluateDO item : list) {
                LambdaQueryWrapper<ProductEvaluateImgDO> productEvaluateImgDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
                productEvaluateImgDOLambdaQueryWrapper.eq(ProductEvaluateImgDO::getEvalId, item.getId());
                List<ProductEvaluateImgDO> imgDOList = productEvaluateImgService.list(productEvaluateImgDOLambdaQueryWrapper);
                Collection<String> imgList = new ArrayList<>();
                for (ProductEvaluateImgDO item2 : imgDOList) {
                    imgList.add(item2.getImgUrl());
                }
                item.setImgList(imgList);
                // 还需要调用产品对应的公司信息
                LambdaQueryWrapper<UserCompanyDO> companyDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
                companyDOLambdaQueryWrapper.eq(UserCompanyDO::getUserId, item.getProductUserId());
                // 防止出错，这里加一个limit 1
                companyDOLambdaQueryWrapper.last("limit 1");
                UserCompanyDO userCompanyDO = userCompanyService.getOne(companyDOLambdaQueryWrapper);
                if (userCompanyDO != null) {
                    item.setCompanyId(userCompanyDO.getUserId());
                    item.setCompanyName(userCompanyDO.getUnitName());
                }
            }
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            // 这里添加几种状态的具体数值
            LambdaQueryWrapper<ProductEvaluateDO> productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productDOLambdaQueryWrapper.eq(ProductEvaluateDO::getUserId, productEvaluateDO.getUserId());
            productDOLambdaQueryWrapper.eq(ProductEvaluateDO::getStatus, 0);
            // 待评价
            jsonObject.put("status0", count(productDOLambdaQueryWrapper));
            // 已评价
            productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productDOLambdaQueryWrapper.eq(ProductEvaluateDO::getUserId, productEvaluateDO.getUserId());
            productDOLambdaQueryWrapper.eq(ProductEvaluateDO::getStatus, 3);
            jsonObject.put("status3", count(productDOLambdaQueryWrapper));
            // 如果有产品ID的情况下，额外计算出对产品的评分
            if (!ObjectUtil.isNullOrEmpty(productEvaluateDO.getProductId())) {
                // 评价星级
                jsonObject.put("productScore", baseMapper.getProductScore(productEvaluateDO.getProductId()));
            }
            return jsonObject;
        } catch (Exception e) {
            log.error("get productEvaluate page list error:{}", e.getMessage());
            throw new DBException();
        }
    }
}
