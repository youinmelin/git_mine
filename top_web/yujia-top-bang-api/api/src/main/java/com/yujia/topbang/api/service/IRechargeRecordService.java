package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSONObject;
import com.yujia.topbang.api.entity.RechargeRecordDO;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 充值记录 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-08-14
 */
public interface IRechargeRecordService extends IService<RechargeRecordDO> {

    /**
     * 充值记录分页
     *
     * @param rechargeRecordDO
     * @return
     */
    JSONObject getMgrPageList(RechargeRecordDO rechargeRecordDO);

}
