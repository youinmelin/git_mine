package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.utils.DateUtil;
import com.forgetfulr.common.utils.ObjectUtil;
import com.yujia.topbang.api.entity.PostsDO;
import com.yujia.topbang.api.mapper.PostsMapper;
import com.yujia.topbang.api.service.IPostsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 文章 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-09-24
 */
@Slf4j
@Service
public class PostsServiceImpl extends ServiceImpl<PostsMapper, PostsDO> implements IPostsService {

    /**
     * 文章分页
     *
     * @param postsDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(PostsDO postsDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<PostsDO> page = new Page<>();
            page.setCurrent(postsDO.getPage());
            page.setSize(postsDO.getLimit());
            LambdaQueryWrapper<PostsDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 标题
            if (!ObjectUtil.isNullOrEmpty(postsDO.getTitle())) {
                lambdaQueryWrapper.like(PostsDO::getTitle, postsDO.getTitle());
            }
            page(page, lambdaQueryWrapper);
            List<PostsDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get posts page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 文章 增改
     *
     * @param postsDO
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void postsSave(PostsDO postsDO) {
        if (ObjectUtil.isNullOrEmpty(postsDO.getPublishAt())) {
            postsDO.setPublishAt(DateUtil.getDate());
        }
        saveOrUpdate(postsDO);
    }

    //region 前端相关

    /**
     * 文章前端分页
     *
     * @param postsDO
     * @return
     */
    @Override
    public JSONObject getWebPageList(PostsDO postsDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<PostsDO> page = new Page<>();
            page.setCurrent(postsDO.getPage());
            page.setSize(postsDO.getLimit());
            LambdaQueryWrapper<PostsDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 标题
            if (!ObjectUtil.isNullOrEmpty(postsDO.getTitle())) {
                lambdaQueryWrapper.like(PostsDO::getTitle, postsDO.getTitle());
            }
            // 分类（先固定）
            if (!ObjectUtil.isNullOrEmpty(postsDO.getCategoryId())) {
                lambdaQueryWrapper.eq(PostsDO::getCategoryId, postsDO.getCategoryId());
            }
            page(page, lambdaQueryWrapper);
            List<PostsDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get webPosts page list error:{}", e.getMessage());
            throw new DBException();
        }
    }
    //endregion

}
