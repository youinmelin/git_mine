package com.yujia.topbang.api.service.impl;

import com.yujia.topbang.api.entity.UserLoginHistoryDO;
import com.yujia.topbang.api.mapper.UserLoginHistoryMapper;
import com.yujia.topbang.api.service.IUserLoginHistoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 用户登录历史 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-09-07
 */
@Service
public class UserLoginHistoryServiceImpl extends ServiceImpl<UserLoginHistoryMapper, UserLoginHistoryDO> implements IUserLoginHistoryService {

}
