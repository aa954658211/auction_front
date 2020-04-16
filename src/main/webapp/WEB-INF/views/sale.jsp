<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <form class="form-horizontal" id="saleForm" onsubmit="return false;" enctype="multipart/form-data">
                <input type="hidden" name="userId" value="<shiro:principal property="userId"/>">
                <div class="form-group">
                    <label for="name" class="col-sm-2 control-label">拍卖品名称</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="name" name="name" placeholder="请输入拍卖品名称">
                    </div>
                </div>
                <div class="form-group">
                    <label for="decription" class="col-sm-2 control-label">拍卖品描述</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="decription" name="description" placeholder="请输入拍卖品描述">
                    </div>
                </div>
                <div class="form-group">
                    <label for="startprice" class="col-sm-2 control-label">起拍价格</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="startprice" name="startprice" placeholder="请输入起拍价格">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inpstart" class="col-sm-2 control-label">起拍时间</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control"  name="startTime" id="inpstart" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inpend" class="col-sm-2 control-label">结束时间</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control"  name="endTime" id="inpend" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">拍卖品类型</label>
                    <div class="col-sm-8">
                        <select class="form-control" name="itemTypeId">
                            <c:forEach items="${itemTypes}" var="itemType">
                                <option value="${itemType.itemTypeId}">${itemType.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="auctionImg" class="col-sm-2 control-label">图片</label>
                    <div class="col-sm-8">
                        <input type="file" class="form-control" id="auctionImg" name="auctionImg" placeholder="拍卖品图片">
                    </div>
                    <div class="col-sm-2 col-sm-offset-10">
                        <img style="width: 160px;height: 180px;" id="img">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button class="btn btn-default" id="sale_btn">上传拍卖品</button>
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
        $("#main").removeClass("active");
        $("#sale").addClass("active");
        $('#auctionImg').on('change',function() {
            $('#img').attr('src', window.URL.createObjectURL(this.files[0]));
        });
        $("#sale_btn").click(function () {
            $("#saleForm").on("submit",function () {
                $(this).ajaxSubmit({
                    type:'post',
                    dataType:'json',
                    url:"${APP_PATH}/item/sale",
                    data:$("#saleForm").serialize(),
                    success:function (result) {
                        if (result.code == 100){
                            layer.msg("上架成功", {icon: 1, time: 10000, offset: '0px'});
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
        jeDate('#inpstart', {
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
                jeDate("#inpend", LinkageEndDate(true));
            }
        });
        jeDate('#inpend', LinkageEndDate);

        function LinkageEndDate(istg) {
            return {
                trigger: istg || "click",
                hmsLimit:true,
                format: 'YYYY/MM/DD hh:mm:ss',
                minDate: function(that) {
                    //that 指向实例对象
                    var nowMinDate = jeDate.valText('#inpstart') == "" && jeDate.valText(that.valCell) == "";
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
