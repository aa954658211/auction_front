<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="row">
        <div class="panel panel-default">
            <!-- Default panel contents -->
            <div class="panel-heading">订单信息</div>
            <!-- Table -->
            <table class="table">
                <tr><td>订单编号</td><td>${order.orderNo}</td><td>成交时间</td><td><fmt:formatDate value="${order.createTime}" pattern="YYYY/MM/dd HH:mm:ss"/> </td></tr>
                <tr><td>商品名称</td><td>${order.item.name}</td><td>成交价</td><td>${order.price}</td></tr>
                <tr><td>订单状态</td><td id="status"></td></tr>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="panel panel-default">
            <div class="panel-heading">收货信息</div>
            <table class="table table-hover">
                <tr>
                    <th><input type="radio" id="radio_all"></th>
                    <th>#</th>
                    <th>收货人</th>
                    <th>地址</th>
                    <th>联系方式</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${addresses}" var="list">
                    <tr>
                        <td><input type="radio" class="radio_item" name="isDefault" value="${list.addressId}"></td>
                        <td>${list.addressId}</td>
                        <td>${list.username}</td>
                        <td>${list.address}</td>
                        <td>${list.phone}</td>
                        <td>
                            <button class="btn btn-primary btn-sm edit_btn" edit_id="${list.addressId}"
                                    name="edit_btn"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                            </button>
                            <button class="btn btn-danger btn-sm delete_btn" delete_id="${list.addressId}"
                                    name="delete_btn"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <c:if test="${order.status==0}">
                <button type="button" class="btn btn-warning" id="confirm">确认订单</button>
            </c:if>
            <button type="button" class="btn btn-default" id="back">返回</button>
        </div>
    </div>
</div>
<jsp:include page="bottom.jsp"/>
<script type="text/javascript" src="${APP_PATH}/static/js/bootstrap-table.js"></script>
<script src="${APP_PATH}/static/lib/layer/layer.js"></script>
<script>
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
    $(function () {
        let addr = "";
        <c:if test="${order.addressId !=null}">
            addr = ${order.addressId};
        </c:if>
        if (addr !== ""){
            $(":input[name='isDefault'][value='"+addr+"']").prop("checked",true);
        }
        let status=checkStatus(${order.status});
        $("#status").text(status);
        $("#back").click(function () {
            window.history.go(-1);
        });
        $("#confirm").click(function () {
            let address = $(":checked[name='isDefault']").val();
            if (address == undefined){
                window.parent.layer.alert("请先添加地址", {icon: 5, offset: 't'});
                return false;
            }else{
                $.ajax({
                   url:"${APP_PATH}/order/confirm",
                   type:"post",
                    dataType:"json",
                    data:{"orderId":${order.orderId},"addressId":address},
                    success:function (response) {
                        if (response.code == 100) {
                            window.parent.layer.msg("确认成功", {icon: 1, time: 1000, offset: 't'});
                            window.location.reload();
                        } else {
                            window.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                        }
                    }
                });
            }
        });
    });
</script>
</body>
</html>
