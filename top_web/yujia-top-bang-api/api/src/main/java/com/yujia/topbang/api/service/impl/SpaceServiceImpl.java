package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.forgetfulr.common.exception.DBException;
import com.yujia.topbang.api.entity.SpaceDO;
import com.yujia.topbang.api.entity.TagsDO;
import com.yujia.topbang.api.mapper.SpaceMapper;
import com.yujia.topbang.api.service.ISpaceService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 空间管理 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-14
 */
@Slf4j
@Service
public class SpaceServiceImpl extends ServiceImpl<SpaceMapper, SpaceDO> implements ISpaceService {

    /**
     * 空间管理分页
     *
     * @param spaceDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(SpaceDO spaceDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<SpaceDO> page = new Page<>();
            page.setCurrent(spaceDO.getPage());
            page.setSize(spaceDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<SpaceDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();

            page(page, lambdaQueryWrapper);
            List<SpaceDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get space page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

}
