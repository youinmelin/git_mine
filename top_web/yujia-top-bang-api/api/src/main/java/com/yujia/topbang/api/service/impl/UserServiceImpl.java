package com.yujia.topbang.api.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.forgetfulr.common.core.SystemConstant;
import com.forgetfulr.common.enums.RedisDBEnum;
import com.forgetfulr.common.enums.errorcode.UserErrorEnum;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.exception.ParamException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.*;
import com.yujia.topbang.api.entity.UserCardDO;
import com.yujia.topbang.api.entity.UserCompanyDO;
import com.yujia.topbang.api.entity.UserDO;
import com.yujia.topbang.api.entity.UserLoginHistoryDO;
import com.yujia.topbang.api.mapper.UserMapper;
import com.yujia.topbang.api.service.*;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
//import javafx.scene.control.Label;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.stereotype.Service;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * <p>
 * 用户 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-08-07
 */
@Slf4j
@Service
@AllArgsConstructor
public class UserServiceImpl extends ServiceImpl<UserMapper, UserDO> implements IUserService {

    /**
     * 用户登录历史
     */
    private final IUserLoginHistoryService userLoginHistoryService;

    /**
     * 用户实名
     */
    private final IUserCardService userCardService;

    /**
     * 企业实名
     */
    private final IUserCompanyService userCompanyService;

    /**
     * 发送手机验证码
     *
     * @param userDO
     */
    @Override
    public void sendRegSmsVeryCode(UserDO userDO) {
        // 先校验验证码（先去掉，前端不需要验证码）
//        if (ObjectUtil.isNullOrEmpty(userDO.getVeryCode())
//                || ObjectUtil.isNullOrEmpty(userDO.getVeryCodeToken())) {
//            // 验证码错误
//            throw new UserException(UserErrorEnum.veryCodeWrong);
//        }
//        String sessionCaptchaCode = CacheUtil.get(SystemConstant.KAPTCHA_CODE_KEY + userDO.getVeryCodeToken(), RedisDBEnum.DB_TEMP);
//        if (sessionCaptchaCode == null
//                || "".equals(sessionCaptchaCode)
//                || !sessionCaptchaCode.equalsIgnoreCase(userDO.getVeryCode())) {
//            // 验证码错误
//            throw new UserException(UserErrorEnum.veryCodeWrong);
//        }
//        // 上诉验证码用完就要删掉，防止重放攻击
//        CacheUtil.delKey(SystemConstant.KAPTCHA_CODE_KEY + userDO.getVeryCodeToken(), RedisDBEnum.DB_TEMP);

        if (StringUtils.isEmpty(userDO.getPhone())) {
            throw new UserException("手机号不能为空");
        }
        // 验证手机号是否正确
        if (!CertIDUtil.isMobile(userDO.getPhone())) {
            throw new UserException(UserErrorEnum.mobileFormatError.getErrorCode(),
                    UserErrorEnum.mobileFormatError.getMsg());
        }
        // 验证手机号码
        LambdaQueryWrapper<UserDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(UserDO::getPhone, userDO.getPhone());
        List<UserDO> users = list(lambdaQueryWrapper);
        if (users != null && users.size() > 0) {
            throw new UserException("当前手机号码[" + userDO.getPhone() + "]已注册");
        }
        String smsVerifyCode = "123456"; //NumberUtil.createSmsVerifyCode();
        String smsContent = MessageFormat.format("验证码为{0}，10分钟内输入有效，如果不您本人操作请忽略。任何索要验证码的都是骗子，千万别给！",
                smsVerifyCode);
        try {
            // 发消息（这里涉及到消息队列了。但是部署的机器不足以支撑一个完整的消息队列系统，所以这里只能直接调用发送）
//                NoticeUtil.sendMsg(0L, mobile, NoticeTypeEnum.phone.getType().toString()
//                        , "手机注册验证码", smsContent, null);
            // 有效期十分钟
            CacheUtil.set(SystemConstant.REGISTER_VERIFY_CODE_KEY + userDO.getPhone(), smsVerifyCode, 600L, RedisDBEnum.DB_TEMP);
        } catch (Exception e) {
            throw new UserException("保存验证码失败");
        }
    }

