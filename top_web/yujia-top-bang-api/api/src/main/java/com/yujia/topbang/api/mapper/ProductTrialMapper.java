package com.yujia.topbang.api.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yujia.topbang.api.entity.ProductTrialDO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 产品试用 Mapper 接口
 * </p>
 *
 * @author caorui
 * @since 2020-09-07
 */
public interface ProductTrialMapper extends BaseMapper<ProductTrialDO> {

    IPage<ProductTrialDO> getProductTrialInfo(Page<?> page
            , @Param("userId") Long userId
            , @Param("status") Integer status
            , @Param("strSearch") String strSearch);

}
