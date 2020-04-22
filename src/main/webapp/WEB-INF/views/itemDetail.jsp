<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp"/>
<script src="${APP_PATH}/static/js/timeCount.js"></script>
<div class="container">
    <div class="row">
        <div class="col-md-6">
            <img class="img-rounded" src="${APP_PATH}/img/${item.picture}" style="width: 100%; height: 100%; max-height: 450px; min-height: 450px">
        </div>
        <div class="col-md-6">
            <form id="recordForm" onsubmit="return false;">
                <input type="hidden" name="itemId" value="${item.itemId}">
                <input type="hidden" name="userId" value="<shiro:principal property="userId"/>">
                <p class="bg-info">${item.name}:${item.description}</p>
                <div class="well well-sm">
                    <div id="fnTimeCountDown" data-end="${item.endTime.toLocaleString()}">
                        出价倒计时：
                        <span class="day">00</span>天
                        <span class="hour">00</span>时
                        <span class="mini">00</span>分
                        <span class="sec">00</span>秒
                        <span class="hm">000</span>
                    </div>
                </div>
                <h4>起拍价：<span class="label label-info">￥${item.startprice}</span></h4>
                <h5>选择竞价：</h5>
                <div>
                    <button id="sub">-</button>
                    <input type="text" name="price" value="${item.startprice}" style="text-align: center;" id="price" onblur="original()"/>
                    <button id="inc">+</button><br />
                </div><br/>
                <div class="well well-sm">
                    出价记录（0）
                </div>
                <button type="button" class="btn btn-success btn-lg btn-block" id="bid">立即出价</button>
                <h4>拍卖信息</h4>
                <h5>开拍时间:<fmt:formatDate value="${item.startTime}" pattern="YYYY/MM/dd HH:mm:ss"/></h5>
                <h5>所属类别:${item.itemType.name}</h5>
                <h5>结束时间:<fmt:formatDate value="${item.endTime}" pattern="YYYY/MM/dd HH:mm:ss"/></h5>
            </form>
        </div>
    </div>
</div>
<jsp:include page="bottom.jsp"/>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery.form.min.js"></script>
<script src="${APP_PATH}/static/lib/layer/layer.js"></script>
<script>
    let original1 = parseInt($("#price").val());
    function original(){
        let price = $("#price").val();
        if(parseInt(price) < original1){
            $("#price").val(original1);
        }
    }
    function subUtil(price,dev){
        if(price%dev==0){
            price-=dev;
        }else{
            price-=price%dev;
        }
        if(price <= original1){
            $("#price").val(original1);
            return false;
        }
        return price;
    }
    function incUtil(price,inc){
        if(price%inc==0){
            price+=inc;
        }else{
            price-=price%inc;
            price+=inc;
        }
        return price;
    }
    $(function () {
        $("#fnTimeCountDown").fnTimeCountDown("2018/07/08 18:45:13");
        //点击按钮在竞价区间里面减，点击减按钮如果值是小于原始值就复原，失去焦点也复原
        $("#inc").click(function(){
            let price = parseInt($("#price").val());
            if(price>=0 && price < 100){
                price = incUtil(price,10);
            }else if(price>=100 && price < 500){
                price = incUtil(price,50);
            }else if(price>=500 && price <= 1000){
                price = incUtil(price,100);
            }else if(price>=1000 && price <= 2000){
                price = incUtil(price,200);
            }else if(price>=2000 && price <= 5000){
                price = incUtil(price,250);
            }else if(price>=5000 && price <= 10000){
                price = incUtil(price,500);
            }else if(price>=10000 && price <= 20000){
                price = incUtil(price,1000);
            }else if(price>=20000){
                price = incUtil(price,2000);
            }
            $("#price").val(price);
        });
        $("#sub").click(function(){
            let price = parseInt($("#price").val());
            if(price>=0 && price <= 100){
                price = subUtil(price,10);
            }else if(price>=100 && price <= 500){
                price = subUtil(price,50);
            }else if(price>=500 && price <= 1000){
                price = subUtil(price,100);
            }else if(price>=1000 && price <= 2000){
                price = subUtil(price,200);
            }else if(price>=2000 && price <= 5000){
                price = subUtil(price,250);
            }else if(price>=5000 && price <= 10000){
                price = subUtil(price,500);
            }else if(price>=10000 && price <= 20000){
                price = subUtil(price,1000);
            }else if(price>=20000){
                price = subUtil(price,2000);
            }
            if(price == false){
                return false;
            }
            $("#price").val(price);
        });
        $("#bid").click(function () {
                $.ajax({
                    type:'post',
                    dataType:'json',
                    url:"${APP_PATH}/auctionRecord/save",
                    data:$("#recordForm").serialize(),
                    success:function (result) {
                        if (result.code == 100){
                            layer.msg("上架成功", {icon: 1, time: 10000, offset: '0px'});
                        }else{
                            layer.alert(result.message, {icon: 5, offset: '0px'});
                        }
                    }
                });
            });
    });
</script>
</body>
</html>
