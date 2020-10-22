<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/30
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String username=(String)session.getAttribute("username");
%>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
    <meta charset="utf-8">
    <meta name="applicable-device" content="pc,mobile">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta http-equiv="Cache-Control" content="no-transform" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title> </title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/header.css" type="text/css">
    <style>
       .userinfo .icon-xia{
            font-size: 20px;
            margin-left: 5px;
            margin-top: 8px;
            color: white;
        }

    </style>
</head>
<body>
<div class="row">
    <div class="h_top fix  col-xs-12  ">
        <div class="logo fix  col-xs-2 " >
            <img src="images/index/logo.jpg" class="logoImg" alt="logo" />
            <img src="images/index/logof.PNG" class="logofont" alt="logo" />
            <%--<span class="C_name">普惠金融服务管理</span>--%>
        </div>
        <!-- 导航栏部分 -->
        <div class="h_top_nav col-xs-8">
            <ul class="col-xs-10" >
                <li class="col-xs-3 "  >
                    <a href="index " >首 页</a>
                </li >
                <li class="col-xs-3 "  >
                    <a onclick="catelog()"  href="/fuwu?page=1&search=&flag=0" >数据服务目录</a>
                </li>
                <li class="col-xs-3 "  >
                    <a href="about">统计分析</a>
                </li>
                <c:if test="${loginUser ne null}">
                <li class="col-xs-3 "  >
                    <a href="userCenter ">用户中心</a>
                </li>
                </c:if>
            </ul>
        </div>
        <c:if test="${username==null}">
            <div class="h_login col-xs-2 ">
                <img src="images/index/user.png" style="width: 45px;height: 45px;margin-right: 5px;margin: 8px 8px;">
                <div class="userinfo">
                    <a  href="login" style="color: white;text-decoration:none;">登录</a>
                </div>
            </div>
        </c:if>
        <c:if test="${username!=null}">
            <div class="h_login col-xs-2 ">
                <img src="images/index/user.png" style="width: 45px;height: 45px;margin-right: 5px;margin: 8px 8px;">
                <div class="userinfo">
                    <span>${username}</span>
                    <span class="iconfont icon-xia"></span>
                    <%--<i class="fa fa-angle-left pull-right" style="transform: rotate(-90deg)"></i>--%>
                </div>
                <div class="u_info">
                    <ul class="sidebar-menu ">
                        <li class="treeview xt_li">
                            <a href="javascript:switc()">
                                <span>切换系统</span>
                                <span class="iconfont icon-zuo"></span>
                                <%--<i class="fa fa-angle-left "></i>--%>
                            </a>
                            <ul class="treeview-menu">
                                <li><a href="" ><span class="iconfont icon-xiangmu"></span>普惠金融子系统一 </a></li>
                                <li><a href="" ><span class="iconfont icon-xiangmu"></span>普惠金融子系统二 </a></li>
                                <li><a href="" ><span class="iconfont icon-xiangmu"></span>普惠金融子系统三</a></li>
                            </ul>
                        </li>
                        <li class=" treeview"><a href="/loginout ">注销</a></li>
                    </ul>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- top end -->
<script>
    $(function(){
        var pathname = window.location.pathname;
        window.onload=function(){
            var index ='';
            if(pathname=="/index"){
                $(".h_top_nav ul li").eq(0).addClass("cur");
                index=0;

            }else if(pathname=="/fuwu"){
                $(".h_top_nav ul li").eq(1).addClass("cur");
                index=1;

            }else if(pathname=="/about"){
                $(".h_top_nav ul li").eq(2).addClass("cur");
                index=2;

            }else{
                $(".h_top_nav ul li").eq(3).addClass("cur");
                index=3;

            }
            $(".h_top_nav ul li").mouseenter(
                function(){
                    $(this).addClass("cur")
                }
            ).mouseleave(
                function(){
                    $(this).removeClass("cur");
                    $(".h_top_nav ul li").eq(index).addClass("cur")
                }
            ).click(function () {
                sessionStorage.removeItem("search_name");
            })
        }
        //展示个人信息下拉列表
        $('.userinfo').mouseover(function () {
            $('.u_info').addClass('show')
        })
        $('.u_info').mouseleave(function () {
            $('.u_info').removeClass('show')
        }).mouseover(function () {
            $('.u_info').addClass('show')
        })
        $('.h_login').mouseleave(function () {
            $('.u_info').removeClass('show')
        })

        $('.u_info ul li a').mouseover(function () {
            $(this).css('color','blue')

        }).mouseleave(function () {
            $(this).css('color','black')
        })

    })
    function switc() {
        var flage =$('.xt_li').attr('class');

        if(flage=="treeview xt_li"){

            $('.xt_li').addClass('active');
            // $('.xt_li .iconfont').attr('class','iconfont icon-xia')
        }else {
            $('.xt_li').removeClass('active');
            // $('.xt_li .iconfont').attr('class','iconfont icon-zuo')
        }
    }
</script>
<script>
    var storge = window.localStorage
    function catelog() {
        storge.searchs="666";
    }
</script>
</body>
</html>
