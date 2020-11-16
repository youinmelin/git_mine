package com.yujia.topbang.api.db;

import com.baomidou.mybatisplus.core.incrementer.IdentifierGenerator;
import com.forgetfulr.common.utils.SnowFlakeUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * 自定义ID生成器
 *
 * @author caorui
 * @date 2020-06-25 18:22
 * Revision History
 * Date      		Programmer       Notes
 * 2020-06-25   	 caorui		     Initial
 */
@Slf4j
@Component
public class CustomIdGenerator implements IdentifierGenerator {

    @Override
    public Number nextId(Object entity) {
        return new SnowFlakeUtils(1, 1).nextId();
    }
}
