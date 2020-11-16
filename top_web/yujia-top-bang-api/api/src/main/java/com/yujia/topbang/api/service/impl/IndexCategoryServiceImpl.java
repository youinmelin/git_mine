package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.ObjectUtil;
import com.yujia.topbang.api.entity.IndexCategoryDO;
import com.yujia.topbang.api.entity.IndustryDO;
import com.yujia.topbang.api.mapper.IndexCategoryMapper;
import com.yujia.topbang.api.service.IIndexCategoryService;
import com.yujia.topbang.api.service.IIndustryService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 首页分类 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-09-25
 */
@Slf4j
@Service
@AllArgsConstructor
public class IndexCategoryServiceImpl extends ServiceImpl<IndexCategoryMapper, IndexCategoryDO> implements IIndexCategoryService {

    private final IIndustryService industryService;

    /**
     * 首页栏目分页
     *
     * @param indexCategoryDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(IndexCategoryDO indexCategoryDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<IndexCategoryDO> page = new Page<>();
            page.setCurrent(indexCategoryDO.getPage());
            page.setSize(indexCategoryDO.getLimit());
            LambdaQueryWrapper<IndexCategoryDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 处理前端参数问题
            page(page, lambdaQueryWrapper);
            List<IndexCategoryDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get indexCategory page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 保存&修改
     *
     * @param indexCategoryDO
     */
    @Override
    public void indexCategorySave(IndexCategoryDO indexCategoryDO) {
        if (!ObjectUtil.isNullOrEmpty(indexCategoryDO.getCategoryId())) {
            StringBuilder name = new StringBuilder();
            // 获取父辈
            List<IndustryDO> industryDOList = industryService.getAllParentNodeMySelf(indexCategoryDO.getCategoryId());
            if (industryDOList != null) {
                for (IndustryDO item : industryDOList) {
                    name.append(item.getName());
                    name.append(" >> ");
                }
            }
            indexCategoryDO.setCategoryName(name.toString());
            saveOrUpdate(indexCategoryDO);
        } else {
            throw new UserException("请输入正确的ID");
        }
    }
}
