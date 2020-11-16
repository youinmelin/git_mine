package com.yujia.topbang.api.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.yujia.topbang.api.core.TreeNode;
import com.yujia.topbang.api.entity.IndustryDO;

import java.util.List;

/**
 * <p>
 * 行业分类 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-09-21
 */
public interface IIndustryService extends IService<IndustryDO> {

    /**
     * 添加节点
     *
     * @param pId
     * @param code
     * @param name
     * @param content
     */
    Long addNode(Long pId, String code, String name, String content);

    /**
     * 返回行业
     *
     * @return
     */
    List<TreeNode> getIndustry();

    /**
     * 节点所有父节点
     *
     * @param id
     * @return
     */
    List<IndustryDO> getAllParentNode(Long id);

    /**
     * 节点所有父节点（包含自己）
     *
     * @param id
     * @return
     */
    List<IndustryDO> getAllParentNodeMySelf(Long id);

    /**
     * 节点所有子节点（包含自己）
     *
     * @param id
     * @return
     */
    List<IndustryDO> getAllSonNodeMySelf(Long id);

}
