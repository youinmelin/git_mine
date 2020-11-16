package com.yujia.topbang.api.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.FrameGrabber;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.*;

/**
 * 视频处理测试类
 *
 * @author caorui
 * @date 2020-09-14 17:15
 * Revision History
 * Date      		Programmer       Notes
 * 2020-09-14   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@SpringBootTest
@RunWith(SpringJUnit4ClassRunner.class)
public class FFmpegUtilTest {

    /**
     * 获取视频时长，单位为秒
     *
     * @return 时长（s）
     */
    @Test
    public void getVideoDuration() throws URISyntaxException, IOException {
        String videoUrl = "http://yujia.img.cdn.chabug.com/test/image/video/20200913172443156000000149765364.mp4";
        // File video = new File("http://yujia.img.cdn.chabug.com/test/image/video/20200913172443156000000149765364.mp4");
        HttpURLConnection httpUrl;
        URL url = new URL(videoUrl);
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
        log.info("视频时长" + duration);
    }


}
