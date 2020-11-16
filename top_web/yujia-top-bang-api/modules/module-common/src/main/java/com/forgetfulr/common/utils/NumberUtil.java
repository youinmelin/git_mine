package com.forgetfulr.common.utils;

import com.forgetfulr.common.enums.RedisDBEnum;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 关于数字的工具类
 *
 * @author caorui
 */
@Component
public class NumberUtil {

    private static final String[] unit = new String[]{"", "万", "亿", "万亿", "亿亿"};

    /**
     * 判断当前数值是否可以被除数整除：可以返回true，否则返回false
     *
     * @param source
     * @param divisor
     * @return
     */
    public static boolean isExactDivision(BigDecimal source, BigDecimal divisor) {
        BigDecimal[] remainder = source.divideAndRemainder(divisor);
        return remainder[1].compareTo(BigDecimal.ZERO) == 0;
    }

    /**
     * 根据当前值，返回指定长度字符串
     * 长度不够，最左边用‘0’补齐
     *
     * @param num 待格式化数字
     * @param len 格式化后长度
     * @return
     */
    public static String getStringZeroFormat(long num, int len) {
        StringBuilder snum = new StringBuilder(String.valueOf(num));
        while (snum.length() < len) {
            snum.insert(0, "0");
        }
        return snum.toString();
    }

    /**
     * 数字金额大写转换
     *
     * @param n
     * @return
     */
    public static String digitUppercase(double n) {
        String[] fraction = {"角", "分"};
        String[] digit = {"零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"};
        String[][] unit = {{"元", "万", "亿"}, {"", "拾", "佰", "仟"}};

        String head = n < 0 ? "负" : "";
        n = Math.abs(n);

        StringBuilder s = new StringBuilder();
        for (int i = 0; i < fraction.length; i++) {
            s.append((digit[(int) (Math.floor(n * 10 * Math.pow(10, i)) % 10)] + fraction[i]).replaceAll("(零.)+", ""));
        }
        if (s.length() < 1) {
            s = new StringBuilder("整");
        }
        int integerPart = (int) Math.floor(n);

        for (int i = 0; i < unit[0].length && integerPart > 0; i++) {
            String p = "";
            for (int j = 0; j < unit[1].length && n > 0; j++) {
                p = digit[integerPart % 10] + unit[1][j] + p;
                integerPart = integerPart / 10;
            }
            s.insert(0, p.replaceAll("(零.)*零$", "").replaceAll("^$", "零") + unit[0][i]);
        }
        return head + s.toString().replaceAll("(零.)*零元", "元").replaceFirst("(零.)+", "").replaceAll("(零.)+", "零").replaceAll("^整$", "零元整");
    }

    /**
     * 转换数额单位
     *
     * @param amount
     * @return
     */
    public static Map transferAmountUnit(BigDecimal amount) {
        Map result = new HashMap();
        String resultUnit = "";
        String resultNumber;
        int index = 0;
        BigDecimal tenThousand = BigDecimal.valueOf(10000);
        BigDecimal amountResult = amount;
        while (amountResult.divide(tenThousand, 2, RoundingMode.HALF_UP).compareTo(BigDecimal.ONE) == 1) {
            index++;
            amountResult = amountResult.divide(tenThousand, 2, RoundingMode.HALF_UP);
        }
        DecimalFormat df = new DecimalFormat("#,##0.00");
        if (index == 0) {
            resultNumber = df.format(amount);
        } else {
            resultNumber = df.format(amountResult);
            resultUnit = unit[index];
        }
        result.put("unit", resultUnit);
        result.put("amount", resultNumber);
        return result;
    }

    /**
     * 获取UUID
     *
     * @return
     */
    public static String getUUID() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    /**
     * 获取32位随机数
     *
     * @return
     */
    public static String getRandomNum() {
        String prefixKey = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        long increment = CacheUtil.increment("RandomNum" + prefixKey, 1, RedisDBEnum.DB_SEQUENCE);
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS"))
                + NumberUtil.getStringZeroFormat(increment, 7)
                + (int) ((Math.random() * 9 + 1) * 10000000);
    }

