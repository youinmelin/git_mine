package com.yujia.topbang.api.controller.web;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.forgetfulr.common.core.R;
import com.yujia.topbang.api.core.EsInit;
import com.yujia.topbang.api.entity.HotSearchDO;
import com.yujia.topbang.api.entity.ProductDO;
import com.yujia.topbang.api.service.IHotSearchService;
import com.yujia.topbang.api.service.IIndexService;
import com.yujia.topbang.api.service.IProductService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 首页
 *
 * @author caorui
 * @date 2020-08-06 15:58
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-06   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("webIndexController")
@RequestMapping("/api/web/index")
public class IndexController {

    private final IIndexService indexService;

    private final IProductService productService;

    private final IHotSearchService hotSearchService;

    /**
     * 首页大接口
     *
     * @return
     */
    @GetMapping
    public R index() {
        return R.ok().put("data", indexService.index());
    }

    /**
     * 首页分类
     *
     * @return
     */
    @GetMapping(value = "/category")
    public R indexCategory() {
        return R.ok().put("data", indexService.getIndexCategory());
    }

    /**
     * 搜索
     *@Parameters Map<String, String> map
     * @return R
     * @throws IOException
     */
    @PostMapping(value = "/search")
    public R search(@RequestBody Map<String, String> map) throws IOException {
        if (map == null) {
            return R.error();
        }
        String strSearch = map.get("strSearch");
        RestHighLevelClient client = EsInit.getClient();
        SearchRequest request = new SearchRequest("product");
        SearchSourceBuilder builder = new SearchSourceBuilder();
        /*
        搜索方法有 matchQuery() termQuery() fuzzyQuery()
        match与term区别，match查询的时候，ES会根据给定的字段提供合适的分析器，而term不会
        fuzzyQuery 模糊搜索（很影响性能，相当于数据库中的 like）
         */
        builder.query(QueryBuilders.multiMatchQuery(strSearch, "name", "content", "tag", "industry"));
        // builder.from(0).size(2); // 分页
        request.source(builder);

        SearchResponse response = client.search(request, RequestOptions.DEFAULT);

        Collection<Long> ids = new ArrayList<>();
        for (SearchHit hit : response.getHits()) {
            ids.add(Long.parseLong(hit.getId()));
        }
        client.close();

        if (ids.isEmpty()) {
            return R.error();
        }
        List<ProductDO> productDOList = productService.listByIds(ids);
        // 这里要提交到后台
        LambdaQueryWrapper<HotSearchDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(HotSearchDO::getContent, strSearch);
        HotSearchDO hotSearchDO = hotSearchService.getOne(lambdaQueryWrapper);
        if (hotSearchDO != null) {
            hotSearchDO.setNum(hotSearchDO.getNum() + 1);
            hotSearchService.updateById(hotSearchDO);
        } else {
            hotSearchDO = new HotSearchDO();
            hotSearchDO.setContent(strSearch);
            hotSearchDO.setNum(1L);
            hotSearchService.save(hotSearchDO);
        }

        return R.ok().put("data", productDOList);
    }
}
