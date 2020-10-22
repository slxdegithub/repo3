<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/9
  Time: 7:25
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户中心</title>
    <link rel="stylesheet" href="css/userCenter.css" type="text/css">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/userCenter.css" type="text/css">
    <link rel="stylesheet" href="css/iconfont.css" type="text/css">
    <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src=" bootstrap/js/bootstrap.js"></script>

</head>
<body>
<!-- 引入导航栏-->
<c:import url="header.jsp"></c:import>
<div class="container float_n col-xs-12 ">
    <div class="div_container flex float_n col-xs-11" id="iframeDiv">
        <div class="left col-xs-2">
            <div class="col-xs-12">
                <h4>功能管理</h4>
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu">
                        <c:if test="${loginUser.role eq 2 or loginUser.role eq 3}">
                        <li class=" treeview active firstLi">
                            <a href=" ">
                                <span class="iconfont icon-fuwuguanli"></span>
                                <span>服务管理</span>
                                <span class="iconfont icon-zuo "></span>
                            </a>
                            <ul class="treeview-menu">
                                <c:choose>
                                    <c:when test="${loginUser eq null}">
                                        <li><a href="${pageContext.request.contextPath}/categoryList?pageNo=1&findType=0&pageSize=10"><span class="iconfont icon-yuan-active"></span> 服务目录 </a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="${pageContext.request.contextPath}/categoryList?pageNo=1&findType=0&pageSize=10" target= "iFrame1"><span class="iconfont icon-yuan-active"></span> 服务目录 </a></li>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${loginUser eq null}">
                                        <li><a href="${pageContext.request.contextPath}/serviceInfoList?pageNo=1&findType=0&pageSize=10"><span class="iconfont icon-yuan-active"></span> 服务注册 </a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="${pageContext.request.contextPath}/serviceInfoList?pageNo=1&findType=0&pageSize=10" target= "iFrame1"><span class="iconfont icon-yuan-active"></span> 服务注册 </a></li>
                                    </c:otherwise>
                                </c:choose>
                                <%--hdd 2020-8-9--%>
                                <c:choose>
                                    <c:when test="${loginUser eq null}">
                                        <li ><a href="${pageContext.request.contextPath}/submitService?pageNo=1&findType=0&pageSize=10"><span class="iconfont icon-yuan-active"></span> 服务挂载 </a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li ><a href="${pageContext.request.contextPath}/submitService?pageNo=1&findType=0&pageSize=10" target= "iFrame1"><span class="iconfont icon-yuan-active"></span> 服务挂载 </a></li>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${loginUser eq null}">
                                        <li ><a href="${pageContext.request.contextPath}/unloadService?pageNo=1&findType=0&pageSize=10"><span class="iconfont icon-yuan-active"></span> 服务卸载 </a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li ><a href="${pageContext.request.contextPath}/unloadService?pageNo=1&findType=0&pageSize=10" target= "iFrame1"><span class="iconfont icon-yuan-active"></span> 服务卸载 </a></li>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${loginUser eq null}">
                                        <li ><a href="${pageContext.request.contextPath}/deleteService?pageNo=1&findType=0&pageSize=10" ><span class="iconfont icon-yuan-active"></span> 服务作废 </a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li ><a href="${pageContext.request.contextPath}/deleteService?pageNo=1&findType=0&pageSize=10" target= "iFrame1"><span class="iconfont icon-yuan-active"></span> 服务作废 </a></li>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${loginUser eq null}">
                                        <li><a href="${pageContext.request.contextPath}/allService?pageNo=1&findType=0&pageSize=10"><span class="iconfont icon-yuan-active"></span> 服务状态 </a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="${pageContext.request.contextPath}/allService?pageNo=1&findType=0&pageSize=10" target= "iFrame1"><span class="iconfont icon-yuan-active"></span> 服务状态 </a></li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </li>
                        </c:if>
                        <c:if test="${loginUser.role eq 3 or loginUser.role eq 4}">
                        <li class=" treeview">
                            <a href=" ">
                                <span class="iconfont icon-kongzhitai"></span>
                                <span>订阅管理</span>
                                <span class="iconfont icon-zuo "></span>
                            </a>
                            <ul class="treeview-menu">
                                <c:if test="${loginUser.role eq 3}">
                                    <c:choose>
                                        <c:when test="${loginUser eq null}">
                                            <li><a href="${pageContext.request.contextPath}/subscribeList?pageNo=1&findType=0&pageSize=10"><span class="iconfont icon-yuan-active"></span> 订阅审核 </a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="${pageContext.request.contextPath}/subscribeList?pageNo=1&findType=0&pageSize=10" target= "iFrame1"><span class="iconfont icon-yuan-active"></span> 订阅审核 </a></li>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${loginUser eq null}">
                                            <li><a href="${pageContext.request.contextPath}/unSubscribeList?pageNo=1&findType=0&pageSize=10"><span class="iconfont icon-yuan-active"></span> 取消订阅审核 </a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="${pageContext.request.contextPath}/unSubscribeList?pageNo=1&findType=0&pageSize=10" target= "iFrame1"><span class="iconfont icon-yuan-active"></span> 取消订阅审核 </a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <c:if test="${loginUser.role eq 4}">
                                  <c:choose>
                                    <c:when test="${loginUser ne null}">
                                        <li><a href="${pageContext.request.contextPath}/mySubscribeList?pageNo=1&findType=0&pageSize=10" target= "iFrame1"><span class="iconfont icon-yuan-active"></span> 我订阅的服务 </a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="${pageContext.request.contextPath}/mySubscribeList?pageNo=1&findType=0&pageSize=10"><span class="iconfont icon-yuan-active"></span> 我订阅的服务 </a></li>
                                    </c:otherwise>
                                  </c:choose>
                                </c:if>
                                <c:if test="${loginUser.role eq 3}">
                                    <c:choose>
                                        <c:when test="${loginUser eq null}">
                                            <li><a href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo=1&findType=0&pageSize=10"><span class="iconfont icon-yuan-active"></span> 我审核的服务 </a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo=1&findType=0&pageSize=10" target= "iFrame1"><span class="iconfont icon-yuan-active"></span> 我审核的服务 </a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </ul>
                        </li>
                        </c:if>
                        <c:if test="${loginUser.role eq 1}">
                            <li class="treeview">
                                <a href="${pageContext.request.contextPath}/dictionaryList?pageNo=1&findType=0&pageSize=10" target= "iFrame1">
                                    <span class="iconfont icon-irp-nav-dictionarycidianguanli"></span>
                                    <span>词典管理</span>
                                </a>
                            </li>
                        <li class="treeview">
                            <a href="${pageContext.request.contextPath}/noticeList"  target= "iFrame1">
                                <span class="iconfont icon-gonggao"></span>
                                <span>公告栏管理</span>
                            </a>
                        </li>
                        <li class="treeview">
                            <a href="${pageContext.request.contextPath}/guideList"  target="iFrame1">
                                <span class="iconfont icon-caozuoshuoming"></span>
                                <span>操作指南管理</span>

                            </a>
                        </li>
                        <li class="treeview">
                            <a href="${pageContext.request.contextPath}/logInfoList?pageNo=1&pageSize=10"  target= "iFrame1">
                                <span class="iconfont icon-rizhi"></span>
                                <span>日志查询</span>
                            </a>
                        </li>
                        </c:if>
                        <li class="treeview remove_select_btn">
                            <c:if test="${loginUser.role eq 4}">
                                <c:choose>
                                    <c:when test="${loginUser ne null}">
                                        <a href="${pageContext.request.contextPath}/myAnalysis?pageNo=1&&findType=0&pageSize=10" target= "iFrame1">
                                            <span class="iconfont icon-fenxi thin_icon"></span><span> 统计分析</span>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/myAnalysis?pageNo=1&&findType=0&pageSize=10">
                                            <span class="iconfont icon-fenxi thin_icon"></span><span> 统计分析</span>
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                            </c:if>
                            <c:if test="${loginUser.role ne 4}">
                                <c:choose>
                                    <c:when test="${loginUser ne null}">
                                        <a href="${pageContext.request.contextPath}/companyAnalysis?pageNo=1&findType=0&pageSize=10" target= "iFrame1">
                                            <span class="iconfont icon-fenxi thin_icon"></span><span> 统计分析</span>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/companyAnalysis?pageNo=1&findType=0&pageSize=10">
                                            <span class="iconfont icon-fenxi thin_icon"></span><span> 统计分析</span>
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                            </c:if>
                        </li>

                    </ul>
                </section>
                <!-- /.sidebar -->
            </div>
        </div>
        <div class="right col-xs-10">
            <c:if test="${loginUser.role eq 1}">
                <iframe id="iFrame1" name= "iFrame1" src="${pageContext.request.contextPath}/dictionaryList?pageNo=1&findType=0&pageSize=10" frameborder="0" style="width: 100%; " onload=" testam()"></iframe>
            </c:if>
            <c:if test="${loginUser.role eq 2 or loginUser.role eq 3}">
                <iframe id="iFrame1" name= "iFrame1" src="${pageContext.request.contextPath}/categoryList?pageNo=1&findType=0&pageSize=10" frameborder="0" style="width: 100%;  " onload=" testam()" ></iframe>
            </c:if>
            <c:if test="${loginUser.role eq 4}">
                <iframe id="iFrame1" name= "iFrame1" src="${pageContext.request.contextPath}/mySubscribeList?pageNo=1&findType=0&pageSize=10" frameborder="0" style="width: 100%; " onload=" testam()"></iframe>
            </c:if>
        </div>
    </div>
