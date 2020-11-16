package com.yujia.topbang.api.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.yujia.topbang.api.core.EsInit;
import com.yujia.topbang.api.entity.ProductApplyIndustryDO;
import com.yujia.topbang.api.entity.ProductDO;
import com.yujia.topbang.api.entity.ProductTagDO;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.search.MultiSearchRequest;
import org.elasticsearch.action.search.MultiSearchResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.jsoup.Jsoup;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 产品测试类
 *
 * @author caorui
 * @date 2020-09-10 14:29
 * Revision History
 * Date      		Programmer       Notes
 * 2020-09-10   	 caorui		     Initial
 */
@Slf4j
@SpringBootTest
@RunWith(SpringJUnit4ClassRunner.class)
public class ProductServiceTest {

    // 产品
    @Autowired
    private IProductService productService;
    // 产品标签
    @Autowired
    private IProductTagService productTagService;
    // 产品应用行业
    @Autowired
    private IProductApplyIndustryService productApplyIndustryService;


    // 产品信息导入ES
    @Test
    public void importProductToEs() throws IOException {

        RestHighLevelClient client = EsInit.getClient();
        BulkRequest requests = new BulkRequest();

        // 先读取所有产品
        List<ProductDO> productDOList = productService.list();
        for (ProductDO item : productDOList) {

            // 标签
            StringBuilder strTag = new StringBuilder();
            LambdaQueryWrapper<ProductTagDO> tagDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
            tagDOLambdaQueryWrapper.eq(ProductTagDO::getProdId, item.getId());
            List<ProductTagDO> productTagDOList = productTagService.list(tagDOLambdaQueryWrapper);
            if (productTagDOList != null && productTagDOList.size() > 0) {
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
            if (productApplyIndustryDOList != null && productApplyIndustryDOList.size() > 0) {
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
        }

        BulkResponse responses = client.bulk(requests, RequestOptions.DEFAULT);

        System.out.println(responses.status().getStatus() + responses.status().name());

        client.close();
    }


    @Test
    public void searchTest() throws IOException {
        RestHighLevelClient client = EsInit.getClient();

        SearchRequest request = new SearchRequest("product");
        SearchSourceBuilder builder = new SearchSourceBuilder();
        /*
        搜索方法有 matchQuery() termQuery() fuzzyQuery()
        match与term区别，match查询的时候，ES会根据给定的字段提供合适的分析器，而term不会
        fuzzyQuery 模糊搜索（很影响性能，相当于数据库中的 like）
         */
//        String[] includField = new String[]{"subTitle", "skus", "id"};
//        builder.fetchSource(includField, null);
        builder.query(QueryBuilders.multiMatchQuery("住宿", "name", "content", "tag", "industry"));
        // builder.from(0).size(2); // 分页
        request.source(builder);

        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        System.out.println(response.toString());
//        log.info(response.toString(), response.getTotalShards());
        for (SearchHit documentFields : response.getHits()) {
            System.out.println("结果：" + documentFields.toString());
        }




        /*
        查询结果具体的含义
        SearchHit[] searchHits = hits.getHits();
        for (SearchHit hit : searchHits) {
        // 结果的Index
            String index = hit.getIndex();
        // 结果的type
            String type = hit.getType();
        // 结果的ID
            String id = hit.getId();
        // 结果的评分
            float score = hit.getScore();
        // 查询的结果 JSON字符串形式
            String sourceAsString = hit.getSourceAsString();
        // 查询的结果 Map的形式
            Map<String, Object> sourceAsMap = hit.getSourceAsMap();
        // Document的title
            String documentTitle = (String) sourceAsMap.get("title");
        // 结果中的某个List
            List<Object> users = (List<Object>) sourceAsMap.get("user");
        // 结果中的某个Map
            Map<String, Object> innerObject = (Map<String, Object>) sourceAsMap.get("innerObject");
        }
         */
        client.close();

    }


    /**
     * 搜索产品
     * 这个好像是多查询合并为一个查询，不是想要的多字段查询
     *
     * @throws IOException
     */
    @Test
    public void searchProduct() throws IOException {
        RestHighLevelClient client = EsInit.getClient();
        MultiSearchRequest request = new MultiSearchRequest();
        SearchRequest searchRequest = new SearchRequest("product");
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        /*
        搜索方法有 matchQuery() termQuery() fuzzyQuery()
        match与term区别，match查询的时候，ES会根据给定的字段提供合适的分析器，而term不会
        fuzzyQuery 模糊搜索（很影响性能，相当于数据库中的 like）
         */
        String strSearch = "产品";
        // name
        SearchRequest firstSearchRequest = new SearchRequest();
        searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(QueryBuilders.matchQuery("name", strSearch));
        firstSearchRequest.source(searchSourceBuilder);
        request.add(firstSearchRequest);
        // content
        SearchRequest secondSearchRequest = new SearchRequest();
        searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(QueryBuilders.matchQuery("content", strSearch));
        secondSearchRequest.source(searchSourceBuilder);
        request.add(secondSearchRequest);
        // tag
        SearchRequest thirdSearchRequest = new SearchRequest();
        searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(QueryBuilders.matchQuery("tag", strSearch));
        thirdSearchRequest.source(searchSourceBuilder);
        request.add(thirdSearchRequest);
        // industry
        SearchRequest fourthSearchRequest = new SearchRequest();
        searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(QueryBuilders.matchQuery("industry", strSearch));
        fourthSearchRequest.source(searchSourceBuilder);
        request.add(fourthSearchRequest);

        // 指定搜索的 index
        request.add(searchRequest);

        MultiSearchResponse response = client.msearch(request, RequestOptions.DEFAULT);
        MultiSearchResponse.Item sss = response.getResponses()[3];


        response.forEach(t -> {
            SearchResponse resp = t.getResponse();

            Arrays.stream(resp.getHits().getHits())
                    .forEach(i -> {
                        System.out.println(i.getId());
                        System.out.println(i.getIndex());
                        System.out.println(i.getSourceAsString());
                        System.out.println(i.getShard());
                    });
            System.out.println("======我是分割线======");
            System.out.println(resp.getHits().getTotalHits());
        });


//        builder.query(QueryBuilders.matchQuery("name", strSearch));
//        // builder.from(0).size(2); // 分页
//        searchRequest.source(builder);
//        request.add(searchRequest);

//        builder = new SearchSourceBuilder();
//        builder.query(QueryBuilders.matchQuery("content", strSearch));
//        searchRequest.source(builder);
//        request.add(searchRequest);
//
//        builder = new SearchSourceBuilder();
//        builder.query(QueryBuilders.matchQuery("tag", strSearch));
//        searchRequest.source(builder);
//        request.add(searchRequest);
//
//        builder = new SearchSourceBuilder();
//        builder.query(QueryBuilders.matchQuery("industry", strSearch));
//        searchRequest.source(builder);
//        request.add(searchRequest);
//
//        MultiSearchResponse response = client.msearch(request, RequestOptions.DEFAULT);





        /*
        查询结果具体的含义
        SearchHit[] searchHits = hits.getHits();
        for (SearchHit hit : searchHits) {
        // 结果的Index
            String index = hit.getIndex();
        // 结果的type
            String type = hit.getType();
        // 结果的ID
            String id = hit.getId();
        // 结果的评分
            float score = hit.getScore();
        // 查询的结果 JSON字符串形式
            String sourceAsString = hit.getSourceAsString();
        // 查询的结果 Map的形式
            Map<String, Object> sourceAsMap = hit.getSourceAsMap();
        // Document的title
            String documentTitle = (String) sourceAsMap.get("title");
        // 结果中的某个List
            List<Object> users = (List<Object>) sourceAsMap.get("user");
        // 结果中的某个Map
            Map<String, Object> innerObject = (Map<String, Object>) sourceAsMap.get("innerObject");
        }
         */
        client.close();
    }

}
