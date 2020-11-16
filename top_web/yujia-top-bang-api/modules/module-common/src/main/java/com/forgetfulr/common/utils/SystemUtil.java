package com.forgetfulr.common.utils;

import com.alibaba.fastjson.JSONObject;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.forgetfulr.common.core.SystemConstant;
import com.forgetfulr.common.enums.RedisDBEnum;
import com.forgetfulr.common.enums.errorcode.UserErrorEnum;
import com.forgetfulr.common.exception.UserException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Map;

/**
 * Mock，返回当前登录用户ID
 *
 * @author caorui
 */
public class SystemUtil {

    /**
     * 获取用户ID
     */
    public static Long userId() {
        Long userId;
        userId = (Long) getSession().getAttribute(SystemConstant.SESSION_USERID);
        return userId;
    }

    /**
     * 获取Header中的token信息
     *
     * @return
     */
    public static String accessToken() {
        return getRequest().getHeader("accessToken");
    }

    public static Long manageUserId() {
        return manageUserId(accessToken());
    }

    /**
     * 管理后台用户ID
     *
     * @return
     */
    public static Long manageUserId(String accessToken) {
        long manageUserId = 0L;

        if (ObjectUtil.isNullOrEmpty(accessToken)) {
            // 返回异常信息
            throw new UserException(UserErrorEnum.invalidToken.getErrorCode(),
                    UserErrorEnum.invalidToken.getMsg());
        } else {
            if (!ObjectUtil.isNullOrEmpty(accessToken)) {
                // 由于token加密了，这里要私钥解一下
                // TODO 空了研究下安全和性能的最优方案，目前只要读用户ID，就要解密并且读Redis，解密和网络开销大
                try {
                    String myToken;
                    // myToken = ArithmeticUtil.RSADecrypt(accessToken, "cert/token_pri.key");
                    // 先去掉加解密
                    myToken = accessToken;

                    Map<String, String> mapToken;
                    // 解析token第二段
                    JSONObject joPlayLoad = JSONObject.parseObject(new String(ArithmeticUtil.Base64Decode(myToken.split("\\.")[1])));
                    // 先判断sessionId是否存在
                    String sessionId = CacheUtil.hashGet("mgrSessionId", joPlayLoad.getString("mgrSessionId"), RedisDBEnum.DB_COMMON);
                    // sessionId 存在才校验
                    if (!ObjectUtil.isNullOrEmpty(sessionId)) {
                        try {
                            // 验证token，过期会报错
                            mapToken = TokenUtil.verify(myToken);
                            manageUserId = Long.parseLong(mapToken.get("mgrUserId"));
                        } catch (TokenExpiredException e) {
                            // 删sessionsId为主键的缓存
                            CacheUtil.hashDel("mgrSessionId", joPlayLoad.getString("mgrSessionId"), RedisDBEnum.DB_COMMON);
                            // 删userId为主键的缓存
                            CacheUtil.hashDel("mgrUserId", joPlayLoad.getString("mgrUserId"), RedisDBEnum.DB_COMMON);
                        }
                    } else {
                        throw new UserException(UserErrorEnum.invalidToken.getErrorCode(),
                                UserErrorEnum.invalidToken.getMsg());
                    }
                } catch (Exception e) {
                    throw new UserException(UserErrorEnum.invalidToken.getErrorCode(),
                            UserErrorEnum.invalidToken.getMsg());
                }
            }
        }
        return manageUserId;
    }

    /**
     * 获取登录用户token信息
     *
     * @return
     */
    public static String appAccessToken() {
        return getRequest().getHeader("My-Token");
    }

    /**
     * APP用户ID
     *
     * @return
     */
    public static Long appUserId() {
        return appUserId(appAccessToken());
    }

    public static Long appUserId(String myToken) {
        long appUserId = 0L;

        if (!ObjectUtil.isNullOrEmpty(myToken)) {
            try {
                Map<String, String> mapToken;
                // 解析token第二段
                JSONObject joPlayLoad = JSONObject.parseObject(new String(ArithmeticUtil.Base64Decode(myToken.split("\\.")[1])));
                // 先判断sessionId是否存在
                String sessionId = CacheUtil.hashGet("sessionId", joPlayLoad.getString("sessionId"), RedisDBEnum.DB_COMMON);
                // sessionId 存在才校验
                if (!ObjectUtil.isNullOrEmpty(sessionId)) {
                    try {
                        // 验证token，过期会报错
                        mapToken = TokenUtil.verify(myToken);
                        appUserId = Long.parseLong(mapToken.get("userId"));
                    } catch (TokenExpiredException e) {
                        // 删sessionsId为主键的缓存
                        CacheUtil.hashDel("sessionId", joPlayLoad.getString("sessionId"), RedisDBEnum.DB_COMMON);
                        // 删userId为主键的缓存
                        CacheUtil.hashDel("userId", joPlayLoad.getString("userId"), RedisDBEnum.DB_COMMON);
                    }
                } else {
                    throw new UserException(UserErrorEnum.invalidToken.getErrorCode(),
                            UserErrorEnum.invalidToken.getMsg());
                }
            } catch (Exception e) {
                throw new UserException(UserErrorEnum.invalidToken.getErrorCode(),
                        UserErrorEnum.invalidToken.getMsg());
            }

        }
        return appUserId;
    }

