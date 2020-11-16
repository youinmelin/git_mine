package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.ObjectUtil;
import com.yujia.topbang.api.entity.UserCardDO;
import com.yujia.topbang.api.mapper.UserCardMapper;
import com.yujia.topbang.api.service.IUserCardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 用户证件表 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-09-02
 */
@Slf4j
@Service
public class UserCardServiceImpl extends ServiceImpl<UserCardMapper, UserCardDO> implements IUserCardService {

    /**
     * 用户实名信息
     *
     * @param userCardDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(UserCardDO userCardDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<UserCardDO> page = new Page<>();
            page.setCurrent(userCardDO.getPage());
            page.setSize(userCardDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<UserCardDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 处理前端参数问题
            if (ObjectUtil.isNullOrEmpty(userCardDO.getUserId())) {
                userCardDO.setUserId(null);
            }
            if (ObjectUtil.isNullOrEmpty(userCardDO.getName())) {
                userCardDO.setName(null);
            }
            page(page, lambdaQueryWrapper);
            List<UserCardDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get userCard page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 用户实名信息审核
     *
     * @param userCardDO
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void auditUserCard(UserCardDO userCardDO) {
        if (ObjectUtil.isNullOrEmpty(userCardDO.getId())) {
            throw new UserException("ID不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(userCardDO.getStatus())) {
            throw new UserException("审核状态不能为空");
        }
        // 先找到这条记录
        UserCardDO userCardModel = getById(userCardDO.getId());
        if (userCardModel == null) {
            throw new UserException("未找到待审核的实名信息");
        }
        // 先修改当前记录
        updateById(userCardDO);
    }

}
