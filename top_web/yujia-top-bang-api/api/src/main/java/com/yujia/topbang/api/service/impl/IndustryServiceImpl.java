package com.yujia.topbang.api.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.yujia.topbang.api.core.TreeNode;
import com.yujia.topbang.api.core.TreeUtil;
import com.yujia.topbang.api.entity.IndustryDO;
import com.yujia.topbang.api.mapper.IndustryMapper;
import com.yujia.topbang.api.service.IIndustryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 行业分类 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-09-21
 */
@Service
public class IndustryServiceImpl extends ServiceImpl<IndustryMapper, IndustryDO> implements IIndustryService {

    /**
     * 添加节点
     *
     * @param pId
     * @param code
     * @param name
     * @param content
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long addNode(Long pId, String code, String name, String content) {
        IndustryDO industryDO = new IndustryDO();
        if (pId != null) {
            // 获取父节点信息
            LambdaQueryWrapper<IndustryDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(IndustryDO::getId, pId);
            IndustryDO parentDO = getOne(lambdaQueryWrapper);
            // 根据父节点计算出新节点的左右值以及层级
            industryDO.setLId(parentDO.getRId());
            industryDO.setRId(parentDO.getRId() + 1);
            industryDO.setCurrentLevel(parentDO.getCurrentLevel() + 1);
            // 基础参数
            industryDO.setCode(code);
            industryDO.setName(name);
            industryDO.setContent(content);
            industryDO.setParentId(parentDO.getId());
            // 然后操作受影响的其他节点
            /*
            将受影响的节点左值加2
            左值>父级右值
             */
            LambdaUpdateWrapper<IndustryDO> lidUpdate = new LambdaUpdateWrapper<>();
            lidUpdate.gt(IndustryDO::getLId, parentDO.getRId());
            lidUpdate.setSql("l_id=l_id+2");
            update(lidUpdate);
            /*
            将受影响的节点右值加2
            右值>=父级右值
             */
            LambdaUpdateWrapper<IndustryDO> ridUpdate = new LambdaUpdateWrapper<>();
            ridUpdate.ge(IndustryDO::getRId, parentDO.getRId());
            ridUpdate.setSql("r_id=r_id+2");
            update(ridUpdate);
        } else {
            // 为null的情况，一般就是没数据，或者说是第一层的问题
            // 应该是找到当下最大的右值来计算？
            LambdaQueryWrapper<IndustryDO> maxRidWrapper = new LambdaQueryWrapper<>();
            maxRidWrapper.orderByDesc(IndustryDO::getRId);
            maxRidWrapper.last("limit 1");
            IndustryDO maxRid = getOne(maxRidWrapper);
            if (maxRid != null) {
                industryDO.setLId(maxRid.getRId() + 1);
                industryDO.setRId(maxRid.getRId() + 2);
            } else {
                industryDO.setLId(1L);
                industryDO.setRId(2L);
            }
            industryDO.setCurrentLevel(1);
            // 基础参数
            industryDO.setCode(code);
            industryDO.setName(name);
            industryDO.setContent(content);
            industryDO.setParentId(0L);
        }
        // 最后把该节点提交给数据库（主要防止上面两步处理受影响节点会更改当前节点数据）
        save(industryDO);
        return industryDO.getId();
    }

    /**
     * 返回行业
     *
     * @return
     */
    @Override
    public List<TreeNode> getIndustry() {
        LambdaQueryWrapper<IndustryDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.le(IndustryDO::getCurrentLevel, 3);
        List<IndustryDO> industryDOList = list(lambdaQueryWrapper);
        List<TreeNode> treeNodeList = new ArrayList<>();
        for (IndustryDO item : industryDOList) {
            TreeNode treeNode = new TreeNode();
            treeNode.setId(item.getId().toString());
            treeNode.setName(item.getName());
            treeNode.setParentId(item.getParentId().toString());
            treeNodeList.add(treeNode);
        }
        return TreeUtil.bulid(treeNodeList);
    }

    /**
     * 节点所有父节点
     *
     * @param id
     * @return
     */
    @Override
    public List<IndustryDO> getAllParentNode(Long id) {
        IndustryDO industryDO = getById(id);
        // 查询全部父节点（l_id<自己，r_id大于自己）
        LambdaQueryWrapper<IndustryDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.lt(IndustryDO::getLId, industryDO.getLId());
        lambdaQueryWrapper.gt(IndustryDO::getRId, industryDO.getRId());
        return list(lambdaQueryWrapper);
    }

    /**
     * 节点所有父节点（包含自己）
     *
     * @param id
     * @return
     */
    @Override
    public List<IndustryDO> getAllParentNodeMySelf(Long id) {
        IndustryDO industryDO = getById(id);
        // 查询全部父节点（l_id<自己，r_id大于自己）
        LambdaQueryWrapper<IndustryDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.le(IndustryDO::getLId, industryDO.getLId());
        lambdaQueryWrapper.ge(IndustryDO::getRId, industryDO.getRId());
        return list(lambdaQueryWrapper);
    }

    /**
     * 节点所有子节点（包含自己）
     *
     * @param id
     * @return
     */
    @Override
    public List<IndustryDO> getAllSonNodeMySelf(Long id) {
        IndustryDO industryDO = getById(id);
        // 查询子孙节点，包含自身（l_id大于等于自己，r_id小于等于自己）
        LambdaQueryWrapper<IndustryDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.ge(IndustryDO::getLId, industryDO.getLId());
        lambdaQueryWrapper.le(IndustryDO::getRId, industryDO.getRId());
        return list(lambdaQueryWrapper);
    }

}
