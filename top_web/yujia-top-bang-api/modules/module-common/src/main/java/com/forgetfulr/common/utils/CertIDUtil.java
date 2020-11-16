package com.forgetfulr.common.utils;

import com.alibaba.fastjson.JSONObject;
import com.forgetfulr.common.exception.CertIDException;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.regex.Pattern;

/**
 * 身份证解析工具
 *
 * @author caorui
 */
public class CertIDUtil {

    /**
     * 根据输入身份证ID，获取对应的出生年月、性别
     *
     * @param certID
     * @return map:key={birthday} value={yyyy-MM-dd},key={gender} value={0|1}
     */
    public static Map<String, String> analysisCertID(String certID) {
        if (certID.length() != 18) {
            throw new CertIDException("输入的日期长度不对");
        }
        Map<String, String> infos = new HashMap<>();
        String birthday = certID.substring(6, 14);
        birthday = birthday.substring(0, 4) + "-" + birthday.substring(4, 6) + "-" + birthday.substring(6);
        int gender = (int) certID.charAt(16);
        // 倒数第二位为偶数，则性别为女
        if (gender % 2 == 0) {
            gender = 0;
        } else {        // 奇数为男
            gender = 1;
        }
        infos.put("birthday", birthday);
        infos.put("gender", Integer.toString(gender));
        return infos;
    }

    private static final Pattern mobilePattern = Pattern.compile("^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[6])|(17[0,1,3,5-8])|(18[0-9])|(19[8,9]))\\d{8}$");

    /**
     * 验证输入是否为手机号
     *
     * @param mobile
     * @return
     */
    public static boolean isMobile(String mobile) {
        if (mobile == null) {
            return false;
        }

        return mobilePattern.matcher(mobile).find();
    }

//    private static final Pattern emailPattern = Pattern.compile("^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$");

    private static final Pattern emailPattern = Pattern.compile("^([A-Za-z0-9_\\-\\.\\u4e00-\\u9fa5])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,8})$");

    /**
     * 验证输入是否为电子邮件
     *
     * @param email
     * @return
     */
    public static boolean isEmail(String email) {
        if (email == null) {
            return false;
        }

        return emailPattern.matcher(email).find();
    }

    private static final Pattern idPattern = Pattern.compile("^[0-9]+$");

    /**
     * 判断输入是否为平台ID
     *
     * @param id
     * @return
     */
    public static boolean isID(String id) {
        if (id == null) {
            return false;
        }

        return idPattern.matcher(id).find();
    }

    private static final Pattern certIDPattern = Pattern.compile("(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}$)");

    /**
     * 判断身份证号码
     *
     * @param certID
     * @return
     */
    public static boolean isCertID(String certID) {
        if (Objects.isNull(certID)) {
            return false;
        }

        return certIDPattern.matcher(certID).find();
    }

    /**
     * 隐藏手机号
     *
     * @param phone
     * @return
     */
    public static String hidePhone(String phone) {
        if (isMobile(phone)) {
            return phone.substring(0, 3) + "****" + phone.substring(7, 11);
        } else {
            return "";
        }
    }

    /**
     * 隐藏邮箱
     *
     * @param email
     * @return
     */
    public static String hideEmail(String email) {
        if (isEmail(email)) {
            String[] em = email.split("@");
            return em[0].substring(0, 1) + "***@" + em[1];
        } else {
            return "";
        }
    }

    /**
     * 验证四要素
     *
     * @param name    姓名
     * @param idNo    身份证
     * @param cardNo  银行卡
     * @param phoneNo 手机号
     */
    public static boolean bankAuthenticate4(String name, String idNo, String cardNo, String phoneNo) {
        String host = "https://yunyidata.market.alicloudapi.com";
        String path = "/bankAuthenticate4";
        String appcode = "94da4cae0dfa460b9987906e457f9f0c";
        Map<String, String> headers = new HashMap<>();
        //最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
        headers.put("Authorization", "APPCODE " + appcode);
        //根据API的要求，定义相对应的Content-Type
        headers.put("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");

        StringBuilder sb = new StringBuilder();
        sb.append("ReturnBankInfo=YES");
        sb.append("&name").append("=").append(name);
        sb.append("&idNo").append("=").append(idNo);
        sb.append("&cardNo").append("=").append(cardNo);
        sb.append("&phoneNo").append("=").append(phoneNo);

        try {
            String response = HttpProtocolUtil.postSSLFormRequest(host + path, sb.toString(), headers);
            // 判断返回回来的参数，验证是否信息匹配
            JSONObject jsonObject = JSONObject.parseObject(response);
            return jsonObject.containsKey("respCode") && "0000".equals(jsonObject.getString("respCode"));
        } catch (Exception e) {
            return false;
        }
    }

}
