package com.yujia.topbang.api.controller.web;

import com.forgetfulr.common.core.R;
import com.forgetfulr.common.utils.SystemUtil;
import com.yujia.topbang.api.entity.BannerDO;
import com.yujia.topbang.api.service.IBannerService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * Banner
 *
 * @author caorui
 * @date 2020-08-06 15:58
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-06   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("webBannerController")
@RequestMapping("/api/web/banner")
public class BannerController {

    /**
     * banner
     */
    private final IBannerService bannerService;

    /**
     * Banner 购买
     *
     * @param bannerDO
     * @return
     */
    @PutMapping(value = "/buyBanner")
    public R buyBanner(@RequestBody BannerDO bannerDO) {
        try {
            // 这里要获取用户信息
            Long userId = SystemUtil.appUserId();
            bannerDO.setUserId(userId);
            bannerService.buyBanner(bannerDO);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取banner列表
     * 改成GET传参不传参都会报错"ERROR" dispatch for GET "/error?XXX=1", parameters={masked}
     * 可以使用POST方式传递如：{"page":2,"limit":5}
     * @return
     */
    @PostMapping(value = "/marketBannerList")
    public R marketBannerList( @RequestBody BannerDO bannerDO) {
        try {
            return R.ok().put("data", bannerService.marketBannerList(bannerDO));
        } catch (Exception e) {
            return R.error();
        }
    }
}
