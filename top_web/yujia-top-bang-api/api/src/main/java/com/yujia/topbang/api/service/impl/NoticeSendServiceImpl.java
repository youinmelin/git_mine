package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.exception.ParamException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.ObjectUtil;
import com.yujia.topbang.api.entity.NoticeContentDO;
import com.yujia.topbang.api.entity.NoticeSendDO;
import com.yujia.topbang.api.entity.NoticeSendVO;
import com.yujia.topbang.api.entity.UserDO;
import com.yujia.topbang.api.enums.NoticeTypeEnum;
import com.yujia.topbang.api.mapper.NoticeSendMapper;
import com.yujia.topbang.api.service.INoticeContentService;
import com.yujia.topbang.api.service.INoticeSendService;
import com.yujia.topbang.api.service.IUserService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 消息发送列表 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
@Slf4j
@Service
@AllArgsConstructor
public class NoticeSendServiceImpl extends ServiceImpl<NoticeSendMapper, NoticeSendDO> implements INoticeSendService {

    /**
     * 消息内容
     */
    private final INoticeContentService noticeContentService;

    /**
     * 用户
     */
    private final IUserService userService;

    /**
     * 新增消息
     *
     * @param noticeSendVO
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void noticeSend(NoticeSendVO noticeSendVO) {
        /**
         * 1.解析传入的数据
         * 2.插入消息内容表
         * 3.得到消息ID，批量插入消息发送列表
         * 4.消息分类型上送到消息队列（等）
         */

        String[] userIdArray = noticeSendVO.getUserId().split(",");
        // 有可能不是Long
        for (String item : userIdArray) {
            try {
                Long.parseLong(item);
            } catch (Exception e) {
                throw new ParamException("用户ID不合法");
            }
        }

        // 插入消息内容表
        NoticeContentDO noticeContentDO = new NoticeContentDO();
        noticeContentDO.setTitle(noticeSendVO.getTitle());
        noticeContentDO.setContent(noticeSendVO.getContent());
        noticeContentDO.setAppUrl(noticeSendVO.getAppUrl() != null ? noticeSendVO.getAppUrl() : "");
        noticeContentService.save(noticeContentDO);

