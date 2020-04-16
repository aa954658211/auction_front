<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<jsp:include page="header.jsp"/>
<link rel="stylesheet" href="${APP_PATH}/static/jeDate/skin/jedate.css" />
<script src="${APP_PATH}/static/jeDate/dist/jedate.min.js"></script>
<div class="container">
    <div class="row">
        <h3>交易管理</h3>
    </div>
    <div class="row">
        <jsp:include page="navbar.jsp"/>
        <div class="col-md-10">
            <form class="form-horizontal" id="updateForm" onsubmit="return false;" enctype="multipart/form-data">
                <input type="hidden" name="userId" value="<shiro:principal property="userId"/>">
                <div class="form-group">
                    <label for="name" class="col-sm-2 control-label">拍卖品名称</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="name" value="${item.name}" name="name" placeholder="请输入拍卖品名称">
                    </div>
                </div>
                <div class="form-group">
                    <label for="decription" class="col-sm-2 control-label">拍卖品描述</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="decription" value="${item.description}" name="description" placeholder="请输入拍卖品描述">
                    </div>
                </div>
                <div class="form-group">
                    <label for="startprice" class="col-sm-2 control-label">起拍价格</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="startprice" value="${item.startprice}" name="startprice" placeholder="请输入起拍价格">
                    </div>
                </div>
                <div class="form-group">
                    <label for="upstart" class="col-sm-2 control-label">起拍时间</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control"  name="startTime" id="upstart" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label for="upend" class="col-sm-2 control-label">结束时间</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control"  name="endTime" id="upend" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">拍卖品类型</label>
                    <div class="col-sm-8">
                        <select class="form-control" name="itemTypeId">
                            <c:forEach items="${itemTypes}" var="itemType">
                                <c:if test="${item.itemType.itemTypeId == itemType.itemTypeId}">
                                    <option value="${itemType.itemTypeId}" selected="selected">${itemType.name}</option>
                                </c:if>
                                <c:if test="${item.itemType.itemTypeId != itemType.itemTypeId}">
                                    <option value="${itemType.itemTypeId}">${itemType.name}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="auctionImg" class="col-sm-2 control-label">图片</label>
                    <div class="col-sm-8">
                        <input type="hidden" value="${item.picture}" name="picture">
                        <input type="file" class="form-control" id="auctionImg" name="auctionImg" placeholder="拍卖品图片">
                    </div>
                    <div class="col-sm-2 col-sm-offset-10">
                        <img style="width: 160px;height: 180px;" id="img" src="${APP_PATH}/img/${item.picture}">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button class="btn btn-default" id="upd_btn">修改拍卖品</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="bottom.jsp"/>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.form.min.js"></script>
<script src="${APP_PATH}/static/lib/layer/layer.js"></script>
<script>
    $(function () {
        $('#auctionImg').on('change',function() {
            $('#img').attr('src', window.URL.createObjectURL(this.files[0]));
        });
        $("#upd_btn").click(function () {
            $("#updateForm").on("submit",function () {
                $(this).ajaxSubmit({
                    type:'post',
                    dataType:"json",
                    url:"${APP_PATH}/item/update/${item.itemId}",
                    data:$("#updateForm").serialize(),
                    success:function (result) {
                        if (result.code == 100){
                            layer.msg("修改成功", {icon: 1, time: 10000, offset: '0px'});
                            window.location.href="${APP_PATH}/user/mySale?userId=<shiro:principal property="userId"/>"
                        }else{
                            layer.alert(result.message, {icon: 5, offset: '0px'});
                        }
                    }
                });
            });
        });
        var start = {},
            end = {};
        jeDate('#upstart', {
            format: 'YYYY/MM/DD hh:mm:ss',
            hmsLimit:true,
            minDate: '2018-04-10', //设定最小日期为当前日期
            maxDate: function(that) {
                //that 指向实例对象
                return jeDate.valText(that.valCell) == "" ? jeDate.nowDate({
                    DD: 0
                }) : start.maxDate;
            }, //设定最大日期为当前日期
            donefun: function(obj) {
                end.minDate = obj.val; //开始日选好后，重置结束日的最小日期
                jeDate("#upend", LinkageEndDate(true));
            }
        });
        jeDate('#upend', LinkageEndDate);

        function LinkageEndDate(istg) {
            return {
                trigger: istg || "click",
                hmsLimit:true,
                format: 'YYYY/MM/DD hh:mm:ss',
                minDate: function(that) {
                    //that 指向实例对象
                    var nowMinDate = jeDate.valText('#upstart') == "" && jeDate.valText(that.valCell) == "";
                    return nowMinDate ? jeDate.nowDate({
                        DD: 0
                    }) : end.minDate;
                }, //设定最小日期为当前日期
                maxDate: '2099-06-16', //设定最大日期为当前日期
                donefun: function(obj) {
                    start.maxDate = obj.val; //将结束日的初始值设定为开始日的最大日期
                }
            };
        }
    })
</script>
</body>
</html>
