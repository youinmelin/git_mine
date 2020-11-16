package com.yujia.topbang.api.controller.web;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.forgetfulr.common.core.R;
import com.forgetfulr.common.enums.DateFormatEnum;
import com.forgetfulr.common.enums.errorcode.UserErrorEnum;
import com.forgetfulr.common.exception.ParamException;
import com.forgetfulr.common.exception.UserException;
import com.forgetfulr.common.utils.CertIDUtil;
import com.forgetfulr.common.utils.DateUtil;
import com.forgetfulr.common.utils.ObjectUtil;
import com.forgetfulr.common.utils.SystemUtil;
import com.yujia.topbang.api.entity.UserCardDO;
import com.yujia.topbang.api.entity.UserCompanyDO;
import com.yujia.topbang.api.entity.UserDO;
import com.yujia.topbang.api.service.IUserCardService;
import com.yujia.topbang.api.service.IUserCompanyService;
import com.yujia.topbang.api.service.IUserService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户
 *
 * @author caorui
 * @date 2020-08-31 17:29
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-31   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("webUserController")
@RequestMapping("/api/web/user")
public class UserController {

    /**
     * 用户信息
     */
    private final IUserService userService;

    /**
     * 用户证件信息
     */
    private final IUserCardService userCardService;

    /**
     * 企业认证信息
     */
    private final IUserCompanyService userCompanyService;


