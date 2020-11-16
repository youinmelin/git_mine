package com.yujia.topbang.api.controller.mgr;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.forgetfulr.common.core.R;
import com.forgetfulr.common.exception.UserException;
import com.yujia.topbang.api.entity.*;
import com.yujia.topbang.api.service.*;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 产品
 *
 * @author caorui
 * @date 2020-08-07 16:00
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-07   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("mgrProductController")
@RequestMapping("/api/mgr/product")
public class ProductController {

    /**
     * 产品管理
     */
    private final IProductService productService;

    /**
     * 产品评价
     */
    private final IProductEvaluateService productEvaluateService;

    /**
     * 标签管理
     */
    private final ITagsService tagsService;

    /**
     * 空间管理
     */
    private final ISpaceService spaceService;

    /**
     * 视频管理
     */
    private final IVideoService videoService;

    /**
     * 直播管理
     */
    private final IVideoLiveService videoLiveService;

    /**
     * 热门搜索
     */
    private final IHotSearchService hotSearchService;

    /**
     * 首页栏目
     */
    private final IIndexCategoryService indexCategoryService;

    /**
     * 行业栏目
     */
    private final IIndustryService industryService;

    //region 产品管理

    /**
     * 获取产品列表
     *
     * @return
     */
    @PostMapping(value = "/getProductList")
    public R getProductList(@RequestBody ProductDO productDO) {
        try {
            return R.ok().put("data", productService.getMgrPageList(productDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 产品审核
     *
     * @param productDO
     * @return
     */
    @PostMapping(value = "/auditProduct")
    public R auditProduct(@RequestBody ProductDO productDO) {
        try {
            productService.auditProduct(productDO);
            return R.ok();
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion


    //region 产品评价管理

    /**
     * 产品评价列表
     *
     * @param productEvaluateDO
     * @return
     */
    @PostMapping(value = "/getProductEvaluateList")
    public R getProductEvaluateList(@RequestBody ProductEvaluateDO productEvaluateDO) {
        try {
            return R.ok().put("data", productEvaluateService.getMgrPageList(productEvaluateDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 产品评价删除
     *
     * @param id
     * @return
     */
    @DeleteMapping(value = "/productEvaluateDelete/{id}")
    public R productEvaluateDelete(@PathVariable Long id) {
        try {
            productEvaluateService.removeById(id);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    //region 标签管理

    /**
     * 标签列表
     *
     * @return
     */
    @PostMapping(value = "/getTagList")
    public R getTagList(@RequestBody TagsDO tagsDO) {
        try {
            return R.ok().put("data", tagsService.getMgrPageList(tagsDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 标签 增改
     *
     * @param tagsDO
     * @return
     */
    @PostMapping(value = "/tagSave")
    public R tagSave(@RequestBody TagsDO tagsDO) {
        try {
            tagsService.saveOrUpdate(tagsDO);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 标签删除
     *
     * @param id
     * @return
     */
    @DeleteMapping(value = "/tagDelete/{id}")
    public R tagDelete(@PathVariable Long id) {
        try {
            tagsService.removeById(id);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    //region 空间管理

    /**
     * 空间列表
     *
     * @return
     */
    @PostMapping(value = "/getSpaceList")
    public R getSpaceList(@RequestBody SpaceDO spaceDO) {
        try {
            return R.ok().put("data", spaceService.getMgrPageList(spaceDO));
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    //region 视频管理

    /**
     * 视频列表
     *
     * @return
     */
    @PostMapping(value = "/getVideoList")
    public R getVideoList(@RequestBody VideoDO videoDO) {
        try {
            return R.ok().put("data", videoService.getMgrPageList(videoDO));
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    //region 直播管理

    /**
     * 直播列表
     *
     * @return
     */
    @PostMapping(value = "/getVideoLiveList")
    public R getVideoLiveList(@RequestBody VideoLiveDO videoLiveDO) {
        try {
            return R.ok().put("data", videoLiveService.getMgrPageList(videoLiveDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 直播审核
     *
     * @param videoLiveDO
     * @return
     */
    @PostMapping(value = "/auditVideoLive")
    public R auditVideoLive(@RequestBody VideoLiveDO videoLiveDO) {
        try {
            videoLiveService.auditVideoLive(videoLiveDO);
            return R.ok();
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    //region 热门搜索

    /**
     * 获取热门搜索列表
     *
     * @return
     */
    @PostMapping(value = "/getHotSearchList")
    public R getHotSearchList(@RequestBody HotSearchDO hotSearchDO) {
        try {
            return R.ok().put("data", hotSearchService.getMgrPageList(hotSearchDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 热门搜索 增改
     *
     * @param hotSearchDO
     * @return
     */
    @PostMapping(value = "/hotSearchSave")
    public R hotSearchSave(@RequestBody HotSearchDO hotSearchDO) {
        try {
            hotSearchService.saveOrUpdate(hotSearchDO);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    //region 首页栏目

    /**
     * 首页栏目分页
     *
     * @return
     */
    @PostMapping(value = "/getIndexCategoryList")
    public R getIndexCategoryList(@RequestBody IndexCategoryDO indexCategoryDO) {
        try {
            return R.ok().put("data", indexCategoryService.getMgrPageList(indexCategoryDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 首页栏目增改
     *
     * @param indexCategoryDO
     * @return
     */
    @PostMapping(value = "/indexCategorySave")
    public R indexCategorySave(@RequestBody IndexCategoryDO indexCategoryDO) {
        try {
            indexCategoryService.indexCategorySave(indexCategoryDO);
            return R.ok();
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 首页栏目删除
     *
     * @param id
     * @return
     */
    @DeleteMapping(value = "/indexCategoryDelete/{id}")
    public R indexCategoryDelete(@PathVariable Long id) {
        try {
            indexCategoryService.removeById(id);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 首页栏目查询
     *
     * @return
     */
    @GetMapping(value = "/getIndexCategory")
    public R getIndexCategory() {
        try {
            LambdaQueryWrapper<IndustryDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 暂时只返回第一级
            lambdaQueryWrapper.eq(IndustryDO::getCurrentLevel, 1);
            return R.ok().put("data", industryService.list(lambdaQueryWrapper));
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

}
