<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    /*高亮部分*/
    $(function () {
        var navIndex = "${navIndex}"; // 当前导航索引
        $("ul.nav li").each(function (i) { // 遍历到第几个元素
            console.log("i-----------:" + i);
            if (i == navIndex) {  // 当你设置的索引和遍历到的索引一致时
                $(this).addClass("active");// 添加calss属性值为active
            }
        })
    });
</script>

<script type="text/javascript">
    /* 页面加载完就执行初始化*/
    $(function () {
            /*  分页插件代码--------------------------------  */
            /* 当前第几页*/
            var pageCurrent = "${productPageInfo.pageNum}" == "" ? 1 : "${productPageInfo.pageNum}";
            var totalPages = "${productPageInfo.pages}" == "" ? 1 : "${productPageInfo.pages}";
            /*.pagination  来在页面上显示分页*/
            $(".pagination").bootstrapPaginator({
                //设置版本号
                bootstrapMajorVersion: 3,
                // 显示第几页
                currentPage: pageCurrent,
                // 总页数
                totalPages: totalPages,
                //当单击操作按钮的时候, 执行该函数, 调用ajax渲染页面
                onPageClicked: function (event, originalEvent, type, page) {
                    // 把当前点击的页码赋值给currentPage, 调用ajax,渲染页面
                    pageCurrent = page;
                    $("#pageNo").val(pageCurrent); // 为id=pageNo 元素设置value值
                    $("#searchForm").submit(); // 手动触发表单请求
                }
            });
            /*  分页插件代码--------------------------------  */


            /*登录校验----------------------start*/

            // $('[data-toggle="tooltip"]').each(function () {
            //     var _this = this;
            //     $(this).on('shown.bs.tooltip', function () {
            //         // 过3秒隐藏提示工具
            //         // 定时器
            //         setTimeout(function () {
            //             $(_this).tooltip("hide");
            //         }, 3000);
            //
            //     })
            // });

            $('#loginForm').bootstrapValidator({
                message: 'This value is not valid',        //验证错误时的信息
                feedbackIcons: {        //验证时显示的图标
                    valid: 'glyphicon glyphicon-ok',      //正确图标
                    invalid: 'glyphicon glyphicon-remove',        //错误图标
                    validating: 'glyphicon glyphicon-refresh'        //正在更新图标
                },
                fields: {       //要验证哪些字段
                    login_name: {
                        message: '用户名无效',       //验证错误时的信息，当然这里是可以使用中文的
                        validators: {
                            notEmpty: {       //非空判断
                                message: '用户名不能为空'        //验证错误时的信息，
                            },
                            stringLength: {        //长度判断
                                min: 6,      //不得小于
                                max: 30,       //不得超过
                                message: '用户名长度控制在6到30'         //验证错误时的信息，
                            },
                            regexp: {          //正则表达式判断
                                regexp: /^[a-zA-Z0-9_]+$/,           //表达式内容
                                message: '用户名只能包含字母、数字、和下划线'           //验证错误时的信息，
                            },
                            <%--remote: {--%>
                            <%--    message: '用户名已经存在',--%>
                            <%--    url: '${pageContext.request.contextPath}/user/checkNewUser',      //Action的地址--%>
                            <%--    data: {                 //传参数--%>
                            <%--        login_name: function () {--%>
                            <%--            return $("#login_name").val()--%>
                            <%--        },    //username参数名，如果想传入特定控件的值一定加入function,这样才能把值传入--%>
                            <%--    },--%>
                            <%--    // delay: 2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）--%>
                            <%--    type: 'POST'//请求方式--%>
                            <%--}--%>
                        }
                    },
                    login_pass: {
                        validators: {
                            notEmpty: {
                                message: '密码不能为空'
                            }
                        },
                        <%--remote: {--%>
                        <%--    message: '用户名已经存在',--%>
                        <%--    url: '${pageContext.request.contextPath}/user/checkNewUserAndPass',      //Action的地址--%>
                        <%--    data: {                 //传参数--%>
                        <%--        login_name: function () {--%>
                        <%--            return $("#login_name").val()--%>
                        <%--        },--%>
                        <%--        login_pass: function () {--%>
                        <%--            return $("#login_pass").val()--%>
                        <%--        }    //username参数名，如果想传入特定控件的值一定加入function,这样才能把值传入--%>
                        <%--    },--%>
                        <%--    // delay: 2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）--%>
                        <%--    type: 'POST'//请求方式--%>
                        <%--}--%>

                    },
                }
            })


            <%--$("#code").on("blur", function () {--%>
            <%--    var code = $("#code").val();// 输入的密码--%>
            <%--    if (code.trim() == '') {--%>
            <%--        // code--%>
            <%--        $('#code').tooltip({--%>
            <%--            'placement': 'top',--%>
            <%--            'title': '请输入验证码',--%>
            <%--            'trigger': 'manual'--%>
            <%--        }).tooltip("show");--%>
            <%--    } else {--%>
            <%--        // 发送ajax校验验证码是否输入正确--%>
            <%--        $.ajax({--%>
            <%--            url: "${pageContext.request.contextPath}/code/checkCode",--%>
            <%--            data: "code=" + code,--%>
            <%--            type: "post",--%>
            <%--            dataType: "text",--%>
            <%--            success: function (result) {--%>
            <%--                if (result == "false") {--%>
            <%--                    $('#code').tooltip({--%>
            <%--                        'placement': 'top',--%>
            <%--                        'title': '请输入正确的验证码',--%>
            <%--                        'trigger': 'manual'--%>
            <%--                    }).tooltip("show");--%>
            <%--                }--%>
            <%--            }--%>

            <%--        })--%>
            <%--    }--%>
            <%--});--%>

            <%--          验证码校验          start--%>
            $('#mpanel').slideVerify({
                type: 2,   //类型
                vOffset: 5,  //误差量，根据需求自行调整
                vSpace: 5, //间隔
                imgName: ['1.jpg', '2.jpg'],
                imgSize: {
                    width: '250px',
                    height: '100px',
                },
                blockSize: {
                    width: '40px',
                    height: '40px',
                },
                barSize: {
                    width: '250px',
                    height: '20px',
                },
                ready: function () {
                },
                success: function () {
                    // 1秒后关闭模态框
                    setTimeout(function () {
                        // 关闭模态框
                        $("#loginModal").modal("show");
                    }, 1000)
                },
                error: function () {
                    alert('验证失败！');
                }
            });
            <%--          验证码校验          end--%>


        },
        /*登录校验----------------------end*/


        /*注册校验------------------------start*/
        $(document).ready(function () {
            $('#registerForm').bootstrapValidator({
                message: 'This value is not valid',        //验证错误时的信息
                feedbackIcons: {        //验证时显示的图标
                    valid: 'glyphicon glyphicon-ok',      //正确图标
                    invalid: 'glyphicon glyphicon-remove',        //错误图标
                    validating: 'glyphicon glyphicon-refresh'        //正在更新图标
                },
                fields: {       //要验证哪些字段
                    username: {        //与表单里input的name属性对应
                        message: '用户名无效',       //验证错误时的信息，当然这里是可以使用中文的
                        validators: {
                            notEmpty: {       //非空判断
                                message: '用户名不能为空'        //验证错误时的信息，
                            },
                            stringLength: {
                                //长度判断
                                max: 6,
                                message: '用户名最长为6'         //验证错误时的信息，
                            },
                            regexp: {          //正则表达式判断
                                regexp: /^[a-zA-Z0-9_]+$/,           //表达式内容
                                message: '用户名只能包含字母、数字、和下划线'           //验证错误时的信息，
                            }
                        }
                    },
                    registryName: {
                        message: '用户名无效',       //验证错误时的信息，当然这里是可以使用中文的
                        validators: {
                            notEmpty: {       //非空判断
                                message: '用户名不能为空'        //验证错误时的信息，
                            },
                            stringLength: {        //长度判断
                                min: 6,      //不得小于
                                max: 30,       //不得超过
                                message: '用户名长度控制在6到30'         //验证错误时的信息，
                            },
                            regexp: {          //正则表达式判断
                                regexp: /^[a-zA-Z0-9_]+$/,           //表达式内容
                                message: '用户名只能包含字母、数字、和下划线'           //验证错误时的信息，
                            },
                            <%--remote: {--%>
                            <%--    message: '用户名已经存在',--%>
                            <%--    url: '${pageContext.request.contextPath}/user/checkNewUser',      //Action的地址--%>
                            <%--    data: {                 //传参数--%>
                            <%--        registryName: function () {--%>
                            <%--            return $("#registryName").val()--%>
                            <%--        },    //username参数名，如果想传入特定控件的值一定加入function,这样才能把值传入--%>
                            <%--    },--%>
                            <%--    // delay: 2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）--%>
                            <%--    type: 'POST'//请求方式--%>
                            <%--}--%>
                        }
                    },
                    login_pass: {
                        validators: {
                            notEmpty: {
                                message: '密码不能为空'
                            }
                        }

                    },
                    phone: {
                        validators: {
                            notEmpty: {       //非空判断
                                message: '电话号码不能为空'        //验证错误时的信息，
                            },
                            stringLength: {        //长度判断
                                min: 11,      //不得小于
                                max: 11,       //不得超过
                                message: '电话号码有11位'         //验证错误时的信息，
                            }
                        }
                    },
                    address: {
                        validators: {
                            notEmpty: {       //非空判断
                                message: '住址不能为空'        //验证错误时的信息，
                            }
                        }

                    }
                }
            });

            /*   注册校验----------------------end */


            /*   修改密码校验校验----------------start*/
            $('#modifyPasswordForm').bootstrapValidator({
                message: 'This value is not valid',        //验证错误时的信息
                feedbackIcons: {        //验证时显示的图标
                    valid: 'glyphicon glyphicon-ok',      //正确图标
                    invalid: 'glyphicon glyphicon-remove',        //错误图标
                    validating: 'glyphicon glyphicon-refresh'        //正在更新图标
                },
                fields: {       //要验证哪些字段
                    oldPass: {
                        validators: {
                            notEmpty: {
                                message: 'The password is required and can\'t be empty'
                            }
                        }
                    },
                    newPass: {
                        validators: {
                            notEmpty: {
                                message: 'The password is required and can\'t be empty'
                            },
                            identical: {
                                field: 'newPass2',
                                message: 'The password and its confirm are not the same'
                            }
                        }
                    },
                    newPass2: {
                        validators: {
                            notEmpty: {
                                message: 'The password is required and can\'t be empty'
                            },
                            identical: {
                                field: 'newPass',
                                message: 'The password and its confirm are not the same'
                            }
                        },
                        <%--remote: {--%>
                        <%--    message: '用户原密码不ok',--%>
                        <%--    url: '${pageContext.request.contextPath}/user/updatePass',      //Action的地址--%>
                        <%--    data: {                 //传参数--%>
                        <%--        oldPass: function () {--%>
                        <%--            return $("#oldPass").val()--%>
                        <%--        },--%>
                        <%--        newPass: function () {--%>
                        <%--            return $("#newPass").val()--%>
                        <%--        }    //username参数名，如果想传入特定控件的值一定加入function,这样才能把值传入--%>
                        <%--    },--%>
                        <%--    // delay: 2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）--%>
                        <%--    type: 'POST'//请求方式--%>
                        <%--}--%>

                    }
                }
            })
            /*   修改密码校验校验----------------end*/
        }),
    );

    /*进入其他页面之前先登录*/
    function  checkLogin() {
        if(${user == null}){  // 用户未登录
            $("#loginModal").modal("show");
            return false;
        }
        return true;
    }

