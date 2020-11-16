package com.yujia.topbang.api.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.yujia.topbang.api.entity.IndustryDO;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * 行业分类测试
 *
 * @author caorui
 * @date 2020-09-21 00:04
 * Revision History
 * Date      		Programmer       Notes
 * 2020-09-21   	 caorui		     Initial
 */
@Slf4j
@SpringBootTest
@RunWith(SpringJUnit4ClassRunner.class)
public class CategoryTest {

    /**
     * 行业
     */
    @Autowired
    private IIndustryService industryService;

    /**
     * 白写，这文件内容不全
     */
    @Test
    public void insertTest() {
        try {
            Resource resource = new ClassPathResource("static/category.json");
            StringBuilder sb = new StringBuilder();
            String line;

            BufferedReader br = new BufferedReader(new InputStreamReader(resource.getInputStream()));
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            String str = sb.toString();
            JSONArray jsonArray = JSON.parseArray(str);

            for (int i = 0; i < jsonArray.size(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                // 先判断层级，如果是一级就直接添加，否则就需要查询父级，然后添加
                if (jsonObject.getInteger("level") == 1) {
                    industryService.addNode(null,
                            jsonObject.getString("class1"),
                            jsonObject.getString("name"),
                            jsonObject.getString("remark"));
                } else {
                    // 这里要先找到对应的父级ID
                    LambdaQueryWrapper<IndustryDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
                    if (jsonObject.getInteger("level") == 2) {
                        lambdaQueryWrapper.eq(IndustryDO::getCode, jsonObject.getString("class1"));
                    } else {
                        lambdaQueryWrapper.eq(IndustryDO::getCode, jsonObject.getString("class1") + jsonObject.getString("class" + (jsonObject.getInteger("level") - 1)));
                    }
                    lambdaQueryWrapper.last("limit 1");
                    IndustryDO industryDO = industryService.getOne(lambdaQueryWrapper);

                    industryService.addNode(industryDO.getId(),
                            jsonObject.getString("class1") + jsonObject.getString("class" + jsonObject.getInteger("level")),
                            jsonObject.getString("name"),
                            jsonObject.getString("remark"));
                }
                // System.out.println(jsonObject.toJSONString());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 新版行业导入
     */
    @Test
    public void insertTest2() {
        try {
            Resource resource = new ClassPathResource("static/2017.json");
            StringBuilder sb = new StringBuilder();
            String line;

            BufferedReader br = new BufferedReader(new InputStreamReader(resource.getInputStream()));
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            String str = sb.toString();
            JSONArray jsonArray = JSON.parseArray(str);

            for (int i = 0; i < jsonArray.size(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                Long id = null;
                id = industryService.addNode(null,
                        jsonObject.getString("code"),
                        jsonObject.getString("name"),
                        "");
                // 存在子级的情况
                if (jsonObject.containsKey("children") && jsonObject.getJSONArray("children").size() > 0) {
                    setChild(id, jsonObject.getString("children"));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void setChild(Long id, String str) {
        JSONArray jsonArray = JSON.parseArray(str);
        for (int i = 0; i < jsonArray.size(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            Long idd = null;
            // 先把自己提交进去
            idd = industryService.addNode(id,
                    jsonObject.getString("code"),
                    jsonObject.getString("name"),
                    "");
            // 存在子级的情况
            if (jsonObject.containsKey("children") && jsonObject.getJSONArray("children").size() > 0) {
                setChild(idd, jsonObject.getString("children"));
            }
        }
    }

}
