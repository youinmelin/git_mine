package com.yujia.topbang.api.service;

import com.yujia.topbang.api.core.EsInit;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.admin.indices.delete.DeleteIndexRequest;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.action.delete.DeleteRequest;
import org.elasticsearch.action.delete.DeleteResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.support.IndicesOptions;
import org.elasticsearch.action.support.master.AcknowledgedResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.indices.CreateIndexRequest;
import org.elasticsearch.client.indices.CreateIndexResponse;
import org.elasticsearch.client.indices.GetIndexRequest;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * ES 测试
 *
 * @author caorui
 * @date 2020-09-10 11:21
 * Revision History
 * Date      		Programmer       Notes
 * 2020-09-10   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@SpringBootTest
@RunWith(SpringJUnit4ClassRunner.class)
public class EsTest {

    /**
     * 创建Index
     *
     * @throws IOException
     */
    @Test
    public void createIndexTest() throws IOException {
        RestHighLevelClient client = EsInit.getClient();
        CreateIndexRequest request = new CreateIndexRequest("product");
        /*
         * 第一种方法
         * 不带映射，让es自动识别字段的类型，并创建相应的映射
         */
//        request.settings(Settings.builder()
//                // 有多少个备份
//                .put("index.number_of_replicas", 1)
//                // 有多少个碎片
//                .put("index.number_of_shards", 5));
        /*
         * 第二种方法
         * 增加自定义映射（如果不自定义，直接删掉下面这段就可以了）
         */
        XContentBuilder builder = XContentFactory.jsonBuilder();
        builder.startObject();
        {
            builder.startObject("properties");
            {
                // 产品名称
                builder.startObject("name");
                {
                    builder.field("type", "text");
                    builder.field("analyzer", "ik_max_word"); // ik_max_word 这个分词器是ik的，可以去github上搜索安装es的ik分词器插件
                    builder.field("search_analyzer", "ik_smart"); // 搜索时使用的方式
//                        builder.field("index", "true");
                }
                builder.endObject();
                // 内容
                builder.startObject("content");
                {
                    builder.field("type", "text");
                    builder.field("analyzer", "ik_max_word"); // ik_max_word 这个分词器是ik的，可以去github上搜索安装es的ik分词器插件
                    builder.field("search_analyzer", "ik_smart"); // 搜索时使用的方式
//                        builder.field("index", "true");
                }
                builder.endObject();
                // 标签
                builder.startObject("tag");
                {
                    builder.field("type", "text");
                    builder.field("analyzer", "ik_max_word");
                    builder.field("search_analyzer", "ik_smart");
                }
                builder.endObject();
                // 行业，可应用行业
                builder.startObject("industry");
                {
                    builder.field("type", "text");
                    builder.field("analyzer", "ik_max_word");
                    builder.field("search_analyzer", "ik_smart");
                }
                builder.endObject();

            }
            builder.endObject();
        }
        builder.endObject();
        // 原先这里是下面这段，但是报错，所以删掉了"topic"
        // request.mapping("topic", mappingBuilder);
        request.mapping(builder);
        // 不知道为什么，非要加RequestOptions.DEFAULT，这样好像就可以了。很多方法都废弃了
        CreateIndexResponse response = client.indices().create(request, RequestOptions.DEFAULT);
        // log.info(response.toString());
        // 索引已经存在，则报错
        System.out.println(response.isAcknowledged());
        client.close();
    }

    /**
     * 查看映射是否存在
     *
     * @throws IOException
     */
    @Test
    public void getIndexTest() throws IOException {
        RestHighLevelClient client = EsInit.getClient();
        GetIndexRequest request = new GetIndexRequest("ceshi");
        // 这一句好像有问题
        // request.indices("ceshi");
        // 不知道下面这两个是干嘛的，先注释掉
        // request.local(false);
        // request.humanReadable(true);
        boolean exists = client.indices().exists(request, RequestOptions.DEFAULT);
        System.out.println(exists);
        client.close();
    }

