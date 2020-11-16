package com.yujia.topbang.api.controller.mgr;

import com.forgetfulr.common.core.R;
import com.forgetfulr.common.exception.UserException;
import com.yujia.topbang.api.entity.BannerDO;
import com.yujia.topbang.api.entity.BannerGroupDO;
import com.yujia.topbang.api.service.IBannerGroupService;
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
@RestController("mgrBannerController")
@RequestMapping("/api/mgr/banner")
public class BannerController {

    /**
     * banner 分组
     */
    private final IBannerGroupService bannerGroupService;

    /**
     * banner
     */
    private final IBannerService bannerService;

    /**
     * Banner 分组分页
     *
     * @return
     */
    @PostMapping(value = "/getBannerGroupList")
    public R getBannerGroupList(@RequestBody BannerGroupDO bannerGroupDO) {
        try {
            return R.ok().put("data", bannerGroupService.getMgrPageList(bannerGroupDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取全部banner分组
     *
     * @return
     */
    @PostMapping(value = "/getBannerGroup")
    public R getBannerGroup() {
        try {
            return R.ok().put("data", bannerGroupService.list());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * Banner 分组增改
     *
     * @param bannerGroupDO
     * @return
     */
    @PostMapping(value = "/bannerGroupSave")
    public R bannerGroupSave(@RequestBody BannerGroupDO bannerGroupDO) {
        try {
            bannerGroupService.bannerGroupSave(bannerGroupDO);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * Banner 分组删除
     *
     * @param id
     * @return
     */
    @PostMapping(value = "/bannerGroupDelete/{id}")
    public R bannerGroupDelete(@PathVariable Long id) {
        try {
            bannerGroupService.removeById(id);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * Banner 分页
     *
     * @return
     */
    @PostMapping(value = "/getBannerList")
    public R getBannerList(@RequestBody BannerDO bannerDO) {
        try {
            return R.ok().put("data", bannerService.getMgrPageList(bannerDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * Banner 增改
     *
     * @param bannerDO
     * @return
     */
    @PostMapping(value = "/bannerSave")
    public R bannerSave(@RequestBody BannerDO bannerDO) {
        try {
            bannerService.bannerSave(bannerDO);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * Banner审核
     *
     * @param bannerDO
     * @return
     */
    @PostMapping(value = "/auditBanner")
    public R auditBanner(@RequestBody BannerDO bannerDO) {
        try {
            bannerService.auditBanner(bannerDO);
            return R.ok();
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * Banner 删除
     *
     * @param id
     * @return
     */
    @DeleteMapping(value = "/bannerDelete/{id}")
    public R bannerDelete(@PathVariable Long id) {
        try {
            bannerService.removeById(id);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }
}
