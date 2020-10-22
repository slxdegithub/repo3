<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/9
  Time: 9:45
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"   %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>
    <title>普惠金融</title>
    <%--页面的css--%>
    <link rel="stylesheet" href="css/fuwu.css">
    <link rel="stylesheet" href="css/iconfont.css" type="text/css">
    <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
</head>
<body>
<!-- 引入导航  -->
<c:import url="header.jsp"></c:import>

<!-- 主体内容框 -->
<div class="wid_main row ">

    <div class="fuwu_content col-xs-10 float_n">
        <div class="flex">
            <div class="zy_left_con  ">
                <div class="list_box padding_l  col-xs-12">
                    <div class="search_kind">
                        搜索分类
                        <div class="has-feedback  ">
                            <input type="text"   class="form-control input-sm"   id="searchkind"/>
                            <i onclick="findSecond()" class="glyphicon glyphicon-search  "></i>
                        </div>
                    </div>
                    <div class="scroll" >
                        <div class="list-group test-1">
                            <%--分类名称以及该类别中发布服务和注册服务占比。--%>
                            <%--遍历输出cataloglist里面的内容--%>
                            <c:if test="${catalogList.size()==0}">
                                <div class="tip_div">没有搜索到相关目录</div>
                            </c:if>
                            <section class="sidebar">
                                <ul class="sidebar-menu">

                                    <%--先循环有子目录的--%>
                                    <c:forEach items="${catalogList}" var="cag" varStatus="vs" >
                                        <c:if test="${cag.status == 2}">
                                            <li class="treeview">
                                                <a href="javascript:void(0)" style="color: #00acef">
                                                    <i class="glyphicon glyphicon-th-large" style="width: 15px;"></i>
                                                    <span class="cname">${cag.name}</span>
                                                    <span class="num_0">[${cag.pubCount}/${cag.regCount}]</span>
                                                        <%--<span class="num">[${cag.pubCount}/${cag.regCount}]</span>--%>
                                                    <span class="iconfont icon-zuo "></span>
                                                </a>
                                                <ul class="treeview-menu">
                                                    <c:forEach items="${cag.categories}" var="two">
                                                        <li>
                                                            <div onclick='testClick("${two.cname}")'  class='aside' target= "iFrame1 " >
                                                                <button type="button" class="list-group-item">
                                                                    <span class="iconfont icon-yuan-active"></span>
                                                                    <span class="secondName">${two.cname}</span>
                                                                    <span class="num">[${two.type}/${two.status}]</span>
                                                                </button>
                                                                <i class="glyphicon glyphicon-menu-right" ></i>
                                                            </div>
                                                        </li>
                                                    </c:forEach>

                                                </ul>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <%--在循环没有子目录的--%>
                                    <c:forEach items="${catalogList}" var="cag" varStatus="vs" >
                                        <c:if test="${cag.status == 1}" >
                                            <li>
                                                <div onclick='testClick("${cag.name}")'  class='aside' target= "iFrame1 " >
                                                    <button type="button" class="list-group-item">
                                                        <i class="glyphicon glyphicon-th-large"></i>
                                                        <span  class="cname">${cag.name}</span>
                                                        <span class="num">[${cag.pubCount}/${cag.regCount}]</span>
                                                    </button>
                                                    <i class="glyphicon glyphicon-menu-right" ></i>
                                                </div>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </section>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 右边内容 -->
            <div class="zy_right_con  ">
                <!-- 内容展示块-->
                <iframe  id="iFrame1" name= "iFrame1 " src="/fuwuUserServiceist?page=1&search=&flag=0"    frameborder="0" style="width: 100%;height: 100%"></iframe>
            </div>             <%-- //"/fuwuUserServiceist?page=1&search=&flag=0"--%>
        </div>
        <!-- 子页内容框 -->
        <!-- 左边栏 -->
        <!-- zy_content end -->
    </div>
