package com.forgetfulr.common.utils;

import org.apache.commons.lang3.StringUtils;

import java.util.Collection;
import java.util.Map;

/**
 * @author caorui
 * @date 2018/4/16
 */
public class ObjectUtil {

    /**
     * 判断obj是否为空为Null
     *
     * @param object
     * @return 为空为Null返回true
     */
    public static boolean isNullOrEmpty(Object object) {
        boolean result = (object instanceof String && StringUtils.isEmpty((String)object)) || (object instanceof String && object.toString().length() == 0);
        if (object == null) {
            return true;
        } else if (result) {
            return true;
        } else return object instanceof Long && Long.parseLong(object.toString()) == 0;
    }

    /**
     * 将字节数组转换为十六进制字符串
     *
     * @param byteArray
     * @return
     * @author diaoliwei
     * @date 2016-2-22
     */
    public static String byteToStr(byte[] byteArray) {
        StringBuilder strDigest = new StringBuilder();
        for (byte b : byteArray) {
            strDigest.append(byteToHexStr(b));
        }
        return strDigest.toString();
    }

    /**
     * 将字节转换为十六进制字符串
     *
     * @param mByte
     * @return
     * @author diaoliwei
     * @date 2016-2-22
     */
    private static String byteToHexStr(byte mByte) {
        char[] Digit = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
        char[] tempArr = new char[2];
        tempArr[0] = Digit[(mByte >>> 4) & 0X0F];
        tempArr[1] = Digit[mByte & 0X0F];
        return new String(tempArr);
    }

    public static boolean isEmpty(Collection<?> collection) {
        return isNull(collection) || collection.size() < 1;
    }

    public static boolean isEmpty(Map<?, ?> map) {
        return isNull(map) || map.size() < 1;
    }

    public static boolean isEmpty(Object object) {
        if (object instanceof Collection) {
            return isEmpty((Collection<?>) object);
        } else if (object instanceof Map) {
            return isEmpty((Map<?, ?>) object);
        }
        return isNull(object) || "".equals(object);
    }

    public static boolean isEmpty(Object[] object) {
        return isNull(object) || object.length < 1;
    }

    public static boolean isEmpty(String text) {
        return isNull(text) || text.length() < 1;
    }

    public static boolean isNotEmpty(Collection<?> collection) {
        return !isEmpty(collection);
    }

    public static boolean isNotEmpty(Map<?, ?> map) {
        return !isEmpty(map);
    }

    public static boolean isNotEmpty(Object object) {
        return !isEmpty(object);
    }

    public static boolean isNotEmpty(Object[] object) {
        return !isEmpty(object);
    }

    public static boolean isNotEmpty(String text) {
        return !isEmpty(text);
    }

    private static boolean isNull(Object object) {
        return object == null;
    }

    /**
     * 各种转化
     */
    public static Long toLong(Object o) {
        try {
            if (o != null) {
                return (Long) o;
            } else {
                return 0L;
            }
        } catch (Exception e) {
            return 0L;
        }
    }
}
