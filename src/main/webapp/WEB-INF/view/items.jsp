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
            var price = parseFloat($(this).find("td:eq(4)").text()); // 取到每个商品总价
            totalPrice = totalPrice + price;   //  所有加起来的总价
        });
        $("#totalPrice").text(totalPrice);   // 赋值

        /* ----------------計算总价格------------------------end*/

    });
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
                <h3>订单详情</h3>
            </div>
        </div>
    </div>
    <table class="table table-hover table-striped table-bordered">
        <tr>
            <th>序号</th>
            <th>商品图片</th>
            <th>商品名称</th>
            <th>商品数量</th>
            <th>商品总价</th>
        </tr>
        <%-- 有多少条记录，就有多少条tr --%>
        <c:forEach items="${items}" var="item" varStatus="s">
            <tr class="tr">
                <td>${s.count}</td>
                <td><img src="${pageContext.request.contextPath}/downloadImg?imgUrl=${item.product.pImg}"
                         alt="${item.product.pName}" width="60" height="60"></td>
                <td>${item.product.pName}</td>
                <td>${item.num}</td>
                <td>${item.num*item.product.pPrice}</td>
            </tr>
        </c:forEach>
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
