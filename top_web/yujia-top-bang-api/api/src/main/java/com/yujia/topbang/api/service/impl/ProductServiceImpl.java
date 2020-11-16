package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.ObjectUtil;
import com.yujia.topbang.api.core.EsInit;
import com.yujia.topbang.api.entity.*;
import com.yujia.topbang.api.enums.NoticeTypeEnum;
import com.yujia.topbang.api.mapper.ProductMapper;
import com.yujia.topbang.api.service.*;
import com.yujia.topbang.api.utils.FFmpegUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.jsoup.Jsoup;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.*;

/**
 * <p>
 * 产品 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
@Slf4j
@Service
@AllArgsConstructor
public class ProductServiceImpl extends ServiceImpl<ProductMapper, ProductDO> implements IProductService {

    //region Service
    /**
     * 标签
     */
    private final ITagsService tagsService;

    /**
     * 行业
     */
    private final IIndustryService industryService;

    /**
     * 产品应用行业
     */
    private final IProductApplyIndustryService productApplyIndustryService;

    /**
     * 产品标签
     */
    private final IProductTagService productTagService;

    /**
     * 产品视频
     */
    private final IProductVideoService productVideoService;

    /**
     * 企业信息
     */
    private final IUserCompanyService userCompanyService;

    /**
     * 个人信息
     */
    private final IUserService userService;

    /**
     * 产品试用
     */
    private final IProductTrialService productTrialService;

    /**
     * 消息列表
     */
    private final INoticeSendService noticeSendService;
    private final INoticeContentService noticeContentService;

    /**
     * 我看过的
     */
    private final IUserProductBrowseHistoryService userProductBrowseHistoryService;

    /**
     * 收藏
     */
    private final IUserProductCollectionService userProductCollectionService;
    //endregion

    //region 后端部分

    /**
     * 产品分页
     *
     * @param productDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(ProductDO productDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<ProductDO> page = new Page<>();
            page.setCurrent(productDO.getPage());
            page.setSize(productDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<ProductDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 产品ID
            if (!ObjectUtil.isNullOrEmpty(productDO.getId())) {
                lambdaQueryWrapper.eq(ProductDO::getId, productDO.getId());
            }
            // 产品名称
            if (!ObjectUtil.isNullOrEmpty(productDO.getName())) {
                lambdaQueryWrapper.like(ProductDO::getName, productDO.getName());
            }
            page(page, lambdaQueryWrapper);
            List<ProductDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get product page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 产品审核
     *
     * @param productDO
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void auditProduct(ProductDO productDO) {
        if (ObjectUtil.isNullOrEmpty(productDO.getId())) {
            throw new UserException("ID不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(productDO.getStatus())) {
            throw new UserException("审核状态不能为空");
        }
        // 先找到这条记录
        ProductDO productModel = getById(productDO.getId());
        if (productModel == null) {
            throw new UserException("未找到待审核的产品信息");
        }
        // 先修改当前记录
        updateById(productDO);
    }
    //endregion

    /**
     * 前端产品列表分页
     * @param productDO
     * @return
     */
    @Override
    public JSONObject getWebPageList(ProductDO productDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            // 获取分页参数
            Page<ProductDO> page = new Page<>();
            page.setCurrent(productDO.getPage());
            page.setSize(productDO.getLimit());
            // 条件构造器
            LambdaQueryWrapper<ProductDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 按用户ID查找产品
            if (!ObjectUtil.isNullOrEmpty(productDO.getUserId())) {
                lambdaQueryWrapper.eq(ProductDO::getUserId, productDO.getUserId());
            }
            // 按状态查找产品
            if (!ObjectUtil.isNullOrEmpty(productDO.getStatus())) {
                lambdaQueryWrapper.eq(ProductDO::getStatus, productDO.getStatus());
            }
            // 按name模糊搜索, 参数为strSearch，这里应该用到ES
            if (!ObjectUtil.isNullOrEmpty(productDO.getStrSearch())) {
                lambdaQueryWrapper.like(ProductDO::getName, productDO.getStrSearch());
            }
            lambdaQueryWrapper.orderByDesc(ProductDO::getId);
            page(page, lambdaQueryWrapper);
            List<ProductDO> list = page.getRecords();
            for (ProductDO item : list) {
                item.setStrDuration(FFmpegUtil.secToTime(item.getDuration()));
            }
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            // 这里添加几种状态的具体数量统计
            LambdaQueryWrapper<ProductDO> productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productDOLambdaQueryWrapper.eq(ProductDO::getUserId, productDO.getUserId());
            productDOLambdaQueryWrapper.eq(ProductDO::getStatus, 0);
            // 审核中
            jsonObject.put("status0", count(productDOLambdaQueryWrapper));
            // 已发布
            productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productDOLambdaQueryWrapper.eq(ProductDO::getUserId, productDO.getUserId());
            productDOLambdaQueryWrapper.eq(ProductDO::getStatus, 1);
            jsonObject.put("status1", count(productDOLambdaQueryWrapper));
            // 未发布
            productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productDOLambdaQueryWrapper.eq(ProductDO::getUserId, productDO.getUserId());
            productDOLambdaQueryWrapper.eq(ProductDO::getStatus, 2);
            jsonObject.put("status2", count(productDOLambdaQueryWrapper));
            return jsonObject;
        } catch (Exception e) {
            log.error("get product page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 产品发布
     *
     * @param productDO
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void releaseProduct(ProductDO productDO) {
        // 获取行业信息（因为涉及到冗余字段，所以这里需要查询，否则只需要在用到的时候联查即可）
        if (!ObjectUtil.isNullOrEmpty(productDO.getIndustryId())) {
            IndustryDO industryDO = industryService.getById(productDO.getIndustryId());
            if (industryDO != null) {
                productDO.setIndustryName(industryDO.getName());
            }
        }
        // 首先保存产品，拿到产品ID后保存标签和视频列表
        saveOrUpdate(productDO);
        Long prodId = productDO.getId();
        // 先要删除之前插入的应用行业
        LambdaQueryWrapper<ProductApplyIndustryDO> productApplyIndustryDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        productApplyIndustryDOLambdaQueryWrapper.eq(ProductApplyIndustryDO::getProdId, prodId);
        productApplyIndustryService.remove(productApplyIndustryDOLambdaQueryWrapper);
        // 查询应用行业
        if (productDO.getIndustryList() != null && !productDO.getIndustryList().isEmpty()) {
            List<IndustryDO> industryDOList = industryService.listByIds(productDO.getIndustryList());
            List<ProductApplyIndustryDO> productApplyIndustryDOList = new ArrayList<>();
            for (IndustryDO item : industryDOList) {
                ProductApplyIndustryDO productApplyIndustryDO = new ProductApplyIndustryDO();
                productApplyIndustryDO.setProdId(prodId);
                productApplyIndustryDO.setIndustryId(item.getId());
                productApplyIndustryDO.setIndustryName(item.getName());
                productApplyIndustryDOList.add(productApplyIndustryDO);
            }
            productApplyIndustryService.saveBatch(productApplyIndustryDOList);
        }
        // 查询标签
        if (productDO.getTagList() != null && !productDO.getTagList().isEmpty()) {
            List<TagsDO> tagsDOList = tagsService.listByIds(productDO.getTagList());
            List<ProductTagDO> productTagDOList = new ArrayList<>();
            for (TagsDO item : tagsDOList) {
                ProductTagDO productTagDO = new ProductTagDO();
                productTagDO.setProdId(prodId);
                productTagDO.setTagId(item.getId());
                productTagDO.setTagName(item.getTagName());
                productTagDOList.add(productTagDO);
            }
            productTagService.saveBatch(productTagDOList);
        }
        // 循环添加视频链接
        int duration = 0;
        if (productDO.getVideoList() != null && !productDO.getVideoList().isEmpty()) {
            List<ProductVideoDO> productVideoDOList = new ArrayList<>();
            for (String item : productDO.getVideoList()) {
                ProductVideoDO productVideoDO = new ProductVideoDO();
                productVideoDO.setProdId(prodId);
                productVideoDO.setVideoUrl(item);
                // 这里要读取下视频时长
                duration = FFmpegUtil.getVideoTime(item);
                productVideoDO.setDuration(duration);
                productVideoDOList.add(productVideoDO);
            }
            productVideoService.saveBatch(productVideoDOList);
        }
        // 更新下产品里面的时长（冗余）
        productDO.setDuration(duration);
        updateById(productDO);

        // 提交到ES
        try {
            RestHighLevelClient client = EsInit.getClient();
            BulkRequest requests = new BulkRequest();

            // 这里其实上面有，来不及写了。先这样用
            ProductDO item = getById(prodId);
            // 标签
            StringBuilder strTag = new StringBuilder();
            LambdaQueryWrapper<ProductTagDO> tagDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            tagDOLambdaQueryWrapper.eq(ProductTagDO::getProdId, item.getId());
            List<ProductTagDO> productTagDOList = productTagService.list(tagDOLambdaQueryWrapper);
            if (productTagDOList != null && !productTagDOList.isEmpty()) {
                for (ProductTagDO tag : productTagDOList) {
                    strTag.append(tag.getTagName()).append(",");
                }
            }

            // 应用行业
            StringBuilder strIndustry = new StringBuilder();
            // 先加上已有的
            strIndustry.append(item.getIndustryName()).append(",");
            LambdaQueryWrapper<ProductApplyIndustryDO> industryDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            industryDOLambdaQueryWrapper.eq(ProductApplyIndustryDO::getProdId, item.getId());
            List<ProductApplyIndustryDO> productApplyIndustryDOList = productApplyIndustryService.list(industryDOLambdaQueryWrapper);
            if (productApplyIndustryDOList != null && !productApplyIndustryDOList.isEmpty()) {
                for (ProductApplyIndustryDO industryDO : productApplyIndustryDOList) {
                    strIndustry.append(industryDO.getIndustryName()).append(",");
                }
            }

            Map<String, Object> map = new HashMap<>();
            map.put("name", item.getName());
            map.put("content", Jsoup.parse(item.getContent()).text());
            map.put("industry", strIndustry.toString());
            map.put("tag", strTag.toString());
            // 添加到 product 中
            IndexRequest request = new IndexRequest("product");
            request.id(item.getId().toString());
            request.source(map);
            requests.add(request);

            // 先把这行注释了, 否则报错
//            client.bulk(requests, RequestOptions.DEFAULT);

            // System.out.println(responses.status().getStatus() + responses.status().name());

            client.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取产品详情
     *
     * @param prodId
     * @return
     */
    @Override
    public JSONObject getProductInfo(Long prodId) {
        // 实际好像直接返回产品类也可以，这里先用JSONObject
        JSONObject jsonObject = new JSONObject();
        ProductDO productDO = getById(prodId);
        if (productDO == null) {
            throw new UserException("获取产品详情失败");
        }
        jsonObject.put("productInfo", productDO);
        // 下面最好异步处理
        // 面包屑导航
        jsonObject.put("crumbs", industryService.getAllParentNodeMySelf((long) productDO.getIndustryId()));
        // 标签
        LambdaQueryWrapper<ProductTagDO> tagQuery = new LambdaQueryWrapper<>();
        tagQuery.eq(ProductTagDO::getProdId, prodId);
        List<ProductTagDO> productTagDOList = productTagService.list(tagQuery);
        jsonObject.put("tagList", productTagDOList);
        // 产品视频
        LambdaQueryWrapper<ProductVideoDO> videoQuery = new LambdaQueryWrapper<>();
        videoQuery.eq(ProductVideoDO::getProdId, prodId);
        List<ProductVideoDO> productVideoDOList = productVideoService.list(videoQuery);
        jsonObject.put("videoList", productVideoDOList);
        // 产品应用行业
        LambdaQueryWrapper<ProductApplyIndustryDO> applyIndustryQuery = new LambdaQueryWrapper<>();
        applyIndustryQuery.eq(ProductApplyIndustryDO::getProdId, prodId);
        List<ProductApplyIndustryDO> productApplyIndustryDOList = productApplyIndustryService.list(applyIndustryQuery);
        jsonObject.put("applyIndustryList", productApplyIndustryDOList);
        // 因为只有企业才能是卖家，这里直接根据用户ID查询企业信息即可
        LambdaQueryWrapper<UserCompanyDO> userCompanyQuery = new LambdaQueryWrapper<>();
        userCompanyQuery.eq(UserCompanyDO::getUserId, productDO.getUserId());
        UserCompanyDO userCompanyDO = userCompanyService.getOne(userCompanyQuery);
        if (userCompanyDO != null) {
            jsonObject.put("companyInfo", userCompanyDO);
        }
        // 相关推荐 8
        LambdaQueryWrapper<ProductDO> recommendQuery = new LambdaQueryWrapper<>();
        // 要是审核过的
        recommendQuery.eq(ProductDO::getStatus, 1);
        recommendQuery.last("order by rand() limit 8");
        List<ProductDO> recommendPro = list(recommendQuery);
        for (ProductDO item : recommendPro) {
            item.setStrDuration(FFmpegUtil.secToTime(item.getDuration()));
        }
        jsonObject.put("recommendList", recommendPro);
        return jsonObject;
    }

    /**
     * 编辑时获取产品详情
     *
     * @param prodId
     * @return
     */
    @Override
    public JSONObject getEditProductInfo(Long prodId) {
        // 实际好像直接返回产品类也可以，这里先用JSONObject
        JSONObject jsonObject = new JSONObject();
        ProductDO productDO = getById(prodId);
        if (productDO == null) {
            throw new UserException("获取产品详情失败");
        }
        jsonObject.put("productInfo", productDO);
        // 处理行业ID
        List<IndustryDO> industryDOList = industryService.getAllParentNodeMySelf((long) productDO.getIndustryId());
        if (industryDOList != null && !industryDOList.isEmpty()) {
            Collection<String> ids = new ArrayList<>();
            for (IndustryDO item : industryDOList) {
                ids.add(item.getId().toString());
            }
            jsonObject.put("industryIds", ids);
        }
        // 可应用行业ID
        LambdaQueryWrapper<ProductApplyIndustryDO> applyIndustryQuery = new LambdaQueryWrapper<>();
        applyIndustryQuery.eq(ProductApplyIndustryDO::getProdId, prodId);
        List<ProductApplyIndustryDO> productApplyIndustryDOList = productApplyIndustryService.list(applyIndustryQuery);
        int i = 1;
        for (ProductApplyIndustryDO applyIndustryDO : productApplyIndustryDOList) {
            List<IndustryDO> applyIndustryList = industryService.getAllParentNodeMySelf(applyIndustryDO.getIndustryId());
            if (applyIndustryList != null && !applyIndustryList.isEmpty()) {
                Collection<String> ids = new ArrayList<>();
                for (IndustryDO item : applyIndustryList) {
                    ids.add(item.getId().toString());
                }
                jsonObject.put("input" + i, ids);
                i++;
            }
        }
        return jsonObject;
    }

    /**
     * 删除产品
     *
     * @param userId
     * @param prodId
     */
    @Override
    public void deleteProduct(Long userId, Long prodId) {
        LambdaQueryWrapper<ProductDO> productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        productDOLambdaQueryWrapper.eq(ProductDO::getUserId, userId);
        productDOLambdaQueryWrapper.eq(ProductDO::getId, prodId);
        remove(productDOLambdaQueryWrapper);
    }

    /**
     * 获取卖家管理中心首页
     *
     * @param userId
     * @return
     */
    @Override
    public JSONObject getSellerIndex(Long userId) {
        JSONObject jsonObject = new JSONObject();
        // 产品
        Page<ProductDO> productDOPage = new Page<>();
        productDOPage.setSize(8);
        LambdaQueryWrapper<ProductDO> productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        productDOLambdaQueryWrapper.eq(ProductDO::getUserId, userId);
        productDOLambdaQueryWrapper.orderByDesc(ProductDO::getId);
        page(productDOPage, productDOLambdaQueryWrapper);
        List<ProductDO> productDOList = productDOPage.getRecords();
        jsonObject.put("productList", productDOList);
        // 判断是个人还是企业，获取对应信息
        UserDO userDO = userService.getById(userId);
        jsonObject.put("userInfo", userDO);
        // 企业信息（卖家好像都是企业用户）
        LambdaQueryWrapper<UserCompanyDO> userCompanyDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        userCompanyDOLambdaQueryWrapper.eq(UserCompanyDO::getUserId, userId);
        jsonObject.put("companyInfo", userCompanyService.getOne(userCompanyDOLambdaQueryWrapper));
        // 消息列表
        LambdaQueryWrapper<NoticeSendDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 用户ID
        lambdaQueryWrapper.eq(NoticeSendDO::getUserId, userId);
        // 只查站内信
        lambdaQueryWrapper.eq(NoticeSendDO::getType, NoticeTypeEnum.write.getType());
        lambdaQueryWrapper.last("limit 2");
        List<NoticeSendDO> list = noticeSendService.list(lambdaQueryWrapper);
        for (NoticeSendDO item : list) {
            NoticeContentDO noticeContentDO = noticeContentService.getById(item.getContentId());
            item.setTitle(noticeContentDO.getTitle());
            item.setContent(noticeContentDO.getContent());
        }
        jsonObject.put("noticeList", list);
        return jsonObject;
    }

    /**
     * 获取买家管理中心首页
     *
     * @param userId
     * @return
     */
    @Override
    public JSONObject getBuyerIndex(Long userId) {
        JSONObject jsonObject = new JSONObject();
        /*
         猜你喜欢
         */
        LambdaQueryWrapper<ProductDO> productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        productDOLambdaQueryWrapper.orderByDesc(ProductDO::getId);
        productDOLambdaQueryWrapper.last("limit 9");
        List<ProductDO> productDOList = list(productDOLambdaQueryWrapper);
        for (ProductDO productDO : productDOList) {
            productDO.setStrDuration(FFmpegUtil.secToTime(productDO.getDuration()));
        }
        jsonObject.put("productList", productDOList);
        /*
        个人信息（买家有可能是企业）
         */
        LambdaQueryWrapper<UserDO> userDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        userDOLambdaQueryWrapper.eq(UserDO::getId, userId);
        jsonObject.put("personalInfo", userService.getOne(userDOLambdaQueryWrapper));
        /*
         消息列表
         */
        LambdaQueryWrapper<NoticeSendDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 用户ID
        lambdaQueryWrapper.eq(NoticeSendDO::getUserId, userId);
        // 只查站内信
        lambdaQueryWrapper.eq(NoticeSendDO::getType, NoticeTypeEnum.write.getType());
        lambdaQueryWrapper.last("limit 2");
        List<NoticeSendDO> list = noticeSendService.list(lambdaQueryWrapper);
        for (NoticeSendDO item : list) {
            NoticeContentDO noticeContentDO = noticeContentService.getById(item.getContentId());
            item.setTitle(noticeContentDO.getTitle());
            item.setContent(noticeContentDO.getContent());
        }
        jsonObject.put("noticeList", list);
        /*
        我看过的
         */
        LambdaQueryWrapper<UserProductBrowseHistoryDO> historyDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        historyDOLambdaQueryWrapper.eq(UserProductBrowseHistoryDO::getUserId, userId);
        historyDOLambdaQueryWrapper.orderByDesc(UserProductBrowseHistoryDO::getGmtModified);
        historyDOLambdaQueryWrapper.last("limit 3");
        List<UserProductBrowseHistoryDO> userProductBrowseHistoryDOList = userProductBrowseHistoryService.list(historyDOLambdaQueryWrapper);
        Iterator<UserProductBrowseHistoryDO> userProductBrowseHistoryDOIterator = userProductBrowseHistoryDOList.iterator();
        while (userProductBrowseHistoryDOIterator.hasNext()) {
            UserProductBrowseHistoryDO historyDO = userProductBrowseHistoryDOIterator.next();
            ProductDO ppDo = getById(historyDO.getProdId());
            if (ppDo == null) {
                // 不知道为什么这里会出现逻辑删除的数据，先临时处理下
                userProductBrowseHistoryDOIterator.remove();
                continue;
            }
            // ID修改掉，不然前端就出错了
            historyDO.setId(ppDo.getId());
            historyDO.setName(ppDo.getName());
            historyDO.setStrDuration(FFmpegUtil.secToTime(ppDo.getDuration()));
            historyDO.setPrice(ppDo.getPrice());
            historyDO.setVideoImgUrl(ppDo.getVideoImgUrl());
        }
        jsonObject.put("browseHistoryList", userProductBrowseHistoryDOList);
        /*
        我的试用
         */
        LambdaQueryWrapper<ProductTrialDO> productTrialDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getUserId, userId);
        productTrialDOLambdaQueryWrapper.last("limit 3");
        List<ProductTrialDO> productTrialDOList = productTrialService.list(productTrialDOLambdaQueryWrapper);
        Iterator<ProductTrialDO> productTrialDOIterator = productTrialDOList.iterator();
        while (productTrialDOIterator.hasNext()) {
            ProductTrialDO trialDO = productTrialDOIterator.next();
            ProductDO productDO = getById(trialDO.getProdId());
            if (productDO == null) {
                productTrialDOIterator.remove();
                continue;
            }
            trialDO.setId(productDO.getId());
            trialDO.setName(productDO.getName());
            trialDO.setVideoImgUrl(productDO.getVideoImgUrl());
        }
        jsonObject.put("productTrialList", productTrialDOList);
        /*
        试用统计数据
         */
        JSONObject trialJson = new JSONObject();
        productTrialDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getUserId, userId);
        productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getStatus, 0);
        // 申请中
        trialJson.put("status0", productTrialService.count(productTrialDOLambdaQueryWrapper));
        // 待评价
        productTrialDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getUserId, userId);
        productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getStatus, 1);
        trialJson.put("status1", productTrialService.count(productTrialDOLambdaQueryWrapper));
        // 已评价
        productTrialDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getUserId, userId);
        productTrialDOLambdaQueryWrapper.eq(ProductTrialDO::getStatus, 3);
        trialJson.put("status3", productTrialService.count(productTrialDOLambdaQueryWrapper));
        jsonObject.put("productTrialCount", trialJson);

        return jsonObject;
    }

    /**
     * 产品试用申请
     *
     * @param prodId
     * @param userId
     */
    @Override
    public void productGiveTrial(Long prodId, Long userId) {
        // 先拿到产品详情
        ProductDO productDO = getById(prodId);
        if (productDO == null) {
            throw new UserException("获取产品信息失败");
        }
        ProductTrialDO productTrialDO = new ProductTrialDO();
        productTrialDO.setProdId(productDO.getId());
        productTrialDO.setProdUserId(productDO.getUserId());
        productTrialDO.setUserId(userId);
        // 试用默认待审核
        productTrialDO.setStatus(0);
        productTrialService.save(productTrialDO);
    }

    /**
     * 获取企业用户信息
     *
     * @param userId
     * @return
     */
    @Override
    public JSONObject getCompanyInfo(Long userId) {
        JSONObject jsonObject = new JSONObject();
        // 企业信息
        LambdaQueryWrapper<UserCompanyDO> companyDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        companyDOLambdaQueryWrapper.eq(UserCompanyDO::getUserId, userId);
        jsonObject.put("companyInfo", userCompanyService.getOne(companyDOLambdaQueryWrapper));
        // 产品列表
        LambdaQueryWrapper<ProductDO> productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        productDOLambdaQueryWrapper.eq(ProductDO::getUserId, userId);
        jsonObject.put("productList", list(productDOLambdaQueryWrapper));
        return jsonObject;
    }

    //region 浏览记录

    /**
     * 前端产品浏览记录分页
     *
     * @param userProductBrowseHistoryDO
     * @return
     */
    @Override
    public JSONObject getWebProductHistoryList(UserProductBrowseHistoryDO userProductBrowseHistoryDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<UserProductBrowseHistoryDO> page = new Page<>();
            page.setCurrent(userProductBrowseHistoryDO.getPage());
            page.setSize(userProductBrowseHistoryDO.getLimit());
            LambdaQueryWrapper<UserProductBrowseHistoryDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 用户ID
            if (!ObjectUtil.isNullOrEmpty(userProductBrowseHistoryDO.getUserId())) {
                lambdaQueryWrapper.eq(UserProductBrowseHistoryDO::getUserId, userProductBrowseHistoryDO.getUserId());
            }
            // 这里要按照更新时间排序
            lambdaQueryWrapper.orderByDesc(UserProductBrowseHistoryDO::getGmtModified);

            // 因为下面调用了产品信息，为了防止循环依赖出错，这里只能写在这里
            userProductBrowseHistoryService.page(page, lambdaQueryWrapper);
            List<UserProductBrowseHistoryDO> list = page.getRecords();
            Iterator<UserProductBrowseHistoryDO> userProductBrowseHistoryDOIterator = list.iterator();
            while (userProductBrowseHistoryDOIterator.hasNext()) {
                UserProductBrowseHistoryDO historyDO = userProductBrowseHistoryDOIterator.next();
                ProductDO ppDo = getById(historyDO.getProdId());
                if (ppDo == null) {
                    // 不知道为什么这里会出现逻辑删除的数据，先临时处理下
                    userProductBrowseHistoryDOIterator.remove();
                    continue;
                }
                // ID修改掉，不然前端就出错了
                historyDO.setId(ppDo.getId());
                historyDO.setName(ppDo.getName());
                historyDO.setStrDuration(FFmpegUtil.secToTime(ppDo.getDuration()));
                historyDO.setPrice(ppDo.getPrice());
                historyDO.setVideoImgUrl(ppDo.getVideoImgUrl());
            }
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get userProductBrowseHistory page list error:{}", e.getMessage());
            throw new DBException();
        }
    }
    //endregion

    /**
     * 前端产品收藏分页
     *
     * @param userProductCollectionDO
     * @return
     */
    @Override
    public JSONObject getWebProductCollectionList(UserProductCollectionDO userProductCollectionDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<UserProductCollectionDO> page = new Page<>();
            page.setCurrent(userProductCollectionDO.getPage());
            page.setSize(userProductCollectionDO.getLimit());
            LambdaQueryWrapper<UserProductCollectionDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 用户ID
            if (!ObjectUtil.isNullOrEmpty(userProductCollectionDO.getUserId())) {
                lambdaQueryWrapper.eq(UserProductCollectionDO::getUserId, userProductCollectionDO.getUserId());
            }
            // 这里要按照更新时间排序
            lambdaQueryWrapper.orderByDesc(UserProductCollectionDO::getGmtModified);

            // 因为下面调用了产品信息，为了防止循环依赖出错，这里只能写在这里
            userProductCollectionService.page(page, lambdaQueryWrapper);
            List<UserProductCollectionDO> list = page.getRecords();
            Iterator<UserProductCollectionDO> userProductBrowseHistoryDOIterator = list.iterator();
            while (userProductBrowseHistoryDOIterator.hasNext()) {
                UserProductCollectionDO historyDO = userProductBrowseHistoryDOIterator.next();
                ProductDO ppDo = getById(historyDO.getProdId());
                if (ppDo == null) {
                    // 不知道为什么这里会出现逻辑删除的数据，先临时处理下
                    userProductBrowseHistoryDOIterator.remove();
                    continue;
                }
                // ID修改掉，不然前端就出错了
                historyDO.setId(ppDo.getId());
                historyDO.setName(ppDo.getName());
                historyDO.setStrDuration(FFmpegUtil.secToTime(ppDo.getDuration()));
                historyDO.setPrice(ppDo.getPrice());
                historyDO.setVideoImgUrl(ppDo.getVideoImgUrl());
            }
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get userProductCollection page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 行业产品
     *
     * @param id
     * @return
     */
    @Override
    public JSONObject getIndustryProdList(Long id) {
                    JSONObject jsonObject = new JSONObject();
                    try {
                        // 先用行业获取子孙节点产品
                        IndustryDO industryDO = industryService.getById(id);
                        jsonObject.put("industryInfo", industryDO);
                        // 查询子孙节点，包含自身（l_id大于等于自己，r_id小于等于自己）
                        LambdaQueryWrapper<IndustryDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
                        lambdaQueryWrapper.ge(IndustryDO::getLId, industryDO.getLId());
                        lambdaQueryWrapper.le(IndustryDO::getRId, industryDO.getRId());
                        lambdaQueryWrapper.le(IndustryDO::getCurrentLevel, 3);
                        List<IndustryDO> list = industryService.list(lambdaQueryWrapper);
                        Collection<Long> industryIds = new ArrayList<>();
                        for (IndustryDO item : list) {
                            industryIds.add(item.getId());
            }
            LambdaQueryWrapper<ProductDO> productDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            productDOLambdaQueryWrapper.in(ProductDO::getIndustryId, industryIds);
            productDOLambdaQueryWrapper.orderByDesc(ProductDO::getId);
            productDOLambdaQueryWrapper.last("limit 6");
            List<ProductDO> productDOList = list(productDOLambdaQueryWrapper);
            for (ProductDO item : productDOList) {
                item.setStrDuration(FFmpegUtil.secToTime(item.getDuration()));
            }
            jsonObject.put("productList", productDOList);
            // 推荐部分
            LambdaQueryWrapper<ProductDO> selectedLambdaQueryWrapper = new LambdaQueryWrapper<>();
            selectedLambdaQueryWrapper.orderByDesc(ProductDO::getId);
            selectedLambdaQueryWrapper.last("limit 10");
            List<ProductDO> selectedList = list(selectedLambdaQueryWrapper);
            for (ProductDO item : selectedList) {
                item.setStrDuration(FFmpegUtil.secToTime(item.getDuration()));
            }
            jsonObject.put("selectedList", selectedList);

            return jsonObject;
        } catch (Exception e) {
            log.error("get getIndustryProdList page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

}