</script>

<script>
<%--    /* 处理修改密码 */--%>
<%--function updatePass() {--%>
<%--    $.ajax({--%>
<%--        url:"${pageContext.request.contextPath}/user/updatePass",--%>
<%--        data:{"newPass":$("#newPass").val(),"oldPass":$("#oldPass").val()},--%>
<%--        type:"post",--%>
<%--        dataType:"text",--%>
<%--        success:function (result) {--%>
<%--            if(result=="true"){--%>
<%--                $('#oldPass').tooltip({--%>
<%--                    'placement':'top',--%>
<%--                    'title':'修改密码成功',--%>
<%--                    'trigger':'manual'--%>
<%--                }).tooltip("show");--%>

<%--                // 1秒后关闭模态框--%>
<%--                setTimeout(function () {--%>
<%--                    // 关闭模态框--%>
<%--                    $("#modifyPasswordModal").modal("hide");--%>
<%--                },500)--%>
<%--            }else{--%>
<%--                $('#oldPass').tooltip({--%>
<%--                    'placement':'top',--%>
<%--                    'title':result,--%>
<%--                    'trigger':'manual'--%>
<%--                }).tooltip("show");--%>
<%--            }--%>
<%--        }--%>

<%--    });--%>
<%--}--%>
</script>

<%--横幅条--%>
<div class="navbar navbar-default clear-bottom">
    <div class="container">
        <!-- logo start -->
        <div class="navbar-header">
            <a class="navbar-brand logo-style" href="${pageContext.request.contextPath}/showMain">
                <img class="brand-img" src="${pageContext.request.contextPath}/images/com-logo1.jpg" alt="logo" height="70">
            </a>
        </div>
        <!-- logo end -->
        <!-- navbar start -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li>
                    <a href="${pageContext.request.contextPath}/showMain">商城主页</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/order/showOrder" onclick="return checkLogin()">我的订单</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/cart/showCart" onclick="return checkLogin()">购物车</a>
                </li>
                <li class="dropdown">
                    <a href="${pageContext.request.contextPath}/center/showCenter" onclick="return checkLogin()">会员中心</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="${pageContext.request.contextPath}/back/showLogin">管理员入口</a>
                </li>
                <li>
                    <%--  未登录时显示登录按钮   --%>
                    <c:if test="${user==null}">
                        <a href="#" data-toggle="modal" data-target="#loginModal">登陆</a>
                    </c:if>
                </li>
                <li>
                    <a href="#" data-toggle="modal" data-target="#registModal">注册</a>
                </li>
                <li class="userName">
                    <c:if test="${user!=null}"> 您好：${user.username}</c:if>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle user-active" data-toggle="dropdown" role="button">
                        <c:choose>
                            <c:when test="${empty user}">
                                <img class="img-circle" src="${pageContext.request.contextPath}/images/user.jpeg" height="30" />
                            </c:when>
                            <c:otherwise>
                                <img class="img-circle" src="${pageContext.request.contextPath}/downloadImg?imgUrl=${user.head}" height="30" />
                            </c:otherwise>
                        </c:choose>
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#" data-toggle="modal" data-target="#modifyPasswordModal">
                                <i class="glyphicon glyphicon-cog"></i>修改密码
                            </a>
                        </li>
                        <li>
                            <%-- a超链接，点击触发href的请求 （get请求） --%>
                            <a href="${pageContext.request.contextPath}/user/loginOut">
                                <i class="glyphicon glyphicon-off"></i> 退出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- navbar end -->
    </div>
