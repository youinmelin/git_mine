package com.forgetfulr.admin.controller.mgr;

import com.forgetfulr.admin.service.IWebOptionsService;
import com.forgetfulr.common.core.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 网站设置
 *
 * @author caorui
 * @date 2020-07-01 15:16
 * Revision History
 * Date      		Programmer       Notes
 * 2020-07-01   	 caorui		     Initial
 */
@RestController("mgrWebOptionController")
@RequestMapping("/api/mgr/webOption")
public class WebOptionController {

    @Autowired
    private IWebOptionsService webOptionsService;

    /**
     * 保存配置
     *
     * @param key
     * @param requestBody
     * @return
     */
    @PostMapping(value = "/setOption/{key}")
    public R setOption(@PathVariable String key, @RequestBody String requestBody) {
        try {
            webOptionsService.saveOption(key, requestBody);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取配置
     *
     * @param key
     * @return
     */
    @GetMapping(value = "/getOption/{key}")
    public R getOption(@PathVariable String key) {
        try {
            return R.ok().put("data", webOptionsService.getOption(key));
        } catch (Exception e) {
            return R.error();
        }
    }
}
