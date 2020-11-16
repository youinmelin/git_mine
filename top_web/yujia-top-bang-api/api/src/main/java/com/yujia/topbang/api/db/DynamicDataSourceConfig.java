package com.yujia.topbang.api.db;

import com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

/**
 * 配置多数据源
 *
 * @author caorui
 * @date 2019-01-29
 */
@Configuration
public class DynamicDataSourceConfig {
    /**
     * 创建 DataSource Bean
     */

    /**
     * TBK_SERVICE
     *
     * @return
     */
    @Bean
    @ConfigurationProperties("spring.datasource.top-bang")
    public DataSource BaseDataSource() {
        return DruidDataSourceBuilder.create().build();
    }

    /**
     * 如果还有数据源,在这继续添加 DataSource Bean
     */
    @Bean
    @Primary
    public DynamicDataSource dataSource(DataSource baseDataSource) {
        Map<Object, Object> targetDataSources = new HashMap<>(1);
        targetDataSources.put(DataSourceEnum.TOP_BANG, baseDataSource);
        // 还有数据源,在targetDataSources中继续添加
//        System.out.println("DataSources:" + targetDataSources);
        return new DynamicDataSource(baseDataSource, targetDataSources);
    }
}
