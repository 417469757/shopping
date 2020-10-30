<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- jstl 表达式 需要加入taglib指令--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>在线购物商城</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrapValidator.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/iconfont/iconfont.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/verify.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/verify.js" type="text/javascript"></script>
<body>
<%-- 头部共通 start--%>
<jsp:include page="top.jsp"/>
<%-- 头部共通 end--%>
<script>


    /* 页面加载完就执行初始化*/
    $(function () {
        /*  分页插件代码--------------------------------  */
        /* 当前第几页*/
        var pageCurrent = "${productPageInfo.pageNum}" =="" ?1:"${productPageInfo.pageNum}";
        var totalPages = "${productPageInfo.pages}"=="" ?1:"${productPageInfo.pages}";
        $(".pagination").bootstrapPaginator({
            //设置版本号
            bootstrapMajorVersion: 3,
            // 显示第几页
            currentPage: pageCurrent,
            // 总页数
            totalPages: totalPages,
            //当单击操作按钮的时候, 执行该函数, 调用ajax渲染页面
            onPageClicked: function (event,originalEvent,type,page) {
                // 把当前点击的页码赋值给currentPage, 调用ajax,渲染页面
                pageCurrent = page;
                $("#pageNo").val(pageCurrent); // 为id=pageNo 元素设置value值
                $("#searchForm").submit(); // 手动触发表单请求
            }
        });
    });

        /*  分页插件代码--------------------------------  */

        /**
     * 处理加入购物车
     * @param productId
     */
    function addCart(productId, userId) {
        if (${user==null}) {        // 先判断用户是否已登录
            $('#addCart').tooltip({
                'placement': 'top',
                'title': '请先登录',
                'trigger': 'manual'
            }).tooltip("show");
        } else {
            $.ajax({
                url: "${pageContext.request.contextPath}/cart/addCart",
                data: 'productId=' + productId + '&userId=' + userId,
                type: "post",
                dataType: "text",
                success: function (result) {
                    if (result === "false") {
                        $('#addCar').tooltip({
                            'placement': 'top',
                            'title': '加入失败',
                            'trigger': 'manual'
                        }).tooltip("show");
                    } else {
                        $('#addCar').tooltip({
                            'placement': 'top',
                            'title': '加入成功',
                            'trigger': 'manual'
                        }).tooltip("show");
                    }
                }
            });
        }
    }
</script>
<!-- content start -->
<div class="container" id="a">
    <div class="row">
        <div class="col-xs-12">
            <div class="page-header" style="margin-bottom: 0px;">
                <h3>商品列表</h3>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <%--  表单提交--%>
            <form class="form-inline hot-search"  id="searchForm" action="${pageContext.request.contextPath}/findProductByParam"
                  method="post">
                <div class="form-group">
                    <label class="control-label">价格：</label>
                    <input type="text" class="form-control" placeholder="最低价格" name="minPrice">--
                    <input type="text" class="form-control" placeholder="最高价格" name="maxPrice">
                </div>
                <%--  隐藏域 放页数--%>
                <input type="hidden" name="pageNo" id="pageNo" />
                &nbsp;
                &nbsp;

                <div class="form-group">
                    <!-- <input type="text" id="datepicker" class="form-control" placeholder="出发时间"> -->
                    <label class="control-label">分类：</label>
                    <select class="form-control input-sm" name="productTypeId">
                        <option value="-1" >查询全部</option>
                        <%-- 循环遍历typeList--%>
                        <c:forEach items="${typeList}"  var="type">
                            <%--  当前遍历到的类型id和带回的参数相等，那么就加上默认选中--%>
                            <option value="${type.id}"  <c:if test="${productTypeId  == type.id}"> selected="selected" </c:if> >${type.typeName}</option>
                        </c:forEach>

                    </select>
                </div>
                <button type="submit" class="btn btn-warning pull-right">
                    <i class="glyphicon glyphicon-search"></i>&nbsp;查询
                </button>
            </form>
        </div>
    </div>
</div>
<div class="content-back">
    <div class="container" id="a">
        <div class="row">
            <c:forEach items="${productPageInfo.list}" var="product">
                <div class="col-xs-3  hot-item">
                    <div class="panel clear-panel">
                        <div class="panel-body">
                            <div class="art-back clear-back">
                                <div class="add-padding-bottom">
                                    <img src="${pageContext.request.contextPath}/downloadImg?imgUrl=${product.pImg}"
                                         class="shopImg">
                                </div>
                                <h4>${product.pName}</h4>
                                <div class="user clearfix pull-right">
                                        ${product.pPrice}
                                </div>
                                <div class="desc">${product.pDescription}</div>
                                <div class="attention pull-right" id="addCart"
                                     onclick="addCart(${product.id},${user.id})">
                                    加入购物车 <i class="icon iconfont icon-gouwuche"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <%--  分页插件   --%>
        <ul id="pagination" class="pagination" style="float: right;margin-right: 50px"></ul>
    </div>
</div>
<!-- content end-->
</body>

</html>
