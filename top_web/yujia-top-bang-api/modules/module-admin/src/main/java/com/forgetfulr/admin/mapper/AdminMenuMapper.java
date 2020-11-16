package com.forgetfulr.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.forgetfulr.admin.entity.AdminMenuDO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 后台权限列表 Mapper 接口
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
public interface AdminMenuMapper extends BaseMapper<AdminMenuDO> {

    /**
     * 批量查询
     *
     * @param ids
     * @return
     */
    List<AdminMenuDO> batchSelect(@Param("list") List<Long> ids);

}