    /**
     * 发送找回密码验证码
     *
     * @param userDO
     */
    @Override
    public void sendForgetPhoneCode(UserDO userDO) {
        if (StringUtils.isEmpty(userDO.getPhone())) {
            throw new UserException("手机号不能为空");
        }
        // 验证手机号是否正确
        if (!CertIDUtil.isMobile(userDO.getPhone())) {
            throw new UserException(UserErrorEnum.mobileFormatError.getErrorCode(),
                    UserErrorEnum.mobileFormatError.getMsg());
        }
        // 验证手机号码
        LambdaQueryWrapper<UserDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(UserDO::getPhone, userDO.getPhone());
        List<UserDO> users = list(lambdaQueryWrapper);
        if (users == null || users.size() <= 0) {
            throw new UserException("当前手机号码[" + userDO.getPhone() + "]未注册");
        }
        String smsVerifyCode = "123456"; //NumberUtil.createSmsVerifyCode();
        String smsContent = MessageFormat.format("验证码为{0}，10分钟内输入有效，如果不您本人操作请忽略。任何索要验证码的都是骗子，千万别给！",
                smsVerifyCode);
        try {
            // 发消息（这里涉及到消息队列了。但是部署的机器不足以支撑一个完整的消息队列系统，所以这里只能直接调用发送）
//                NoticeUtil.sendMsg(0L, mobile, NoticeTypeEnum.phone.getType().toString()
//                        , "手机注册验证码", smsContent, null);
            // 有效期十分钟
            CacheUtil.set(SystemConstant.FORGET_VERIFY_CODE_KEY + userDO.getPhone(), smsVerifyCode, 600L, RedisDBEnum.DB_TEMP);
        } catch (Exception e) {
            throw new UserException("保存验证码失败");
        }
    }

    /**
     * 注册
     *
     * @param userDO
     * @return
     */
    @Override
    public JSONObject register(UserDO userDO) {
        // 验证身份证号码
        if (!ObjectUtil.isNullOrEmpty(userDO.getIdCard())) {
            // 存在才校验（公司注册不需要）
            if (!CertIDUtil.isCertID(userDO.getIdCard())) {
                throw new UserException("请输入正确的身份证号码");
            }
        }
        if (StringUtils.isEmpty(userDO.getPhone())) {
            throw new ParamException("手机号不能为空");
        }
        // 验证手机号是否正确
        if (!CertIDUtil.isMobile(userDO.getPhone())) {
            throw new UserException(UserErrorEnum.mobileFormatError.getErrorCode(),
                    UserErrorEnum.mobileFormatError.getMsg());
        }
        // 2020年07月20日 更新需求，去除短信验证码校验
        if (StringUtils.isEmpty(userDO.getSmsVeryCode())) {
            throw new ParamException("手机验证码不能为空");
        }
        String verifyCode = CacheUtil.get(SystemConstant.REGISTER_VERIFY_CODE_KEY + userDO.getPhone(), RedisDBEnum.DB_TEMP);
        if (verifyCode == null) {
            throw new ParamException("手机验证码已过期");
        }
        if (!verifyCode.equals(userDO.getSmsVeryCode())) {
            throw new ParamException("手机验证码错误");
        }
        if (StringUtils.isEmpty(userDO.getUserName())) {
            throw new ParamException("用户名不能为空");
        }
        if (userDO.getRole() != null && userDO.getRole() == 1) {
            if (ObjectUtil.isNullOrEmpty(userDO.getName())) {
                throw new ParamException("姓名不能为空");
            }
        }
        // 上面验证都过了，就直接删除缓存
        CacheUtil.delKey(SystemConstant.REGISTER_VERIFY_CODE_KEY + userDO.getPhone(), RedisDBEnum.DB_TEMP);
        // 验证手机号有没有被占用（同时防止重放攻击）
        LambdaQueryWrapper<UserDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(UserDO::getPhone, userDO.getPhone());
        List<UserDO> users = list(lambdaQueryWrapper);
        if (users != null && users.size() > 0) {
            throw new UserException("当前手机号码[" + userDO.getPhone() + "]已注册");
        }

        // 原密码和确认密码不一致
        if (!userDO.getPasswd().equals(userDO.getConfirmPasswd())) {
            throw new UserException("两次输入密码不一致");
        }
        // 创建用户账号 用户只输入了手机号以及密码，其余基本信息等开户回调后update
        userDO.setId(createUserId());
        userDO.setPasswd(ArithmeticUtil.loginmd5(userDO.getConfirmPasswd()));
        // 姓名已改为前端传进来
        // userDO.setName("匿名" + userDO.getId());

        save(userDO);
        // 记录登录历史（注册成功就记录一次）
        UserLoginHistoryDO userLoginHistoryDO = new UserLoginHistoryDO();
        userLoginHistoryDO.setUserId(userDO.getId());
        userLoginHistoryService.save(userLoginHistoryDO);

        // 注册成功就返回token，因为还有下一步
        return getUserToken(userDO.getId());
    }

