/**
 * 消息管理
 */

layui.define(['form', "table2", "laypage"], function (exports) {
    var $ = layui.$
        , admin = layui.admin
        , view = layui.view
        , table2 = layui.table2
        , laypage = layui.laypage
        , form = layui.form;

    // 设置全局 table 实例的 token（这样一来，所有 table 实例均会有效）
    table2.set({
        headers: { //通过 request 头传递
            accessToken: layui.data([layui.setter.tableName])[layui.setter.request.tokenName]
        }, response: {
            countName: 'total'
        }
    });

    // 消息管理
    table2.render({
        elem: '#LAY-notice-manage'
        , height: 'full-300'
        , url: layui.setter.request.url + '/mgr/notice/getNoticeList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , response:
            {
                countName: 'total'
            }
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'userId', title: '用户ID', minWidth: 100}
            , {field: 'receiveObject', title: '消息接收者', minWidth: 200}
            , {field: 'title', title: '标题', minWidth: 100}
            , {
                field: 'type', title: '类型', width: 100, align: 'center'
                , templet: function (d) {
                    if (d.type === 1) {
                        return '站内信';
                    } else if (d.type === 2) {
                        return '邮件';
                    } else if (d.type === 3) {
                        return '短信';
                    } else if (d.type === 5) {
                        return '微信';
                    } else if (d.type === 6) {
                        return 'APP推送';
                    }
                }
            }
            , {field: 'content', title: '内容', width: 200}
            , {field: 'gmtCreate', title: '创建时间', width: 165, align: 'center'}
            , {field: 'gmtSend', title: '发送时间', width: 165, align: 'center'}
            , {
                field: 'isSend', title: '是否已发送', width: 100, align: 'center'
                , templet: function (d) {
                    return d.isSend === 1 ? '是' : '否';
                }
            }
            , {field: 'gmtReceived', title: '送达时间', width: 165, align: 'center'}
            , {field: 'gmtRead', title: '阅读时间', width: 165, align: 'center'}
            , {
                field: 'isRead', title: '是否已读', width: 100, align: 'center'
                , templet: function (d) {
                    return d.isRead === 1 ? '是' : '否';
                }
            }
            , {
                field: 'isUserDeleted', title: '用户删除', width: 100, align: 'center'
                , templet: function (d) {
                    return d.isUserDeleted === 1 ? '是' : '否';
                }
            }
        ]]
        // 开启分页，layout里面包含所有的功能项
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    //监听工具条
    table2.on('tool(LAY-notice-manage)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {
            layer.prompt({
                formType: 1
                , title: '敏感操作，请验证口令'
            }, function (value, index) {
                layer.close(index);

                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            });
        } else if (obj.event === 'edit') {
            admin.popup({
                title: '编辑用户'
                , area: ['500px', '750px']
                , id: 'LAY-popup-user-add'
                , success: function (layero, index) {
                    view(this.id).render('user/user/userform', data).done(function () {
                        form.render(null, 'layuiadmin-form-useradmin');

                        //监听提交
                        form.on('submit(LAY-user-front-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            // 修改的时候ID会漏掉
                            field.id = obj.data.id;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            admin.req({
                                url: layui.setter.request.url + '/mgr/user/userUpdate' //实际使用请改成服务端真实接口
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'PUT'
                                , success: function (res) {
                                    //执行重载
                                    table2.reload('LAY-user-manage');
                                    layer.close(index); //执行关闭
                                }
                            });
                        });
                    });
                }
            });
        }
    });
    exports('notice', {})
});
