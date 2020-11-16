package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.common.exception.DBException;
import com.yujia.topbang.api.entity.ProductTrialDO;
import com.yujia.topbang.api.mapper.ProductTrialMapper;
import com.yujia.topbang.api.service.IProductTrialService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 产品试用 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-09-07
 */
@Slf4j
@Service
@AllArgsConstructor
public class ProductTrialServiceImpl extends ServiceImpl<ProductTrialMapper, ProductTrialDO> implements IProductTrialService {

    private final ProductTrialMapper productTrialMapper;

    /**
     * 前端产品试用分页
     *
     * @param productTrialDO
     * @return
     */
    @Override
    public JSONObject getWebPageList(ProductTrialDO productTrialDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<ProductTrialDO> page = new Page<>();
            page.setCurrent(productTrialDO.getPage());
            page.setSize(productTrialDO.getLimit());
            // 自定义是否就需要分页上加上排序条件
            page.addOrder(OrderItem.desc("id"));
//            LambdaQueryWrapper<ProductTrialDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
//            // 状态
//            if (!ObjectUtil.isNullOrEmpty(productTrialDO.getStatus())) {
//                lambdaQueryWrapper.eq(ProductTrialDO::getStatus, productTrialDO.getStatus());
//            }
//            lambdaQueryWrapper.orderByDesc(ProductTrialDO::getId);
            // 好像自定义分页就不能用户lambda这种形式了？
            productTrialMapper.getProductTrialInfo(page, productTrialDO.getUserId()
                    , productTrialDO.getStatus(), productTrialDO.getStrSearch());

            List<ProductTrialDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            // 这里添加几种状态的具体数值
            LambdaQueryWrapper<ProductTrialDO> productTrialDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getUserId,productTrialDO.getUserId());
            productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getStatus, 0);
            // 申请中
            jsonObject.put("status0", count(productTrialDOLambdaQueryWrapper));
            // 待评价
            productTrialDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getUserId,productTrialDO.getUserId());
            productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getStatus, 1);
            jsonObject.put("status1", count(productTrialDOLambdaQueryWrapper));
            // 已评价
            productTrialDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getUserId,productTrialDO.getUserId());
            productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getStatus, 3);
            jsonObject.put("status3", count(productTrialDOLambdaQueryWrapper));
            return jsonObject;
        } catch (Exception e) {
            log.error("get productTrial page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 产品试用审核
     *
     * @param id
     * @param status
     */
    @Override
    public void auditProductTrial(Long id, Integer status) {
        LambdaUpdateWrapper<ProductTrialDO> lambdaUpdateWrapper = new LambdaUpdateWrapper<>();
        lambdaUpdateWrapper.eq(ProductTrialDO::getId, id);
        lambdaUpdateWrapper.set(ProductTrialDO::getStatus, status);
        update(lambdaUpdateWrapper);
    }

}