    private static final Pattern userSeqPattern = Pattern.compile("4+|6{2,}|8{2,}");

    /**
     * 创建用户ID
     * 规则：不可包含4；对包含66、666、6666、88、8888、8888账号保留
     *
     * @return
     */
    private Long createUserId() {
        String userId = CacheUtil.get(SystemConstant.USER_SEQUENCE, RedisDBEnum.DB_WEB_USER);
        // 如果为空，则自动创建
        if (userId == null) {
            userId = "10000";
            CacheUtil.set(SystemConstant.USER_SEQUENCE, userId, RedisDBEnum.DB_WEB_USER);
        }
        long id = Long.parseLong(userId);

        id++;
        while (userSeqPattern.matcher(String.valueOf(id).substring(1)).find()) {
            id++;
        }
        CacheUtil.set(SystemConstant.USER_SEQUENCE, String.valueOf(id), RedisDBEnum.DB_WEB_USER);

        return id;
    }

    /**
     * 找回密码
     *
     * @param userDO
     */
    @Override
    public void forgetPasswd(UserDO userDO) {
        if (StringUtils.isEmpty(userDO.getPhone())) {
            throw new ParamException("手机号不能为空");
        }
        // 验证手机号是否正确
        if (!CertIDUtil.isMobile(userDO.getPhone())) {
            throw new UserException(UserErrorEnum.mobileFormatError.getErrorCode(),
                    UserErrorEnum.mobileFormatError.getMsg());
        }
        if (StringUtils.isEmpty(userDO.getSmsVeryCode())) {
            throw new ParamException("手机验证码不能为空");
        }
        String verifyCode = CacheUtil.get(SystemConstant.FORGET_VERIFY_CODE_KEY + userDO.getPhone(), RedisDBEnum.DB_TEMP);
        if (verifyCode == null) {
            throw new ParamException("手机验证码已过期");
        }
        if (!verifyCode.equals(userDO.getSmsVeryCode())) {
            throw new ParamException("手机验证码错误");
        }
        // 上面验证都过了，就直接删除缓存
        CacheUtil.delKey(SystemConstant.REGISTER_VERIFY_CODE_KEY + userDO.getPhone(), RedisDBEnum.DB_TEMP);
        // 验证手机号有没有被占用（同时防止重放攻击）
        LambdaQueryWrapper<UserDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(UserDO::getPhone, userDO.getPhone());
        List<UserDO> users = list(lambdaQueryWrapper);
        if (users == null || users.size() <= 0) {
            throw new UserException("当前手机号码[" + userDO.getPhone() + "]未注册");
        }
        // 原密码和确认密码不一致
        if (!userDO.getPasswd().equals(userDO.getConfirmPasswd())) {
            throw new UserException("两次输入密码不一致");
        }

        // 修改用户密码（只能取第一个修改，因为有可能存在同个手机号注册多次问题，虽然进行了唯一校验，但是并不能保证绝对）
        UserDO user = users.get(0);
        user.setPasswd(ArithmeticUtil.loginmd5(userDO.getConfirmPasswd()));
        updateById(user);
    }

