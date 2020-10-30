<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>backend</title>
    <link rel="stylesheet" type="text/css" href="../bootstarp/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../css/index.css" />
    <script src="../js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="../bootstarp/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/userSetting.js" type="text/javascript" charset="utf-8"></script>
    <script>
        /*禁用某商品*/
        function ban(id) {
            if (confirm("确认禁用？")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/back/BanProType",
                    data: "banTypeId=" + id,
                    dataType: "text",
                    method: "post",
                    success: function (result) {
                        if (result === "true") {
                            window.location.href = "${pageContext.request.contextPath}/back/showProductTypeManager"
                        }
                    }
                })
            }
        }

        function updateProTypeInfo(id,obj) {
            var $this = $(obj);
            // var name = document.getElementById("productTypeName2");
            // debugger;
            var name = $this.parent().parent().find("td:eq(1) input").val();
            $.ajax({
                url: "${pageContext.request.contextPath}/back/updateProTypeInfo",
                data: {"proTypeName" : name,"typeId" : id},
                dataType: "text",
                method: "post",
                success: function (result) {
                    if (result === "true") {
                        window.location.href = "${pageContext.request.contextPath}/back/showProductTypeManager"
                    }else{
                        console.log("修改失败")
                    }
                }
            })
        }
    </script>
</head>

<body>
<div class="panel panel-default" id="userSet">
    <div class="panel-heading">
        <h3 class="panel-title">商品类型管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加商品类型" class="btn btn-primary" id="doAddProTpye">
        <div class="modal fade" tabindex="-1" id="ProductType">
            <!-- 窗口声明 -->
            <div class="modal-dialog modal-lg">
                <form action="${pageContext.request.contextPath}/back/addProductType"
                      method="post">
                <!-- 内容声明 -->
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">添加商品类型信息</h4>
                    </div>
                    <div class="modal-body text-center">
                        <div class="row text-right">
                            <label for="proTypeName" class="col-sm-4 control-label">类型名称：</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="proTypeName" name="productTypeName">
                            </div>
                        </div>
                        <br>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary addProductType">添加</button>
                        <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                    </div>
                </div>
                </form>
            </div>
        </div>
        <br>
        <br>
        <div class="show-list">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">类型名称</th>
                    <th class="text-center">状态</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">
                <c:forEach items="${productTypeList}" var="proType" varStatus="s">
                <tr class="tr">
                    <td>${s.count}</td>
                    <td id="proTypeNameText">
                        <input  type="text" id="productTypeName2" value="${proType.typeName}">
                    </td>
                    <td>启用</td>
                    <td class="text-center">
                        <button class="btn btn-success btn-sm doProDisable" type="button" onclick="updateProTypeInfo(${proType.id},this)">
                            修改
                        </button>
<%--                        <input type="button" class="btn btn-warning btn-sm doProTypeModify" onclick="updateProTypeInfo(${proType.id})" value="修改">--%>
                        <button class="btn btn-danger btn-sm doProDisable" type="button" onclick="ban(${proType.id})">
                            禁用
                        </button>
<%--                        <input type="button" class="btn btn-danger btn-sm doProTypeDisable" value="禁用">--%>
                    </td>
                </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
<%--        <div class="modal fade" tabindex="-1" id="myProductType">--%>
<%--            <!-- 窗口声明 -->--%>
<%--            <div class="modal-dialog modal-lg">--%>
<%--                <form action="${pageContext.request.contextPath}/back/updateProTypeInfo" method="post">--%>
<%--                <!-- 内容声明 -->--%>
<%--                <div class="modal-content">--%>
<%--                    <!-- 头部、主体、脚注 -->--%>
<%--                    <div class="modal-header">--%>
<%--                        <button class="close" data-dismiss="modal">&times;</button>--%>
<%--                        <h4 class="modal-title">商品类型修改</h4>--%>
<%--                    </div>--%>
<%--                    <div class="modal-body text-center">--%>
<%--&lt;%&ndash;                        <div class="row text-right">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <label for="proTypeNum" class="col-sm-4 control-label">编号：</label>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <div class="col-sm-4">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <input type="text" class="form-control" id="proTypeNum">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <br>&ndash;%&gt;--%>
<%--                        <div class="row text-right">--%>
<%--                            <label for="proTypeName" class="col-sm-4 control-label">类型名称</label>--%>
<%--                            <div class="col-sm-4">--%>
<%--                                <input type="text" class="form-control" name="proTypeName" id="proTypeName">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer">--%>
<%--                        <button class="btn btn-warning updateProType">修改</button>--%>
<%--                        <button class="btn btn-primary cancel" data-dismiss="modal" type="submit"  onclick="updateProTypeInfo()">取消</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>
</div>
</body>

</html>
