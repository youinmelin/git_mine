package com.forgetfulr.common.utils;

import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;
import lombok.extern.slf4j.Slf4j;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

/**
 * 图片操作
 *
 * @author caorui
 * @date 2020-07-21 20:19
 * Revision History
 * Date      		Programmer       Notes
 * 2020-07-21   	 caorui		     Initial
 */
@Slf4j
public class ImageUtil {

    /**
     * 解析二维码，使用google的zxing  javase-2.2.jar   core-2.2.jar
     * <p>
     * 参考文档
     * https://www.geek-share.com/detail/2721211876.html
     *
     * @param @param  filepath
     * @param @return
     * @param @throws IOException
     * @param @throws NotFoundException    设定文件
     * @return String    返回类型
     * @throws
     * @Title: decode
     * @Description: 解析远程URL二维码
     */

    public static String imgDecode(String imgUrl) {
        try {
            HttpURLConnection httpUrl;
            URL url = new URL(imgUrl);
            httpUrl = (HttpURLConnection) url.openConnection();
            httpUrl.connect();
            BufferedInputStream bis = new BufferedInputStream(httpUrl.getInputStream());
            BufferedImage bufferedImage = ImageIO.read(bis);
            LuminanceSource source = new BufferedImageLuminanceSource(
                    bufferedImage);
            Binarizer binarizer = new HybridBinarizer(source);
            BinaryBitmap bitmap = new BinaryBitmap(binarizer);
            HashMap<DecodeHintType, Object> decodeHints = new HashMap<DecodeHintType, Object>();
            decodeHints.put(DecodeHintType.CHARACTER_SET, "UTF-8");
            Result result = new MultiFormatReader().decode(bitmap, decodeHints);
            return result.getText();
        } catch (NotFoundException e) {
//            log.error("二维码解析NotFoundException");
            e.printStackTrace();
        } catch (IOException e) {
//            log.error("二维码解析IOException");
            e.printStackTrace();
        }
        return null;
    }
}
