<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>backend</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/bootstarp/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/bootstarp/js/bootstrap.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/userSetting.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
            width: 100%;
            text-align: center;
        }

        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }

        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }
    </style>
    <script>
        /*禁用某商品*/
        function ban(id) {
            if (confirm("确认禁用？")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/back/BanPro",
                    data: "banId=" + id,
                    dataType: "text",
                    method: "post",
                    success: function (result) {
                        if (result === "true") {
                            window.location.href = "${pageContext.request.contextPath}/back/showProductManager"
                        }
                    }
                })
            }
        }


        function updateProInfo(id) {
            //获取servlet传过来的值
            $.ajax({
                type: 'post',
                //async : 'false', //async，true是异步传输，false指同步传输
                dataType: 'json', //dataType是数据类型，json: 返回 JSON 数据 。
                // cache: 'false', //cache属性是flase时：每次读取的是最新的数据。
                url: "${pageContext.request.contextPath}/back/beforeUpdateProInfo",
                data: "id="+id,
                success: function (data) {
                    console.log(data);
                    //将数据回显到弹窗
                    $("#proName").val(data.pname);
                    $("#proPrice").val(data.pprice);
                    $("#productTypeId").val(data.ptypeId);
                    $("#proNo").val(data.pno);
                    $("#myModal").modal("show");
                }
            });
        }
    </script>
</head>

<body>
<div class="panel panel-default" id="userPic">
    <div class="panel-heading">
        <h3 class="panel-title">商品管理</h3>
    </div>
    <div class="panel-body">
        <input type="button" value="添加商品" class="btn btn-primary" id="doAddPro">
        <div class="modal fade" tabindex="-1" id="Product">
            <!-- 窗口声明 -->
            <div class="modal-dialog modal-lg">
                <!-- 内容声明 -->
                <div class="modal-content">
                    <!-- 头部、主体、脚注 -->
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">添加商品</h4>
                    </div>
                    <form
                            action="${pageContext.request.contextPath}/back/addProduct"
                            method="post"
                            enctype="multipart/form-data">
                        <div class="modal-body text-center">
                            <div class="row text-right">
                                <label for="productName" class="col-sm-4 control-label">商品名称：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="productName" id="productName">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="productDes" class="col-sm-4 control-label">商品描述：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="productDes" id="productDes">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="productPrice" class="col-sm-4 control-label">商品价格：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="productPrice" id="productPrice">
                                </div>
                            </div>
                            <br>
                            <%--                        for="product-image"   --%>
                            <div class="row text-right">
                                <label class="col-sm-4 control-label">商品图片：</label>
                                <div class="col-sm-4">
                                    <%--   href="javascript:;" --%>
                                    <a class="file">选择文件
                                        <input type="file" name="pImg" id="pImg">
                                    </a>
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <%-- for="product-type" --%>
                                <label class="col-sm-4 control-label">商品类型：</label>

                                <div class="col-sm-4">
                                    <select class="form-control input-sm" id="proTypeId" name="productTypeId">
                                        <option value="-1" selected="selected">请选择</option>
                                        <%-- 循环遍历typeList--%>

                                        <%-- 循环遍历typeList--%>
                                        <c:forEach items="${typeList}" var="type">
                                            <%--  当前遍历到的类型id和带回的参数相等，那么就加上默认选中--%>
                                            <option value="${type.id}">${type.typeName}</option>
                                        </c:forEach>

                                    </select>
                                </div>
                            </div>
                            <br>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary addProduct">添加</button>
                            <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <br>
        <br>
        <div class="show-list">
            <table class="table table-bordered table-hover" style='text-align: center;'>
                <thead>
                <tr class="text-danger">
                    <th class="text-center">编号</th>
                    <th class="text-center">商品</th>
                    <th class="text-center">价格</th>
                    <th class="text-center">产品类型</th>
                    <%--                    <th class="text-center">状态</th>--%>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody id="tb">

                <c:forEach items="${productList}" var="pro" varStatus="s">
                    <tr>
                        <td>${s.count}</td>
                        <td>${pro.PName}</td>
                        <td>${pro.PPrice}</td>
                        <td>${pro.productType.typeName}</td>
                            <%--                    <td>${pro.}</td>--%>
                        <td class="text-center">
                            <button id="updateProId" class="btn btn-warning btn-sm doProModify" type="button"
                                    onclick="updateProInfo(${pro.id})">
                                修改
                            </button>
                            <button class="btn btn-danger btn-sm doProDisable" type="button" onclick="ban(${pro.id})">
                                禁用
                            </button>
                                <%--                            <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>--%>
                                <%--                            <input type="button" class="btn btn-danger btn-sm doProDisable" onclick="ban(this)" value="禁用">--%>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>


        <div class="modal fade" tabindex="-1" id="myProduct">
            <!-- 窗口声明 -->
            <div class="modal-dialog modal-lg">
                <form id="modifyPasswordForm" action="${pageContext.request.contextPath}/back/updateInfo"
                      class="form-horizontal" method="post">
                    <!-- 内容声明 -->
                    <div class="modal-content">

                        <!-- 头部、主体、脚注 -->
                        <div class="modal-header">
                            <button class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">商品修改</h4>
                        </div>
                        <div class="modal-body text-center">
                            <%--                        <div class="row text-right">--%>
                            <%--                            <label for="pro-num" class="col-sm-4 control-label">序号：</label>--%>
                            <%--                            <div class="col-sm-4">--%>
                            <%--                                <input type="text" class="form-control" id="pro-num">--%>
                            <%--                            </div>--%>
                            <%--                        </div>--%>
                            <%--                        <br>--%>
                            <div class="row text-right">
                                <label for="proName" class="col-sm-4 control-label">商品名称</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="proName" name="proName">
                                </div>
                            </div>
                            <br>

                                    <input type="hidden" class="form-control" id="proNo" name="proNo">

                                <div class="row text-right">
                                <label for="proPrice" class="col-sm-4 control-label">商品价格：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="proPrice" name="proPrice">
                                </div>
                            </div>
                            <br>
                            <div class="row text-right">
                                <label for="productTypeId" class="col-sm-4 control-label">产品类型：</label>
                                <div class="col-sm-4">
                                    <select class="form-control input-sm"  id="productTypeId" name="productTypeId">
                                        <option value="-1" >查询全部</option>
                                        <%-- 循环遍历typeList--%>
                                        <c:forEach items="${typeList}"  var="type">
                                            <%--  当前遍历到的类型id和带回的参数相等，那么就加上默认选中--%>
                                            <option value="${type.id}"  <c:if test="${productTypeId  == type.id}"> selected="selected" </c:if> >${type.typeName}</option>
                                        </c:forEach>
                                    </select>
                                    <%--                                    <input type="email" class="form-control" id="pro-state" name="proType">--%>
                                </div>
                            </div>
                            <br>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary updatePro" type="submit">修改</button>
                            <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>


    </div>
</div>
</body>

</html>
