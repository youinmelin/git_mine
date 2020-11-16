package com.yujia.topbang.api.controller.mgr;

import com.forgetfulr.common.core.R;
import com.forgetfulr.common.exception.UserException;
import com.yujia.topbang.api.entity.UserCardDO;
import com.yujia.topbang.api.entity.UserCompanyDO;
import com.yujia.topbang.api.entity.UserDO;
import com.yujia.topbang.api.service.IUserCardService;
import com.yujia.topbang.api.service.IUserCompanyService;
import com.yujia.topbang.api.service.IUserService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 用户
 *
 * @author caorui
 * @date 2020-07-07 15:22
 * Revision History
 * Date      		Programmer       Notes
 * 2020-07-07   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("mgrUserController")
@RequestMapping("/api/mgr/user")
public class UserController {

    /**
     * 用户
     */
    private final IUserService userService;

    /**
     * 个人实名认证
     */
    private final IUserCardService userCardService;

    /**
     * 企业信息
     */
    private final IUserCompanyService userCompanyService;

    /**
     * 获取网站用户列表
     *
     * @return
     */
    @RequestMapping(value = "/getUserList", method = RequestMethod.POST)
    public R getUserList(@RequestBody UserDO userDO) {
        try {
            return R.ok().put("data", userService.getMgrPageList(userDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 用户增改
     *
     * @param userDO
     * @return
     */
    @PostMapping(value = "/userSave")
    public R userSave(@RequestBody UserDO userDO) {
        try {
            userService.userSave(userDO);
            return R.ok();
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    //region 个人

    /**
     * 个人实名信息
     *
     * @param userCardDO
     * @return
     */
    @PostMapping(value = "/getUserCardList")
    public R getUserCardList(@RequestBody UserCardDO userCardDO) {

        try {
            return R.ok().put("data", userCardService.getMgrPageList(userCardDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 个人实名认证审核
     *
     * @param userCardDO
     * @return
     */
    @RequestMapping(value = "/auditUserCard")
    public R auditUserCard(@RequestBody UserCardDO userCardDO) {
        try {
            userCardService.auditUserCard(userCardDO);
            return R.ok();
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    //region 企业

    /**
     * 企业实名信息
     *
     * @param userCompanyDO
     * @return
     */
    @RequestMapping(value = "/getUserCompanyList", method = RequestMethod.POST)
    public R getUserCompanyList(@RequestBody UserCompanyDO userCompanyDO) {

        try {
            return R.ok().put("data", userCompanyService.getMgrPageList(userCompanyDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 企业实名认证审核
     *
     * @param userCompanyDO
     * @return
     */
    @RequestMapping(value = "/auditCompany", method = RequestMethod.POST)
    public R auditCompany(@RequestBody UserCompanyDO userCompanyDO) {
        try {
            userCompanyService.auditCompany(userCompanyDO);
            return R.ok();
        } catch (UserException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

}
