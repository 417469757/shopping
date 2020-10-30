<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>我的订单</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css"/>
<body>
<%-- 头部共通 start--%>
<jsp:include page="top.jsp"/>
<%-- 头部共通 end--%>
<!-- content start -->
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="page-header" style="margin-bottom: 0px;">
                <h3>我的订单</h3>
            </div>
        </div>
    </div>
    <table class="table table-hover table-striped table-bordered ">
        <tr>
            <th>序号</th>
            <th>订单号</th>
            <th>订单详情</th>
        </tr>
        <c:forEach items="${orderList}" var="order" varStatus="s">
            <tr>
                <td>${s.count}</td>
                <td class="clear-color">
                    <a href="${pageContext.request.contextPath}/order/showOrder">${order.no}</a>
                </td>
                <td class="clear-color">
                    <a href="${pageContext.request.contextPath}/item/showItemDetails?orderNo=${order.no}">查看</a>
                </td>
            </tr>
        </c:forEach>

    </table>
</div>
<!-- content end-->
</body>

</html>
