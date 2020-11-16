package com.yujia.topbang.api.controller.web;

import com.forgetfulr.admin.service.IWebOptionsService;
import com.forgetfulr.common.core.R;
import com.forgetfulr.common.exception.ParamException;
import com.forgetfulr.common.exception.UserException;
import com.yujia.topbang.api.entity.PostsDO;
import com.yujia.topbang.api.service.IIndustryService;
import com.yujia.topbang.api.service.IPostsService;
import com.yujia.topbang.api.service.IProductService;
import com.yujia.topbang.api.service.ITagsService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**tongyong
 * 通用
 *
 * @author caorui
 * @date 2020-08-06 15:58
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-06   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("webCommonController")
@RequestMapping("/api/web/common")
public class CommonController {

    /**
     * 行业分类
     */
    private final IIndustryService industryService;

    /**
     * 标签
     */
    private final ITagsService tagsService;

    /**
     * 产品
     */
    private final IProductService productService;

    /**
     * 系统配置
     */
    private final IWebOptionsService webOptionsService;

    /**
     * 文章
     */
    private final IPostsService postsService;

    /**
     * 行业分类
     *
     * @return
     */
    @GetMapping(value = "/getIndustry")
    public R getIndustry() {
        try {
            return R.ok().put("data", industryService.getIndustry());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 标签
     *
     * @return
     */
    @GetMapping(value = "/getTag")
    public R getTag() {
        try {
            return R.ok().put("data", tagsService.list());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 根据userId查询企业信息
     *
     * @return
     */
    @GetMapping(value = "/getCompanyInfo/{uid}")
    public R getCompanyInfo(@PathVariable Long uid) {
        try {
            return R.ok().put("data", productService.getCompanyInfo(uid));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    //region 配置信息

    /**
     * 获取关于我们公司信息
     *
     * @return
     */
    @GetMapping(value = "/getCompanyInfo")
    public R getCompanyInfo() {
        try {
            return R.ok().put("data", webOptionsService.getOptionByKey("setCompanyInfo"));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取服务声明
     * 类似的操作有很多，单独写是为了防止前端直接拿到code获取后端参数
     *
     * @return
     */
    @GetMapping(value = "/getServiceState")
    public R getServiceState() {
        try {
            return R.ok().put("data", webOptionsService.getOptionByKey("setServiceState"));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取联系我们
     *
     * @return
     */
    @GetMapping(value = "/getContactus")
    public R getContactus() {
        try {
            return R.ok().put("data", webOptionsService.getOptionByKey("setContactus"));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取SEO信息
     *
     * @return
     */
    @GetMapping(value = "/getSeo")
    public R getSeo() {
        try {
            return R.ok().put("data", webOptionsService.getOptionByKey("setSeo"));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取注册协议
     *
     * @return
     */
    @GetMapping(value = "/getRegAgree")
    public R getRegAgree() {
        try {
            return R.ok().put("data", webOptionsService.getOptionByKey("setRegAgree"));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }
    //endregion

    /**
     * 文章列表
     * POST 传参{ "page":3, "limit":2 }
     * @return
     */
    @PostMapping(value = "/getPostsList")
    public R getPostsList(@RequestBody PostsDO postsDO) {
        try {
            return R.ok().put("data", postsService.getWebPageList(postsDO));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 获取文章详情
     *
     * @return
     */
    @GetMapping(value = "/getPostInfo/{id}")
    public R getPostInfo(@PathVariable Long id) {
        try {
            return R.ok().put("data", postsService.getById(id));
        } catch (UserException | ParamException e) {
            return R.error(e.getErrorCode(), e.getMsg());
        } catch (Exception e) {
            return R.error();
        }
    }
}