    /**
     * 删除Index
     *
     * @throws IOException
     */
    @Test
    public void deleteIndexTest() throws IOException {
        RestHighLevelClient client = EsInit.getClient();
        DeleteIndexRequest request = new DeleteIndexRequest("ceshi");
        // 不知道下面这句话干嘛的
        request.indicesOptions(IndicesOptions.LENIENT_EXPAND_OPEN);
        AcknowledgedResponse response = client.indices().delete(request, RequestOptions.DEFAULT);
        System.out.println(response.isAcknowledged());
        client.close();
    }

    /**
     * 添加文档
     * 也有更新文档的接口 UpdateRequest ，但是更新时如果ID已经存在，就会报错
     * 实际上添加文档的接口会自动判断是新增还是更新，所以更新接口用的极少，这里就不测试了
     *
     * @throws IOException
     */
    @Test
    public void createDocTest() throws IOException {
        RestHighLevelClient client = EsInit.getClient();
        IndexRequest request = new IndexRequest("ceshi");
        request.id("1");
        Map<String, Object> jsonMap = new HashMap<>();
        jsonMap.put("title", "上海自来水来自海上");
        jsonMap.put("content", "中国");
        request.source(jsonMap, XContentType.JSON);
        IndexResponse response = client.index(request, RequestOptions.DEFAULT);
        System.out.println(response.toString());
        client.close();
    }

    /**
     * 批量添加文档
     *
     * @throws IOException
     */
    @Test
    public void batchCreateDocTest() throws IOException {
        RestHighLevelClient client = EsInit.getClient();
        BulkRequest requests = new BulkRequest();

        Map<String, Object> map1 = new HashMap<>();
        map1.put("title", "我是中国人");
        map1.put("content", "Python");
        IndexRequest request1 = new IndexRequest("ceshi", "_doc", "1");
        request1.source(map1);
        requests.add(request1);

        Map<String, Object> map2 = new HashMap<>();
        map2.put("title", "武汉市长江大桥欢迎您");
        map2.put("content", "海上");
        IndexRequest request2 = new IndexRequest("ceshi", "_doc", "2");
        request2.source(map2);
        requests.add(request2);

        Map<String, Object> map3 = new HashMap<>();
        map3.put("title", "上海自来水来自海上");
        map3.put("content", "武汉");
        IndexRequest request3 = new IndexRequest("ceshi", "_doc", "3");
        request3.source(map3);
        requests.add(request3);

        BulkResponse responses = client.bulk(requests, RequestOptions.DEFAULT);

        System.out.println(responses.status().getStatus() + responses.status().name());

        client.close();
    }

    /**
     * 删除文档
     *
     * @throws IOException
     */
    @Test
    public void deleteDocTest() throws IOException {
        RestHighLevelClient client = EsInit.getClient();
        DeleteRequest request = new DeleteRequest("ceshi", "test", "1");
        DeleteResponse response = client.delete(request, RequestOptions.DEFAULT);
        // exist: result: code: 200, status: OK
        // not exist: result: code: 404, status: NOT_FOUND
        System.out.println(response.status().getStatus() + response.status().name());
        client.close();
    }

    /**
     * 搜索文档
     *
     * @throws IOException
     */
    @Test
    public void searchDocTest() throws IOException {
        RestHighLevelClient client = EsInit.getClient();
        //region 据说很叼的方法，但是不能指定type
        SearchRequest request = new SearchRequest("ceshi");
        SearchSourceBuilder builder = new SearchSourceBuilder();
        /*
        搜索方法有 matchQuery() termQuery() fuzzyQuery()
        match与term区别，match查询的时候，ES会根据给定的字段提供合适的分析器，而term不会
        fuzzyQuery 模糊搜索（很影响性能，相当于数据库中的 like）
         */
        builder.query(QueryBuilders.matchQuery("title", "上海"));
        // builder.from(0).size(2); // 分页
        request.source(builder);

        SearchResponse response = client.search(request, RequestOptions.DEFAULT);
        System.out.println(response.toString());
//        log.info(response.toString(), response.getTotalShards());
        for (SearchHit documentFields : response.getHits()) {
            System.out.println("结果：" + documentFields.toString());
        }
        //endregion




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