        // 插入消息发送表
        List<NoticeSendDO> noticeSendDOList = new ArrayList<>();
        NoticeSendDO noticeSendDO;
        String str = "on";
        for (String item : userIdArray) {
            // 找到对应用户的信息
            UserDO userDO = new UserDO();
            // 涉及到用户ID是0的情况，直接补充邮箱和手机号
            if ("0".equals(item)) {
                if (ObjectUtil.isNullOrEmpty(noticeSendVO.getReceiveObject())) {
                    throw new UserException("消息接收者不能为空");
                }
                // 邮箱
//                userDO.setIsEmail(1);
//                userDO.setEmail(noticeSendVO.getReceiveObject());
//                // 手机
//                userDO.setIsMobile(1);
//                userDO.setMobile(noticeSendVO.getReceiveObject());
                // 站内信、微信和APP，不存在用户ID是0的情况下的推送。这里不做考虑
            } else {
                userDO = userService.getById(Long.parseLong(item));
            }
            if (userDO == null) {
                throw new UserException("未找到" + item + "的用户信息");
            }

            // 站内信
            if (!ObjectUtil.isNullOrEmpty(noticeSendVO.getWrite())
                    && noticeSendVO.getWrite().equals(str)) {
                noticeSendDO = new NoticeSendDO();
                noticeSendDO.setContentId(noticeContentDO.getId());
                noticeSendDO.setUserId(Long.parseLong(item));
                // 站内信是空白的，就是自己
                noticeSendDO.setReceiveObject("");
                noticeSendDO.setType(NoticeTypeEnum.write.getType());
                noticeSendDOList.add(noticeSendDO);
            }
            // 邮件
            if (!ObjectUtil.isNullOrEmpty(noticeSendVO.getMail())
                    && noticeSendVO.getMail().equals(str)) {
                noticeSendDO = new NoticeSendDO();
                noticeSendDO.setContentId(noticeContentDO.getId());
                noticeSendDO.setUserId(Long.parseLong(item));
                // 邮件就是用户的邮箱
//                if (userDO.getIsEmail().equals(1)) {
//                    noticeSendDO.setReceiveObject(userDO.getEmail());
//                } else {
                // 没绑定邮箱，就直接空白
                noticeSendDO.setReceiveObject("");
//                }
                noticeSendDO.setType(NoticeTypeEnum.mail.getType());
                noticeSendDOList.add(noticeSendDO);
            }
            // 手机
            if (!ObjectUtil.isNullOrEmpty(noticeSendVO.getPhone())
                    && noticeSendVO.getPhone().equals(str)) {
                noticeSendDO = new NoticeSendDO();
                noticeSendDO.setContentId(noticeContentDO.getId());
                noticeSendDO.setUserId(Long.parseLong(item));
                // 手机就是用户绑定的手机号
//                if (userDO.getIsMobile().equals(1)) {
//                    noticeSendDO.setReceiveObject(userDO.getMobile());
//                } else {
                // 没绑定手机，就直接空白
                noticeSendDO.setReceiveObject("");
//                }
                noticeSendDO.setType(NoticeTypeEnum.phone.getType());
                noticeSendDOList.add(noticeSendDO);
            }
            // 微信
            if (!ObjectUtil.isNullOrEmpty(noticeSendVO.getWeixin())
                    && noticeSendVO.getWeixin().equals(str)) {
                noticeSendDO = new NoticeSendDO();
                noticeSendDO.setContentId(noticeContentDO.getId());
                noticeSendDO.setUserId(Long.parseLong(item));
                // 微信这里暂时空白，目前没有对接微信公众号
                noticeSendDO.setReceiveObject("");
                noticeSendDO.setType(NoticeTypeEnum.weixin.getType());
                noticeSendDOList.add(noticeSendDO);
            }
            // APP
//            if (!ObjectUtil.isNullOrEmpty(noticeSendVO.getApp())
//                    && noticeSendVO.getApp().equals(str)) {
//                // 首先去拿对应的regId
//                JgPushRegDO jgPushRegDO = new JgPushRegDO();
//                jgPushRegDO.setUserId(Long.parseLong(item));
//                // 有极大的可能存在多条记录
//                List<JgPushRegDO> jgPushRegDOList = jgPushRegService.getList(jgPushRegDO);
//                if (jgPushRegDOList == null || jgPushRegDOList.size() <= 0) {
////                    throw new UserException("未找到" + item + "用户的APP注册信息");
//                } else {
//                    // 由于可能多条记录，这里额外加一层循环
//                    for (JgPushRegDO jg : jgPushRegDOList) {
//                        noticeSendDO = new NoticeSendDO();
//                        noticeSendDO.setContentId(noticeContentDO.getId());
//                        noticeSendDO.setUserId(jg.getUserId());
//                        noticeSendDO.setReceiveObject(jg.getRegId());
//                        noticeSendDO.setType(NoticeTypeEnum.app.getType());
//                        noticeSendDOList.add(noticeSendDO);
//                    }
//                }
//            }
        }
        if (noticeSendDOList.size() > 0) {
            saveBatch(noticeSendDOList);
        }
        // 根据返回回来的ID，添加到消息队列中。然后消费者消费消息
//        for (NoticeSendDO item : noticeSendDOList) {
//            RocketMQUtil.rocketMQ("noticeSend", item.getId().toString(), 1);
//        }
    }

    /**
     * 消息列表
     * 这里应该是视图查询，后面改
     *
     * @param noticeSendDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(NoticeSendDO noticeSendDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<NoticeSendDO> page = new Page<>();
            page.setCurrent(noticeSendDO.getPage());
            page.setSize(noticeSendDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<NoticeSendDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            page(page, lambdaQueryWrapper);
            List<NoticeSendDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get noticeSend page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 前端消息列表
     *
     * @param noticeSendDO
     * @return
     */
    @Override
    public JSONObject getWebPageList(NoticeSendDO noticeSendDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<NoticeSendDO> page = new Page<>();
            page.setCurrent(noticeSendDO.getPage());
            page.setSize(noticeSendDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<NoticeSendDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 用户ID
            lambdaQueryWrapper.eq(NoticeSendDO::getUserId, noticeSendDO.getUserId());
            // 只查站内信
            lambdaQueryWrapper.eq(NoticeSendDO::getType, NoticeTypeEnum.write.getType());
            page(page, lambdaQueryWrapper);
            List<NoticeSendDO> list = page.getRecords();
            for (NoticeSendDO item : list) {
                NoticeContentDO noticeContentDO = noticeContentService.getById(item.getContentId());
                item.setTitle(noticeContentDO.getTitle());
                item.setContent(noticeContentDO.getContent());
            }
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get noticeSend page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

}
