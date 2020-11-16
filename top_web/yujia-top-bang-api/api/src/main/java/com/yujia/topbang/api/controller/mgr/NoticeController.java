package com.yujia.topbang.api.controller.mgr;

import com.forgetfulr.common.core.R;
import com.forgetfulr.common.exception.ParamException;
import com.forgetfulr.common.exception.UserException;
import com.yujia.topbang.api.entity.NoticeSendDO;
import com.yujia.topbang.api.entity.NoticeSendVO;
import com.yujia.topbang.api.service.INoticeSendService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * 消息管理
 *
 * @author caorui
 * @date 2019-02-19
 */
@AllArgsConstructor
@RestController("mgrNoticeController")
@RequestMapping("/api/mgr/notice")
public class NoticeController {

    /**
     * 消息发送
     */
    private final INoticeSendService noticeSendService;

    /**
     * 消息发送添加
     *
     * @param noticeSendVO
     * @return
     */
    @RequestMapping(value = "/noticeInsert", method = RequestMethod.POST)
    public R userInsert(@RequestBody NoticeSendVO noticeSendVO) {
        try {
            noticeSendService.noticeSend(noticeSendVO);
            return R.ok();
        } catch (ParamException | UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 消息列表
     *
     * @param noticeSendDO
     * @return
     */
    @RequestMapping(value = "/getNoticeList", method = RequestMethod.POST)
    public R getAdminRoleList(@RequestBody NoticeSendDO noticeSendDO) {
        try {
            return R.ok().put("data", noticeSendService.getMgrPageList(noticeSendDO));
        } catch (Exception e) {
            return R.error();
        }
    }
}
