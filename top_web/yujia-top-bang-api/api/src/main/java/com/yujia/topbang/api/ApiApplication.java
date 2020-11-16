package com.yujia.topbang.api;

import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import com.baomidou.mybatisplus.extension.plugins.pagination.optimize.JsqlParserCountOptimize;
import com.yujia.topbang.api.db.DynamicDataSourceConfig;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableAsync
@Import({DynamicDataSourceConfig.class})
@EnableTransactionManagement
@EnableScheduling
@ServletComponentScan
@MapperScan({"com.forgetfulr.admin.mapper", "com.yujia.topbang.api.mapper"})
// 扫描其他的Jar包中的内容
@ComponentScan(basePackages = {"com.forgetfulr.*", "com.yujia.topbang.api"})
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class ApiApplication {

    public static void main(String[] args) {
        System.out.println("API服务 开始启动...");
        SpringApplication.run(ApiApplication.class, args);
        System.out.println("API服务 启动加载完毕...");
    }

    /**
     * Mybatis-Plus 分页 page.getTotal() 返回 0 的问题
     *
     * @return
     */
    @Bean
    public PaginationInterceptor paginationInterceptor() {
        PaginationInterceptor paginationInterceptor = new PaginationInterceptor();
        // 设置请求的页面大于最大页后操作， true调回到首页，false 继续请求  默认false
        // paginationInterceptor.setOverflow(false);
        // 设置最大单页限制数量，默认 500 条，-1 不受限制
        // paginationInterceptor.setLimit(500);
        // 开启 count 的 join 优化,只针对部分 left join
        paginationInterceptor.setCountSqlParser(new JsqlParserCountOptimize(true));
        return paginationInterceptor;
    }

}
