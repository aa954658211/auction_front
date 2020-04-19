<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="row">
        <h3>个人资料</h3>
    </div>
    <div class="row">
        <jsp:include page="navbar.jsp"/>
        <div class="col-md-10">
            <div id="toolbar">
                <button id="btn-update" class="btn btn-info">更新</button>
                <button id="btn-delete" class="btn btn-danger">删除</button>
            </div>
            <table id="table">
            </table>
        </div>
    </div>
</div>
<jsp:include page="bottom.jsp"/>
<script src="${APP_PATH}/static/js/bootstrap-table.js"></script>
<script src="${APP_PATH}/static/lib/layer/layer.js"></script>
<script type="text/javascript">
    function customSearch(data, text) {
        return data.filter(function (row) {
            return row.name.indexOf(text) > -1
        })
    }

    $(function () {
        let list_url = '${APP_PATH}/user/saleData?userId=<shiro:principal property="userId"/>';
        // 初始化表格数据
        let dataTable = $('#table').bootstrapTable({
            url: list_url,                      //  请求后台的URL
            method: "get",                      //  请求方式
            uniqueId: "itemId",                     //  每一行的唯一标识，一般为主键列
            cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
            pagination: true,                   //  是否显示分页
            sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
            pageSize: 5,                       //  每页的记录行数
            pageList:[5,10,15],
            search:true,
            sortName:"itemId",
            sortOrder:"asc",
            customSearch:"customSearch",
            formatSearch: function () {
                return '搜索拍卖品名称'
            },
            queryParams: function (param) {
                return {
                    pageNum: param.pageNumber,
                    pageSize: param.pageSize,
                    name: $("#name").val()
                }
            },
            columns: [{
                checkbox: true
            }, {
                field: 'itemId',
                title: '#'
            }, {
                field: 'name',
                title: '名称'
            }, {
                field: 'startprice',
                title: '起拍价格',
                formatter:function (value) {
                    return "¥"+value;
                }
            }, {
                field: 'description',
                title: '描述'
            },{
                field: 'startTime',
                title: '起拍时间',
                formatter:function (value) {
                    let date = new Date(value);
                    return date.toLocaleString();
                }
            },{
                field: 'endTime',
                title: '结束时间',
                formatter:function (value) {
                    let date = new Date(value);
                    return date.toLocaleString();
                }
            },{
                field: 'status',
                title: '状态',
                formatter:function (value) {
                    if (value == 1){
                        return"未拍卖";
                    }else if (value == 2){
                        return"已拍卖";
                    }else if (value == 3){
                        return"已流拍";
                    }
                }
            }]
        });
        // 刷新表格
        function refreshTable() {
            dataTable.bootstrapTable('refresh', {
                url: list_url,
                pageSize: 5,
                pageNumber: 1
            });
        }
        $("#btn-update").click(function () {
            let rows = $('#table').bootstrapTable('getSelections');
            if (rows.length == 0) {
                window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
            } else if (rows.length != 1) {
                window.parent.layer.msg("一次只能修改一条数据!", {icon: 2, time: 1000, offset: 't'})
            } else {
                window.location.href = '${APP_PATH}/item/toUpdate?itemId=' + rows[0].itemId;
            }
        });

        // 删除
        $('#btn-delete').click(function () {
            var rows = $('#table').bootstrapTable('getSelections');
            if (rows.length == 0) {
                window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
            } else if (rows.length == 1) {
                window.parent.layer.confirm("确认删除?", {icon: 3, offset: 't'}, function () {
                    $.ajax({
                        url: '${APP_PATH}/item/delete/' + rows[0].itemId,
                        type: 'delete',
                        dataType:"json",
                        success: function (response) {
                            if (response.code == 100) {
                                window.parent.layer.msg("删除成功", {icon: 1, time: 1000, offset: 't'});
                                refreshTable();
                            } else {
                                window.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                            }
                        }
                    });
                })
            } else {
                window.parent.layer.confirm("确认批量删除?", {icon: 3, offset: 't'}, function () {
                    let ids='';//要删除的用户的id的集合
                    for (let i = 0; i < rows.length; i++) {
                        ids+=rows[i].itemId+',';
                    }
                    ids.substring(0,ids.length-1);
                    $.ajax({
                        url: '${APP_PATH}/item/deleteBatch?ids='+ids,
                        type: 'delete',
                        dateType: 'json',
                        success: function (response) {
                            if (response.code == 100) {
                                window.parent.layer.msg("删除成功", {icon: 1, time: 1000, offset: 't'});
                                refreshTable();
                            } else {
                                window.parent.layer.alert(response.message, {icon: 5, offset: 't'});
                            }
                        }
                    });
                });
            }
        });
    });
</script>
</body>
</html>
