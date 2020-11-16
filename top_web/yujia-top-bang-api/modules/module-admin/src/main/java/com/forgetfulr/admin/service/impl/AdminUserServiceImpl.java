package com.forgetfulr.admin.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.forgetfulr.admin.entity.AdminUserDO;
import com.forgetfulr.admin.mapper.AdminUserMapper;
import com.forgetfulr.admin.service.IAdminUserService;
import com.forgetfulr.admin.service.IWebOptionsService;
import com.forgetfulr.common.core.SystemConstant;
import com.forgetfulr.common.enums.RedisDBEnum;
import com.forgetfulr.common.enums.errorcode.UserErrorEnum;
import com.forgetfulr.common.exception.DBException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.geetest.GeetestLib;
import com.forgetfulr.common.geetest.GeetestLibResult;
import com.forgetfulr.common.utils.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * <p>
 * 后台管理用户表 服务实现类
 * </p>
 *
 * @author caorui
 * @since 2020-06-29
 */
@Slf4j
@Service
public class AdminUserServiceImpl extends ServiceImpl<AdminUserMapper, AdminUserDO> implements IAdminUserService {

    @Value("${geetest.id:}")
    private String GEETEST_ID;
    @Value("${geetest.key:}")
    private String GEETEST_KEY;

    /**
     * 系统配置
     */
    @Autowired
    private IWebOptionsService webOptionsService;

    /**
     * 管理后台登录
     *
     * @param adminUserDO
     * @return
     */
    @Override
    public JSONObject adminLogin(AdminUserDO adminUserDO,
                                 String challenge,
                                 String seccode,
                                 String validate) {
        // 读取配置文件，判断是否进行极验验证
        String isGeetest = webOptionsService.getOptionByKey("loginConf", "isGeetest");
        if (isGeetest != null && isGeetest.equals("1")) {
            // 多加一步，校验极验验证，后期修改为根据配置文件判断是否校验
            GeetestLib gtLib = new GeetestLib(GEETEST_ID, GEETEST_KEY);
//        String challenge = request.getParameter(GeetestLib.GEETEST_CHALLENGE);
//        String validate = request.getParameter(GeetestLib.GEETEST_VALIDATE);
//        String seccode = request.getParameter(GeetestLib.GEETEST_SECCODE);
            int status = 0;
            String strUserId = "";
            try {
                // session必须取出值，若取不出值，直接当做异常退出
                // status = (Integer) request.getSession().getAttribute(GeetestLib.GEETEST_SERVER_STATUS_SESSION_KEY);
                // 不知道是我有问题还是它有问题，传进来的是34位，第一次请求返回的实际是32位，这里先截断测试
                String shortChallenge = challenge.substring(0, 32);
                String sessionGeetestStatusKey = CacheUtil.get(GeetestLib.GEETEST_SERVER_STATUS_SESSION_KEY + shortChallenge, RedisDBEnum.DB_TEMP);
                if (sessionGeetestStatusKey == null
                        || "".equals(sessionGeetestStatusKey)
                        || "0".equals(sessionGeetestStatusKey)) {
                    // 验证码错误
                    throw new UserException(UserErrorEnum.veryCodeWrong);
                }
                status = Integer.parseInt(sessionGeetestStatusKey);
                // 上诉验证码用完就要删掉，防止重放攻击
                CacheUtil.delKey(GeetestLib.GEETEST_SERVER_STATUS_SESSION_KEY + challenge, RedisDBEnum.DB_TEMP);
                // 这个userId参数传不传好像都可以，太麻烦了，先不传
                // strUserId = (String) request.getSession().getAttribute("userId");
            } catch (Exception e) {
                throw new UserException("session取key发生异常");
            }

            GeetestLibResult result = null;
            if (status == 1) {
            /*
            自定义参数,可选择添加
                user_id 客户端用户的唯一标识，确定用户的唯一性；作用于提供进阶数据分析服务，可在register和validate接口传入，不传入也不影响验证服务的使用；若担心用户信息风险，可作预处理(如哈希处理)再提供到极验
                client_type 客户端类型，web：电脑上的浏览器；h5：手机上的浏览器，包括移动应用内完全内置的web_view；native：通过原生sdk植入app应用的方式；unknown：未知
                ip_address 客户端请求sdk服务器的ip地址
            */
                Map<String, String> paramMap = new HashMap<String, String>();
                paramMap.put("user_id", strUserId);
                paramMap.put("client_type", "web");
                paramMap.put("ip_address", "127.0.0.1");
                result = gtLib.successValidate(challenge, validate, seccode, paramMap);
            } else {
                result = gtLib.failValidate(challenge, validate, seccode);
            }
            // 注意，不要更改返回的结构和值类型
            if (result.getStatus() != 1) {
                throw new UserException("非法请求");
            }
        }
        // 先校验验证码
        if (ObjectUtil.isNullOrEmpty(adminUserDO.getVeryCode())
                || ObjectUtil.isNullOrEmpty(adminUserDO.getVeryCodeToken())) {
            // 验证码错误
            throw new UserException(UserErrorEnum.veryCodeWrong);
        }
        String sessionCaptchaCode = CacheUtil.get(SystemConstant.KAPTCHA_CODE_KEY + adminUserDO.getVeryCodeToken(), RedisDBEnum.DB_TEMP);
        if (sessionCaptchaCode == null
                || "".equals(sessionCaptchaCode)
                || !sessionCaptchaCode.equalsIgnoreCase(adminUserDO.getVeryCode())) {
            // 验证码错误
            throw new UserException(UserErrorEnum.veryCodeWrong);
        }
        // 上诉验证码用完就要删掉，防止重放攻击
        CacheUtil.delKey(SystemConstant.KAPTCHA_CODE_KEY + adminUserDO.getVeryCodeToken(), RedisDBEnum.DB_TEMP);

        JSONObject jsonObject = new JSONObject();
        // 不知道为什么，这里自定义的方法找不到，先用MybatisPlus自带的方法查询
        LambdaQueryWrapper<AdminUserDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 有效的，可登录的账号
        lambdaQueryWrapper.eq(AdminUserDO::getStatus, 1L);
        lambdaQueryWrapper.eq(AdminUserDO::getUserName, adminUserDO.getUserName());
        lambdaQueryWrapper.eq(AdminUserDO::getPassword, ArithmeticUtil.SHA256(adminUserDO.getPassword()));
        List<AdminUserDO> adminUserDOList = list(lambdaQueryWrapper);
        if (adminUserDOList == null || adminUserDOList.size() <= 0) {
            throw new UserException("账号或密码错误");
        } else if (adminUserDOList.size() > 1) {
            throw new UserException("存在多个账户，禁止登录");
        } else {
            // 登录成功
            Long userId = adminUserDOList.get(0).getId();

            Map<String, String> map = new HashMap<>();
            String sessionId = NumberUtil.getSessionId();
            // 用户ID
            map.put("mgrUserId", (userId).toString());
            // 关联的SessionId
            map.put("mgrSessionId", sessionId);
            String token = TokenUtil.create(map);
            // token 要加密传回去（证书的路径在子项目中不是很方便，暂时去掉加密）
            // token = ArithmeticUtil.RSAEncrypt(token, "cert/token_pub.key");
            jsonObject.put("accessToken", token);
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
            String oldSessionId = CacheUtil.hashGet("mgrUserId", userId.toString(), RedisDBEnum.DB_COMMON);
            if (!ObjectUtil.isNullOrEmpty(oldSessionId)) {
                // 删除对应的SessionId
                CacheUtil.hashDel("mgrSessionId", oldSessionId, RedisDBEnum.DB_COMMON);
            }
            // UserID
            Map<String, String> mapUserId = new HashMap<>();
            mapUserId.put(userId.toString(), sessionId);
            CacheUtil.hashSet("mgrUserId", mapUserId, RedisDBEnum.DB_COMMON);
            // SessionId
            Map<String, String> mapSessionId = new HashMap<>();
            mapSessionId.put(sessionId, userId.toString());
            CacheUtil.hashSet("mgrSessionId", mapSessionId, RedisDBEnum.DB_COMMON);
        }
        return jsonObject;
    }

