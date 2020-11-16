package com.yujia.topbang.api.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yujia.topbang.api.entity.ProductEvaluateDO;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 产品评价 Mapper 接口
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
public interface ProductEvaluateMapper extends BaseMapper<ProductEvaluateDO> {

    /**
     * 获取产品评价均分
     *
     * @param prodId
     * @return
     */
    Long getProductScore(@Param("prodId") Long prodId);

}
