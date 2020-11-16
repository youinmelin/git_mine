package com.yujia.topbang.api.core;

import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * @author caorui@caorui.net
 * @date 2020/3/3 20:51
 */
@Component
public class EsInit {

    private static String[] esServer;

    @Value("${elsearch.server}")
    public void setServer(String[] esServer) {
        EsInit.esServer = esServer;
    }

    /**
     * 获取连接
     *
     * @return
     */
    public static RestHighLevelClient getClient() {

        return new RestHighLevelClient(
                RestClient.builder(
                        new HttpHost(esServer[0], Integer.parseInt(esServer[1]), "http")
                )
        );
    }
}