    /**
     * 获取前端验证码
     *
     * @return
     */
    public static String webKaptchaCodeKey() {
        return (String) getSession().getAttribute(SystemConstant.WEB_KAPTCHA_CODE_KEY);
    }

    public static HttpServletRequest getRequest() {
        return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    }

    public static HttpSession getSession() {
        return getRequest().getSession();
    }

    public static HttpSession getSession(boolean create) {
        return getRequest().getSession(create);
    }

    /**
     * 获取当前网络ip
     *
     * @return
     */
    public static String getIpAddress() {
        HttpServletRequest request = SystemUtil.getRequest();
        String ipAddress = request.getHeader("x-forwarded-for");
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getRemoteAddr();
            if (ipAddress.equals("127.0.0.1") || ipAddress.equals("0:0:0:0:0:0:0:1")) {
                //根据网卡取本机配置的IP
                InetAddress inet = null;
                try {
                    inet = InetAddress.getLocalHost();
                    ipAddress = inet.getHostAddress();
                } catch (UnknownHostException e) {
                    ipAddress = "0.0.0.0";
                }
            }
        }
        //对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        if (ipAddress != null && ipAddress.length() > 15) {
            //"***.***.***.***".length() = 15
            if (ipAddress.indexOf(",") > 0) {
                ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
            }
        }
        return ipAddress;
    }

    /**
     * 判断当前是否手机
     *
     * @return
     */
    public static boolean isMobileDevice() {
        /**
         * android : 所有android设备
         * mac os : iphone ipad
         * windows phone:Nokia等windows系统的手机
         */
        String agent = getRequest().getHeader("User-Agent");

        boolean isMoblie = false;
        String[] mobileAgents = {"iphone", "android", "ipad", "phone", "mobile", "wap", "netfront", "java", "opera mobi",
                "opera mini", "ucweb", "windows ce", "symbian", "series", "webos", "sony", "blackberry", "dopod",
                "nokia", "samsung", "palmsource", "xda", "pieplus", "meizu", "midp", "cldc", "motorola", "foma",
                "docomo", "up.browser", "up.link", "blazer", "helio", "hosin", "huawei", "novarra", "coolpad", "webos",
                "techfaith", "palmsource", "alcatel", "amoi", "ktouch", "nexian", "ericsson", "philips", "sagem",
                "wellcom", "bunjalloo", "maui", "smartphone", "iemobile", "spice", "bird", "zte-", "longcos",
                "pantech", "gionee", "portalmmm", "jig browser", "hiptop", "benq", "haier", "^lct", "320x320",
                "240x320", "176x220", "w3c ", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq", "bird", "blac",
                "blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco", "eric", "hipt", "inno", "ipaq", "java", "jigs",
                "kddi", "keji", "leno", "lg-c", "lg-d", "lg-g", "lge-", "maui", "maxo", "midp", "mits", "mmef", "mobi",
                "mot-", "moto", "mwbp", "nec-", "newt", "noki", "oper", "palm", "pana", "pant", "phil", "play", "port",
                "prox", "qwap", "sage", "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-", "siem",
                "smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-", "tosh", "tsm-", "upg1", "upsi", "vk-v",
                "voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw", "xda", "xda-",
                "Googlebot-Mobile"};
        if (agent != null) {
            for (String mobileAgent : mobileAgents) {
                if (agent.toLowerCase().contains(mobileAgent) && agent.toLowerCase().indexOf("windows nt") <= 0 && agent.toLowerCase().indexOf("macintosh") <= 0) {
                    isMoblie = true;
                    break;
                }
            }
        }
        return isMoblie;
    }

    /**
     * 获取爱名网登录State
     *
     * @return
     */
    public static String amwState() {
        return (String) getSession().getAttribute(SystemConstant.SESSION_AMW_STATE);
    }
}
