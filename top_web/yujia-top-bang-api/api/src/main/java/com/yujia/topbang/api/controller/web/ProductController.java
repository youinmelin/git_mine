package com.yujia.topbang.api.controller.web;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.forgetfulr.common.core.R;
import com.forgetfulr.common.enums.errorcode.UserErrorEnum;
import com.forgetfulr.common.exception.ParamException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.SystemUtil;
import com.yujia.topbang.api.entity.*;
import com.yujia.topbang.api.service.*;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 产品
 *
 * @author caorui
 * @date 2020-08-31 17:29
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-31   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("webProductController")
@RequestMapping("/api/web/product")
public class ProductController {

    /**
     * 产品管理
     */
    private final IProductService productService;

    /**
     * 产品试用
     */
    private final IProductTrialService productTrialService;

    /**
     * 产品评价
     */
    private final IProductEvaluateService productEvaluateService;

    /**
     * 直播管理
     */
    private final IVideoLiveService videoLiveService;

    /**
     * 热门搜索
     */
    private final IHotSearchService hotSearchService;

    /**
     * 浏览记录
     */
    private final IUserProductBrowseHistoryService userProductBrowseHistoryService;

    /**
     * 收藏记录
     */
    private final IUserProductCollectionService userProductCollectionService;

    //region 产品管理