</div>
<!-- 底部 -->
<div class="footerbox  " style="height: auto;">
    <c:import url="footer.jsp"></c:import>
</div>


<!-- AdminLTE App -->
<script src="js/ulList/app.min.js" type="text/javascript"></script>

<script>
    $(function () {


        $('.treeview-menu li').click(function () {
            $(this).addClass('select_btn')
            //移除除了自身之外其他元素的背景样式
            $('.treeview-menu li ').not(this).removeClass('select_btn');
        })
        $('.remove_select_btn').click(function () {
            //移除除了自身之外其他元素的背景样式
            $('.treeview-menu li ').removeClass('select_btn');
        })
    })
    function testam() {
        var tableHeight = $("#iFrame1").contents().find(".zy_right_con").height();
        // console.log('tableHeight'+tableHeight) ;
        // var iframeHeight = $("#iFrame1").contents().find("body").height();
        $("#iFrame1").contents().find("body").height(tableHeight+50);
        var iframeHeight = $("#iFrame1").contents().find("body").height();
        // console.log('body'+iframeHeight) ;
        $('#iframeDiv').height(iframeHeight+30);
        $('#iframeDiv .left').height(iframeHeight+20);
        $('#iframeDiv .right').height(iframeHeight+20);
        $('#iFrame1').height(iframeHeight+30);
        $("#iFrame1").contents().find("html").height(iframeHeight);
        // console.log('iFrame1'+ $('#iFrame1').height()) ;
        // console.log('iframeDiv'+ $('#iframeDiv').height()) ;

        if( iframeHeight < 800 ){
            //当网页正文高度小于可视窗口高度时，为footer添加类fixed-bottom
            $(".page_btn").addClass("paging");
        } else {
            $(".page_btn").removeClass("paging");
            $(".footerbox").removeClass("fixed-bottom");
        }
        }
</script>
</body>
</html>

