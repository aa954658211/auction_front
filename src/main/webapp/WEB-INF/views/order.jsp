<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp"/>
<style type="text/css">
    #header_left li {
        float: left;
        list-style-type: none;
        margin-left: 30px;
    }

    #header_left li a {
        color: black;
        line-height: 30px;
        font-size: 15px;
        text-decoration: underline
    }

    #header_left li a:hover {
        color: blue;
    }

    .order li {
        border: 1px solid black;
        margin: 10px;
        list-style: none;
        border-radius: 5px;
        color: red;
        padding: 8px;
    }
</style>
<style>
    .ordertab1 {
        border-top: 1px solid #e6e6e6;
        border-left: 1px solid #e6e6e6;
    }

    .ordertab1 td {
        border-right: 1px solid #e6e6e6;
        border-bottom: 1px solid #e6e6e6;
    }

    .orderbg {
        height: 33px;
        line-height: 33px;
        background: #e6e6e6;
        text-align: center;
        border-bottom: 1px solid #d5d5d5;
    }

    .orderbg1 {
        height: 32px;
        line-height: 32px;
        color: #636363;
    }

    .orderbg1 span {
        padding-left: 15px;
    }
</style>
<div class="container">
    <div class="row">
        <h3>交易管理</h3>
    </div>
    <div class="row">
        <jsp:include page="navbar.jsp"/>

        <div class="col-md-10">
            <div id="header_left">
                <ul id="navi">
                    <li><a href="javascript:void(0)" status="">全部</a></li>
                    <li><a href="javascript:void(0)" status="0">待确认</a></li>
                    <li><a href="javascript:void(0)" status="1">待付款</a></li>
                    <li><a href="javascript:void(0)" status="2">待发货</a></li>
                    <li><a href="javascript:void(0)" status="3">待收货</a></li>
                    <li><a href="javascript:void(0)" status="4">已完成</a></li>
                    <li><a href="javascript:void(0)" status="5">失败</a></li>
                </ul>
            </div>
            <br>
            <div>
                <table width="980" border="0" cellspacing="0" cellpadding="0" class="ordertab1">
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="bottom.jsp"/>
<script type="text/javascript" src="${APP_PATH}/static/js/bootstrap-table.js"></script>
<script src="${APP_PATH}/static/lib/layer/layer.js"></script>
<script type="text/javascript">
    function checkStatus(status) {
        switch (status) {
            case 0:return "待确认";
            case 1:return "待付款";
            case 2:return "待发货";
            case 3:return "待收货";
            case 4:return "已完成";
            case 5:return "失败订单";
            default:return "";
        }
    }
    function check(status) {
        switch (status) {
            case 0:return "确认订单";
            case 1:return "点击付款";
            case 3:return "点击收货";
            default:return "请等待";
        }
    }
    function query(status) {
        $(".ordertab1").empty();
        $.ajax({
            url: "${APP_PATH}/order/list",
            type: "POST",
            dataType: "json",
            data: {userId: "<shiro:principal property="userId"/>", status: status},
            success: function (resutl) {
                let orders = resutl.extend.orders;
                $(".ordertab1").append($('<tr class="orderbg">\n' +
                    '                        <td height="36" colspan="2">商品</td>\n' +
                    '                        <td width="108">单价（元）</td>\n' +
                    '                        <td width="102">数量</td>\n' +
                    '                        <td width="170">实付款（元）</td>\n' +
                    '                        <td width="168">订单状态</td>\n' +
                    '                        <td width="132">操作</td>\n' +
                    '                    </tr>'));
                $.each(orders, function () {
                    let head = $('<tr>\n' +
                        '                        <td colspan="8" class="orderbg1"><span>\n' +
                        '              <input name="" type="checkbox" value=""/>\n' +
                        '              </span><span>订单编号：'+this.orderNo+'</span><span> 成交时间：'+new Date(this.createTime).toLocaleString()+'</span><span>河南火星人商贸有限公司 </span></td>\n' +
                        '                    </tr>');
                    let status=checkStatus(this.status);
                    let operate=check(this.status);
                    let body = $('<tr align="center">\n' +
                        '                        <td height="96">\n' +
                        '                            <p class="proimg"><img src="${APP_PATH}/img/'+this.item.picture+'" width="60" height="60"/></p>\n' +
                        '                        </td>\n' +
                        '                        <td>'+this.item.name+'</td>\n' +
                        '                        <td>'+this.price+'</td>\n' +
                        '                        <td><strong>1</strong></td>\n' +
                        '                        <td>\n' +
                        '                            <p>'+this.price+'</p>\n' +
                        '                        </td>\n' +
                        '                        <td>\n' +
                        '                            <p class="red">'+status+'</p>\n' +
                        '                            <p class="blue"><a class="detail" href="${APP_PATH}/order/orderDetail?orderId='+this.orderId+'&userId='+<shiro:principal property="userId"/> +'" id="'+this.orderId+'">订单详情</a></p>\n' +
                        '                        </td>\n' +
                        '                        <td>\n' +
                        '                            <p><a class="orderOperate" href="javascript:void(0)"  operate="'+operate+'" id="'+this.orderId+'">'+operate+'</a></p>\n' +
                        '                        </td>\n' +
                        '                    </tr>');
                    $(".ordertab1").append(head).append(body);
                });
            }
        })
    }

    $(function () {
        query();
        $("#navi li a").click(function () {
            let status = $(this).attr("status");
            query(status);
        });
        // $(document).on("click",".detail",function () {   //绑定订单详情
        //
        // });
        $(document).on("click",".orderOperate",function () {
            let operate = $(this).attr("operate");
            let id = $(this).attr("id");
            let price =$(this).parents("tr").find("td:eq(2)").text();
            if (operate == "确认订单"){
                // alert("32423");发送确认请求,1.先选择地址，如果没有的话就新建
            }else if (operate == "点击付款"){
                //1.查询余额
                $.ajax({
                    url:"${APP_PATH}/user/balance",
                    type:"get",
                    data:{"userId":<shiro:principal property="userId"/> },
                    dataType: "json",
                    success:function (result) {
                        let balance = result.extend.balance;
                        if (balance != null){
                            if (balance < price){
                                window.parent.layer.alert("您的余额不足，请先充值!", {icon: 5, offset: 't'});
                            }else{
                                //发送付款请求
                                $.ajax({
                                    url:"${APP_PATH}/user/pay",
                                    type:"post",
                                    data:{"userId":<shiro:principal property="userId"/>,"price":price,"orderId":id},
                                    dataType: "json",
                                    success:function (result) {
                                        if (result.code == 100){
                                            window.parent.layer.msg("付款成功", {icon: 1, time: 1000, offset: 't'});
                                            window.location.reload();
                                        }else{
                                            window.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                                        }
                                    }
                                });
                            }
                        }else{
                            window.parent.layer.alert("您的余额不足，请先充值!", {icon: 5, offset: 't'});
                        }
                    }
                });

            }else if(operate == "点击收货"){

            }
        });
    });
</script>
</body>
</html>