    // 产品提交
    @PostMapping(value = "/releaseProduct")
    public R realName(@RequestBody ProductDO productDO) {
        try {
            // 这里要获取用户信息
            Long userId = SystemUtil.appUserId();
            productDO.setUserId(userId);
            productService.releaseProduct(productDO);
            return R.ok();
        } catch (UserException | ParamException e) {
            return R.error(1, e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取产品列表
     *
     * @return
     */
    @PostMapping(value = "/getProductList")
    public R getProductList(@RequestBody ProductDO productDO) {
        try {
            Long userId = SystemUtil.appUserId();
            productDO.setUserId(userId);
            return R.ok().put("data", productService.getWebPageList(productDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取产品详情
     *
     * @param prodId
     * @return
     */
    @GetMapping(value = "/getProductInfo/{prodId}")
    public R getProductInfo(@PathVariable Long prodId) {
        try {
            // 有用户ID就记一笔，没有就算了
            Long userId = SystemUtil.appUserId();
            if (userId != null && userId > 0) {
                UserProductBrowseHistoryDO historyDO = new UserProductBrowseHistoryDO();
                historyDO.setUserId(userId);
                historyDO.setProdId(prodId);
                LambdaUpdateWrapper<UserProductBrowseHistoryDO> updateWrapper = new LambdaUpdateWrapper<>();
                updateWrapper.eq(UserProductBrowseHistoryDO::getUserId, userId);
                updateWrapper.eq(UserProductBrowseHistoryDO::getProdId, prodId);
                userProductBrowseHistoryService.saveOrUpdate(historyDO, updateWrapper);
            }
            return R.ok().put("data", productService.getProductInfo(prodId));
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 编辑时获取产品详情
     *
     * @param prodId
     * @return
     */
    @GetMapping(value = "/getEditProductInfo/{prodId}")
    public R getEditProductInfo(@PathVariable Long prodId) {
        try {
            return R.ok().put("data", productService.getEditProductInfo(prodId));
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 产品试用申请
     *
     * @param prodId
     * @return
     */
    @GetMapping(value = "/productGiveTrial/{prodId}")
    public R productGiveTrial(@PathVariable Long prodId) {
        try {
            Long userId = SystemUtil.appUserId();
            productService.productGiveTrial(prodId, userId);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取产品试用列表
     *
     * @return
     */
    @PostMapping(value = "/getProductTrialList")
    public R getProductTrialList(@RequestBody ProductTrialDO productTrialDO) {
        try {
            Long userId = SystemUtil.appUserId();
            productTrialDO.setUserId(userId);
            return R.ok().put("data", productTrialService.getWebPageList(productTrialDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 产品试用审核
     *
     * @param productTrialDO
     * @return
     */
    @PostMapping(value = "/auditProductTrial")
    public R auditProductTrial(@RequestBody ProductTrialDO productTrialDO) {
        try {
            productTrialService.auditProductTrial(productTrialDO.getId(), productTrialDO.getStatus());
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 产品评价
     *
     * @param productEvaluateDO
     * @return
     */
    @PostMapping(value = "/productEvaluate")
    public R productEvaluate(@RequestBody ProductEvaluateDO productEvaluateDO) {
        try {
            Long userId = SystemUtil.appUserId();
            productEvaluateDO.setUserId(userId);
            productEvaluateService.productEvaluate(productEvaluateDO);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 产品评价分页
     * 由于有分页，这里最好还是独立写，不要和大接口放在一起
     *
     * @param productEvaluateDO
     * @return
     */
    @PostMapping(value = "/getWebPageProductEvaluate")
    public R getWebPageProductEvaluate(@RequestBody ProductEvaluateDO productEvaluateDO) {
        try {
            return R.ok().put("data", productEvaluateService.getWebPageProductEvaluate(productEvaluateDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 产品评价分页
     *
     * @param productEvaluateDO
     * @return
     */
    @PostMapping(value = "/getProductEvaluateList")
    public R getProductEvaluateList(@RequestBody ProductEvaluateDO productEvaluateDO) {
        try {
            Long userId = SystemUtil.appUserId();
            productEvaluateDO.setUserId(userId);
            return R.ok().put("data", productEvaluateService.getWebPageProductEvaluate(productEvaluateDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 删除产品
     *
     * @param prodId
     * @return
     */
    @GetMapping(value = "/deleteProduct/{prodId}")
    public R deleteProduct(@PathVariable Long prodId) {
        try {
            // 这里需要校验用户
            Long userId = SystemUtil.appUserId();
            productService.deleteProduct(userId, prodId);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    //region 直播管理

    // 发布直播
    @PostMapping(value = "/releaseVideoLive")
    public R releaseVideoLive(@RequestBody VideoLiveDO videoLiveDO) {
        try {
            // 这里要获取用户信息
            Long userId = SystemUtil.appUserId();
            videoLiveDO.setUserId(userId);
            return R.ok().put("data", videoLiveService.save(videoLiveDO));
        } catch (UserException | ParamException e) {
            return R.error(1, e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取直播列表
     *
     * @return
     */
    @PostMapping(value = "/getVideoLiveList")
    public R getVideoLiveList(@RequestBody VideoLiveDO videoLiveDO) {
        try {
            Long userId = SystemUtil.appUserId();
            videoLiveDO.setUserId(userId);
            return R.ok().put("data", videoLiveService.getWebPageList(videoLiveDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取直播详情
     *
     * @param videoLiveId
     * @return
     */
    @GetMapping(value = "/getVideoLiveInfo/{videoLiveId}")
    public R getVideoLiveInfo(@PathVariable Long videoLiveId) {
        try {
            return R.ok().put("data", videoLiveService.getVideoLiveInfo(videoLiveId));
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 删除直播
     *
     * @param videoLiveId
     * @return
     */
    @GetMapping(value = "/deleteVideoLive/{videoLiveId}")
    public R deleteVideoLive(@PathVariable Long videoLiveId) {
        try {
            // 这里需要校验用户
            Long userId = SystemUtil.appUserId();
            videoLiveService.deleteVideoLive(userId, videoLiveId);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    //region 产品浏览记录分页

    /**
     * 产品浏览记录分页
     *
     * @param userProductBrowseHistoryDO
     * @return
     */
    @PostMapping(value = "/getProductHistoryList")
    public R getProductHistoryList(@RequestBody UserProductBrowseHistoryDO userProductBrowseHistoryDO) {
        try {
            Long userId = SystemUtil.appUserId();
            userProductBrowseHistoryDO.setUserId(userId);
            return R.ok().put("data", productService.getWebProductHistoryList(userProductBrowseHistoryDO));
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion


    //region 产品收藏

    /**
     * 产品收藏分页
     *
     * @param userProductCollectionDO
     * @return
     */
    @PostMapping(value = "/getProductCollectionList")
    public R getWebProductCollectionList(@RequestBody UserProductCollectionDO userProductCollectionDO) {
        try {
            Long userId = SystemUtil.appUserId();
            userProductCollectionDO.setUserId(userId);
            return R.ok().put("data", productService.getWebProductCollectionList(userProductCollectionDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 产品收藏
     * 这里应该写到service层去
     *
     * @param prodId
     * @return
     */
    @GetMapping(value = "/productCollection/{prodId}")
    public R productCollection(@PathVariable Long prodId) {
        try {
            Long userId = SystemUtil.appUserId();
            if (userId != null && userId > 0) {
                UserProductCollectionDO collectionDO = new UserProductCollectionDO();
                collectionDO.setUserId(userId);
                collectionDO.setProdId(prodId);
                LambdaUpdateWrapper<UserProductCollectionDO> updateWrapper = new LambdaUpdateWrapper<>();
                updateWrapper.eq(UserProductCollectionDO::getUserId, userId);
                updateWrapper.eq(UserProductCollectionDO::getProdId, prodId);
                userProductCollectionService.saveOrUpdate(collectionDO, updateWrapper);
                return R.ok();
            } else {
                throw new UserException(UserErrorEnum.notLoginOrExpired);
            }
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    /**
     * 获取行业内容
     *
     * @param id
     * @return
     */
    @GetMapping(value = "/getIndustryProdList/{id}")
    public R getIndustryProdList(@PathVariable Long id) {
        try {
            return R.ok().put("data", productService.getIndustryProdList(id));
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

}
