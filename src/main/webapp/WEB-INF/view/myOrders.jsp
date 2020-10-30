<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>确认订单</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css" />
    <script>


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

        $(function () {
            $("#close").click(function () {
                window.location.href = "${pageContext.request.contextPath}/order/showOrder";
            });
        });


        /**
         * 生成订单
         */
        function  creatOrder() {
            $.ajax({
                url:"${pageContext.request.contextPath}/order/create",
                data:{},
                dataType:"text",
                method:"post",
                success:function (result) {
                    $("#order_no").text(result);
                    $("#buildOrder").modal("show");// show模态框
                }
            });
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
            <th>序号</th>
            <th>商品名称</th>
            <th>商品图片</th>
            <th>商品数量</th>
            <th>商品总价</th>
        </tr>
        <c:forEach items="${carList}" var="car" varStatus="s">
            <tr class="tr">
                <td>${s.count}</td>
                <td>${car.product.pName}</td>
                <td><img src="${pageContext.request.contextPath}/downloadImg?imgUrl=${car.product.pImg}" alt="" width="60" height="60"></td>
                <td>${car.num}</td>
                <td>${car.product.pPrice * car.num}</td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="5" class="foot-msg">
                总计：<b> <span id="totalPrice"></span></b>元
                <a href="${pageContext.request.contextPath}/cart/showCart"><button class="btn btn-warning pull-right ">返回</button></a>

                <button class="btn btn-warning pull-right margin-right-15" data-toggle="modal" data-target="#buildOrder"  onclick="creatOrder()">生成订单</button>

            </td>
        </tr>
    </table>

</div>
<!-- content end-->

<%-- 订单生成的模态框 --%>
<div class="modal fade" id="buildOrder" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"  id="close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">提示消息</h4>
            </div>
            <div class="orderMsg">
                <p>
                    订单生成成功！！

                </p>
                <p>
                    订单号：<span id="order_no">${carList.no}</span>

                </p>
            </div>

        </div>
    </div>
</div>


</body>

</html>