    /**
     * 用户登录
     *
     * @param userDO
     * @return
     */
    @Override
    public JSONObject userLogin(UserDO userDO) {
        if (CertIDUtil.isMobile(userDO.getName())) {
            userDO.setPhone(userDO.getName());
        } else if (CertIDUtil.isID(userDO.getName())) {
            userDO.setId(Long.valueOf(userDO.getName()));
        } else {
            throw new UserException(UserErrorEnum.accountError.getErrorCode(),
                    UserErrorEnum.accountError.getMsg());
        }
        // 加密密码
        String webPassword = ArithmeticUtil.loginmd5(userDO.getPasswd());
        LambdaQueryWrapper<UserDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.isNotEmpty(userDO.getPhone())) {
            lambdaQueryWrapper.eq(UserDO::getPhone, userDO.getPhone());
        }
        if (userDO.getId() != null && userDO.getId() > 0) {
            lambdaQueryWrapper.eq(UserDO::getId, userDO.getId());
        }
        lambdaQueryWrapper.eq(UserDO::getPasswd, webPassword);
        List<UserDO> userDOList = list(lambdaQueryWrapper);
        // 没有找到对应用户信息
        if (userDOList == null || userDOList.size() <= 0) {
            throw new UserException(UserErrorEnum.accountOrPasswordError.getErrorCode(),
                    UserErrorEnum.accountOrPasswordError.getMsg());
        }
        // 数据不止一条
        if (userDOList.size() > 1) {
            throw new UserException(UserErrorEnum.accountIsMany.getErrorCode(),
                    UserErrorEnum.accountIsMany.getMsg());
        }
        // 这里由于身份不同跳转地址也不同，所以需要做区分
        JSONObject jsonObject = getUserToken(userDOList.get(0).getId());
        jsonObject.put("type", userDOList.get(0).getType());
        // 记录登录历史
        UserLoginHistoryDO userLoginHistoryDO = new UserLoginHistoryDO();
        userLoginHistoryDO.setUserId(userDOList.get(0).getId());
        userLoginHistoryService.save(userLoginHistoryDO);

