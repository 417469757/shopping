<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>个人中心</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrapValidator.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrapValidator.min.css" />
<body>
<%-- 头部共通 start--%>
<jsp:include page="top.jsp"/>
<%-- 头部共通 end--%>
<!-- content start -->
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="page-header" style="margin-bottom: 0px;">
                <h3>基本资料</h3>
            </div>
        </div>
    </div>
</div>
<%--修改基本信息--%>
<div class="container">
    <form class="form-horizontal" action="${pageContext.request.contextPath}/user/modifyUserInfo" method="post">
        <input type="hidden" name="id" value="${user.id}">  <%--隐藏域存放id--%>
        <div class="form-group">
            <label for="name" class="col-md-2  col-sm-2 control-label">用户姓名:</label>
            <div class="col-md-8 col-sm-10">
                <input type="text" class="form-control" id="name" name="username" placeholder="用户姓名" readonly="readonly" value="${user.username}">
            </div>
        </div>
        <div class="form-group">
            <label for="loginName" class="col-md-2 col-sm-2 control-label">登陆账号:</label>
            <div class="col-md-8  col-sm-10">
                <input type="text" class="form-control" id="loginName" name="loginName" placeholder="登陆账号" readonly="readonly" value="${user.loginName}">
            </div>
        </div>

        <div class="form-group">
            <label for="phone" class="col-md-2  col-sm-2 control-label">联系电话:</label>
            <div class="col-md-8 col-sm-10">
                <input type="text" class="form-control" id="phone"  name="phone" placeholder="联系电话" value="${user.phone}">
            </div>
        </div>
        <div class="form-group">
            <label for="address" class="col-md-2   col-sm-2  control-label">联系地址:</label>
            <div class="col-md-8 col-sm-10">
                <input type="text" class="form-control" id="address" name="address" placeholder="联系电话" value="${user.address}">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-warning">确认修改</button>
            </div>
        </div>
    </form>
</div>
<%--修改头像等信息--%>
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="page-header" style="margin-bottom: 0px;">
                <h3>修改头像</h3>
            </div>
        </div>
    </div>
    <form action="${pageContext.request.contextPath}/user/modifyHeadImg" class="form-horizontal"   method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="address" class="col-md-2   col-sm-2  control-label">选择头像:</label>
            <div class="col-md-10 col-sm-10">
                <c:choose>
                    <c:when test="${empty user.head}">
                        <img src="${pageContext.request.contextPath}/images/user.jpeg" id="showImg" class="togeImg" onclick="openFile()" alt="" width="100" height="100">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/downloadImg?imgUrl=${user.head}" id="showImg" class="togeImg" onclick="openFile()" alt="" width="100" height="100">
                    </c:otherwise>
                </c:choose>

                <input id="file" name="file" type="file" style="display: none;"/>

                <script>

                    function openFile() {
                        $("#file").click();  //  手动触发 type="file" 的input框的的点击事件
                    }
                    $('#file').change(function() {  // 改变事件，一旦选了其它图片，图片显示在img元素里面
                        $("#showImg").attr("src", window.URL.createObjectURL(this.files[0]));
                        console.log($('#file').val());
                    });
                </script>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-warning">确认修改</button>
            </div>
        </div>
    </form>

    <div class="row">
        <div class="col-xs-12">
            <div class="page-header" style="margin-bottom: 0px;">
                <h3>上传生活照</h3>
            </div>
        </div>
    </div>
    <form action="${pageContext.request.contextPath}/user/modifyImages" class="form-horizontal">
        <div class="form-group">
            <label for="address" class="col-md-2   col-sm-2  control-label">选择生活照:</label>
            <div class="col-md-10 col-sm-10">
                <img src="${pageContext.request.contextPath}/images/add.png" id="showImg0" class="togeImg" onclick="openFile0()" alt="" width="100" height="100">
                <input id="file0" type="file" style="display: none;" name="imgName" />
<%--                <button type="button" class="btn btn-warning margin-right-15">删除</button>--%>
                <script>
                    function openFile0() {
                        $("#file0").click();
                    }
                    $('#file0').change(function() {
                        $("#showImg0").attr("src", window.URL.createObjectURL(this.files[0]));
                    });
                </script>
            </div>
        </div>
        <input id="fileImages" name="fileImages" type="file" style="display: none;"/>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
<%--                <button type="buttonbutton" class="btn btn-warning margin-right-15" id="more">更多</button>--%>
                <button type="button" class="btn btn-warning margin-right-15">上传</button>
            </div>
        </div>
    </form>
</div>
<!-- content end-->
</body>

</html>
