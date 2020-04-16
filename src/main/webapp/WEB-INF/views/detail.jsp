<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="row">
        <h3>个人资料</h3>
    </div>
    <div class="row">
        <jsp:include page="navbar.jsp"/>
        <div class="col-md-10">
            <form class="form-horizontal" action="${APP_PATH}/user/update" method="post">
                <input type="hidden" name="userId" value="${user.userId}">
                <div class="form-group">
                    <label class="col-sm-2 control-label">username</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${user.username}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="phone" class="col-sm-2 control-label">phone</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="phone" name="phone" placeholder="phone" value="${user.phone}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="phone" class="col-sm-2 control-label">email</label>
                    <div class="col-sm-10">
                        <input type="email" class="form-control" id="email" name="email" placeholder="email" value="${user.email}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="age" class="col-sm-2 control-label">age</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="age" name="age" placeholder="age" value="${user.age}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">sex</label>
                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${user.sex==1}">
                                <label class="radio-inline">
                                    <input type="radio" name="sex" value="1" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" value="2"> 女
                                </label>
                            </c:when>
                            <c:when test="${user.sex == 2}">
                                <label class="radio-inline">
                                    <input type="radio" name="sex" value="1" > 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" value="2" checked="checked"> 女
                                </label>
                            </c:when>
                            <c:otherwise>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" value="1"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" value="2"> 女
                                </label>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default">修改</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="bottom.jsp"/>
</body>
</html>
