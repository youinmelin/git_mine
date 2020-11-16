package com.yujia.topbang.api.controller.web;

import com.forgetfulr.common.core.R;
import com.forgetfulr.common.utils.SystemUtil;
import com.yujia.topbang.api.entity.NoticeSendDO;
import com.yujia.topbang.api.service.INoticeSendService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 首页
 *
 * @author caorui
 * @date 2020-08-06 15:58
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-06   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("webNoticeController")
@RequestMapping("/api/web/notice")
public class NoticeController {

    // 消息
    private final INoticeSendService noticeSendService;

    /**
     * 消息列表
     *
     * @return
     */
    @PostMapping(value = "/getNoticeList")
    public R getNoticeList(@RequestBody NoticeSendDO noticeSendDO) {
        try {
            Long userId = SystemUtil.appUserId();
            noticeSendDO.setUserId(userId);
            return R.ok().put("data", noticeSendService.getWebPageList(noticeSendDO));
        } catch (Exception e) {
            return R.error();
        }
    }

}
