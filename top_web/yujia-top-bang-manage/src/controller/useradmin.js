/**
 * 用户管理 管理员管理 角色管理
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

    //用户管理
    table2.render({
        elem: '#LAY-user-manage'
        , url: layui.setter.request.url + '/mgr/user/getUserList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {field: 'id', width: 100, title: 'ID'}
            // , {field: 'recommendUserId', width: 120, title: '推荐人ID'}
            , {field: 'userName', title: '用户名', minWidth: 100}
            , {field: 'name', title: '姓名', width: 150}
            , {field: 'idCard', title: '证件号码', width: 250}
            , {field: 'phone', title: '手机', width: 120}
            // , {field: 'avatar', title: '头像', width: 100, templet: '#imgTpl'}
            , {
                field: 'sex', title: '性别', width: 60, align: 'center'
                , templet: function (d) {
                    return d.sex === 1 ? '男' : '女';
                }
            }
            , {
                field: 'role', title: '角色', width: 60, align: 'center'
                , templet: function (d) {
                    return d.role === 1 ? '卖家' : '买家';
                }
            }
            , {
                field: 'type', title: '类型', width: 60, align: 'center'
                , templet: function (d) {
                    return d.type === 1 ? '企业' : '个人';
                }
            }
            , {field: 'gmtRegister', title: '加入时间', width: 165, align: 'center'}
            , {title: '操作', width: 150, align: 'center', fixed: 'right', toolbar: '#table-useradmin-webuser'}
        ]]
        // 开启分页，layout里面包含所有的功能项
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    //监听工具条
    table2.on('tool(LAY-user-manage)', function (obj) {
        var data = obj.data;
        if (obj.event === 'mobileShow') {
            console.log("aaa");
            // 要去后端取图片
            admin.req({
                url: layui.setter.request.url + '/mgr/user/getUserMobileQrImg/' + data.id
                , dataType: 'json'
                , contentType: "application/json"
                , type: 'GET'
                , success: function (res) {
                    // 判断返回
                    if (res.data.isMobile === 1) {
                        window.open(res.data.imgUrl);
                    } else if (res.data.isMobile === 0) {
                        layer.photos({
                            // 控制图片大小
                            area: ['230px', '230px'],
                            photos: {
                                "title": "扫码拨号"
                                , "data": [{
                                    "src": "data:image/png;base64," + res.data.imgUrl
                                }]
                            }
                            , shade: 0.01
                            , closeBtn: 1
                            , anim: 5
                        });
                    } else {
                        layui.msg("错误");
                    }
                }
            });
        } else if (obj.event === 'del') {
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
                , area: ['500px', '550px']
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
                                url: layui.setter.request.url + '/mgr/user/userSave'
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'POST'
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

    // 监听排序请求
    table2.on('sort(LAY-user-manage)', function (obj) {
        // 执行重载
        table2.reload('LAY-user-manage', {
            // 这个参数好像有问题（有可能是另起table2的问题，可能直接修改原生table.js就不会有这个问题，空了试下）
            // initSort: {
            //     // 记录初始排序，如果不设的话，将无法标记表头的排序状态 layui 2.1.1 新增参数
            //     field: obj.field, //排序字段（好比上面的name）
            //     type: obj.type //排序方式（升序，降序，默认）
            // },
            page: {
                curr: 1
            }
            , where: {
                // 这里比较蛋疼的Java后端下划线问题，Java里面是gmtExpired参数，实际MySQL里面是gmt_expired
                orderBy: obj.field + " " + obj.type
            }
        });
    });

    //管理员管理
    table2.render({
        // 唯一ID，执行重载的时候用
        id: 'LAY-user-back-manage-id'
        , elem: '#LAY-user-back-manage'
        , url: layui.setter.request.url + '/mgr/admin/getUserList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        /**
         * 这里很蛋疼，前后端参数不一致，前端默认的pageName和limitName都是写死的最底层的源代码里面了。为了后期维护方便，已经改了后端的参数名
         */
        // , request: {
        //     pageName: 'index'
        //     , limitName: 'size'
        // }
        /**
         * 这里是因为后端的PageHelper分页插件默认返回的会额外包装一下，所以真正的数据是在data.list
         * 需要修改源代码，为了以后方便升级，这里复制一份table.js去改写
         * 解决方法详见/src/controller/table2.js 729行 @author caorui 2019年01月25日16:12:44
         */
        , response:
            {
                // statusName: 'status' //规定数据状态的字段名称，默认：code
                // , statusCode: 200 //规定成功的状态码，默认：0
                // , msgName: 'hint' //规定状态信息的字段名称，默认：msg
                // , countName: 'total' //规定数据总数的字段名称，默认：count
                // , dataName: 'rows' //规定数据列表的字段名称，默认：data
                countName: 'total'
                // dataName: 'data.list'
            }
        ,
        cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 80, title: 'ID'}
            , {field: 'userName', title: '登录名'}
            , {field: 'name', title: '姓名'}
            , {field: 'roleName', title: '角色', minWidth: 100}
            , {
                field: 'sex', title: '性别', width: 60, align: 'center'
                , templet: function (d) {
                    return d.sex === 1 ? '男' : '女';
                }
            }
            , {field: 'mobile', title: '手机'}
            , {field: 'email', title: '邮箱'}
            // , {field: 'role', title: '角色'}
            , {field: 'gmtCreate', title: '创建时间', width: 165, align: 'center'}
            , {field: 'status', title: '审核状态', templet: '#buttonTpl', minWidth: 80, align: 'center'}
            , {title: '操作', width: 150, align: 'center', fixed: 'right', toolbar: '#table-useradmin-admin'}
        ]]
        // 开启分页，layout里面包含所有的功能项
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
        // 是否显示加载条（目测没看出来有啥效果）
        // , loading: true
        // 调整头部工具栏
        // , toolbar: true
        // , text: {
        //     none: '对不起，加载出现异常！'
        // }
    })
    ;

    //管理员管理-监听工具条
    table2.on('tool(LAY-user-back-manage)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {
            layer.confirm('确定删除此管理员？', function (index) {
                admin.req({
                    url: layui.setter.request.url + '/mgr/admin/userDelete/' + obj.data.id
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
                title: '编辑管理员'
                , area: ['420px', '720px']
                , id: 'LAY-popup-user-add'
                , success: function (layero, index) {
                    view(this.id).render('adminuser/adminform', data).done(function () {
                        form.render(null, 'layuiadmin-form-admin');

                        //监听提交
                        form.on('submit(LAY-user-back-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            // 修改的时候ID会漏掉
                            field.id = obj.data.id;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            admin.req({
                                url: layui.setter.request.url + '/mgr/admin/userSave' //实际使用请改成服务端真实接口
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'POST'
                                , success: function (res) {
                                    //执行重载
                                    table2.reload('LAY-user-back-manage-id');
                                    layer.close(index); //执行关闭
                                }
                            });
                        });
                    });
                }
            });
        }
    });

    //角色管理
    table2.render({
        elem: '#LAY-user-back-role'
        , url: layui.setter.request.url + '/mgr/admin/getRoleList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , response:
            {
                countName: 'total'
            }
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 80, title: 'ID'}
            , {field: 'name', title: '角色名'}
            , {field: 'description', title: '描述'}
            , {title: '操作', width: 260, align: 'center', fixed: 'right', toolbar: '#table-useradmin-admin'}
        ]]
        // 开启分页，layout里面包含所有的功能项
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    //监听工具条
    table2.on('tool(LAY-user-back-role)', function (obj) {
        var data = obj.data;
        if (obj.event === 'del') {
            layer.confirm('确定删除此角色？', function (index) {
                //
                console.log(obj.data.id);
                admin.req({
                    url: layui.setter.request.url + '/mgr/admin/roleDelete/' + obj.data.id
                    , dataType: 'json'
                    , contentType: "application/json"
                    , type: 'DELETE'
                    , success: function (res) {
                        obj.del();
                        layer.close(index);
                    }
                });

            });
        } else if (obj.event === 'set') {
            admin.popup({
                title: '设置角色权限菜单'
                , area: ['600px', '480px']
                , id: 'LAY-popup-user-set'
                , success: function (layero, index) {
                    view(this.id).render('adminuser/adminroleform', data).done(function () {
                        form.render(null, 'administrators-adminroleform');

                        //监听提交
                        form.on('submit(LAY-user-role-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            field.id = obj.data.id;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格

                        });
                    });
                }
            });
        } else if (obj.event === 'edit') {
            admin.popup({
                title: '添加新角色'
                , area: ['500px', '480px']
                , id: 'LAY-popup-user-add'
                , success: function (layero, index) {
                    view(this.id).render('adminuser/roleform', data).done(function () {
                        form.render(null, 'layuiadmin-form-role');

                        //监听提交
                        form.on('submit(LAY-user-role-submit)', function (data) {
                            var field = data.field; //获取提交的字段
                            field.id = obj.data.id;

                            //提交 Ajax 成功后，关闭当前弹层并重载表格
                            admin.req({
                                url: layui.setter.request.url + '/mgr/admin/roleSave' //实际使用请改成服务端真实接口
                                , data: JSON.stringify(field)
                                , dataType: 'json'
                                , contentType: "application/json"
                                , type: 'POST'
                                , success: function (res) {
                                    //执行重载
                                    table2.reload('LAY-user-back-role');
                                    layer.close(index); //执行关闭
                                }
                            });
                        });
                    });
                }
            });
        }
    });

    // 实名审核列表
    table2.render({
        elem: '#LAY-user-card-list'
        , url: layui.setter.request.url + '/mgr/user/getUserCardList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'userId', title: '用户ID', width: 80}
            , {field: 'name', title: '姓名', width: 80}
            , {field: 'cardNo', title: '证件号', width: 180}
            , {
                field: 'imageUrl',
                title: '正面图片',
                width: 100,
                align: 'center',
                event: 'justShow',
                templet: '#table-user-card-justImgTpl'
            }
            , {
                field: 'validStart',
                title: '有效时间起',
                width: 110,
                templet: '<div>{{ layui.util.toDateString(d.validStart,"yyyy-MM-dd") }}</div>'
            }
            , {
                field: 'validEnd',
                title: '有效时间止',
                width: 110,
                templet: '<div>{{ layui.util.toDateString(d.validEnd,"yyyy-MM-dd") }}</div>'
            }
            , {
                field: 'imageUrl2',
                title: '背面图片',
                width: 100,
                align: 'center',
                event: 'backShow',
                templet: '#table-user-card-backImgTpl'
            }
            , {field: 'gmtCreate', title: '提交时间', width: 170}
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
            , {title: '操作', width: 90, align: 'center', fixed: 'right', toolbar: '#LAY-user-card-list-tool'}
        ]]
        // 开启分页，layout里面包含所有的功能项
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    //监听单元格事件
    table2.on('tool(LAY-user-card-list)', function (obj) {
        var data = obj.data;
        if (obj.event === 'justShow') {
            layer.photos({
                photos: {
                    "title": "查看头像" //相册标题
                    , "data": [{
                        "src": data.imageUrl //原图地址
                    }]
                }
                , shade: 0.01
                , closeBtn: 1
                , anim: 5
            });
        } else if (obj.event === 'backShow') {
            layer.photos({
                photos: {
                    "title": "查看头像" //相册标题
                    , "data": [{
                        "src": data.imageUrl2 //原图地址
                    }]
                }
                , shade: 0.01
                , closeBtn: 1
                , anim: 5
            });
        } else if (obj.event === 'audit') {
            layer.open({
                title: '实名审核'
                , btn: ['通过', '拒绝']
                , yes: function (index) {
                    //按钮 通过 的回调
                    var field = {};
                    field.id = data.id;
                    field.status = 1;
                    //提交 Ajax
                    admin.req({
                        url: layui.setter.request.url + '/mgr/user/auditUserCard' //实际使用请改成服务端真实接口
                        , data: JSON.stringify(field)
                        , dataType: 'json'
                        , contentType: "application/json"
                        , type: 'POST'
                        , success: function (res) {
                            //执行重载
                            table2.reload('LAY-user-card-list');
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
                        url: layui.setter.request.url + '/mgr/user/auditUserCard' //实际使用请改成服务端真实接口
                        , data: JSON.stringify(field)
                        , dataType: 'json'
                        , contentType: "application/json"
                        , type: 'POST'
                        , success: function (res) {
                            //执行重载
                            table2.reload('LAY-user-card-list');
                            layer.close(index); //执行关闭
                        }
                    });
                }
            });
        }
    });

    // 企业实名审核列表
    table2.render({
        elem: '#LAY-user-company-list'
        , url: layui.setter.request.url + '/mgr/user/getUserCompanyList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'userId', title: '用户ID', width: 80}
            , {field: 'unitName', title: '企业名称', width: 200}
            , {field: 'socialCreditCode', title: '统一社会信用代码', width: 190}
            , {field: 'regCapital', title: '注册资本', width: 120}
            , {field: 'establishDate', title: '注册时间', width: 160}
            , {field: 'expirationDate', title: '营业期限', width: 160}
            , {field: 'regAddress', title: '注册地址', width: 300}
            , {
                field: 'imgUrl',
                title: '营业执照图片',
                width: 120,
                align: 'center',
                event: 'imgShow',
                templet: '#table-user-company-imgTpl'
            }
            , {field: 'cardNo', title: '证件号', width: 180}
            , {
                field: 'justImgUrl',
                title: '正面图片',
                width: 100,
                align: 'center',
                event: 'justShow',
                templet: '#table-user-card-justImgTpl'
            }
            , {field: 'signOrg', title: '签发机关', width: 180}
            , {
                field: 'validStart',
                title: '有效时间起',
                width: 110,
                templet: '<div>{{ layui.util.toDateString(d.validStart,"yyyy-MM-dd") }}</div>'
            }
            , {
                field: 'validEnd',
                title: '有效时间止',
                width: 110,
                templet: '<div>{{ layui.util.toDateString(d.validEnd,"yyyy-MM-dd") }}</div>'
            }
            , {
                field: 'backImgUrl',
                title: '背面图片',
                width: 100,
                align: 'center',
                event: 'backShow',
                templet: '#table-user-card-backImgTpl'
            }
            , {field: 'gmtCreate', title: '提交时间', width: 170}
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
            , {title: '操作', width: 80, align: 'center', fixed: 'right', toolbar: '#LAY-user-card-list-tool'}
        ]]
        // 开启分页，layout里面包含所有的功能项
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    //监听单元格事件
    table2.on('tool(LAY-user-company-list)', function (obj) {
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
        } else if (obj.event === 'justShow') {
            layer.photos({
                photos: {
                    "title": "查看头像" //相册标题
                    , "data": [{
                        "src": data.justImgUrl //原图地址
                    }]
                }
                , shade: 0.01
                , closeBtn: 1
                , anim: 5
            });
        } else if (obj.event === 'backShow') {
            layer.photos({
                photos: {
                    "title": "查看头像" //相册标题
                    , "data": [{
                        "src": data.backImgUrl //原图地址
                    }]
                }
                , shade: 0.01
                , closeBtn: 1
                , anim: 5
            });
        } else if (obj.event === 'audit') {
            layer.open({
                title: '企业实名审核'
                , btn: ['通过', '拒绝']
                , yes: function (index) {
                    //按钮 通过 的回调
                    var field = {};
                    field.id = data.id;
                    field.status = 1;
                    //提交 Ajax
                    admin.req({
                        url: layui.setter.request.url + '/mgr/user/auditCompany' //实际使用请改成服务端真实接口
                        , data: JSON.stringify(field)
                        , dataType: 'json'
                        , contentType: "application/json"
                        , type: 'POST'
                        , success: function (res) {
                            //执行重载
                            table2.reload('LAY-user-company-list');
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
                        url: layui.setter.request.url + '/mgr/user/auditCompany' //实际使用请改成服务端真实接口
                        , data: JSON.stringify(field)
                        , dataType: 'json'
                        , contentType: "application/json"
                        , type: 'POST'
                        , success: function (res) {
                            //执行重载
                            table2.reload('LAY-user-company-list');
                            layer.close(index); //执行关闭
                        }
                    });
                }
            });
        }
    });

    // 三方登录绑定信息
    table2.render({
        elem: '#LAY-user-auth-list'
        , url: layui.setter.request.url + '/mgr/user/getUserAuthList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'userId', title: '用户ID', width: 80}
            , {
                field: 'platform', title: '平台', align: 'center', width: 80
                , templet: function (d) {
                    if (d.platform === 'wx') {
                        return '微信';
                    } else if (d.platform === '22') {
                        return '爱名网';
                    } else if (d.platform === 'qq') {
                        return 'QQ';
                    } else {
                        return '未知';
                    }
                }
            }
            , {field: 'openId', title: 'openId', width: 300}
            , {field: 'ip', title: 'IP', width: 120}
            , {
                field: 'canUnbind', title: '是否支持解绑', align: 'center', width: 200
                , templet: function (d) {
                    if (d.canUnbind === 0) {
                        return '否';
                    } else if (d.canUnbind === 1) {
                        return '是';
                    } else {
                        return '未知';
                    }
                }
            }
            , {
                field: 'canQuickLogin', title: '是否支持快捷登录', align: 'center', width: 200
                , templet: function (d) {
                    if (d.canQuickLogin === 0) {
                        return '否';
                    } else if (d.canQuickLogin === 1) {
                        return '是';
                    } else {
                        return '未知';
                    }
                }
            }
            , {field: 'gmtCreate', title: '创建时间', width: 170}
            , {title: '操作', width: 150, align: 'center', fixed: 'right', toolbar: '#table-user-auth-list-tool'}
        ]]
        // 开启分页，layout里面包含所有的功能项
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    // 三方登录绑定信息
    table2.render({
        elem: '#LAY-user-emer-contact-list'
        , url: layui.setter.request.url + '/mgr/user/getEmerContactList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'userId', title: '用户ID', width: 80}
            , {field: 'relationship', title: '关系', width: 300}
            , {field: 'name', title: '姓名', width: 300}
            , {field: 'mobile', title: '手机号', width: 120}
            , {field: 'gmtCreate', title: '创建时间', width: 165}
            // , {title: '操作', width: 150, align: 'center', fixed: 'right', toolbar: '#table-user-auth-list-tool'}
        ]]
        // 开启分页，layout里面包含所有的功能项
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    exports('useradmin', {})
});
