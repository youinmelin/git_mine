package com.forgetfulr.common.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.forgetfulr.common.enums.RedisDBEnum;
import com.forgetfulr.common.geetest.GeetestLib;
import com.forgetfulr.common.geetest.GeetestLibResult;
import com.forgetfulr.common.utils.CacheUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * 极验验证
 *
 * @author caorui
 * @date 2020-08-03 19:49
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-03   	 caorui		     Initial
 */
@Slf4j
@RestController("webGeetestController")
@RequestMapping("/api/web")
public class GeetestController {

    @Value("${geetest.id:}")
    private String GEETEST_ID;
    @Value("${geetest.key:}")
    private String GEETEST_KEY;

    // 验证初始化接口，GET请求
    @GetMapping(value = "/geetest")
    public void doGet(HttpServletResponse response) throws IOException {
        /*
        必传参数
            digestmod 此版本sdk可支持md5、sha256、hmac-sha256，md5之外的算法需特殊配置的账号，联系极验客服
        自定义参数,可选择添加
            user_id 客户端用户的唯一标识，确定用户的唯一性；作用于提供进阶数据分析服务，可在register和validate接口传入，不传入也不影响验证服务的使用；若担心用户信息风险，可作预处理(如哈希处理)再提供到极验
            client_type 客户端类型，web：电脑上的浏览器；h5：手机上的浏览器，包括移动应用内完全内置的web_view；native：通过原生sdk植入app应用的方式；unknown：未知
            ip_address 客户端请求sdk服务器的ip地址
        */
        response.setContentType("application/json;charset=UTF-8");
        GeetestLib gtLib = new GeetestLib(GEETEST_ID, GEETEST_KEY);
        String userId = "test";
        String digestmod = "md5";
        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("digestmod", digestmod);
        paramMap.put("user_id", userId);
        paramMap.put("client_type", "web");
        paramMap.put("ip_address", "127.0.0.1");
        GeetestLibResult result = gtLib.register(digestmod, paramMap);
        // 有效期十分钟，防止恶意攻击此接口导致大量无用的缓存常驻
        JSONObject jsonObject = JSON.parseObject(result.getData());
        CacheUtil.set(GeetestLib.GEETEST_SERVER_STATUS_SESSION_KEY + jsonObject.getString("challenge"),
                String.valueOf(result.getStatus()), 600L, RedisDBEnum.DB_TEMP);
        // request.getSession().setAttribute("userId", userId);
        // 注意，不要更改返回的结构和值类型
        PrintWriter out = response.getWriter();
        out.println(result.getData());
    }
}
