/**
 * 公共业务
 */

layui.define(function (exports) {
    var $ = layui.$
        , layer = layui.layer
        , admin = layui.admin

    //公共业务的逻辑处理可以写在此处，切换任何页面都会执行
    //……


    //退出
    admin.events.logout = function () {
        //执行退出接口
        admin.req({
            url: layui.setter.request.url + '/mgr/logout'
            , headers: { //通过 request 头传递
                accessToken: layui.data([layui.setter.tableName])[layui.setter.request.tokenName]
            }
            , type: 'POST'
            // 这里要说明一下：done 是只有 response 的 code 正常才会执行。而 succese 则是只要 http 为 200 就会执行
            , done: function (res) {
                layer.msg("退出成功");
                //清空本地记录的 token，并跳转到登入页
                admin.exit();
            }
        });
    };

    //对外暴露的接口
    exports('common', {});
});