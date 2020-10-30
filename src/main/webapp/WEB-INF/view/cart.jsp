<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--  jstl 表达式 需要加入taglib指令  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>我的购物车</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script>

        /* 页面加载完就执行的函数 （都是做初始化操作）*/
        /*计算总价格*/
        $(function () {
            /* ----------------計算总价格------------------------start*/
            var totalPrice = 0;
            $("tr.tr").each(function (i) {
                var price = parseFloat($(this).find("td:eq(5)").text()); // 取到每个商品总价
                totalPrice = totalPrice + price;   //  所有加起来的总价
            });
            $("#totalPrice").text(totalPrice);   // 赋值

            /* ----------------計算总价格------------------------end*/

        });


        /*  结算 */
        function account() {
            var carIds = "";
            $(".checkbox").each(function () {  // 循环遍历所有class=checkbox的多选框
                if($(this).prop("checked")){  // 如果是被选中的
                    carIds = carIds +  $(this).val() + ","; // 将value拼接到字符串后面   1,2,3,
                }
            });

            if(carIds === ""){
                alert("请选择购买的商品");
            }else{
                // 发送get请求
                window.location.href = "${pageContext.request.contextPath}/order/showAccount?carIds="+carIds;
            }
        }

        /*删除某个商品*/
        function deleteCartById(carId) {
            if (confirm("确认删除？")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/cart/deleteById",
                    data: "carId=" + carId,
                    dataType: "text",
                    method: "post",
                    success: function (result) {
                        if (result === "true") {
                            window.location.href = "${pageContext.request.contextPath}/cart/showCart"
                        }
                    }
                })
            }
        }

        /*更新商品数量*/
        function updateNumById(carId, obj) {
            var $this = $(obj)
            var num = $this.parent().parent().find("td:eq(4) input").val();
            $.ajax({
                url: "${pageContext.request.contextPath}/cart/updateNumById",
                data: {"num": num, "carId": carId},
                dataType: "text",
                method: "post",
                success: function (result) {
                    if (result === "true") {
                        window.location.href = "${pageContext.request.contextPath}/cart/showCart"
                    }
                }
            })
        }

        /**
         * 删除选中项
         */
        function deleteAll() {
            var carIds = "";
            $(".checkbox").each(function () {  // 循环遍历所有class=checkbox的多选框
                if ($(this).prop("checked")) {  // 如果是被选中的
                    carIds = carIds + $(this).val() + ","; // 将value拼接到字符串后面
                }
            });

            if (carIds === "") {
                alert("请选择要删除的记录");
            } else if (confirm("确认要删除?")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/cart/deleteAll",
                    data: "carIds=" + carIds,
                    dataType: "text",
                    method: "post",
                    success: function (result) {
                        if (result === "true") {
                            window.location.href = "${pageContext.request.contextPath}/cart/showCart";
                        }
                    }
                });
            }
        }

        /*删除所有商品*/
        function deleteAllPro() {
            var carIds = "";
            $(".checkbox").each(function () {  // 循环遍历所有class=checkbox的多选框
                carIds = carIds + $(this).val() + ","; // 将value拼接到字符串后面
            });
            if (confirm("确认要删除所有?")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/cart/deleteAll",
                    data: "carIds=" + carIds,
                    dataType: "text",
                    method: "post",
                    success: function (result) {
                        if (result === "true") {
                            window.location.href = "${pageContext.request.contextPath}/cart/showCart";
                        }
                    }
                });
            }
        }

        /**
         * 全选全不选
         */
        function checkAll(obj) {
            var $this = $(obj);
            console.log("----------" + $this.prop("checked")); // 获得选中或不选中的值

            $("input[type='checkbox']").prop("checked", $this.prop("checked"));// 赋值给下面的input
        }
    </script>
<body>
<%-- 头部共通 start--%>
<jsp:include page="top.jsp"/>
<%-- 头部共通 end--%>
<!-- content start -->
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="page-header" style="margin-bottom: 0px;">
                <h3>我的购物车</h3>
            </div>
        </div>
    </div>
    <table class="table table-hover table-striped table-bordered">
        <tr>
            <th>
                <input type="checkbox" id="all" onclick="checkAll(this)">全选
            </th>
            <th>序号</th>
            <th>商品名称</th>
            <th>商品图片</th>
            <th>商品数量</th>
            <th>商品总价</th>
            <th>操作</th>
        </tr>
        <%-- 有多少条记录，就有多少条tr --%>
        <c:forEach items="${cartList}" var="car" varStatus="s">
            <tr class="tr">
                <td >
                    <input class="checkbox" type="checkbox" value="${car.id}">
                </td>
                <td>${s.count}</td>
                <td>${car.product.pName}</td>

                    <%-- TODO--%>
                <td><img src="${pageContext.request.contextPath}/downloadImg?imgUrl=${car.product.pImg}"
                         alt="${car.product.pName}" width="60" height="60"></td>
                <td>
                    <input type="text" value="${car.num}" size="5">
                </td>
                <td>${car.num*car.product.pPrice}</td>
                <td>
                    <button class="btn btn-success" type="button" onclick="updateNumById(${car.id},this)">
                        <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>修改
                    </button>
                    <button class="btn btn-danger" type="button" onclick="deleteCartById(${car.id})">
                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                    </button>
                </td>
            </tr>
        </c:forEach>
            <tr>
                <td colspan="7" align="right">
                    <button class="btn btn-warning margin-right-15" type="button" onclick="deleteAll()"> 删除选中项</button>
                    <button class="btn btn-warning  margin-right-15" type="button" onclick="deleteAllPro()">删除所有
                    </button>
                    <button class="btn btn-warning margin-right-15" type="button"
                            onclick='window.location.href="${pageContext.request.contextPath}/showMain"'> 继续购物
                    </button>
                    <a href="#" onclick="account()">
                        <button class="btn btn-warning " type="button"> 结算</button>
                    </a>

                </td>

            </tr>
            <tr>
                <td colspan="7" align="right" class="foot-msg">
                    总计： <b><span id="totalPrice"></span> </b>元
                </td>
            </tr>
    </table>
</div>
<!-- content end-->
</body>

</html>