</div>


<%--                   注册模态框              开始--%>
<div class="modal fade" id="registModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="registModalLabel">会员注册</h4>
            </div>
            <form id="registerForm" class="form-horizontal" action="${pageContext.request.contextPath}/user/doRegistry"
                  method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="username" class="col-sm-2 control-label">用户姓名</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="username" name="username"
                                   placeholder="请输入您的真实姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="registryName" class="col-sm-2 control-label">登录账号</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="registryName" name="registryName"
                                   placeholder="请输入注册账号">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="login_pass" class="col-sm-2 control-label">登录密码</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="login_pass" name="login_pass"
                                   placeholder="请输入注册密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="col-sm-2 control-label">联系电话</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="phone" name="phone" placeholder="请输入联系电话">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address" class="col-sm-2 control-label">联系地址</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="address" name="address" placeholder="请输入联系地址">
                        </div>
                    </div>

                </div>
                <div class="modal-footer form-group">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                        关&nbsp;&nbsp;闭
                    </button>
                    <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                    <button type="submit" class="btn btn-warning">注&nbsp;&nbsp;册</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%--                   注册模态框             end--%>


<!--                   登录模态框            start-->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">登&nbsp;陆</h4>
            </div>
            <form id="loginForm" action="${pageContext.request.contextPath}/user/login" class="form-horizontal"
                  method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">登录帐号：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" name="login_name" id="login_name_id">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password" name="login_pass" id="login_pass_id">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">向右滑动验证</label>
                        <div id="mpanel" class="col-sm-6"></div>
                        <!--  <label class="col-sm-3 control-label" style="text-align:left; border: 1px solid #ccc;">1234</label> -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                        关&nbsp;&nbsp;闭
                    </button>
                    <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                    <button type="submit" class="btn btn-warning">登&nbsp;&nbsp;陆</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!--                   登录模态框               end-->


<!-- 修改密码模态框 start-->
<div class="modal fade" id="modifyPasswordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改密码</h4>
            </div>
            <form id="modifyPasswordForm"  action="${pageContext.request.contextPath}/user/updatePass"
                  class="form-horizontal" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">原密码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="text" id="oldPass" name="oldPass">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">新密码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password" id="newPass" name="newPass">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">重复密码：</label>
                        <div class="col-sm-6">
                            <input class="form-control" type="password" id="newPass2" name="newPass2">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal" aria-label="Close">
                        关&nbsp;&nbsp;闭
                    </button>
                    <button type="reset" class="btn btn-warning">重&nbsp;&nbsp;置</button>
                    <%-- type=submit   表示表单请求，直接触发form中action请求   --%>
                    <%--  如果用ajax请求，   type改为普通按钮button --%>
                    <%--<button type="submit" class="btn btn-warning">修&nbsp;&nbsp;改</button>--%>
<%--                    onclick="updatePass()"   --%>
                    <button type="submit" class="btn btn-warning" >修&nbsp;&nbsp;改</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 修改密码模态框 end-->
