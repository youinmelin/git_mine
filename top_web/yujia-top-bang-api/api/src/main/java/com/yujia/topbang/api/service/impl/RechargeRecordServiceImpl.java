package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.forgetfulr.common.exception.DBException;
import com.yujia.topbang.api.entity.RechargeRecordDO;
import com.yujia.topbang.api.entity.TagsDO;
import com.yujia.topbang.api.mapper.RechargeRecordMapper;
import com.yujia.topbang.api.service.IRechargeRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 充值记录 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-14
 */
@Slf4j
@Service
public class RechargeRecordServiceImpl extends ServiceImpl<RechargeRecordMapper, RechargeRecordDO> implements IRechargeRecordService {

    /**
     * 充值记录分页
     *
     * @param rechargeRecordDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(RechargeRecordDO rechargeRecordDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<RechargeRecordDO> page = new Page<>();
            page.setCurrent(rechargeRecordDO.getPage());
            page.setSize(rechargeRecordDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<RechargeRecordDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();

            page(page, lambdaQueryWrapper);
            List<RechargeRecordDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get rechargeRecord page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

}
