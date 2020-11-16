package com.forgetfulr.admin.core;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.forgetfulr.common.utils.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

/**
 * 字段填充器
 *
 * @author caorui@caorui.net
 * @date 2020/5/9 01:04
 */
@Slf4j
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        this.strictInsertFill(metaObject, "gmtCreate", String.class, DateUtil.getDate()); // 起始版本 3.3.0(推荐使用)
        this.strictUpdateFill(metaObject, "gmtModified", String.class, DateUtil.getDate());
        this.strictInsertFill(metaObject, "gmtRegister", String.class, DateUtil.getDate());
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        // insert 的地方也要写一遍，然后 insert_update 才有效果
        this.strictUpdateFill(metaObject, "gmtModified", String.class, DateUtil.getDate()); // 起始版本 3.3.0(推荐使用)
    }
}
