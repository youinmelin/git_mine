package com.yujia.topbang.api.controller.mgr;

import com.forgetfulr.common.core.R;
import com.yujia.topbang.api.entity.PostsDO;
import com.yujia.topbang.api.service.ICategoryService;
import com.yujia.topbang.api.service.IPostsService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

/**
 * 文章
 *
 * @author caorui
 * @date 2020-08-06 15:58
 * Revision History
 * Date      		Programmer       Notes
 * 2020-08-06   	 caorui		     Initial
 */
@Slf4j
@AllArgsConstructor
@RestController("mgrPostsController")
@RequestMapping("/api/mgr/posts")
public class PostsController {

    /**
     * 文章
     */
    private final IPostsService postsService;

    /**
     * 分类
     */
    private final ICategoryService categoryService;

//    /**
//     * Banner 分组分页
//     *
//     * @return
//     */
//    @RequestMapping(value = "/getBannerGroupList", method = RequestMethod.POST)
//    public R getBannerGroupList(@RequestBody BannerGroupDO bannerGroupDO) {
//        try {
//            return R.ok().put("data", bannerGroupService.getMgrPageList(bannerGroupDO));
//        } catch (Exception e) {
//            return R.error();
//        }
//    }

    /**
     * 获取全部分类
     *
     * @return
     */
    @GetMapping(value = "/getCategory")
    public R getCategory() {
        try {
            return R.ok().put("data", categoryService.list());
        } catch (Exception e) {
            return R.error();
        }
    }

//    /**
//     * Banner 分组增改
//     *
//     * @param bannerGroupDO
//     * @return
//     */
//    @RequestMapping(value = "/bannerGroupSave", method = RequestMethod.POST)
//    public R bannerGroupSave(@RequestBody BannerGroupDO bannerGroupDO) {
//        try {
//            bannerGroupService.bannerGroupSave(bannerGroupDO);
//            return R.ok();
//        } catch (Exception e) {
//            return R.error();
//        }
//    }
//
//    /**
//     * Banner 分组删除
//     *
//     * @param id
//     * @return
//     */
//    @RequestMapping(value = "/bannerGroupDelete/{id}", method = RequestMethod.DELETE)
//    public R bannerGroupDelete(@PathVariable Long id) {
//        try {
//            bannerGroupService.removeById(id);
//            return R.ok();
//        } catch (Exception e) {
//            return R.error();
//        }
//    }

    /**
     * 文章 分页
     *
     * @return
     */
    @PostMapping(value = "/getPostsList")
    public R getPostsList(@RequestBody PostsDO postsDO) {
        try {
            return R.ok().put("data", postsService.getMgrPageList(postsDO));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 文章 增改
     *
     * @param postsDO
     * @return
     */
    @PostMapping(value = "/postsSave")
    public R postsSave(@RequestBody PostsDO postsDO) {
        try {
            postsService.postsSave(postsDO);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 文章获取
     *
     * @param id
     * @return
     */
    @GetMapping(value = "/getPosts/{id}")
    public R getPosts(@PathVariable Long id) {
        try {
            return R.ok().put("data", postsService.getById(id));
        } catch (Exception e) {
            return R.error();
        }
    }

    /**
     * 文章 删除
     *
     * @param id
     * @return
     */
    @DeleteMapping(value = "/postsDelete/{id}")
    public R postsDelete(@PathVariable Long id) {
        try {
            postsService.removeById(id);
            return R.ok();
        } catch (Exception e) {
            return R.error();
        }
    }
}
