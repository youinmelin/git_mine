package com.forgetfulr.admin.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.service.IService;
import com.forgetfulr.admin.entity.WebOptionsDO;

/**
 * <p>
 * 系统配置 服务类
 * </p>
 *
 * @author caorui
 * @since 2020-07-01
 */
public interface IWebOptionsService extends IService<WebOptionsDO> {

    /**
     * 保存配置
     *
     * @param key
     * @param value
     */
    void saveOption(String key, String value);

    /**
     * 获取配置
     *
     * @param key
     * @return
     */
    JSONArray getOption(String key);

    /**
     * 获取配置
     *
     * @param key
     * @return JSONObject
     */
    JSONObject getOptionByKey(String key);

    /**
     * 获取配置指定参数项
     *
     * @param key
     * @param value
     * @return JSONObject
     */
    String getOptionByKey(String key, String value);

}
