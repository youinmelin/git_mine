/**
 * 文章管理
 */


layui.define(['table', 'form', "table2"], function (exports) {
    var $ = layui.$
        , admin = layui.admin
        , view = layui.view
        , table2 = layui.table2
        , router = layui.router()
        , form = layui.form;

    // 设置全局 table 实例的 token（这样一来，所有 table 实例均会有效）
    table2.set({
        headers: { //通过 request 头传递
            accessToken: layui.data([layui.setter.tableName])[layui.setter.request.tokenName]
        }, response: {
            countName: 'total'
        }
    });

    //region 文章管理
    // 文章管理
    table2.render({
        elem: '#LAY-posts-list'
        , url: layui.setter.request.url + '/mgr/posts/getPostsList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: '文章ID'}
            // , {field: 'label', title: '文章标签', minWidth: 100}
            , {field: 'title', title: '文章标题', width: 300}
            , {field: 'publishAt', title: '发布时间', width: 165, align: 'center'}
            , {field: 'gmtCreate', title: '创建时间', width: 165, align: 'center'}
            , {field: 'is_recommend', title: '推荐', width: 85, align: 'center', templet: '#switchTpl', unresize: true}
            // , {field: 'status', title: '发布状态', templet: '#buttonTpl', minWidth: 80, align: 'center'}
            , {title: '操作', align: 'center', width: 350, toolbar: '#table-posts-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    //监听工具条
    table2.on('tool(LAY-posts-list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {
            layer.confirm('确定删除该文章？', function (index) {
                admin.req({
                    url: layui.setter.request.url + '/mgr/posts/delete/' + obj.data.id
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
            location.hash = '/post/listform/id=' + data.id;
        } else if (obj.event === 'setTag') {
            // 设置标签
            admin.popup({
                title: '设置文章标签'
                , area: ['600px', '480px']
                , id: 'LAY-popup-posts-tag-set'
                , success: function (layero, index) {
                    view(this.id).render('posts/tagpostform', data).done(function () {
                    });
                }
            });
        } else if (obj.event === 'setPages') {
            // 多页管理
            location.hash = '/posts/pagelist/postId=' + data.id;
        }
    });
    //endregion

    //region 分类管理
    //分类管理
    table2.render({
        elem: '#LAY-posts-category-list'
        , url: layui.setter.request.url + '/mgr/posts/categoryList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: '分类ID'}
            // , {field: 'label', title: '文章标签', minWidth: 100}
            , {field: 'name', title: '分类名称', width: 300}
            , {field: 'created_at', title: '创建时间', width: 165, align: 'center'}
            , {title: '操作', width: 150, align: 'center', fixed: 'right', toolbar: '#table-posts-category-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    //监听工具条
    table2.on('tool(LAY-posts-category-list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {
            layer.confirm('确定删除此分类？', function (index) {
                admin.req({
                    url: layui.setter.request.url + '/mgr/posts/categoryDelete/' + obj.data.id
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
                title: '编辑分类'
                , area: ['550px', '700px']
                , id: 'LAY-popup-content-edit'
                , success: function (layero, index) {
                    view(this.id).render('posts/categoryform', data).done(function () {
                        form.render(null, 'layuiadmin-app-form-list');

                        //监听提交
                        form.on('submit(LAY-posts-category-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            field.id = obj.data.id;
                            // 修改时，随便给个父级ID(后续引入动态排序后此字段才有用)
                            field.parent_id = 0;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            admin.req({
                                url: layui.setter.request.url + '/mgr/posts/categorySave'
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'POST'
                                , success: function (res) {
                                    //执行重载
                                    table2.reload('LAY-posts-category-list'); //重载表格
                                    layer.close(index); //执行关闭
                                }
                            });

                        });
                    });
                }
            });
        }
    });
    //endregion

    //region 标签管理
    // 标签管理
    table2.render({
        elem: '#LAY-posts-tag-list'
        , url: layui.setter.request.url + '/mgr/posts/tagList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'name', title: '名称', width: 300}
            , {field: 'alias', title: '别名'}
            , {field: 'post_num', title: '文章数量'}
            , {field: 'created_at', title: '创建时间', width: 165, align: 'center'}
            , {title: '操作', minWidth: 150, align: 'center', fixed: 'right', toolbar: '#table-posts-tag-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    //监听工具条
    table2.on('tool(LAY-posts-tag-list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {
            layer.confirm('确定删除该标签？', function (index) {
                admin.req({
                    url: layui.setter.request.url + '/mgr/posts/tagDelete/' + obj.data.id
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
                title: '编辑标签'
                , area: ['550px', '350px']
                , id: 'LAY-popup-posts-tag-edit'
                , success: function (layero, index) {
                    view(this.id).render('posts/tagform', data).done(function () {
                        form.render(null, 'layuiadmin-app-form-list');

                        //监听提交
                        form.on('submit(LAY-posts-tag-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            field.id = obj.data.id;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            admin.req({
                                url: layui.setter.request.url + '/mgr/posts/tagSave'
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'POST'
                                , success: function (res) {
                                    //执行重载
                                    table2.reload('LAY-posts-tag-list'); //重载表格
                                    layer.close(index); //执行关闭
                                }
                            });

                        });
                    });
                }
            });
        }
    });
    //endregion

    // 文章访问IP记录
    table2.render({
        elem: '#LAY-posts-uv-ip-list'
        , url: layui.setter.request.url + '/mgr/posts/postUvIpList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {field: 'post_id', title: '文章ID', width: 200}
            , {field: 'visitor', title: 'IP地址'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    exports('posts', {})
});
