<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="row">
        <div class="jumbotron">
            <h1>欢迎来到飞舞拍卖</h1>
            <p>在这里你可以任意选择你想要拍卖的，你也可以选择拍卖你的物品</p>
            <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
        </div>
    </div>
    <div class="row">
        <c:forEach items="${items}" var="item">
            <div class="col-sm-6 col-md-3">
                <div class="thumbnail">
                    <a href="${APP_PATH}/item/detail?itemId=${item.itemId}" target="_blank">
                        <img src="${APP_PATH}/img/${item.picture}" alt="${item.name}"  style="width: 100%; height: 100%; max-height: 200px; min-height: 200px">
                        <div class="caption">
                            <h3>${item.name}</h3>
                            <h6>起拍时间：<fmt:formatDate value="${item.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></h6>
                            <p>起拍价格：${item.startprice}</p>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<jsp:include page="bottom.jsp"/>
<script>
    $("#sale").removeClass("active");
    $("#main").addClass("active");
</script>
</body>
</html>
