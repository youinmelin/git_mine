package com.forgetfulr.common.utils;

import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

/**
 * URL工具类
 *
 * @author caorui
 * @date 2020-07-13 23:49
 * Revision History
 * Date      		Programmer       Notes
 * 2020-07-13   	 caorui		     Initial
 */
public class UriUtils {

    /**
     * 获取URL中的参数
     * 该方法不是最优的方法，但目前来说胜在好用
     *
     * @param strUrl
     * @param param
     * @return
     */
    public static String splitUrlParam(String strUrl, String param) {
        try {
            URL url = new URL(strUrl);
            // 为了处理含有特殊字符的URL，这里对参数进行编码
            String[] params = URLEncoder.encode(url.getQuery()).split("%26");
            Map<String, String> map = new HashMap<>();
            for (String item : params) {
                String[] kv = item.split("%3D");
                map.put(kv[0], kv[1]);
            }
            return map.get(param);
        } catch (Exception e) {
            return null;
        }
    }
}
