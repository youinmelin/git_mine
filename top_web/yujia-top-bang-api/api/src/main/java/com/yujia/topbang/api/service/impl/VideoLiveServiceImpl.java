package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.ObjectUtil;
import com.yujia.topbang.api.entity.ProductDO;
import com.yujia.topbang.api.entity.VideoLiveApplyIndustryDO;
import com.yujia.topbang.api.entity.VideoLiveDO;
import com.yujia.topbang.api.mapper.VideoLiveMapper;
import com.yujia.topbang.api.service.IIndustryService;
import com.yujia.topbang.api.service.IProductService;
import com.yujia.topbang.api.service.IVideoLiveApplyIndustryService;
import com.yujia.topbang.api.service.IVideoLiveService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 视频直播 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-09-05
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class VideoLiveServiceImpl extends ServiceImpl<VideoLiveMapper, VideoLiveDO> implements IVideoLiveService {

    /**
     * 行业
     */
    private final IIndustryService industryService;

    /**
     * 直播应用行业
     */
    private final IVideoLiveApplyIndustryService videoLiveApplyIndustryService;

    /**
     * 产品
     */
    private final IProductService productService;

    /**
     * 视频直播分页
     *
     * @param videoLiveDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(VideoLiveDO videoLiveDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<VideoLiveDO> page = new Page<>();
            page.setCurrent(videoLiveDO.getPage());
            page.setSize(videoLiveDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<VideoLiveDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 处理前端参数问题
//            if (ObjectUtil.isNullOrEmpty(userCompanyDO.getUserId())) {
//                userCompanyDO.setUserId(null);
//            }
            page(page, lambdaQueryWrapper);
            List<VideoLiveDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get videoLiveList page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 直播审核
     *
     * @param videoLiveDO
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void auditVideoLive(VideoLiveDO videoLiveDO) {
        if (ObjectUtil.isNullOrEmpty(videoLiveDO.getId())) {
            throw new UserException("ID不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(videoLiveDO.getStatus())) {
            throw new UserException("审核状态不能为空");
        }
        // 先找到这条记录
        VideoLiveDO videoLiveModel = getById(videoLiveDO.getId());
        if (videoLiveModel == null) {
            throw new UserException("未找到待审核的直播信息");
        }
        // 先修改当前记录
        updateById(videoLiveDO);
    }

    /**
     * 前端视频直播分页
     *
     * @param videoLiveDO
     * @return
     */
    @Override
    public JSONObject getWebPageList(VideoLiveDO videoLiveDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<VideoLiveDO> page = new Page<>();
            page.setCurrent(videoLiveDO.getPage());
            page.setSize(videoLiveDO.getLimit());
            LambdaQueryWrapper<VideoLiveDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 用户ID
            if (!ObjectUtil.isNullOrEmpty(videoLiveDO.getUserId())) {
                lambdaQueryWrapper.eq(VideoLiveDO::getUserId, videoLiveDO.getUserId());
            }
            // 状态
            if (!ObjectUtil.isNullOrEmpty(videoLiveDO.getStatus())) {
                lambdaQueryWrapper.eq(VideoLiveDO::getStatus, videoLiveDO.getStatus());
            }
            // 搜索条件
            if (!ObjectUtil.isNullOrEmpty(videoLiveDO.getStrSearch())) {
                lambdaQueryWrapper.like(VideoLiveDO::getTitle, videoLiveDO.getStrSearch());
            }
            lambdaQueryWrapper.orderByDesc(VideoLiveDO::getId);
            page(page, lambdaQueryWrapper);
            List<VideoLiveDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            // 这里添加几种状态的具体数值
            LambdaQueryWrapper<VideoLiveDO> productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productDOLambdaQueryWrapper.eq(VideoLiveDO::getUserId, videoLiveDO.getUserId());
            productDOLambdaQueryWrapper.eq(VideoLiveDO::getStatus, 0);
            // 审核中
            jsonObject.put("status0", count(productDOLambdaQueryWrapper));
            // 已发布
            productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productDOLambdaQueryWrapper.eq(VideoLiveDO::getUserId, videoLiveDO.getUserId());
            productDOLambdaQueryWrapper.eq(VideoLiveDO::getStatus, 1);
            jsonObject.put("status1", count(productDOLambdaQueryWrapper));
            // 未发布
            productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productDOLambdaQueryWrapper.eq(VideoLiveDO::getUserId, videoLiveDO.getUserId());
            productDOLambdaQueryWrapper.eq(VideoLiveDO::getStatus, 2);
            jsonObject.put("status2", count(productDOLambdaQueryWrapper));
            return jsonObject;
        } catch (Exception e) {
            log.error("get videoLive page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 获取直播详情
     *
     * @param videoLiveId
     * @return
     */
    @Override
    public JSONObject getVideoLiveInfo(Long videoLiveId) {
        // 实际好像直接返回产品类也可以，这里先用JSONObject
        JSONObject jsonObject = new JSONObject();
        VideoLiveDO videoLiveDO = getById(videoLiveId);
        if (videoLiveDO == null) {
            throw new UserException("获取直播详情失败");
        }
        jsonObject.put("productInfo", videoLiveDO);
        // 面包屑导航
        jsonObject.put("crumbs", industryService.getAllParentNodeMySelf((long) videoLiveDO.getIndustryId()));
        // 产品应用行业
        LambdaQueryWrapper<VideoLiveApplyIndustryDO> applyIndustryQuery = new LambdaQueryWrapper<>();
        applyIndustryQuery.eq(VideoLiveApplyIndustryDO::getVideoLiveId, videoLiveId);
        List<VideoLiveApplyIndustryDO> videoLiveApplyIndustryServiceList = videoLiveApplyIndustryService.list(applyIndustryQuery);
        jsonObject.put("applyIndustryList", videoLiveApplyIndustryServiceList);
        // 因为只有企业才能是卖家，这里直接根据用户ID查询企业信息即可
//        LambdaQueryWrapper<UserCompanyDO> userCompanyQuery = new LambdaQueryWrapper<>();
//        userCompanyQuery.eq(UserCompanyDO::getUserId, productDO.getUserId());
//        UserCompanyDO userCompanyDO = userCompanyService.getOne(userCompanyQuery);
//        if (userCompanyDO != null) {
//            jsonObject.put("companyInfo", userCompanyDO);
//        }
        // 相关推荐 8
        LambdaQueryWrapper<ProductDO> recommendQuery = new LambdaQueryWrapper<>();
        recommendQuery.last("order by rand() limit 8");
        jsonObject.put("recommendList", productService.list(recommendQuery));
        return jsonObject;
    }

    /**
     * 删除直播
     *
     * @param userId
     * @param videoLiveId
     */
    @Override
    public void deleteVideoLive(Long userId, Long videoLiveId) {
        LambdaQueryWrapper<VideoLiveDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(VideoLiveDO::getUserId, userId);
        lambdaQueryWrapper.eq(VideoLiveDO::getId, videoLiveId);
        remove(lambdaQueryWrapper);
    }

}
