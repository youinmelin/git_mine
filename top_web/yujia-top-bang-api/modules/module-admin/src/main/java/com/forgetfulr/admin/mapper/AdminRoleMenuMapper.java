package com.forgetfulr.admin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.forgetfulr.admin.entity.AdminRoleMenuDO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 后台角色权限 Mapper 接口
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
public interface AdminRoleMenuMapper extends BaseMapper<AdminRoleMenuDO> {

    /**
     * 查询角色菜单IDs
     *
     * @param roleId
     * @return
     */
    List<Long> getMenuIds(@Param("roleId") Long roleId);

    /**
     * 批量删除
     *
     * @param roleId
     * @param ids
     */
    void batchDelete(@Param("roleId") Long roleId, @Param("list") List<Long> ids);

    /**
     * 批量查询
     *
     * @param roleId
     * @param ids
     * @return
     */
    List<AdminRoleMenuDO> batchSelect(@Param("roleId") Long roleId, @Param("list") List<Long> ids);

    /**
     * 批量插入
     *
     * @param adminRoleMenuDOList
     * @return
     */
    int batchInsert(List<AdminRoleMenuDO> adminRoleMenuDOList);

    /**
     * 批量恢复已删除数据
     *
     * @param roleId
     * @param ids
     * @return
     */
    List<AdminRoleMenuDO> batchRecovery(@Param("roleId") Long roleId, @Param("list") List<Long> ids);

}
