<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en" >
<head>
    <meta charset="utf-8" />
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="css/login.css" />
    <style>
        html{
            width: 100%;
        }

    </style>
</head>
<body>
<img class="bgone" src="images/login/1.jpg" />
<img class="pic" src="images/login/a.png" />
<input type="hidden" value="${loginType}" id="loginType">
<form action="${pageContext.request.contextPath}/loginsys" method="post">
    <div class="table second_div">
        <div class="wel">普惠金融服务管理系统</div>
        <div class="user">
            <div class="login_img"><img src="images/login/yhm.png" /></div>
            <input type="text"  id="username" name="username" placeholder="用户名"  autocomplete="off"/>
        </div>
        <div class="password">
            <div class="login_img"><img src="images/login/mm.png" /></div>
            <input type="password" id="password" name="password" name="密码" placeholder="密码"  autocomplete="off" >
        </div>
        <input class="btn" type="submit" value="登录"/>
        <div class="info"><span style="color: red;text-align: center;position: absolute; bottom: 6px;right: 6.9rem; ">${info} <c:if test="${info!=null}">，请重新输入</c:if></span></div>
    </div>
</form>
<form action="${pageContext.request.contextPath}/updatePassword" method="post">
    <div class="table first_div"  style="display: none" >
        <div class="changePwd_txt ">重 置 密 码</div>
        <div class="user">
            <div class="login_img"><img src="images/login/mm.png" /></div>
            <input type="password" id="new_password1" name="new_password1" autocomplete="off" placeholder="新密码"  >
        </div>
        <div class="password">
            <div class="login_img"><img src="images/login/mm.png"/></div>
            <input type="password" id="new_password2" name="new_password2" autocomplete="off" placeholder="确认密码"  >
        </div>
        <input class="btn" type="submit" value="修改" />
        <div class="info"><span style="color: red;text-align: center;position: absolute; bottom: 15px;right: 10.9rem; ">${info}</span></div>
    </div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
<script>
    $(function () {
        var loginType = $("#loginType").val();
        console.log("loginType==登录状态="+loginType);
        if(loginType=="1"){
            $(".first_div").css("display","block");
            $(".second_div").css("display","none");
        }
        $( '#password,#username,#new_password1,#new_password2').click(function () {
            $('.info').hide()
        })
    })

</script>
</body>
</html>