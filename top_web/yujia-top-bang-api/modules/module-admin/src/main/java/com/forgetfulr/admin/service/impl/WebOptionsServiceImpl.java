package com.forgetfulr.admin.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.admin.entity.WebOptionsDO;
import com.forgetfulr.admin.mapper.WebOptionsMapper;
import com.forgetfulr.admin.service.IWebOptionsService;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * <p>
 * 系统配置 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-07-01
 */
@Service
public class WebOptionsServiceImpl extends ServiceImpl<WebOptionsMapper, WebOptionsDO> implements IWebOptionsService {

    /**
     * 保存配置
     *
     * @param key
     * @param value
     */
    @Override
    public void saveOption(String key, String value) {
        // 判断是否有同样的key（key字段在数据库中有唯一索引）
        LambdaUpdateWrapper<WebOptionsDO> lambdaUpdateWrapper = new LambdaUpdateWrapper<>();
        lambdaUpdateWrapper.eq(WebOptionsDO::getOptionKey, key);

        WebOptionsDO webOptionsDO = new WebOptionsDO();
        webOptionsDO.setOptionKey(key);
        webOptionsDO.setOptionValue(value);
        saveOrUpdate(webOptionsDO, lambdaUpdateWrapper);
    }

    /**
     * 获取配置
     *
     * @param key
     * @return
     */
    @Override
    public JSONArray getOption(String key) {
        JSONArray jsonArray = new JSONArray();
        LambdaQueryWrapper<WebOptionsDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(WebOptionsDO::getOptionKey, key);
        WebOptionsDO webOptionsDO = getOne(lambdaQueryWrapper);
        // 这里比较复杂，前端不好循环找到这些数据，所以通过后端改为JsonArray形式
        if (webOptionsDO != null) {
            JSONObject jsonObject = JSONObject.parseObject(webOptionsDO.getOptionValue());
            for (Map.Entry<String, Object> entry : jsonObject.entrySet()) {
                JSONObject json = new JSONObject();
                json.put("code", entry.getKey());
                json.put("value", entry.getValue());
                jsonArray.add(json);
            }
        }
        return jsonArray;
    }

    /**
     * 获取配置
     *
     * @param key
     * @return JSONObject
     */
    @Override
    public JSONObject getOptionByKey(String key) {
        LambdaQueryWrapper<WebOptionsDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(WebOptionsDO::getOptionKey, key);
        WebOptionsDO webOptionsDO = getOne(lambdaQueryWrapper);
        if (webOptionsDO != null) {
            return JSONObject.parseObject(webOptionsDO.getOptionValue());
        }
        return null;
    }

    /**
     * 获取配置指定参数项
     *
     * @param key
     * @param value
     * @return JSONObject
     */
    @Override
    public String getOptionByKey(String key, String value) {
        LambdaQueryWrapper<WebOptionsDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(WebOptionsDO::getOptionKey, key);
        WebOptionsDO webOptionsDO = getOne(lambdaQueryWrapper);
        if (webOptionsDO != null) {
            JSONObject jsonObject = JSONObject.parseObject(webOptionsDO.getOptionValue());
            // 判断key是否存在
            if (jsonObject.containsKey(value)) {
                return jsonObject.getString(value);
            } else {
                return null;
            }
        }
        return null;
    }

}
