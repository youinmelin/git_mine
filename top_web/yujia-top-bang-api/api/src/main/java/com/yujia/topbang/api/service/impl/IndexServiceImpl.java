package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.forgetfulr.common.utils.DateUtil;
import com.yujia.topbang.api.entity.*;
import com.yujia.topbang.api.service.*;
import com.yujia.topbang.api.utils.FFmpegUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * 首页
 *
 * @author caorui
 * @date 2020-09-08 15:13
 * Revision History
 * Date      		Programmer       Notes
 * 2020-09-08   	 caorui		     Initial
 */
@Slf4j
@Service
@AllArgsConstructor
public class IndexServiceImpl implements IIndexService {

    // 热门搜索
    private final IHotSearchService hotSearchService;
    // banner
    private final IBannerService bannerService;
    // 产品
    private final IProductService productService;
    // 直播
    private final IVideoLiveService videoLiveService;
    // Index栏目
    private final IIndexCategoryService indexCategoryService;
    // 行业
    private final IIndustryService industryService;

    private static final String LIMIT_5 = "limit 5";

    /**
     * 首页大接口
     *
     * @return
     */
    @Override
    public JSONObject index() {
        JSONObject jsonObject = new JSONObject();
        /*
        热门搜索
         */
        LambdaQueryWrapper<HotSearchDO> hotSearchDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        hotSearchDOLambdaQueryWrapper.orderByAsc(HotSearchDO::getSort);
        hotSearchDOLambdaQueryWrapper.orderByDesc(HotSearchDO::getNum);
        hotSearchDOLambdaQueryWrapper.last(LIMIT_5);
        jsonObject.put("hotSearchList", hotSearchService.list(hotSearchDOLambdaQueryWrapper));
        /*
         首页banner
         */
        LambdaQueryWrapper<BannerDO> bannerDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 默认首页banner
        bannerDOLambdaQueryWrapper.eq(BannerDO::getGroupId, 0);
        // 到期时间内
        bannerDOLambdaQueryWrapper.gt(BannerDO::getGmtDue, DateUtil.getDate());
        // 显示中
        bannerDOLambdaQueryWrapper.eq(BannerDO::getUsed, 1);
        // 审核通过
        bannerDOLambdaQueryWrapper.eq(BannerDO::getStatus, 1);
        jsonObject.put("bannerList", bannerService.list(bannerDOLambdaQueryWrapper));
        /*
        为您精选
         */
        LambdaQueryWrapper<ProductDO> selectedLambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 发布中才显示
        selectedLambdaQueryWrapper.eq(ProductDO::getStatus, 1);
        selectedLambdaQueryWrapper.orderByDesc(ProductDO::getId);
        selectedLambdaQueryWrapper.last("limit 10");
        List<ProductDO> selectedList = productService.list(selectedLambdaQueryWrapper);
        for (ProductDO item : selectedList) {
            item.setStrDuration(FFmpegUtil.secToTime(item.getDuration()));
        }
        jsonObject.put("selectedList", selectedList);
        /*
        几个行业分类产品
        获取后台配置好的栏目，返回到前端
         */
        LambdaQueryWrapper<IndexCategoryDO> indexCategoryDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        indexCategoryDOLambdaQueryWrapper.orderByAsc(IndexCategoryDO::getSort);
        List<IndexCategoryDO> indexCategoryDOList = indexCategoryService.list(indexCategoryDOLambdaQueryWrapper);
        JSONObject itemJson = new JSONObject();
        int i = 0;
        for (IndexCategoryDO item : indexCategoryDOList) {
            LambdaQueryWrapper<ProductDO> productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 这里要去找到合适的ID
            List<IndustryDO> industryDOS = industryService.getAllSonNodeMySelf(item.getCategoryId());
            Collection<Integer> industryIds = new ArrayList<>();
            if (industryDOS != null && !industryDOS.isEmpty()) {
                for (IndustryDO ii : industryDOS) {
                    industryIds.add(Integer.parseInt(ii.getId().toString()));
                }
            }
            productDOLambdaQueryWrapper.in(ProductDO::getIndustryId, industryIds);
            productDOLambdaQueryWrapper.eq(ProductDO::getStatus, 1);
            productDOLambdaQueryWrapper.orderByDesc(ProductDO::getId);
            productDOLambdaQueryWrapper.last("limit 6");
            List<ProductDO> productDOS = productService.list(productDOLambdaQueryWrapper);
            for (ProductDO productDO : productDOS) {
                productDO.setStrDuration(FFmpegUtil.secToTime(productDO.getDuration()));
            }
            // 这里还需要填充一些别的内容进去
            IndustryDO industryDO = industryService.getById(item.getCategoryId());
            JSONObject jj = new JSONObject();
            jj.put("list", productDOS);
            jj.put("id", industryDO.getId());
            jj.put("name", industryDO.getName());
            jj.put("content", industryDO.getContent());
            itemJson.put("item" + i, jj);
            i++;
        }
        jsonObject.put("indexCategoryList", itemJson);
        /*
        热销TOP 5
         */
        // 先随便找5个产品
        LambdaQueryWrapper<ProductDO> hotSaleLambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 发布中才显示
        hotSaleLambdaQueryWrapper.eq(ProductDO::getStatus, 1);
        hotSaleLambdaQueryWrapper.orderByDesc(ProductDO::getId);
        hotSaleLambdaQueryWrapper.last(LIMIT_5);
        List<ProductDO> hotSaleListFive = productService.list(hotSaleLambdaQueryWrapper);
        for (ProductDO item : hotSaleListFive) {
            item.setStrDuration(FFmpegUtil.secToTime(item.getDuration()));
        }
        jsonObject.put("hotSaleListFive", hotSaleListFive);
        /*
        新品 6
         */
        LambdaQueryWrapper<ProductDO> newSixLambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 发布中才显示
        newSixLambdaQueryWrapper.eq(ProductDO::getStatus, 1);
        newSixLambdaQueryWrapper.orderByDesc(ProductDO::getId);
        newSixLambdaQueryWrapper.last("limit 6");
        List<ProductDO> newListSix = productService.list(newSixLambdaQueryWrapper);
        for (ProductDO item : newListSix) {
            item.setStrDuration(FFmpegUtil.secToTime(item.getDuration()));
        }
        jsonObject.put("newListSix", newListSix);
        /*
        直播 5
         */
        LambdaQueryWrapper<VideoLiveDO> videoLiveDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 发布中才显示
        videoLiveDOLambdaQueryWrapper.eq(VideoLiveDO::getStatus, 1);
        videoLiveDOLambdaQueryWrapper.orderByDesc(VideoLiveDO::getId);
        videoLiveDOLambdaQueryWrapper.last(LIMIT_5);
        jsonObject.put("videoLiveList", videoLiveService.list(videoLiveDOLambdaQueryWrapper));

        return jsonObject;
    }

    /**
     * 单独获取首页分类
     *
     * @return
     */
    @Override
    public List<IndexCategoryDO> getIndexCategory() {
        LambdaQueryWrapper<IndexCategoryDO> indexCategoryDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        indexCategoryDOLambdaQueryWrapper.orderByAsc(IndexCategoryDO::getSort);
        List<IndexCategoryDO> indexCategoryDOList = indexCategoryService.list(indexCategoryDOLambdaQueryWrapper);
        if (indexCategoryDOList != null && !indexCategoryDOList.isEmpty()) {
            // 由于这里为了照顾后台管理显示，没有冗余分类名，这里需要单独查询获取，并替换掉显示到后台的内容为前端内容输出
            for (IndexCategoryDO item : indexCategoryDOList) {
                IndustryDO industryDO = industryService.getById(item.getCategoryId());
                if (industryDO != null) {
                    item.setCategoryName(industryDO.getName());
                }
            }
        }
        return indexCategoryDOList;
    }
}