    // 个人实名认证
    @RequestMapping(value = "/realName", method = RequestMethod.POST)
    public R realName(@RequestBody UserCardDO userCardDO) {
        try {
            // 这里要获取用户信息
            Long userId = SystemUtil.appUserId();
            // 校验一下身份证号码
            if (!ObjectUtil.isNullOrEmpty(userCardDO.getCardno())) {
                // 存在才校验（公司注册不需要）
                if (!CertIDUtil.isCertID(userCardDO.getCardno())) {
                    throw new UserException("请输入正确的身份证号码");
                }
            }
            // 时间字段要特殊处理
            if (ObjectUtil.isNullOrEmpty(userCardDO.getValidStart())
                    || ObjectUtil.isNullOrEmpty(userCardDO.getValidEnd())) {
                throw new UserException("证件期限不能为空");
            }
            userCardDO.setValidStart(DateUtil.MongoDBDateToJavaDate(userCardDO.getValidStart(), DateFormatEnum.DATEFORMAT_yyyy_MM_dd));
            userCardDO.setValidEnd(DateUtil.MongoDBDateToJavaDate(userCardDO.getValidEnd(), DateFormatEnum.DATEFORMAT_yyyy_MM_dd));
            userCardDO.setUserId(userId);
            // 只要修改就是待审核
            userCardDO.setStatus(0);
            // 判断是添加还是修改
            LambdaQueryWrapper<UserCardDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(UserCardDO::getUserId, userId);
            return R.ok().put("data", userCardService.saveOrUpdate(userCardDO, lambdaQueryWrapper));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 企业认证
     *
     * @param userCompanyDO
     * @return
     */
    @RequestMapping(value = "/realCompany", method = RequestMethod.POST)
    public R realCompany(@RequestBody UserCompanyDO userCompanyDO) {
        try {
            // 时间字段要特殊处理
            if (ObjectUtil.isNullOrEmpty(userCompanyDO.getEstablishDate())
                    || ObjectUtil.isNullOrEmpty(userCompanyDO.getExpirationDate())) {
                throw new UserException("经营期限不能为空");
            }
            if (ObjectUtil.isNullOrEmpty(userCompanyDO.getValidStart())
                    || ObjectUtil.isNullOrEmpty(userCompanyDO.getValidEnd())) {
                throw new UserException("法人身份期限不能为空");
            }
            // 经营期限
            userCompanyDO.setEstablishDate(DateUtil.MongoDBDateToJavaDate(userCompanyDO.getEstablishDate(), DateFormatEnum.DATEFORMAT_yyyy_MM_dd));
            userCompanyDO.setExpirationDate(DateUtil.MongoDBDateToJavaDate(userCompanyDO.getExpirationDate(), DateFormatEnum.DATEFORMAT_yyyy_MM_dd));
            // 法人证件有效期
            userCompanyDO.setValidStart(DateUtil.MongoDBDateToJavaDate(userCompanyDO.getValidStart(), DateFormatEnum.DATEFORMAT_yyyy_MM_dd));
            userCompanyDO.setValidEnd(DateUtil.MongoDBDateToJavaDate(userCompanyDO.getValidEnd(), DateFormatEnum.DATEFORMAT_yyyy_MM_dd));
            // 这里要获取用户信息
            Long userId = SystemUtil.appUserId();
            // 预读一下公司名进行同步
            UserDO user = userService.getById(userId);
            userCompanyDO.setUnitName(user.getCompanyName());
            userCompanyDO.setUserId(userId);
            return R.ok().put("data", userCompanyService.save(userCompanyDO));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取用户信息
     *
     * @return
     */
    @PostMapping(value = "/info")
    public R getUserInfo() {
        try {
            JSONObject jsonObject;
            // 这里要获取用户信息
            Long userId = SystemUtil.appUserId();
            jsonObject = JSONObject.parseObject(JSONObject.toJSONString(userService.getById(userId)));
            // 将用户实名信息也放进去
            LambdaQueryWrapper<UserCardDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(UserCardDO::getUserId, userId);
            UserCardDO userCardDO = userCardService.getOne(lambdaQueryWrapper);
            jsonObject.put("userCard", userCardDO);
            return R.ok().put("data", jsonObject);
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取用户账户安全信息
     *
     * @return
     */
    @GetMapping(value = "/getSecurity")
    public R getSecurity() {
        try {
            Long userId = SystemUtil.appUserId();
            return R.ok().put("data", userService.getSecurity(userId));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取企业信息
     *
     * @return
     */
    @GetMapping(value = "/getCompanyInfo")
    public R getCompanyInfo() {
        try {
            // 这里要获取用户信息
            Long userId = SystemUtil.appUserId();
            return R.ok().put("data", userCompanyService.getCompanyInfo(userId));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 修改密码
     *
     * @param userDO
     * @return
     */
    @PostMapping(value = "/setPasswd")
    public R setPasswd(@RequestBody UserDO userDO) {
        try {
            Long userId = SystemUtil.appUserId();
            userDO.setId(userId);
            userService.setPasswd(userDO);
            return R.ok();
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 修改公司简介
     *
     * @param userCompanyDO
     * @return
     */
    @PostMapping(value = "/updateCompanyContent")
    public R updateCompanyContent(@RequestBody UserCompanyDO userCompanyDO) {
        try {
            Long userId = SystemUtil.appUserId();
            userCompanyDO.setUserId(userId);
            userCompanyService.updateCompanyContent(userCompanyDO);
            return R.ok();
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 修改用户头像
     *
     * @param userDO
     * @return
     */
    @PostMapping(value = "/updateHeadImg")
    public R updateHeadImg(@RequestBody UserDO userDO) {
        try {
            // 比较简单，但防止出意外
            UserDO user = new UserDO();
            Long userId = SystemUtil.appUserId();
            user.setId(userId);
            user.setHeadImg(userDO.getHeadImg());
            userService.updateById(user);
            return R.ok();
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 修改邮箱
     *
     * @param userDO
     * @return
     */
    @PostMapping(value = "/updateEmail")
    public R updateEmail(@RequestBody UserDO userDO) {
        try {
            // 比较简单，但防止出意外
            UserDO user = new UserDO();
            Long userId = SystemUtil.appUserId();
            user.setId(userId);
            user.setEmail(userDO.getEmail());
            userService.updateById(user);
            return R.ok();
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 修改手机号
     *
     * @param userDO
     * @return
     */
    @PostMapping(value = "/updatePhone")
    public R updatePhone(@RequestBody UserDO userDO) {
        try {
            // 比较简单，但防止出意外
            UserDO user = new UserDO();
            Long userId = SystemUtil.appUserId();

            // 验证手机号是否正确
            if (!CertIDUtil.isMobile(userDO.getPhone())) {
                throw new UserException(UserErrorEnum.mobileFormatError.getErrorCode(),
                        UserErrorEnum.mobileFormatError.getMsg());
            }
            // 验证手机号有没有被占用（同时防止重放攻击）
            LambdaQueryWrapper<UserDO> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(UserDO::getPhone, userDO.getPhone());
            List<UserDO> users = userService.list(lambdaQueryWrapper);
            if (users != null && users.size() > 0) {
                throw new UserException("当前手机号码[" + userDO.getPhone() + "]已注册");
            }
            user.setId(userId);
            user.setPhone(userDO.getPhone());
            userService.updateById(user);
            return R.ok();
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }


}
