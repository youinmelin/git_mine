package com.forgetfulr.common.utils;

import com.forgetfulr.common.enums.DateFormatEnum;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * @author caorui
 */
public class DateUtil {

    /**
     * @param date           字符串类型日期
     * @param dateFormatEnum 日期格式
     * @return date类型日期
     * @throws ParseException
     */
    public static Date StringToDate(String date, DateFormatEnum dateFormatEnum) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatEnum.getFormat());
        return simpleDateFormat.parse(date);
    }

    /**
     * Date转String
     *
     * @param date
     * @param dateFormatEnum
     * @return
     */
    public static String DateToString(Date date, DateFormatEnum dateFormatEnum) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatEnum.getFormat());
        return simpleDateFormat.format(date);
    }

    /**
     * 时间格式化
     *
     * @param date
     * @param dateFormatEnum
     * @return
     */
    public static String StringToString(String date, DateFormatEnum dateFormatEnum) throws ParseException {
        Date temp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
        return new SimpleDateFormat(dateFormatEnum.getFormat()).format(temp);
    }

    /**
     * @param date           字符串类型日期
     * @param dateFormatEnum 日期格式
     * @return long类型日期
     * @throws ParseException
     */
    public static long StringToLong(String date, DateFormatEnum dateFormatEnum) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatEnum.getFormat());
        long time = 0L;
        if (date != null) {
            time = simpleDateFormat.parse(date).getTime();
        }

        return time;
    }

    /**
     * MongoDBDate转JavaDate
     *
     * @param date
     * @return
     * @throws ParseException
     */
    public static Date MongoDBDateToJavaDate(String date) throws ParseException {
        // 注意是空格+UTC
        date = date.replace("Z", " UTC");
        // 注意格式化的表达式
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS Z");
        return format.parse(date);
    }

    /**
     * MongoDBDate转JavaDate转自定义格式
     *
     * @param date
     * @param dateFormatEnum
     * @return
     * @throws ParseException
     */
    public static String MongoDBDateToJavaDate(String date, DateFormatEnum dateFormatEnum) throws ParseException {
        // 注意是空格+UTC
        date = date.replace("Z", " UTC");
        // 注意格式化的表达式
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS Z");
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatEnum.getFormat());
        return simpleDateFormat.format(format.parse(date));
    }

    /**
     * 时间戳转换成日期格式字符串
     *
     * @param seconds 精确到秒的字符串
     * @return
     */
    public static String timeStamp2Date(String seconds, DateFormatEnum dateFormatEnum) {
        if (seconds == null || seconds.isEmpty() || seconds.equals("null")) {
            return "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat(dateFormatEnum.getFormat());
        // 判断是毫秒还是秒
        if (seconds.length() == 10) {
            return sdf.format(new Date(Long.parseLong(seconds + "000")));
        } else if (seconds.length() == 13) {
            return sdf.format(new Date(Long.parseLong(seconds)));
        } else {
            return null;
        }
    }

    /**
     * 获取当前的时间戳参数
     *
     * @return
     */
    public static String getTimeStamp() {
        return String.valueOf(LocalDateTime.now().toEpochSecond(ZoneOffset.of("+8")));
    }

    /**
     * 获取当前的时间戳参数
     *
     * @return
     */
    public static Long getLongTimeStamp() {
        return LocalDateTime.now().toEpochSecond(ZoneOffset.of("+8"));
    }

    /**
     * 获取N分钟之后的时间戳参数
     *
     * @param minute
     * @return
     */
    public static Long getTimeStampAddMinute(Integer minute) {
        return LocalDateTime.now().toEpochSecond(ZoneOffset.of("+8")) + minute * 60;
    }

    /**
     * 获取N分钟之后时间
     *
     * @param time
     * @param minute
     * @return
     * @throws ParseException
     */
    public static String getDateAddMinute(String time, Integer minute) {
        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DateFormatEnum.DATEFORMAT_yyyy_MM_dd_HH_mm_ss.getFormat());
            Date date = simpleDateFormat.parse(time);
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(date);
            calendar.add(Calendar.MINUTE, minute);
            return simpleDateFormat.format(calendar.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 获取N天之后的时间戳参数
     *
     * @param day
     * @return
     */
    public static Long getTimeStampAddDay(Integer day) {
        return LocalDateTime.now().toEpochSecond(ZoneOffset.of("+8")) + day * 24 * 60 * 60;
    }

    /**
     * 获取N天后时间
     *
     * @param day 把日期往后增加一天.正数往后推,负数往前推
     * @return
     */
    public static Date getDateAddDay(Integer day) {
        Date date = new Date();//取时间
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, day);
        return calendar.getTime();
    }

    public static String getDateAddDay(Integer day, DateFormatEnum dateFormatEnum) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatEnum.getFormat());
        //取时间
        Date date = new Date();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, day);
        return simpleDateFormat.format(calendar.getTime());
    }

    /**
     * 获取N天后时间
     *
     * @param time
     * @param day
     * @return
     * @throws ParseException
     */
    public static String getDateAddDay(String time, Integer day) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DateFormatEnum.DATEFORMAT_yyyy_MM_dd_HH_mm_ss.getFormat());
        Date date = simpleDateFormat.parse(time);
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, day);
        return simpleDateFormat.format(calendar.getTime());
    }

    public static String getDateAddDay(String time, Integer day, DateFormatEnum dateFormatEnum) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatEnum.getFormat());
        Date date = simpleDateFormat.parse(time);
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, day);
        return simpleDateFormat.format(calendar.getTime());
    }

    /**
     * 获取指定月后的时间
     *
     * @param time
     * @param month
     * @param dateFormatEnum
     * @return
     * @throws ParseException
     */
    public static String getDateAddMonth(String time, Integer month, DateFormatEnum dateFormatEnum) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatEnum.getFormat());
        Date date = simpleDateFormat.parse(time);
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.MONTH, month);
        return simpleDateFormat.format(calendar.getTime());
    }

    /**
     * 获取指定月后的时间
     *
     * @param month
     * @param dateFormatEnum
     * @return
     * @throws ParseException
     */
    public static String getDateAddMonth(Integer month, DateFormatEnum dateFormatEnum) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatEnum.getFormat());
        Date date = new Date();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.MONTH, month);
        return simpleDateFormat.format(calendar.getTime());
    }

    /**
     * 获取指定年后的时间
     *
     * @param year
     * @param dateFormatEnum
     * @return
     * @throws ParseException
     */
    public static String getDateAddYear(Integer year, DateFormatEnum dateFormatEnum) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatEnum.getFormat());
        Date date = new Date();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(Calendar.YEAR, year);
        return simpleDateFormat.format(calendar.getTime());
    }

    /**
     * 根据生日获取年龄(周岁算法)
     *
     * @param birthday 生日格式'yyyy-MM-dd'
     * @return
     */
    public static Integer getAgeByBirthday(String birthday) {
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.parse(birthday, dateTimeFormatter);
        LocalDate today = LocalDate.now();
        int age = today.getYear() - date.getYear();
        if (today.getMonthValue() < date.getMonthValue()) {
            age--;
        } else if (today.getMonthValue() == date.getMonthValue()) {
            if (today.getDayOfYear() < date.getDayOfYear()) {
                age--;
            }
        }
        //不满一周岁算一岁
        if (age < 1) {
            age = 1;
        }
        return age;
    }

    public static String getDate() {
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat(DateFormatEnum.DATEFORMAT_yyyy_MM_dd_HH_mm_ss.getFormat());
        return sdf.format(date);
    }

    public static String getYYYYMMDD() {
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        return sdf.format(date);
    }

    public static String getYYYYMMDD(DateFormatEnum dateFormatEnum) {
        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat(dateFormatEnum.getFormat());
        return sdf.format(date);
    }

    public static String getYYYY() {
        Calendar cal = Calendar.getInstance();
        return String.valueOf(cal.get(Calendar.YEAR));
    }

    /**
     * 将秒间隔转换为xx小时xx分钟格式
     *
     * @param second
     * @return
     */
    public static Map transferSecondToHourMinute(Long second) {
        Map result = new HashMap<>();
        if (second == null) {
            result.put("hour", 0);
            result.put("minute", 0);
            return result;
        }
        Long hour = second / 3600;
        Long leftSecond = second % 3600;
        Long minute = leftSecond / 60;
        result.put("hour", hour);
        result.put("minute", minute);
        return result;
    }

    /**
     * 获取指定时间的指定参数
     *
     * @param date
     * @param dateFormatEnum
     * @return
     */
    public static int dateGet(String date, DateFormatEnum dateFormatEnum) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime ldt = LocalDateTime.parse(date, formatter);
        switch (dateFormatEnum) {
            // 年
            case DATEFORMAT_yyyy:
                return ldt.getYear();
            // 月
            case DATEFORMAT_MM:
                return ldt.getMonthValue();
            // 日
            case DATEFORMAT_dd:
                return ldt.getDayOfMonth();
            // 时
            case DATEFORMAT_HH:
                return ldt.getHour();
            // 分
            case DATEFORMAT_mm:
                return ldt.getMinute();
            // 秒
            case DATEFORMAT_ss:
                return ldt.getSecond();
            default:
                return -1;
        }
    }

    /**
     * UTC时间转JavaDate
     *
     * @param utcTime
     * @return
     * @throws ParseException
     */
    public static String utc2JavaDate(String utcTime) throws ParseException {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
        //设置时区UTC
        df.setTimeZone(TimeZone.getTimeZone("UTC"));
        //格式化，转当地时区时间
        Date after = df.parse(utcTime);
        df.applyPattern("yyyy-MM-dd HH:mm:ss");
        //默认时区
        df.setTimeZone(TimeZone.getDefault());
        return df.format(after);
    }
}
