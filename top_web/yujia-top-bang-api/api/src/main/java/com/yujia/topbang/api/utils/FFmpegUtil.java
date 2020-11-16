package com.yujia.topbang.api.utils;

import lombok.extern.slf4j.Slf4j;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.FrameGrabber;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * FFmpeg 工具类
 *
 * @author caorui
 * @date 2020-09-14 17:09
 * Revision History
 * Date      		Programmer       Notes
 * 2020-09-14   	 caorui		     Initial
 */
@Slf4j
public class FFmpegUtil {

    /**
     * 获取视频总时间
     *
     * @return
     */
    public static int getVideoTime(String video_path) {
        try {
            HttpURLConnection httpUrl;
            URL url = new URL(video_path);
            httpUrl = (HttpURLConnection) url.openConnection();
            httpUrl.connect();
            BufferedInputStream bis = new BufferedInputStream(httpUrl.getInputStream());
            long duration = 0L;
            FFmpegFrameGrabber ff = new FFmpegFrameGrabber(bis);
            try {
                ff.start();
                duration = ff.getLengthInTime() / (1000 * 1000);
                ff.stop();
            } catch (FrameGrabber.Exception e) {
                e.printStackTrace();
            }
            return (int) duration;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static String secToTime(int time) {
        String timeStr = null;
        int hour = 0;
        int minute = 0;
        int second = 0;
        if (time <= 0)
            return "00:00";
        else {
            minute = time / 60;
            if (minute < 60) {
                second = time % 60;
                timeStr = unitFormat(minute) + ":" + unitFormat(second);
            } else {
                hour = minute / 60;
                if (hour > 99)
                    return "99:59:59";
                minute = minute % 60;
                second = time - hour * 3600 - minute * 60;
                timeStr = unitFormat(hour) + ":" + unitFormat(minute) + ":" + unitFormat(second);
            }
        }
        return timeStr;
    }

    public static String unitFormat(int i) {
        String retStr = null;
        if (i >= 0 && i < 10)
            retStr = "0" + Integer.toString(i);
        else
            retStr = "" + i;
        return retStr;
    }
}
