package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.forgetfulr.common.exception.DBException;
import com.yujia.topbang.api.entity.ProductDO;
import com.yujia.topbang.api.entity.TagsDO;
import com.yujia.topbang.api.mapper.TagsMapper;
import com.yujia.topbang.api.service.ITagsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 标签 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-10
 */
@Slf4j
@Service
public class TagsServiceImpl extends ServiceImpl<TagsMapper, TagsDO> implements ITagsService {

    /**
     * 标签分页
     *
     * @param tagsDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(TagsDO tagsDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<TagsDO> page = new Page<>();
            page.setCurrent(tagsDO.getPage());
            page.setSize(tagsDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<TagsDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();

            page(page, lambdaQueryWrapper);
            List<TagsDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get tags page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

}
