<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div class="col-md-2">
    <ul class="nav nav-pills nav-stacked">
        <li role="presentation" class="active"><a href="#">交易管理</a></li>
        <li role="presentation"><a href="#">订单管理</a></li>
        <li role="presentation"><a href="${APP_PATH}/item/toSale">上架拍卖品</a></li>
        <li role="presentation"><a href="#">我的收藏</a></li>
    </ul>
    <ul class="nav nav-pills nav-stacked">
        <li role="presentation" class="active"><a href="#">个人中心</a></li>
        <li role="presentation"><a href="${APP_PATH}/user/toDetail?userId=<shiro:principal property="userId"/>">个人资料</a></li>
        <li role="presentation"><a href="${APP_PATH}/user/mySale">个人拍卖品</a></li>
        <li role="presentation"><a href="${APP_PATH}/address/list?userId=<shiro:principal property="userId"/>">收货地址</a></li>
    </ul>
</div>