    /**
     * 退出登录
     */
    @Override
    public void logout() {
        String myToken = SystemUtil.accessToken();
        // 退出实际就是把token从Redis中删除
        JSONObject joPlayLoad = JSONObject.parseObject(new String(ArithmeticUtil.Base64Decode(myToken.split("\\.")[1])));
        // 先判断sessionId是否存在
        String sessionId = CacheUtil.hashGet("mgrSessionId", joPlayLoad.getString("mgrSessionId"), RedisDBEnum.DB_COMMON);
        // sessionId 存在才校验，否则直接返回
        if (!ObjectUtil.isNullOrEmpty(sessionId)) {
            // 删sessionsId为主键的缓存
            CacheUtil.hashDel("mgrSessionId", joPlayLoad.getString("mgrSessionId"), RedisDBEnum.DB_COMMON);
            // 删userId为主键的缓存
            CacheUtil.hashDel("mgrUserId", joPlayLoad.getString("mgrUserId"), RedisDBEnum.DB_COMMON);
        }
    }

    /**
     * 管理用户分页
     *
     * @param adminUserDO
     * @return
     */
    @Override
    public JSONObject getPageList(AdminUserDO adminUserDO) {
        JSONObject jsonObject = new JSONObject();
        try {
            Page<AdminUserDO> page = new Page<>();
            page.setCurrent(adminUserDO.getPage());
            page.setSize(adminUserDO.getLimit());
            // 由于前端问题，有些参数，传进来会是""，但是实际上没值，这里直接把所有的需要查询的条件都赋值null
            LambdaQueryWrapper<AdminUserDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            // 登录名
            if (!ObjectUtil.isNullOrEmpty(adminUserDO.getUserName())) {
                lambdaQueryWrapper.eq(AdminUserDO::getUserName, adminUserDO.getUserName());
            }
            // 真实姓名
            if (!ObjectUtil.isNullOrEmpty(adminUserDO.getName())) {
                lambdaQueryWrapper.eq(AdminUserDO::getName, adminUserDO.getName());
            }
            // 手机号
            if (!ObjectUtil.isNullOrEmpty(adminUserDO.getMobile())) {
                lambdaQueryWrapper.eq(AdminUserDO::getMobile, adminUserDO.getMobile());
            }
            // 邮箱
            if (!ObjectUtil.isNullOrEmpty(adminUserDO.getEmail())) {
                lambdaQueryWrapper.eq(AdminUserDO::getEmail, adminUserDO.getEmail());
            }
            page(page, lambdaQueryWrapper);
            List<AdminUserDO> list = page.getRecords();
            // TODO 这分页返回，每次都要这样写一遍，暂时还不知道那里可以全局定义这些东西，或者自定义实现返回内容
            jsonObject.put("total", page.getTotal());
            jsonObject.put("page", page.getCurrent());
            jsonObject.put("limit", page.getSize());
            jsonObject.put("list", list);
            return jsonObject;
        } catch (Exception e) {
            log.error("get adminUser page list error:{}", e.getMessage());
            throw new DBException();
        }
    }