</div>

<!-- 底部 -->
<div class="footerbox  " style="height: auto;">
    <c:import url="footer.jsp"></c:import>
</div>

<!-- AdminLTE App 点击列表必用 -->
<script src="js/ulList/app.min.js" type="text/javascript"></script>

<script>
    var storge = window.localStorage;
    $(function () {

        // alert(window.location.search)
        var indexSearch = GetQueryString("search");
        // alert(indexSearch)
        // storge.searchName = indexSearch
        //搜索之后返回全部分类
        var name = window.sessionStorage.getItem("search_name");//从缓存读取name的值

        if (name!=null) {
            if(name!=''){
                $('#searchkind').attr('value',name);
                $('.test-1').append('<div class="list_btn"><button  type="button" class="btn btn-default" onclick="showAll()" style="border-radius: 13px;">查看全部分类</button></div>')
            }
        }

        var id = GetQueryString("flag")  //从url读取flag的值
        storge.flag=id;     //控制高亮
        if (indexSearch != ''){
            var url = "/fuwuUserServiceist" + window.location.search
            $('#iFrame1').attr('src',url)
        } else {
            if ( id == 1){
                var url = "/fuwuUserServiceist?page=1&search=&flag=1"
                $('#iFrame1').attr('src',url)
            }else if (id == 2) {
                var url ="/fuwuUserServiceist?page=1&search=&flag=2"
                $('#iFrame1').attr('src',url)
            }

        }

        $('.pager a').click(function () {
            console.log($(this).attr('disabled'))
            if($(this).attr('disabled') == 'disabled'){
                return false;
            }
            var name = storge.cagname;
            var flag = storge.flag;
            var search = storge.searchName;
            var searchs = storge.searchs
            //如果searchs为666 新的if else iffalg=0 falg=1
            if (searchs == 666){
                if (flag == 0){
                    window.location.href=  "/fuwu?page=" + $(this).attr('page-id') + "&search=" +search + "&flag="+ flag
                }else if (flag ==1 || flag ==2) {
                    window.location.href =  "/fuwu?page=" + $(this).attr('page-id') + "&search=" +search + "&flag="+ flag
                }


            } else {
                if (flag == 0){
                    window.location.href=  "/fuwu?page=" + $(this).attr('page-id') + "&name=" +name
                }else if (flag ==1 || flag ==2) {
                    window.location.href =  "/fuwu?page=" + $(this).attr('page-id') + "&name=" +name + "&flag="+ flag

                }
            }



        })
        $('.aside ').click(function () {
            $(this).addClass('select_btn');
            //移除除了自身之外其他元素的背景样式
            $('li .aside').not(this).removeClass('select_btn');
        })
        // alert(storge.searchName)
        storge.removeItem("searchName");
        // alert(storge.searchName)

    });

    window.onbeforeunload=function(){
        // storge.searchName=storge.indexSearch;
        return ;
    }

    function currentPage(currentPage){
    }

    var box2 = $("#open2").next('span')



    /*左侧分类栏点击的链接*/

    /*
       三个排序 默认排序更新排序和热度排序
    */
    /* function sort(i,data) {
         var name = data;
         var flag = i;
         storge.flag = flag;
         // alert(name)
         // alert(i)/
         //如果searchs为666 新的if else
         if (storge.searchs == 666) {
             if (flag == 0){
                 window.location.href=  "/fuwu?page=1&search=" +storge.searchName+ "&flag="+ flag
             }else if (flag ==1 || flag ==2) {
                 window.location.href =  "/fuwu?page=1&search=" +storge.searchName + "&flag="+ flag

             }
         }else {
             if (i == 0){
                 window.location.href = "/fuwuUserServiceist?page=1&name="+name ;

             } else {
                 window.location.href = "/fuwu?page=1&name="+name + "&flag=" +i;
             }
         }
     }*/

    /*
        订阅
     */
    function open1(id) {
        // this.$alert('<span>类别名称:</span><input type="text">', '新增类别', {
        //     dangerouslyUseHTMLString: true
        // });serviceSub
        alert("订阅被点击了")
        $.ajax({
            url : "/serviceSub",
            async : true,
            type : "get",
            dataType : "json",
            data : {
                "ServiceId" : id ,
            },
            // 成功后开启模态框
            success : function(response) {
                alert("请求成功，返回的状态为"+ response.status)
                if (response.status == 1){

                } else if (response.status == 2) {

                } else if (response.status == 3) {

                } else if (response.status == 4) {

                } else if (response.status == 5) {

                } else if (response.status == 6) {

                }
            },
            error : function() {
                alert("请求失败");
            }
        });

    }

    //通过url获取值的工具方法
    function GetQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);

        if(r!=null)return  unescape(r[2]);
        return null;
    }

    /*
        左侧分类栏目
     */
    function testClick(data){
        var name = data;
        storge.cagname=name;
        storge.flag = 0;
        storge.searchs = 0;
        // localStorage.Cagelogname =name;
        // alert(storge.cagname)
        document.getElementById("iFrame1").src="/fuwuUserServiceist?page=1&name="+name;
    }

    /*左侧分栏目的搜索框的点击事件*/
    function searchClick(){
        // alert( this.getInput()) ;
        var name = document.getElementById("searchkind").value;
        window.sessionStorage.setItem('search_name', name); //将name存入缓存
        storge.searchs = 666 ;

        // var name = this.input
        // alert(name)
        // storge.cagname=name;
        storge.flag = 0;
        // document.getElementById("iFrame1").src="/fuwuUserServiceist?page=1&leftsearch="+name;
        window.location.href = "/fuwu?page=1&name="+name;

    }
    function searchAll() {
        sessionStorage.removeItem("search_name");
        storge.searchs = 666 ;
        storge.flag = 0;
        window.location.href = "/fuwu?page=1&name=";
    }
    
    function showAll() {
        window.location.href = "/fuwu?page=1&search=&flag=0"
        
    }


