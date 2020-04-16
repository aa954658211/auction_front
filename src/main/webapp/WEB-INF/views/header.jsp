<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    session.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
    <title>欢迎来到飞舞拍卖</title>
    <script src="${APP_PATH}/static/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap-table.css">
    <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>
    <link rel="shutcut icon" href="${APP_PATH}/static/img/page_white_freehand.png" type="image/x-icon">
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>111
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand">
                <img class="logo" src="${APP_PATH}/static/img/page_white_freehand.png">
            </a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li id="main"><a href="${APP_PATH}/index" >首页 <span class="sr-only">(current)</span></a></li>
                <li id="sale"><a href="${APP_PATH}/item/toSale" >我要拍卖物品</a></li>
            </ul>
            <form class="navbar-form navbar-left">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="搜索你想要的">
                </div>
                <button type="submit" class="btn btn-default">搜索</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <shiro:guest>
                    <li><a href="${APP_PATH}/login">登录</a></li>
                </shiro:guest>
                <li><a href="${APP_PATH}/login#register">注册</a></li>
                <shiro:user>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                           aria-expanded="false">
                            <shiro:principal property="username"/>
                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="${APP_PATH}/user/toDetail?userId=<shiro:principal property="userId"/>">个人设置</a></li>
                            <li><a href="#">修改密码</a></li>
                            <li><a href="${APP_PATH}/logout">退出</a></li>
                        </ul>
                    </li>
                </shiro:user>
            </ul>
        </div><!-- /.navbar-collapse -->

    </div><!-- /.container-fluid -->
</nav>