    /**
     * 用户增改
     *
     * @param adminUserDO
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void userSave(AdminUserDO adminUserDO) {
        // 用户状态
        if (ObjectUtil.isNullOrEmpty(adminUserDO.getStatus())) {
            adminUserDO.setStatus(0);
        }
        // 性别
        if (ObjectUtil.isNullOrEmpty(adminUserDO.getSex())) {
            adminUserDO.setSex(0);
        }
        // 密码
        if (!ObjectUtil.isNullOrEmpty(adminUserDO.getPassword())) {
            adminUserDO.setPassword(ArithmeticUtil.SHA256(adminUserDO.getPassword()));
        } else {
            // 防止前端传进来个空字符串，给改没了
            adminUserDO.setPassword(null);
        }
        // 角色
        if (ObjectUtil.isNullOrEmpty(adminUserDO.getRoleId())) {
            adminUserDO.setRoleId(0);
        }
        saveOrUpdate(adminUserDO);
        // 判断是添加还是修改
//        if (ObjectUtil.isNullOrEmpty(adminUserDO.getId())) {
//            // 没有ID就是添加，执行save方法
//            save(adminUserDO);
//        } else {
//            // 否则执行update方法（理想状态应该是Mybatis-Plus自动区分增加还是修改的，不知道那里出了问题）
//            update(adminUserDO);
//        }

    }

    /**
     * 修改密码
     *
     * @param adminUserDO
     */
    @Override
    public void setPassword(AdminUserDO adminUserDO) {
        if (ObjectUtil.isNullOrEmpty(adminUserDO.getId())) {
            throw new UserException("ID不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(adminUserDO.getOldPassword())) {
            throw new UserException("原密码不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(adminUserDO.getPassword())) {
            throw new UserException("新密码不能为空");
        }
        if (ObjectUtil.isNullOrEmpty(adminUserDO.getConfirmPassword())) {
            throw new UserException("新确认密码不能为空");
        }
        String password = adminUserDO.getPassword();
        // 有效的，可登录的账号
        adminUserDO.setStatus(1);
        adminUserDO.setPassword(ArithmeticUtil.SHA256(adminUserDO.getOldPassword()));
        List<AdminUserDO> adminUserDOList = baseMapper.getLogin(adminUserDO);
        if (adminUserDOList == null || adminUserDOList.size() <= 0) {
            throw new UserException("原密码错误");
        } else {
            // 原密码和确认密码不一致
            if (!password.equals(adminUserDO.getConfirmPassword())) {
                throw new UserException("两次输入密码不一致");
            }
            // 修改数据库中的密码
            LambdaUpdateWrapper<AdminUserDO> lambdaUpdateWrapper = new LambdaUpdateWrapper<>();
            lambdaUpdateWrapper.eq(AdminUserDO::getId, adminUserDO.getId());
            lambdaUpdateWrapper.set(AdminUserDO::getPassword, ArithmeticUtil.SHA256(adminUserDO.getConfirmPassword()));
            update(lambdaUpdateWrapper);
            // 修改成功后，要删掉token信息，并要求重新登录
            String oldSessionId = CacheUtil.hashGet("mgrUserId", adminUserDO.getId().toString(), RedisDBEnum.DB_COMMON);
            if (!ObjectUtil.isNullOrEmpty(oldSessionId)) {
                // 删除对应的SessionId
                CacheUtil.hashDel("mgrSessionId", oldSessionId, RedisDBEnum.DB_COMMON);
                // 删除对应的UserId
                CacheUtil.hashDel("mgrUserId", adminUserDO.getId().toString(), RedisDBEnum.DB_COMMON);
            }
        }
    }

}