</script>

<script>
    var a = document.getElementById("searchName");
    function search(){
        storge.searchName = a.value
        storge.searchs = 666 ;
        storge.flag=0;
        window.location.href = "/fuwuUserServiceist?page=1&search="+a.value + "&flag="+storge.flag ;

    }

    //输入框调用回车事件 按类别搜索
    $('#searchkind').bind('keypress',function(event){

        if(event.keyCode == "13"  )
        {
            // searchClick();
            findSecond();
        }
    });

    //搜索 目录

    function findSecond() {

        var a = document.getElementById("searchkind").value;
        if (a!='') {
            // 清除一级或二级目录查询突出字体样式
            $(".aside .secondName").removeClass('fontColor_red');
            $(".cname").removeClass('fontColor_red');
            //先把所有的都隐藏起来
            $('.sidebar-menu > li ').hide();
            // 二级目录查询
            $(".aside .secondName").filter(":contains('"+a+"')").addClass('fontColor_red');
            $(".aside .secondName").filter(":contains('"+a+"')").parents('.treeview-menu').css('display','block').addClass('menu-open');
            $(".aside .secondName").filter(":contains('"+a+"')").parents('.treeview').addClass('active');
            //显示二级目录
            $(".aside .secondName").filter(":contains('"+a+"')").parents('li').show();
            // 一级目录
            $(".cname").filter(":contains('"+a+"')").addClass('fontColor_red');
            //显示出来
            $(".cname").filter(":contains('"+a+"')").parents('li').show();
            if ($( ".test-1:has('.list_btn')" ).length==0){
                $('.test-1').append('<div class="list_btn"><button  type="button" class="btn btn-default" onclick="showAll()" style="border-radius: 13px;">查看全部分类</button></div>')
            }
        }

    }


</script>
</body>
</html>
