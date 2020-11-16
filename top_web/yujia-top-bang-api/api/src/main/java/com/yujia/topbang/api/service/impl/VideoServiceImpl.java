package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.forgetfulr.common.exception.DBException;
import com.yujia.topbang.api.entity.TagsDO;
import com.yujia.topbang.api.entity.VideoDO;
import com.yujia.topbang.api.mapper.VideoMapper;
import com.yujia.topbang.api.service.IVideoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 视频管理 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-14
 */
@Slf4j
@Service
public class VideoServiceImpl extends ServiceImpl<VideoMapper, VideoDO> implements IVideoService {

    /**
     * 视频管理分页
     *
     * @param videoDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(VideoDO videoDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<VideoDO> page = new Page<>();
            page.setCurrent(videoDO.getPage());
            page.setSize(videoDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<VideoDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();

            page(page, lambdaQueryWrapper);
            List<VideoDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get video page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

}
