package com.yujia.topbang.api.controller.mgr;

import com.forgetfulr.common.core.R;
import com.yujia.topbang.api.entity.RechargeRecordDO;
import com.yujia.topbang.api.service.IRechargeRecordService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * 支付
 *
 * @author caorui
 * @date 2020-08-07 16:00
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-07   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("mgrPaymentController")
@RequestMapping("/api/mgr/payment")
public class PaymentController {

    /**
     * 充值记录
     */
    private final IRechargeRecordService rechargeRecordService;

    //region 充值记录

    /**
     * 充值记录列表
     *
     * @return
     */
    @RequestMapping(value = "/getRechargeRecordList", method = RequestMethod.POST)
    public R getRechargeRecordList(@RequestBody RechargeRecordDO rechargeRecordDO) {
        try {
            return R.ok().put("data", rechargeRecordService.getMgrPageList(rechargeRecordDO));
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

}
