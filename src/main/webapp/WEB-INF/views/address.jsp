<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="row">
        <h3>个人资料</h3>
    </div>
    <div class="row">
        <jsp:include page="navbar.jsp"/>
        <div class="col-md-10">
            <div class="col-md-4 col-md-offset-8">
                <button id="add_btn" class="btn btn-primary">新增</button>
                <button id="delete_btn" class="btn btn-danger">删除</button>
            </div>
            <table class="table table-hover">
                <tr>
                    <th><input type="checkbox" id="check_all"></th>
                    <th>#</th>
                    <th>收货人</th>
                    <th>地址</th>
                    <th>联系方式</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="list">
                    <tr>
                        <td><input type="checkbox" class="check_item"></td>
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
            <div class="col-md-6">
                <h4>当前页为${pageInfo.pageNum},共有${pageInfo.pages}页,总记录数为${pageInfo.total}</h4>
            </div>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${APP_PATH}/address/list?pageNum=1&userId=<shiro:principal property="userId"/>">首页</a></li>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/address/list?pageNum=${pageInfo.pageNum-1}&userId=<shiro:principal property="userId"/>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${pageInfo.navigatepageNums}" var="nav">
                            <c:if test="${pageInfo.pageNum == nav}">
                                <li class="active"><a href="javascript:void(0)">${nav}</a></li>
                            </c:if>
                            <c:if test="${pageInfo.pageNum != nav}">
                                <li><a href="${APP_PATH}/address/list?pageNum=${nav}&userId=<shiro:principal property="userId"/>">${nav}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/address/list?pageNum=${pageInfo.pageNum+1}&userId=<shiro:principal property="userId"/>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="${APP_PATH}/address/list?pageNum=${pageInfo.pages}&userId=<shiro:principal property="userId"/>">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="exampleModalLabel"></h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="addForm">
                    <input type="hidden" name="userId" value="<shiro:principal property="userId"/>">
                    <div class="row">
                        <div class="form-group">
                            <label for="address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="address" id="address" placeholder="请填写详细地址">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="username" class="col-sm-2 control-label">收货人</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="username" id="username" placeholder="请填写收货人">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone" class="col-sm-2 control-label">联系电话</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="phone" id="phone" placeholder="请填写联系电话">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="isDefault" value="1"> 默认地址
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_add_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="bottom.jsp"/>
<script type="text/javascript">
    function getAddress(id){
        $.ajax({
            url:"${APP_PATH}/address/get/"+id,
            type: "GET",
            success:function (result) {
                //回显数据
                let address = result.extend.address;
                $("#address").val(address.address);
                $("#username").val(address.username);
                $("#phone").val(address.phone);
                $(":input[name='isDefault'][value='"+address.isDefault+"']").prop("checked",true);
            }
        })
    }
    function resetForm(){
        $("#addForm")[0].reset();
    }
    $(function () {
        $("#add_btn").click(function () {
            resetForm();
            $("#save_add_btn").attr("operate","添加");
            $("#exampleModalLabel").text("新增地址");
            $('#addModal').modal({
                backdrop: 'static',
                show: 'true'
            });
        });
        $("#save_add_btn").click(function () {
            let operate = $(this).attr("operate");
            if (operate == "添加"){
                $.ajax({
                    url: "${APP_PATH}/address/save",
                    data: $("#addForm").serialize(),
                    type: "POST",
                    success: function (result) {
                        alert(result.message);
                        window.location.href = "${APP_PATH}/address/list?pageNum=${pageInfo.pages}&userId=<shiro:principal property="userId"/>"
                    }
                });
            }else{
                $.ajax({
                    url: "${APP_PATH}/address/update/"+$(this).attr("edit_id"),
                    data: $("#addForm").serialize(),
                    type: "PUT",
                    success: function (result) {
                        alert(result.message);
                        window.location.href = "${APP_PATH}/address/list?pageNum=${pageInfo.pages}&userId=<shiro:principal property="userId"/>"
                    }
                });
            }
        });
        $(".edit_btn").on("click",function () {
            let id = $(this).attr("edit_id");
            $("#save_add_btn").attr("operate","编辑");
            $("#save_add_btn").attr("edit_id",id);
            resetForm();
            getAddress(id);
            $("#exampleModalLabel").text("修改地址");
            $('#addModal').modal({
                backdrop: 'static',
                show: 'true'
            });
        });
        //完成全选/全不选功能
        $("#check_all").click(function () {
            $(".check_item").each(function () {
                $(this).prop("checked",$("#check_all").prop("checked"));
            })
        });
        //完成单选功能
        $(".check_item").click(function () {
            let flag = $(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked",flag);
        });
        //单个删除功能
        $(".delete_btn").on("click",function () {
            let confirm1 = confirm("确定删除["+$(this).parents("tr").find("td:eq(2)").text()+"]吗?");
            if (confirm1){
                $.ajax({
                    url:"${APP_PATH}/address/delete/"+$(this).parents("tr").find("td:eq(1)").text(),
                    type:"DELETE",
                    success:function (resutl) {
                        alert("删除"+resutl.message);
                        window.location.href="${APP_PATH}/address/list/?pageNum=${pageInfo.pageNum}&userId=<shiro:principal property="userId"/>";

                    }
                })
            }
        });
        //多个选择删除
        $("#delete_btn").click(function () {
            //拼接id字符串
            let names='',addressIds='';
            $(".check_item:checked").each(function () {
                names += $(this).parent().next().next().text() + "-";
                addressIds+=$(this).parent().next().text()+" ";
            });
            names = names.substring(0, names.length-1);
            if (names != ''){
                let confirm2 = confirm("确定删除【"+names+"】吗");
                if(confirm2){
                    $.ajax({
                        url:"${APP_PATH}/address/deleteBatch?addressIds="+addressIds,
                        type:"DELETE",
                        success:function (result) {
                            alert("删除"+result.message);
                            window.location.href="${APP_PATH}/address/list?pageNum=${pageInfo.pageNum}&userId=<shiro:principal property="userId"/>";
                        }
                    })
                }
            }else
                alert("请选择要删除的员工");
        });
    });
</script>
</body>
</html>