        return jsonObject;
    }

    /**
     * 获取用户登录Token
     *
     * @param userId
     * @return
     */
    private JSONObject getUserToken(Long userId) {
        Map<String, String> map = new HashMap<>();
        String sessionId = NumberUtil.getSessionId();
        // 用户ID
        map.put("userId", (userId).toString());
        // 关联的SessionId
        map.put("sessionId", sessionId);
        String token = TokenUtil.create(map);
        Map<String, String> mapUserInfo = new HashMap<>();
        mapUserInfo.put("token", token);
        /**
         * 加入特殊校验
         * 规则：
         * 1.登录成功的userId当key，SessionId当value存一份
         * 2.SessionId当key，userId当value存一份
         * 3.正常请求时：验SessionId是否存在，存在校验userId是否相同（验userId可省略）
         * 4.已存在登录，再次登录时，通过userId找SessionId，然后删掉SessionId为key的数据，并修改userId为key的SessionId
         * 5.退出登录时，通过userId找到SessionId，然后删除两份数据
         * 6.校验token时，发现过期情况，同时删除两份数据
         * 7.存在盗用情况时，删除两份数据即可
         */

        // 查看是否存在userId对应的SessionId(重复登录情况)
        String oldSessionId = CacheUtil.hashGet("userId", userId.toString(), RedisDBEnum.DB_COMMON);
        if (!ObjectUtil.isNullOrEmpty(oldSessionId)) {
            // 删除对应的SessionId
            CacheUtil.hashDel("sessionId", oldSessionId, RedisDBEnum.DB_COMMON);
        }
        // UserID
        Map<String, String> mapUserId = new HashMap<>();
        mapUserId.put(userId.toString(), sessionId);
        CacheUtil.hashSet("userId", mapUserId, RedisDBEnum.DB_COMMON);
        // SessionId
        Map<String, String> mapSessionId = new HashMap<>();
        mapSessionId.put(sessionId, userId.toString());
        CacheUtil.hashSet("sessionId", mapSessionId, RedisDBEnum.DB_COMMON);

        JSONObject jsonObject = new JSONObject();
        jsonObject.putAll(mapUserInfo);
        return jsonObject;
    }

    /**
     * 用户分页
     *
     * @param userDO
     * @return
     */
    @Override
    public JSONObject getMgrPageList(UserDO userDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<UserDO> page = new Page<>();
            page.setCurrent(userDO.getPage());
            page.setSize(userDO.getLimit());
            page.addOrder(OrderItem.desc("id"));
            LambdaQueryWrapper<UserDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 用户ID
            if (!ObjectUtil.isNullOrEmpty(userDO.getId())) {
                lambdaQueryWrapper.eq(UserDO::getId, userDO.getId());
            }
            // 姓名
            if (!ObjectUtil.isNullOrEmpty(userDO.getName())) {
                lambdaQueryWrapper.like(UserDO::getName, userDO.getName());
            }
            // 手机号
            if (!ObjectUtil.isNullOrEmpty(userDO.getPhone())) {
                lambdaQueryWrapper.eq(UserDO::getPhone, userDO.getPhone());
            }
            // ID 倒序
            lambdaQueryWrapper.orderByDesc(UserDO::getId);
            page(page, lambdaQueryWrapper);
            List<UserDO> list = page.getRecords();
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get user page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 用户增改（实际只有修改）
     *
     * @param userDO
     * @return
     */
    @Override
    public void userSave(UserDO userDO) {
        // 性别
        if (ObjectUtil.isNullOrEmpty(userDO.getSex())) {
            userDO.setSex(0);
        }
        // 密码
        if (!ObjectUtil.isNullOrEmpty(userDO.getPasswd())) {
            userDO.setPasswd(ArithmeticUtil.loginmd5(userDO.getPasswd()));
        }
        // 用户ID
        if (ObjectUtil.isNullOrEmpty(userDO.getId())) {
            userDO.setId(createUserId());
        }
        saveOrUpdate(userDO);
    }

    /**
     * 退出登录
     */
    @Override
    public void logout() {
        String myToken = SystemUtil.appAccessToken();
        // 退出实际就是把token从Redis中删除
        JSONObject joPlayLoad = JSONObject.parseObject(new String(ArithmeticUtil.Base64Decode(myToken.split("\\.")[1])));
        // 先判断sessionId是否存在
        String sessionId = CacheUtil.hashGet("sessionId", joPlayLoad.getString("sessionId"), RedisDBEnum.DB_COMMON);
        // sessionId 存在才校验，否则直接返回
        if (!ObjectUtil.isNullOrEmpty(sessionId)) {
            // 删sessionsId为主键的缓存
            CacheUtil.hashDel("sessionId", joPlayLoad.getString("sessionId"), RedisDBEnum.DB_COMMON);
            // 删userId为主键的缓存
            CacheUtil.hashDel("userId", joPlayLoad.getString("userId"), RedisDBEnum.DB_COMMON);
        }
    }

    /**
     * 获取账户安全信息
     *
     * @param userId
     * @return
     */
    @Override
    public JSONObject getSecurity(Long userId) {
        JSONObject jsonObject = new JSONObject();
        UserDO userDO = getById(userId);
        // 用户信息
        jsonObject.put("userInfo", userDO);
        // 用户实名信息（个人）
        if (userDO.getType() == 0) {
            LambdaQueryWrapper<UserCardDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(UserCardDO::getUserId, userId);
            UserCardDO userCardDO = userCardService.getOne(lambdaQueryWrapper);
            jsonObject.put("userCard", userCardDO);
        } else if (userDO.getType() == 1) {
            // 企业（比较特殊，需要单独处理下）
            JSONObject jj = new JSONObject();
            LambdaQueryWrapper<UserCompanyDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(UserCompanyDO::getUserId, userId);
            UserCompanyDO userCompanyDO = userCompanyService.getOne(lambdaQueryWrapper);
            if (userCompanyDO != null) {
                jj.put("name", userCompanyDO.getUnitName());
                jj.put("cardno", userCompanyDO.getSocialCreditCode());
                jj.put("status", userCompanyDO.getStatus());
            }
            jsonObject.put("userCard", jj);
        }
        // 获取账户最后一次登录信息
        LambdaQueryWrapper<UserLoginHistoryDO> userLoginHistoryDOLambdaQueryWrapper = new LambdaQueryWrapper<>();
        userLoginHistoryDOLambdaQueryWrapper.eq(UserLoginHistoryDO::getUserId, userId);
        userLoginHistoryDOLambdaQueryWrapper.orderByDesc(UserLoginHistoryDO::getId);
        // 这里实际不用加这一句的，但是mybatis-plus组件getone出现错误，所以这里额外加一条
        userLoginHistoryDOLambdaQueryWrapper.last("limit 1");
        UserLoginHistoryDO userLoginHistoryDO = userLoginHistoryService.getOne(userLoginHistoryDOLambdaQueryWrapper);
        jsonObject.put("lastLogin", userLoginHistoryDO != null ? userLoginHistoryDO.getGmtCreate() : "");

        return jsonObject;

    }

    /**
     * 修改密码
     *
     * @param userDO
     */
    @Override
    public void setPasswd(UserDO userDO) {
        if (ObjectUtil.isNullOrEmpty(userDO.getId())) {
            throw new UserException("ID不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(userDO.getOldPasswd())) {
            throw new UserException("原密码不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(userDO.getPasswd())) {
            throw new UserException("新密码不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(userDO.getConfirmPasswd())) {
            throw new UserException("新确认密码不能为空");
        }
        String password = userDO.getPasswd();
        // 有效的，可登录的账号
        // userDO.setStatus(1);
        // 加密密码
        String webPassword = ArithmeticUtil.loginmd5(userDO.getOldPasswd());
        LambdaQueryWrapper<UserDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(UserDO::getId, userDO.getId());
        lambdaQueryWrapper.eq(UserDO::getPasswd, webPassword);
        List<UserDO> userDOList = list(lambdaQueryWrapper);
        // 数据不止一条
        if (userDOList == null || userDOList.size() > 1) {
            throw new UserException("账号错误");
        }
        // 没有找到对应用户信息
        if (userDOList.size() <= 0) {
            throw new UserException("原密码错误");
        } else {
            // 原密码和确认密码不一致
            if (!password.equals(userDO.getConfirmPasswd())) {
                throw new UserException("两次输入密码不一致");
            }
            UserDO userModifyDO = userDOList.get(0);
            userModifyDO.setPasswd(ArithmeticUtil.loginmd5(userDO.getConfirmPasswd()));
            updateById(userModifyDO);
            // 修改成功后，要删掉token信息，并要求重新登录
            String oldSessionId = CacheUtil.hashGet("userId", userDO.getId().toString(), RedisDBEnum.DB_COMMON);
            if (!ObjectUtil.isNullOrEmpty(oldSessionId)) {
                // 删除对应的SessionId
                CacheUtil.hashDel("sessionId", oldSessionId, RedisDBEnum.DB_COMMON);
                // 删除对应的UserId
                CacheUtil.hashDel("userId", userDO.getId().toString(), RedisDBEnum.DB_COMMON);
            }
        }
    }

}