    /**
     * 获取16位随机数
     *
     * @return
     */
    public static String getShortRandomNum() {
        String prefixKey = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        long increment = CacheUtil.increment("ShortRandomNum" + prefixKey, 1, RedisDBEnum.DB_SEQUENCE);
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"))
                + NumberUtil.getStringZeroFormat(increment, 5)
                + (int) ((Math.random() * 9 + 1) * 1000);
    }

    /**
     * 生成api接口唯一ID
     * 规则：
     * UUID+年月日时分秒毫秒+自增7位+随机8位 组合的字符串MD5加密
     *
     * @return
     */
    public static String getSeqId() {
        String prefixKey = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        long increment = CacheUtil.increment("SeqId" + prefixKey, 1, RedisDBEnum.DB_SEQUENCE);
        return ArithmeticUtil.MD5(UUID.randomUUID().toString()
                + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS"))
                + NumberUtil.getStringZeroFormat(increment, 7)
                + (int) ((Math.random() * 9 + 1) * 10000000));
    }

    /**
     * 生成Token唯一验证ID
     * 规则：
     * UUID+年月日时分秒毫秒+自增7位+随机8位 组合的字符串MD5加密
     *
     * @return
     */
    public static String getSessionId() {
        String prefixKey = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        long increment = CacheUtil.increment("SessionId" + prefixKey, 1, RedisDBEnum.DB_SEQUENCE);
        return ArithmeticUtil.MD5(UUID.randomUUID().toString()
                + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS"))
                + NumberUtil.getStringZeroFormat(increment, 7)
                + (int) ((Math.random() * 9 + 1) * 10000000));
    }

    /**
     * 生成随机6位数字短信验证码
     */
    public static String createSmsVerifyCode() {
//        return "123456";
        StringBuilder code = new StringBuilder();
        Random random = new Random();
        while (code.length() < 6) {
            code.append(random.nextInt(10));
        }
        return code.toString();
    }

    /**
     * 生成随机8位的数字
     *
     * @return
     */
    public static String getEightCode() {
        StringBuilder code = new StringBuilder();
        Random random = new Random();
        while (code.length() < 8) {
            code.append(random.nextInt(10));
        }
        return code.toString();
    }

    /**
     * 按指定规律生成标的编码
     * 生成borrowCode：YJ + 当前日期 + 自增的三位序列
     * 每新的一天，编号重新从1开始计数
     *
     * @return
     */
    public static String createDealCode() {
        // 将LocalDate类型转化为String
        String todayString = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String key = "YJ" + todayString;

        long increment = CacheUtil.increment(key, 1, RedisDBEnum.DB_SEQUENCE);
        return key + NumberUtil.getStringZeroFormat(increment, 3);
    }

    /**
     * 获取交易订单编码
     *
     * @param dealCode
     * @return
     */
    public static String createDealOrderCode(String dealCode) {
        long increment = CacheUtil.increment(dealCode, 1, RedisDBEnum.DB_SEQUENCE);
        return dealCode + NumberUtil.getStringZeroFormat(increment, 5);
    }

    /**
     * IPv4地址转换为int类型数字
     */
    public static int ip2Integer(String ipv4Addr) {
        // 判断是否是ip格式的
        if (!isIPv4Address(ipv4Addr))
            throw new RuntimeException("Invalid ip address");

        // 匹配数字
        Pattern pattern = Pattern.compile("\\d+");
        Matcher matcher = pattern.matcher(ipv4Addr);
        int result = 0;
        int counter = 0;
        while (matcher.find()) {
            int value = Integer.parseInt(matcher.group());
            result = (value << 8 * (3 - counter++)) | result;
        }
        return result;
    }

    /**
     * 判断是否为ipv4地址
     */
    private static boolean isIPv4Address(String ipv4Addr) {
        String lower = "(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])"; // 0-255的数字
        String regex = lower + "(\\." + lower + "){3}";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(ipv4Addr);
        return matcher.matches();
    }

    /**
     * 将int数字转换成ipv4地址
     */
    public static String integer2Ip(int ip) {
        StringBuilder sb = new StringBuilder();
        int num = 0;
        boolean needPoint = false; // 是否需要加入'.'
        for (int i = 0; i < 4; i++) {
            if (needPoint) {
                sb.append('.');
            }
            needPoint = true;
            int offset = 8 * (3 - i);
            num = (ip >> offset) & 0xff;
            sb.append(num);
        }
        return sb.toString();
    }
}
