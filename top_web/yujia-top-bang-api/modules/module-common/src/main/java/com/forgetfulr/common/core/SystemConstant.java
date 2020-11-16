package com.forgetfulr.common.core;

/**
 * 系统常量定义
 *
 * @author caorui
 */
public class SystemConstant {

    /**
     * 系统编码字符
     */
    public static final String SYSTEM_CHARSET_UTF8 = "UTF-8";

    /**
     * session中用户ID属性名称
     */
    public static final String SESSION_USERID = "userId";

    /**
     * 用户自增序列
     */
    public static final String USER_SEQUENCE = "USER_SEQUENCE";

    /**
     * 管理后台Session ID
     */
    public static final String SESSION_MANAGE_USERID = "manageUserId";

    /**
     * session中爱名网用户ID属性名称
     */
    public static final String SESSION_AMW_USERID = "amwUserId";

    /**
     * 爱名网用户基本信息
     */
    public static final String SESSION_AMW_USERCONTENT = "amwUserContent";

    /**
     * session中爱名网请求时的State
     */
    public static final String SESSION_AMW_STATE = "amwState";

    /**
     * QQ openid
     */
    public static final String SESSION_QQ_OPENID = "qqOpenId";

    /**
     * session中QQ请求时的State
     */
    public static final String SESSION_QQ_STATE = "qqState";

    /**
     * 微信OpenId
     */
    public static final String SESSION_WX_OPENID = "wxOpenId";

    /**
     * 微信UnionId
     */
    public static final String SESSION_WX_UNIONID = "wxUnionId";

    /**
     * 微信State
     */
    public static final String SESSION_WX_STATE = "wxState";

    /**
     * 响应头类型
     */
    public static final String RESPONSE_CONTENTTYPE_APPLICATIONJSON = "application/json";


    /**
     * 后端验证码关键字
     */
    public static final String KAPTCHA_CODE_KEY = "kaptchaCode";

    /**
     * 前端验证码关键字
     */
    public static final String WEB_KAPTCHA_CODE_KEY = "webKaptchaCode";

    /**
     * 字典表redis存储键
     */
    public static final String DICT_MAP = "DICT_MAP_";

    /**
     * 注册验证码前缀
     */
    public static final String REGISTER_VERIFY_CODE_KEY = "REGISTER_VERIFY_CODE_KEY_";

    /**
     * 登录验证码前缀
     */
    public static final String LOGIN_VERIFY_CODE_KEY = "LOGIN_VERIFY_CODE_";

    /**
     * 激活验证码前缀
     */
    public static final String ACTIVE_VERIFY_CODE_KEY = "ACTIVE_VERIFY_CODE_";

    /**
     * 忘记密码验证码前缀
     */
    public static final String FORGET_VERIFY_CODE_KEY = "FORGET_VERIFY_CODE_KEY_";

    /**
     * 四要素验证码前缀
     */
    public static final String FOUR_FACTOR_VERIFY_CODE_KEY = "FOUR_FACTOR_VERIFY_CODE_KEY_";

    /**
     * 删除绑定卡验证码前缀
     */
    public static final String DEL_BANKCARD_VERIFY_CODE_KEY = "DEL_BANKCARD_VERIFY_CODE_KEY_";

    /**
     * 手机短信频率
     */
    public static final String MOBILE_SMS_QPS = "MOBILE_SMS_QPS_";
    /**
     * 买家当天取消订单次数
     */
    public static final String BUYER_CANCEL_COUNT = "BUYER_CANCEL_COUNT_";
    /**
     * 用户佣金表锁Key
     */
    public static final String USER_COMMISSION_LOCK = "USER_COMMISSION_LOCK_";
    /**
     * 用户签到锁Key
     */
    public static final String USER_SIGN_LOCK = "USER_SIGN_LOCK_";
    /**
     * 绑定邮箱验证码前缀
     */
    public static final String BIND_EMAIL_VERIFY_CODE_KEY = "BIND_EMAIL_VERIFY_CODE_KEY_";
    /**
     * 绑定手机验证码前缀
     */
    public static final String BIND_MOBILE_VERIFY_CODE_KEY = "BIND_MOBILE_VERIFY_CODE_KEY_";
    /**
     * 验证原有邮箱
     */
    public static final String CHECK_OLD_EMAIL_VERIFY_CODE_KEY = "CHECK_OLD_EMAIL_VERIFY_CODE_KEY_";
    /**
     * 验证原有手机号
     */
    public static final String CHECK_OLD_MOBILE_VERIFY_CODE_KEY = "CHECK_OLD_MOBILE_VERIFY_CODE_KEY_";
}
