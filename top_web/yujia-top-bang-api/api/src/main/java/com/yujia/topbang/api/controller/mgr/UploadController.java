package com.yujia.topbang.api.controller.mgr;

import com.alibaba.fastjson.JSONObject;
import com.aliyun.oss.OSSClient;
import com.forgetfulr.common.core.R;
import com.forgetfulr.common.utils.NumberUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * OSS上传接口
 *
 * @author caorui
 */
@Slf4j
@RestController("mgrUploadController")
@RequestMapping("/api/mgr/upload")
public class UploadController {

    @Value("${ali.access-key-id}")
    private String accessKeyId;

    @Value("${ali.access-key-secret}")
    private String accessKeySecret;

    @Value("${ali.oss.endpoint}")
    private String ossEndpoint;

    @Value("${ali.oss.bucket}")
    private String ossBucket;

    @Value("${ali.oss.img-url}")
    private String ossImgUrl;

    @Value("${ali.oss.model}")
    private String ossModel;

    @RequestMapping(value = "/oss/{type}", method = RequestMethod.POST)
    public R ossUploadFile(@PathVariable String type, @RequestParam(value = "file") MultipartFile file,
                           String reportDate) {

        if (file == null) {
            log.warn("upload file is null");
            return R.error("文件不能为空");
        }
        String fileKey = ossModel + "/image";

        // 上传的文件名防止冲突，需要特殊处理
        String fileName = NumberUtil.getRandomNum();
        fileName += "." + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
        switch (type) {
            case "bank":
                //银行卡
                fileKey = fileKey + "/bank/" + fileName;
                break;

            case "card":
                //身份证
                fileKey = fileKey + "/card/" + fileName;
                break;

            case "banner":
                //广告
                fileKey = fileKey + "/banner/" + fileName;
                break;

            default:
                fileKey = fileKey + "/" + type + "/" + fileName;
                break;

        }
        OSSClient ossClient = new OSSClient(ossEndpoint, accessKeyId, accessKeySecret);
        try {
            ossClient.putObject(ossBucket, fileKey, file.getInputStream());
            // Layui 这里比较特殊，需要转换一下
            JSONObject json = new JSONObject();
            json.put("src", ossImgUrl + "/" + fileKey);
            json.put("title", "");
            return R.ok().put("data", json);
        } catch (IOException e) {
            log.warn("oss upload file error:{}", e.getMessage());
            return R.error();
        } finally {
            ossClient.shutdown();
        }
    }
}
