<%--
  Created by IntelliJ IDEA.
  User: 95465
  Date: 2020/4/16
  Time: 16:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>Title</title>
    <script src="${APP_PATH}/static/js/jquery.min.js"></script>
</head>
<body>
<button id="test">id</button>
<script>
    $(function () {
        $("#test").click(function () {
            alert("33");
            $.ajax({
                url:"${APP_PATH}/item/update2/1",
                dataType:"json",
                type:"post",
                data:{name:"qer",description:"32432"},
                success:function (result) {
                    console.log(result);
                }
            })
        });
    })
</script>
</body>
</html>
