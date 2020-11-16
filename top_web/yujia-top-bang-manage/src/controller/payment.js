/**
 * 支付管理
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
        elem: '#LAY-payment-recharge-record-list'
        , url: layui.setter.request.url + '/mgr/payment/getRechargeRecordList'
        , dataType: 'json'
        , contentType: "application/json"
        , method: 'POST'
        , cols: [[
            {type: 'checkbox', fixed: 'left'}
            , {field: 'id', width: 100, title: 'ID'}
            , {field: 'userId', title: '用户ID'}
            , {field: 'price', title: '金额'}
            , {field: 'type', title: '充值类型'}
            , {field: 'content', title: '描述'}
            , {field: 'gmtCreate', title: '创建时间', width: 165, align: "center"}
            , {title: '操作', minWidth: 150, align: 'center', fixed: 'right', toolbar: '#table-payment-recharge-record-list'}
        ]]
        , page: {layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']}
    });

    exports('payment', {})
});
