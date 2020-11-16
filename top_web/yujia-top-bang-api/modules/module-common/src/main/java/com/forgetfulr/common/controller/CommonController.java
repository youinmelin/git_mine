package com.forgetfulr.common.controller;

import com.alibaba.fastjson.JSONObject;
import com.forgetfulr.common.core.R;
import com.forgetfulr.common.core.SystemConstant;
import com.forgetfulr.common.enums.RedisDBEnum;
import com.forgetfulr.common.utils.CacheUtil;
import com.forgetfulr.common.utils.NumberUtil;
import com.google.code.kaptcha.Producer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.util.Base64;

/**
 * 通用Controller
 *
 * @author caorui
 * @date 2019-01-16
 */
@RestController("commonController")
@RequestMapping("/api/common")
public class CommonController {

    @Autowired
    private Producer captchaProducer;

    /**
     * 获取后台管理验证码
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/mgrCaptcha", method = RequestMethod.GET)
        public R getMgrCaptchaImage() throws Exception {
            String uuid = NumberUtil.getUUID();
            // 生成验证码
            String capText = captchaProducer.createText();
            BufferedImage bi = captchaProducer.createImage(capText);
            // 创建编码对象
            Base64.Encoder base64 = Base64.getEncoder();
            // 创建字符流
            ByteArrayOutputStream bs = new ByteArrayOutputStream();
            ImageIO.write(bi, "jpg", bs);
            JSONObject jsonObject = new JSONObject();
            // 配置imgToken
            jsonObject.put("img", base64.encodeToString(bs.toByteArray()));
            // 验证码=4位数字+几号+星期几
            // LocalDateTime localDateTime = LocalDateTime.now();
            // capText = capText + localDateTime.getDayOfMonth() + "" + localDateTime.getDayOfWeek().getValue();
            // UUID为key，验证码为value，放入Redis，登录时带进来UUID和验证码，解决layuiAdmin中不使用session的问题
            // 有效期十分钟，防止恶意攻击此接口导致大量无用的缓存常驻
            CacheUtil.set(SystemConstant.KAPTCHA_CODE_KEY + uuid,
                    capText, 600L, RedisDBEnum.DB_TEMP);
            jsonObject.put("imgToken", uuid);
            return R.ok().put("data", jsonObject);
    }
}
