/**
 * 产品管理
 */


layui.define(['form', "table2"], function (exports) {
    var $ = layui.$
        , admin = layui.admin
        , view = layui.view
        , table2 = layui.table2
        , form = layui.form;

    // 设置全局 table 实例的 token（这样一来，所有 table 实例均会有效）
    table2.set({
        headers: { //通过 request 头传递
            accessToken: layui.data([layui.setter.tableName])[layui.setter.request.tokenName]
        }, response: {
            countName: 'total'
        }
    });

    // 产品列表
    table2.render({
        elem: '#LAY-product-list'
        , url: layui.setter.request.url + '/mgr/product/getProductList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'name', title: '产品名称', width: 200}
            , {field: 'description', title: '产品文字说明'}
            , {field: 'price', title: '价格'}
            , {field: 'score', title: '评分'}
            , {field: 'stock', title: '库存'}
            , {
                field: 'status', title: '状态', width: 100, align: 'center'
                , templet: function (d) {
                    if (d.status === 0) {
                        return '待审核';
                    } else if (d.status === 1) {
                        return '通过';
                    } else if (d.status === 2) {
                        return '拒绝';
                    } else {
                        return '未知';
                    }
                }
            }
            , {field: 'gmtCreate', title: '创建时间', width: 165, align: "center"}
            , {title: '操作', minWidth: 150, align: 'center', fixed: 'right', toolbar: '#table-product-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    //监听工具条
    table2.on('tool(LAY-product-list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'imgShow') {
            layer.photos({
                photos: {
                    "title": "查看头像" //相册标题
                    , "data": [{
                        "src": data.imgUrl //原图地址
                    }]
                }
                , shade: 0.01
                , closeBtn: 1
                , anim: 5
            });
        } else if (obj.event === 'del') {
            layer.confirm('确定删除此轮播图？', function (index) {
                admin.req({
                    url: layui.setter.request.url + '/mgr/banner/bannerDelete/' + obj.data.id
                    , dataType: 'json'
                    , contentType: "application/json"
                    , type: 'DELETE'
                    , success: function (res) {
                        obj.del();
                        layer.close(index);
                    }
                });

            });
        } else if (obj.event === 'edit') {
            admin.popup({
                title: '编辑轮播图'
                , area: ['550px', '650px']
                , id: 'LAY-banner-list-edit'
                , success: function (layero, index) {
                    view(this.id).render('banner/listform', data).done(function () {
                        form.render(null, 'layuiadmin-form-banner');
                        layer.load();
                        //监听提交
                        form.on('submit(LAY-banner-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            field.id = obj.data.id;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            admin.req({
                                url: layui.setter.request.url + '/mgr/banner/bannerSave'
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'POST'
                                , success: function (res) {
                                    //执行重载
                                    table2.reload('LAY-banner-list'); //重载表格
                                    layer.close(index); //执行关闭
                                }
                            });
                        });
                    });
                }
            });
        } else if (obj.event === 'audit') {
            layer.open({
                title: '产品审核'
                , btn: ['通过', '拒绝']
                , yes: function (index) {
                    //按钮 通过 的回调
                    var field = {};
                    field.id = data.id;
                    field.status = 1;
                    //提交 Ajax
                    admin.req({
                        url: layui.setter.request.url + '/mgr/product/auditProduct'
                        , data: JSON.stringify(field)
                        , dataType: 'json'
                        , contentType: "application/json"
                        , type: 'POST'
                        , success: function (res) {
                            //执行重载
                            table2.reload('LAY-product-list');
                            layer.close(index); //执行关闭
                        }
                    });
                }
                , btn2: function (index) {
                    // 按钮 拒绝 的回调
                    var field = {};
                    field.id = data.id;
                    field.status = 2;
                    //提交 Ajax
                    admin.req({
                        url: layui.setter.request.url + '/mgr/product/auditProduct'
                        , data: JSON.stringify(field)
                        , dataType: 'json'
                        , contentType: "application/json"
                        , type: 'POST'
                        , success: function (res) {
                            //执行重载
                            table2.reload('LAY-product-list');
                            layer.close(index); //执行关闭
                        }
                    });
                }
            });
        }
    });

    // 产品评价列表
    table2.render({
        elem: '#LAY-product-evaluate-list'
        , url: layui.setter.request.url + '/mgr/product/getProductEvaluateList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {field: 'id', width: 100, title: 'ID'}
            , {field: 'productId', title: '产品ID', width: 100}
            , {field: 'productName', title: '产品名称', width: 100}
            , {field: 'userId', title: '用户ID', width: 100}
            , {field: 'trialId', title: '试用ID', width: 100}
            , {field: 'score', title: '评分', width: 100}
            , {field: 'content', title: '评价内容', width: 200}
            // , {
            //     field: 'status', title: '评价', width: 100, align: 'center'
            //     , templet: function (d) {
            //         if (d.status === 1) {
            //             return '好评';
            //         } else if (d.status === 2) {
            //             return '中评';
            //         } else if (d.status === 3) {
            //             return '差评';
            //         } else {
            //             return '未知';
            //         }
            //     }
            // }
            , {field: 'gmtCreate', title: '创建时间', width: 165, align: "center"}
            , {title: '操作', minWidth: 150, align: 'center', fixed: 'right', toolbar: '#table-product-evaluate-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    // 产品评价工具条
    table2.on('tool(LAY-product-evaluate-list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {
            layer.confirm('确定删除此评价？', function (index) {
                admin.req({
                    url: layui.setter.request.url + '/mgr/product/productEvaluateDelete/' + obj.data.id
                    , dataType: 'json'
                    , contentType: "application/json"
                    , type: 'DELETE'
                    , success: function (res) {
                        obj.del();
                        layer.close(index);
                    }
                });

            });
        }
    });

    // 标签
    table2.render({
        elem: '#LAY-tag-list'
        , url: layui.setter.request.url + '/mgr/product/getTagList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {field: 'id', width: 100, title: 'ID'}
            // , {field: 'type', title: '类型', width: 165}
            , {field: 'tagName', title: '标签名', width: 165}
            , {field: 'tagCode', title: '标签编码', width: 165}
            , {field: 'gmtCreate', title: '创建时间', width: 165, align: "center"}
            , {title: '操作', width: 150, align: 'center', fixed: 'right', toolbar: '#table-tag-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    // 标签工具条
    table2.on('tool(LAY-tag-list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {
            layer.confirm('确定删除此标签？', function (index) {
                admin.req({
                    url: layui.setter.request.url + '/mgr/product/tagDelete/' + obj.data.id
                    , dataType: 'json'
                    , contentType: "application/json"
                    , type: 'DELETE'
                    , success: function (res) {
                        obj.del();
                        layer.close(index);
                    }
                });

            });
        } else if (obj.event === 'edit') {
            admin.popup({
                title: '编辑轮播图'
                , area: ['550px', '350px']
                , id: 'LAY-banner-list-edit'
                , success: function (layero, index) {
                    view(this.id).render('product/tagform', data).done(function () {
                        form.render(null, 'layuiadmin-form-banner');
                        //监听提交
                        form.on('submit(LAY-tag-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            field.id = obj.data.id;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            admin.req({
                                url: layui.setter.request.url + '/mgr/product/tagSave'
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'POST'
                                , success: function (res) {
                                    //执行重载
                                    table2.reload('LAY-tag-list'); //重载表格
                                    layer.close(index); //执行关闭
                                }
                            });
                        });
                    });
                }
            });
        }
    });

    //region 空间管理

    // 空间列表
    table2.render({
        elem: '#LAY-product-space-list'
        , url: layui.setter.request.url + '/mgr/product/getSpaceList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'userId', title: '用户ID'}
            , {field: 'totalSize', title: '总大小'}
            , {field: 'usedSize', title: '已用大小'}
            , {field: 'freeSize', title: '剩余大小'}
            , {title: '操作', minWidth: 150, align: 'center', fixed: 'right', toolbar: '#table-product-space-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });
    //endregion

    //region 视频管理

    // 视频列表
    table2.render({
        elem: '#LAY-product-video-list'
        , url: layui.setter.request.url + '/mgr/product/getVideoList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'prodId', title: '产品ID', width: 100}
            , {field: 'userId', title: '用户ID'}
            , {field: 'videoUrl', title: '视频地址'}
            , {field: 'imgUrl', title: '图片地址'}
            , {field: 'duration', title: '视频时长'}
            , {field: 'size', title: '视频大小'}
            , {field: 'content', title: '简介', width: 100}
            , {field: 'gmtCreate', title: '创建时间', width: 165, align: "center"}
            , {title: '操作', minWidth: 150, align: 'center', fixed: 'right', toolbar: '#table-product-video-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });
    //endregion

    //region 直播管理

    // 直播列表
    table2.render({
        elem: '#LAY-product-video-live-list'
        , url: layui.setter.request.url + '/mgr/product/getVideoLiveList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 80, title: 'ID'}
            , {field: 'userId', title: '用户ID', width: 100}
            , {field: 'title', title: '标题', width: 200}
            , {field: 'platformName', title: '直播平台', width: 100}
            , {field: 'liveLink', title: '直播链接', width: 100}
            , {field: 'platformName', title: '直播平台', width: 100}
            , {field: 'videoImgUrl', title: '视频封面', width: 100}
            , {field: 'industryName', title: '所属行业', width: 100}
            , {field: 'price', title: '价格', width: 100}
            , {field: 'isCustom', title: '是否支持定制', width: 100}
            , {field: 'buyUrl', title: '购买链接', width: 100}
            , {field: 'downloadUrl', title: '软件试用下载', width: 100}
            , {field: 'content', title: '简介', width: 100}
            , {
                field: 'status', title: '状态', width: 100, align: 'center'
                , templet: function (d) {
                    if (d.status === 0) {
                        return '待审核';
                    } else if (d.status === 1) {
                        return '通过';
                    } else if (d.status === 2) {
                        return '拒绝';
                    } else {
                        return '未知';
                    }
                }
            }
            , {field: 'gmtCreate', title: '创建时间', width: 165, align: "center"}
            , {title: '操作', minWidth: 150, align: 'center', fixed: 'right', toolbar: '#table-product-video-live-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    // 直播列表工具条
    table2.on('tool(LAY-product-video-live-list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'imgShow') {
            layer.photos({
                photos: {
                    "title": "查看头像" //相册标题
                    , "data": [{
                        "src": data.imgUrl //原图地址
                    }]
                }
                , shade: 0.01
                , closeBtn: 1
                , anim: 5
            });
        } else if (obj.event === 'del') {
            layer.confirm('确定删除此轮播图？', function (index) {
                admin.req({
                    url: layui.setter.request.url + '/mgr/banner/bannerDelete/' + obj.data.id
                    , dataType: 'json'
                    , contentType: "application/json"
                    , type: 'DELETE'
                    , success: function (res) {
                        obj.del();
                        layer.close(index);
                    }
                });

            });
        } else if (obj.event === 'edit') {
            admin.popup({
                title: '编辑轮播图'
                , area: ['550px', '650px']
                , id: 'LAY-banner-list-edit'
                , success: function (layero, index) {
                    view(this.id).render('banner/listform', data).done(function () {
                        form.render(null, 'layuiadmin-form-banner');
                        layer.load();
                        //监听提交
                        form.on('submit(LAY-banner-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            field.id = obj.data.id;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            admin.req({
                                url: layui.setter.request.url + '/mgr/banner/bannerSave'
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'POST'
                                , success: function (res) {
                                    //执行重载
                                    table2.reload('LAY-banner-list'); //重载表格
                                    layer.close(index); //执行关闭
                                }
                            });
                        });
                    });
                }
            });
        } else if (obj.event === 'audit') {
            layer.open({
                title: '直播审核'
                , btn: ['通过', '拒绝']
                , yes: function (index) {
                    //按钮 通过 的回调
                    var field = {};
                    field.id = data.id;
                    field.status = 1;
                    //提交 Ajax
                    admin.req({
                        url: layui.setter.request.url + '/mgr/product/auditVideoLive'
                        , data: JSON.stringify(field)
                        , dataType: 'json'
                        , contentType: "application/json"
                        , type: 'POST'
                        , success: function (res) {
                            //执行重载
                            table2.reload('LAY-product-video-live-list');
                            layer.close(index); //执行关闭
                        }
                    });
                }
                , btn2: function (index) {
                    // 按钮 拒绝 的回调
                    var field = {};
                    field.id = data.id;
                    field.status = 2;
                    //提交 Ajax
                    admin.req({
                        url: layui.setter.request.url + '/mgr/product/auditVideoLive'
                        , data: JSON.stringify(field)
                        , dataType: 'json'
                        , contentType: "application/json"
                        , type: 'POST'
                        , success: function (res) {
                            //执行重载
                            table2.reload('LAY-product-video-live-list');
                            layer.close(index); //执行关闭
                        }
                    });
                }
            });
        }
    });
    //endregion

    // 热门搜索
    table2.render({
        elem: '#LAY-hot-search-list'
        , url: layui.setter.request.url + '/mgr/product/getHotSearchList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'content', width: 100, title: '搜索内容'}
            , {field: 'num', width: 100, title: '搜索次数'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    // 首页栏目
    table2.render({
        elem: '#LAY-index-category-list'
        , url: layui.setter.request.url + '/mgr/product/getIndexCategoryList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'categoryId', width: 100, title: '分类ID'}
            , {field: 'categoryName', width: 500, title: '分类名'}
            , {field: 'sort', width: 100, title: '排序'}
            , {title: '操作', minWidth: 150, align: 'center', toolbar: '#table-index-category-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    // 监听首页栏目工具条
    table2.on('tool(LAY-index-category-list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {
            layer.confirm('确定删除此栏目？', function (index) {
                admin.req({
                    url: layui.setter.request.url + '/mgr/product/indexCategoryDelete/' + obj.data.id
                    , dataType: 'json'
                    , contentType: "application/json"
                    , type: 'DELETE'
                    , success: function (res) {
                        obj.del();
                        layer.close(index);
                    }
                });

            });
        } else if (obj.event === 'edit') {
            admin.popup({
                title: '修改'
                , area: ['500px', '480px']
                , id: 'LAY-index-category-edit'
                , success: function (layero, index) {
                    view(this.id).render('product/indexcategoryform', data).done(function () {
                        form.render(null, 'layuiadmin-form-role');

                        //监听提交
                        form.on('submit(LAY-product-index-category-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            field.id = obj.data.id;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            admin.req({
                                url: layui.setter.request.url + '/mgr/product/indexCategorySave'
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'POST'
                                , success: function (res) {
                                    //执行重载
                                    table2.reload('LAY-index-category-list');
                                    layer.close(index); //执行关闭
                                }
                            });
                        });
                    });
                }
            });
        }
    });

    exports('product', {})
});
