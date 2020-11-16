package com.yujia.topbang.api.service.impl;

import com.yujia.topbang.api.entity.CategoryDO;
import com.yujia.topbang.api.mapper.CategoryMapper;
import com.yujia.topbang.api.service.ICategoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-09-24
 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, CategoryDO> implements ICategoryService {

}
