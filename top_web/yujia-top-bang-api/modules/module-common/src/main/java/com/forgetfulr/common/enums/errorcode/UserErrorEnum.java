package com.forgetfulr.common.enums.errorcode;

/**
 * 用户相关错误码
 *
 * @author caorui
 */
public enum UserErrorEnum {

    //100用户登录错误
    accountNotExist(100001, "账户不存在"),
    pwdOrAccountWrong(100002, "密码或账户错误"),
    notLoginOrExpired(100003, "没有登录或登录超时"),
    pleaseLoginFirst(100005, "请先登录"),
    invalidToken(100006, "无效的Token"),
    accountIsMany(100007, "当前登录方式存在多个账号，建议使用用户ID登录"),
    accountError(100009, "请使用用户ID、邮箱或手机号登录"),
    accountOrPasswordError(100010, "账号或密码错误"),
    existNotActiveAccount(100011, "已存在未激活账号"),
    veryCodeWrong(100012, "验证码错误"),
    mobileFormatError(101005, "手机号码格式错误"),

    weixinNoBindError(100013, "当前微信账号未绑定"),
    weixinManyBindError(100015, "当前微信账号存在多个绑定"),

    ;

    UserErrorEnum(Integer errorCode, String msg) {
        this.errorCode = errorCode;
        this.msg = msg;
    }

    private final Integer errorCode;

    private final String msg;

    public Integer getErrorCode() {
        return errorCode;
    }

    public String getMsg() {
        return msg;
    }
}
