package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.forgetfulr.common.exception.DBException;
import com.yujia.topbang.api.entity.HotSearchDO;
import com.yujia.topbang.api.entity.VideoLiveDO;
import com.yujia.topbang.api.mapper.HotSearchMapper;
import com.yujia.topbang.api.service.IHotSearchService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 热门搜索 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-09-10
 */
@Slf4j
@Service
public class HotSearchServiceImpl extends ServiceImpl<HotSearchMapper, HotSearchDO> implements IHotSearchService {

    /**
     * 热门搜索分页
     *
     * @param hotSearchDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(HotSearchDO hotSearchDO) {
                JSONObject jsonObject = new JSONObject();
        try {
                    Page<HotSearchDO> page = new Page<>();
                    page.setCurrent(hotSearchDO.getPage());
                    page.setSize(hotSearchDO.getLimit());
                    page.addOrder(OrderItem.desc("num"));
                    LambdaQueryWrapper<HotSearchDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 处理前端参数问题
            page(page, lambdaQueryWrapper);
            List<HotSearchDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get hotSearch page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

}
