package com.yujia.topbang.api.db;

import java.lang.annotation.*;

/**
 * 多数据源注解
 *
 * @author caorui
 * @date 2019-01-29
 */
@Documented
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface DataSource {
    String value() default DataSourceEnum.TOP_BANG;
}
