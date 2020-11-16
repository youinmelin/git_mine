/**
 * 轮播图
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

    // Banner列表
    table2.render({
        elem: '#LAY-banner-list'
        , url: layui.setter.request.url + '/mgr/banner/getBannerList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            // , {field: 'title', title: '标题', width: 300}
            // , {field: 'linkUrl', title: '链接地址'}
            , {field: 'userId', title: '用户ID', width: 80}
            , {field: 'cycle', title: '周期', width: 80}
            , {field: 'cycleNum', title: '时长', width: 80}
            , {
                field: 'imgUrl',
                title: '图片地址',
                width: 100,
                align: 'center',
                event: 'imgShow',
                templet: '#imgTpl'
            }
            , {field: 'gmtDue', title: '到期时间', width: 165, align: 'center'}
            // , {
            //     field: 'open_mode', title: '打开方式', width: 100, align: 'center'
            //     , templet: function (d) {
            //         return d.openMode === 1 ? '当前页面' : '跳转打开';
            //     }
            // }
            , {
                field: 'isShow', title: '是否显示', width: 100, align: 'center'
                , templet: function (d) {
                    return d.isShow === 1 ? '是' : '否';
                }
            }
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
            // , {field: 'sort', title: '排序', width: 80}
            , {title: '操作', minWidth: 150, align: 'center', fixed: 'right', toolbar: '#table-banner-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    //监听工具条
    table2.on('tool(LAY-banner-list)', function (obj) {
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
                title: 'Banner审核'
                , btn: ['通过', '拒绝']
                , yes: function (index) {
                    //按钮 通过 的回调
                    var field = {};
                    field.id = data.id;
                    field.status = 1;
                    //提交 Ajax
                    admin.req({
                        url: layui.setter.request.url + '/mgr/banner/auditBanner'
                        , data: JSON.stringify(field)
                        , dataType: 'json'
                        , contentType: "application/json"
                        , type: 'POST'
                        , success: function (res) {
                            //执行重载
                            table2.reload('LAY-banner-list');
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
                        url: layui.setter.request.url + '/mgr/banner/auditBanner'
                        , data: JSON.stringify(field)
                        , dataType: 'json'
                        , contentType: "application/json"
                        , type: 'POST'
                        , success: function (res) {
                            //执行重载
                            table2.reload('LAY-banner-list');
                            layer.close(index); //执行关闭
                        }
                    });
                }
            });
        }
    });

    // Banner 分组列表
    table2.render({
        elem: '#LAY-banner-group-list'
        , url: layui.setter.request.url + '/mgr/banner/getBannerGroupList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: '分组ID'}
            , {field: 'code', title: '分组Code', width: 300}
            , {field: 'name', title: '分组名称'}
            , {title: '操作', width: 150, align: 'center', fixed: 'right', toolbar: '#table-banner-group-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    // 监听Banner分组工具条
    table2.on('tool(LAY-banner-group-list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {
            layer.confirm('确定删除此轮播图分组？', function (index) {
                admin.req({
                    url: layui.setter.request.url + '/mgr/banner/bannerGroupDelete/' + obj.data.id
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
                title: '编辑轮播图分组'
                , area: ['550px', '280px']
                , id: 'LAY-banner-group-list-edit'
                , success: function (layero, index) {
                    view(this.id).render('banner/groupform', data).done(function () {
                        form.render(null, 'layuiadmin-form-banner');
                        //监听提交
                        form.on('submit(LAY-banner-group-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            field.id = obj.data.id;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            admin.req({
                                url: layui.setter.request.url + '/mgr/banner/bannerGroupSave'
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'POST'
                                , success: function (res) {
                                    //执行重载
                                    table2.reload('LAY-banner-group-list'); //重载表格
                                    layer.close(index); //执行关闭
                                }
                            });
                        });
                    });
                }
            });
        }
    });

    exports('banner', {})
});
