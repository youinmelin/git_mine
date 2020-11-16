package com.yujia.topbang.api.controller.web;

import com.forgetfulr.common.core.R;
import com.forgetfulr.common.utils.SystemUtil;
import com.yujia.topbang.api.service.IProductService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 管理中心首页
 *
 * @author caorui
 * @date 2020-08-06 15:58
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-06   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("webManageController")
@RequestMapping("/api/web/manage")
public class ManageController {

    /**
     * 产品
     */
    private final IProductService productService;

    /**
     * 卖家中心首页
     *
     * @return
     */
    @GetMapping(value = "/getSellerIndex")
    public R getSellerIndex() {
        try {
            Long userId = SystemUtil.appUserId();
            return R.ok().put("data", productService.getSellerIndex(userId));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 买家中心首页
     *
     * @return
     */
    @GetMapping(value = "/getBuyerIndex")
    public R getBuyerIndex() {
        try {
            Long userId = SystemUtil.appUserId();
            return R.ok().put("data", productService.getBuyerIndex(userId));
        } catch (Exception e) {
            return R.error();
        }
    }
}
