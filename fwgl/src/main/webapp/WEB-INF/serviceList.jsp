<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/page.css">  <!-- 分页的css-->

    <link rel="stylesheet" href="css/start.css"><!-- 星星的css-->

    <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="js/jquery.SuperSlide.2.1.1.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userCenter.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iconfont.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
    <link href="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
       <!-- Ionicons 2.0.0 -->
    <link href="${pageContext.request.contextPath}/css/ionicons.min.css/" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/fuwu.css"><!-- 页面的css -->

</head>
<body style="height: 100%" >
<div class="fuwu" style="position: relative;padding-bottom: 75px;min-height:720px;">
    <div class="fuwu_detail">
        <div class="detail_left">
            共${services.total}个服务
        </div>
        <div class="detail_right">
            <a type="primary" class=" " size="small"  href="javascript:sort(0,storge.cagname)"  >
                默认排序 <i class="glyphicon glyphicon-sort-by-attributes-alt"></i></a>

            <a size="small"   href="javascript:sort(1,storge.cagname)">
                更新排序 <i class="glyphicon glyphicon-sort-by-attributes-alt"></i></a>
            <a size="small"   href="javascript:sort(2,storge.cagname)">
                热度排序 <i class="glyphicon glyphicon-sort-by-attributes-alt"></i> </a>
        </div>

        <div class="search_div  ">
            <input type="text" placeholder="按名称搜索" class="search-input" id="searchName" autocomplete="off" />
            <i class="fa fa-fw fa-search search_icon" onclick="search()"></i>
        </div>
    </div>
    <%--遍历服务--%>
    <c:if test="${services.list.size() == 0}">
        <div class="tip_div">
            <img src="images/fuwu/404.png" alt="">
            <span class="title">～～没有搜索到相关服务～～</span>
            <span class="jump">您可以：<a href="javascript:searchAll()">查看全部服务目录</a></span>
        </div>
    </c:if>

    <c:forEach items="${vices.list}" var="service" varStatus="vs">
        <div class="fuwu_list">
            <table>
                <tr >
                    <td >
                        <span class="fuwu_name" >${service.name}</span>

                    </td>
                    <td colspan="3">
                        <div class="cont_start">
                            <span>订阅热度：</span>
                            <div class="atar_Show">
                                <p tip="${service.unmountTime/2}"></p>
                            </div>
                        </div>

                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="sp-1">订阅量:</span>
                        <span class="sp-2">${service.unmountTime}</span>
                    </td>
                    <td>
                        <span class="sp-1">共享类型:</span>
                        <c:choose>
                            <c:when test="${service.openType eq 1}">
                                <span class="sp-2">公开</span>
                            </c:when>
                            <c:when test="${service.openType eq 2}">
                                <span class="sp-2">半公开</span>
                            </c:when>
                            <c:otherwise>
                                <span class="sp-2">保密</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <span class="sp-1">服务类别:</span>
                        <c:choose>
                            <c:when test="${service.serviceType eq 1}">
                                <span class="sp-2">RPC</span>
                            </c:when>
                            <c:when test="${service.serviceType eq 2}">
                                <span class="sp-2">SOAP</span>
                            </c:when>
                            <c:otherwise>
                                <span class="sp-2">REST</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td rowspan="2" valign=＂middle＂>
                        <div class="fuwu_button"  >
                            <button type="button" class="btn  btn-info btn-sm" onclick="look('${service.id}')">查看</button>
                            <c:if test="${ (service.categoryId eq 0) or loginUser.role lt 4 }" >
                                <button  type="button" class="btn btn-default btn-sm" title="请先登录"  disabled="disabled" id="open0">订阅 </button>
                            </c:if>
                            <c:if test="${(service.categoryId eq null  or service.categoryId eq 5) and loginUser.role eq 4  }" >
                                <button onclick="subscribe('${service.id}');" type="button" class="btn btn-info btn-sm" id="open1">订阅 </button>
                            </c:if>
                            <c:if test="${ (service.categoryId eq 3) and loginUser.role eq 4 }" >
                                <button onclick="subscribe('${service.id}');" type="button" class="btn btn-info btn-sm" id="open1">再次订阅 </button>
                            </c:if>
                            <c:if test="${(service.categoryId eq 2 || service.categoryId eq 6) and loginUser.role eq 4}" >
                                <button onclick="cancelSubscribe(${service.id})" type="button" class="btn btn-danger btn-sm" id="open2">取消订阅 </button>
                            </c:if>

                            <c:if test="${service.categoryId eq 1}" >
                                <button onclick="open3(${service.id})" type="button" class="btn btn-default  btn-sm" disabled="disabled" id="open3">订阅审核中 </button>
                            </c:if>
                            <c:if test="${service.categoryId eq 4}" >
                                <button onclick="open4(${service.id})" type="button" class="btn  btn-danger  btn-sm" disabled="disabled" id="open4">取消审核中 </button>
                            </c:if>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="sp-1">更新时间:</span>
                        <span class="sp-2 mar">${service.mountTime}</span>
                    </td>
                    <td>
                        <span class="sp-1">资源目录:</span>
                        <span class="sp-2">${service.cancelTime}</span>
                    </td>
                    <td>
                        <span class="sp-1">请求方法:</span>
                        <span class="sp-2">${service.reqMethod}</span>
                    </td>

                </tr>

            </table>
        </div>
    </c:forEach>

    <div class="row page_btn">
        <label style="margin-left: 22px; font-size: 15px;font-weight: 500;">
            <c:if test="${services.pages == 0}">
                当前第0页,
            </c:if>
            <c:if test="${services.pages != 0}">
                当前第${services.pageNum}页,
            </c:if>
            共${services.pages}页 ,
            每页${services.pageSize}条数据</label>
        <div id="pager" class="pager clearfix">
        </div>
    </div>
</div>
<%--查看 detailModal--%>
<div class="modal fade bs-example-modal-lg" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal_large" role="document"  >
        <input type="hidden" id="id2" name="id2">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">注册接口服务</h4>
            </div>
            <div class="modal-body box">
                <div align="center" >
                    <table class="modal_table">
                        <tr>
                            <td class="left_td"> 接口名称 </td>
                            <td>
                                <input type="text" autocomplete="off" id="cname2" readonly style="width:100%;height:26px;">
                            </td>
                            <td class="d_td">服务类型</td>
                            <td>
                                <input type="text" autocomplete="off" id="stype2" readonly style="width:100%;height:26px;">
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">协议类型</td>
                            <td>
                                <input type="text" autocomplete="off" id="ptype2" readonly style="width:100%;height:26px;">
                            </td>
                            <td class="d_td">请求类型 </td>
                            <td>
                                <input type="text" autocomplete="off" id="rtype2" readonly style="width:100%;height:26px;">
                            </td>
                        </tr>
                        <tr>
                            <td class="d_td">版本号</td>
                            <td>
                                <input type="text" autocomplete="off" id="version2" style="width: 100%;height:26px;" readonly>
                                <div id="pic2"></div>
                            </td>
                            <td class="d_td">公开类型 </td>
                            <td width="120px">
                                <input type="text" autocomplete="off" id="otype2" style="width: 100%;height:26px;" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td" >一级目录</td>
                            <td>
                                <input type="text" autocomplete="off" id="firstCtype2" style="width: 100%;height:26px;" readonly>
                            </td>
                            <td class="d_td">二级目录</td>
                            <td>
                                <input type="text" autocomplete="off" id="secondCtype2" style="width: 100%;height:26px;" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">请求地址 </td>
                            <td colspan="3">
                                <input type="text" autocomplete="off" id="address2" style='width:100%;height: 26px' readonly>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">功能描述</td>
                            <td colspan="3">
                                <textarea id="desc2" autocomplete="off" rows="2" style="width: 100%; " readonly></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="box  modal_table2">
                <div class="box-header  ">
                    请求参数信息
                </div>
                <div class="box-body ">
                    <table id="req2" class="col-xs-12 table table-bordered table-striped  ">
                        <thead>
                        <tr>
                            <td>参数名称</td>
                            <td>参数类型</td>
                            <td>备注信息</td>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box   modal_table3">
                <div class="box-header  ">
                    响应参数信息
                </div>
                <div class="box-body ">
                    <table class="col-xs-12 table table-bordered table-striped" id="resp2">
                        <thead>
                        <tr>
                            <td>参数名称</td>
                            <td>参数类型</td>
                            <td>备注信息</td>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" id="close3" name="close3" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                    <button type="button" id="btn_download" class="btn btn-info" onclick="downServiceFile();" style="color: #444"><span class="iconfont icon-wendang" aria-hidden="true"></span>下载附件</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.js "></script>
<script type="text/javascript" src="js/jquery.z-pager.js"></script><!-- 分页的js-->
<%--左侧分类高亮--%>
<script>
    var storge = window.localStorage;
    let totalData= ${services.total};//总条数
    let pageData= ${services.pageSize}; //每页条数
    let pageCount=${services.pages};//总页数
    let current= ${services.pageNum};//当前页数
    let pageStep= 6; //当前可见最多页码个数
    let minPage= 5; //最小页码数，页码小于此数值则不显示上下分页按钮
    let btnShow= true;
    let ajaxSetData= false;


    $("#pager").zPager({
        totalData:totalData,//总条数
        pageData: pageData, //每页条数
        pageCount:pageCount,//总页数
        current:current,//当前页数
        pageStep: pageStep, //当前可见最多页码个数
        minPage: minPage, //最小页码数，页码小于此数值则不显示上下分页按钮
        btnShow: btnShow,
        ajaxSetData: ajaxSetData
    });

    /* $(window).unload(function(){
 //这里面写在关闭页面时，要调用的事件
         alert("页面要关闭了");
     });*/


    $(function () {
        var color = storge.flag
        // alert(color)
        $(".detail_right a").eq(color).addClass("select_a");
        $(".detail_right a").eq(color).siblings().removeClass('select_a');

        $('.pager a').click(function () {
            console.log($(this).attr('disabled'))
            if($(this).attr('disabled') == 'disabled'){
                return false;
            }
            var name = storge.cagname;
            var flag = storge.flag;
            // var search = storge.searchName;
            var search =   GetUrlByParamName("search");
            var searchs = storge.searchs
            // alert(search)
            //如果searchs为666 新的if else iffalg=0 falg=1
            if (searchs == 666 ){
                if (flag == 0){
                    if (typeof(search) == "undefined") {
                        search='';
                    }
                    // alert(name)
                    window.location.href=  "/fuwuUserServiceist?page=" + $(this).attr('page-id') + "&search=" +search + "&flag="+ flag
                }else if (flag ==1 || flag ==2) {
                    if (typeof(search) == "undefined") {
                        search='';
                    }
                    // alert(name)
                    window.location.href =  "/fuwuUserServiceist?page=" + $(this).attr('page-id') + "&search=" +search + "&flag="+ flag
                }


            } else {
                if (flag == 0){
                    window.location.href=  "/fuwuUserServiceist?page=" + $(this).attr('page-id') + "&name=" +name
                }else if (flag ==1 || flag ==2) {
                    window.location.href =  "/fuwuUserServiceist?page=" + $(this).attr('page-id') + "&name=" +name + "&flag="+ flag

                }
            }

        })
        $('.detail_right a').click(function () {
            $(this).addClass('select_a');
            $(this).siblings().removeClass('select_a');
        })
        if (storge.searchName!=null) {
            $('#searchName').attr('value',storge.searchName)
        }

    });

   /* function GetQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }*/


    function GetUrlByParamName(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var URL =  decodeURI(window.location.search);
        var r = URL.substr(1).match(reg);
        if(r!=null){
            //decodeURI() 函数可对 encodeURI() 函数编码过的 URI 进行解码
            return  decodeURI(r[2]);
        };
        return null;
    };


    function currentPage(currentPage){
    }

    var address;


    var box2 = $("#open2").next('span')


    /*
       三个排序 默认排序更新排序和热度排序
    */
    function sort(i,data) {
        var name = data;
        var flag = i;
        storge.flag = flag;
        // var search = storge.searchName;
        var search =   GetUrlByParamName("search");
        // alert(name)
        // alert(i)/
        //如果searchs为666 新的if else
        if (storge.searchs == 666) {
            if (flag == 0){
                if (typeof(search) == "undefined") {
                    search='';
                }
                // alert(search + "search")
                window.location.href=  "/fuwuUserServiceist?page=1&search=" +search+ "&flag="+ flag
            }else if (flag ==1 || flag ==2) {
                if (typeof(search) == "undefined") {
                    search='';
                }
                // alert(search +  "search")
                window.location.href =  "/fuwuUserServiceist?page=1&search=" +search + "&flag="+ flag

            }
        }else {
            if (i == 0){
                window.location.href = "/fuwuUserServiceist?page=1&name="+name ;
                // alert(search +  "search")
            } else {
                window.location.href = "/fuwuUserServiceist?page=1&name="+name + "&flag=" +i;
                // alert(search +  "search")
            }
        }
    }


</script>
<script>
    var a = document.getElementById("searchName");
    let confirmId=1;
    let cancelId=1;

    function search(){

        window.sessionStorage.setItem('name', name); //将name存入缓存
        storge.searchName = a.value
        storge.searchs = 666 ;
        storge.flag=0;
        // alert(storge.flag.toString())
        // alert(storge.searchName)
        window.location.href = "/fuwuUserServiceist?page=1&search="+a.value + "&flag="+storge.flag ;

    }
    function searchAll(){
        storge.searchs = 666 ;
        storge.flag=0;
        window.location.href = "/fuwuUserServiceist?page=1&search=&flag="+storge.flag ;
    }

    //输入框调用回车事件 按名称搜索
    $('#searchName').bind('keypress',function(event){
        if(event.keyCode == "13")
        {
            search();
        }
    });


    function look(id){
        $.ajax({
            url : "${pageContext.request.contextPath}/service/getServiceInfo",
            async : true,
            type : "POST",
            dataType : "json",
            data : {
                "id" : id
            },
            // 成功后开启模态框
            success : showDetail,
            error : function() {
                alert("请求失败");
            }
        });
    }

    function showDetail(data) {
        $('#id2').attr("value",data.serviceInfo.id );
        $('#cname2 ').attr("value",data.serviceInfo.name );
        $("#stype2").attr("value", data.serviceType.name);
        if(data.serviceInfo.openType=="1"){
            $("#otype2").attr("value","公开");
        }else if(data.serviceInfo.openType=="2"){
            $("#otype2").attr("value","半公开");
        }else{
            $("#otype2").attr("value","保密");
        }
        if(data.firstCategory!=null) {
            $("#firstCtype2").attr("value", data.firstCategory.cname);
        }else{
            $("#firstCtype2").attr("value", "");
        }
        if(data.secondCategory!=null){
            $("#secondCtype2").attr("value",data.secondCategory.cname);
        }else{
            $("#secondCtype2").attr("value","");
        }
        $("#ptype2").attr("value",data.pType.name);
        $("#rtype2").attr("value",data.serviceInfo.reqMethod);
        $('#address2 ').attr("value",data.serviceInfo.address );
        $('#version2 ').attr("value",data.serviceInfo.version );
        $('#desc2').val(data.serviceInfo.description );
        var reqParams=data.serviceInfo.reqParams.split(";");
        var length=reqParams.length;
        var reqtab = document.getElementById("req2") ;
        $("#req2 tr:not(:first)").remove();
        var reqrows = reqtab.rows.length ;
        if(length>reqrows){
            for(i=0;i<length-reqrows;i++){
                $('#req2').append("<tr role='row' class='even'>" +
                    "<td><input type='text' value='' id='reqName2"+(i+1).toString()+"' autocomplete='off' readonly='true'></td>"+
                    "<td><input type='text' value='' id='reqType2"+(i+1).toString()+"' autocomplete='off' readonly='true'></td>"+
                    "<td ><input type='text' id='reqBz2"+(i+1).toString()+"'  autocomplete='off'></td></tr>"
                );
            }
        }
        for(i=0;i<length;i++){
            var reqParam=reqParams[i].split(",");
            var reqName=reqParam[0];
            var reqType=reqParam[1];
            var reqBz=reqParam[2];
            var idName='reqName2'+(i+1).toString();
            var idType="reqType2"+(i+1).toString();
            var idBz="reqBz2"+(i+1).toString();
            $("#"+idName).attr("value",reqName);
            $("#"+idType).attr("value",reqType);
            $("#"+idBz).attr("value",reqBz);
        }
        var resParams=data.serviceInfo.resParams.split(";");
        var length=resParams.length;
        var restab = document.getElementById("resp2") ;
        $("#resp2 tr:not(:first)").remove();
        var resrows = restab.rows.length ;
        if(length>resrows){
            for(i=0;i<length-resrows;i++){
                $('#resp2').append("<tr role='row' class='even'>" +
                    "<td><input type='text' id='respName2"+(i+1).toString()+"' autocomplete='off' readonly='true'></td>"+
                    "<td><input type='text' id='respType2"+(i+1).toString()+"' autocomplete='off' readonly='true'></td>"+
                    "<td class='del_btn'><input type='text' id='respBz2"+(i+1).toString()+"' autocomplete='off' readonly='true' ></td> </tr>"
                )
            }
        }
        for(i=0;i<length;i++){
            var resParam=resParams[i].split(",");
            var respName=resParam[0];
            var respType=resParam[1];
            var respBz=resParam[2];
            var idName='respName2'+(i+1).toString();
            var idType="respType2"+(i+1).toString();
            var idBz="respBz2"+(i+1).toString();
            $("#"+idName).attr("value",respName);
            $("#"+idType).attr("value",respType);
            $("#"+idBz).attr("value",respBz);
        }
        var subFlag=data.subFlag;
        if (subFlag == 0) {
                $('#btn_download').hide();
        } else {
            $('#btn_download').show();
        }
        $('#detailModal').modal('show');
    }

    function open1( ){
        var id =confirmId;
        // alert(id);
        $.ajax({
            url : "sub/applySub",
            async : true,
            type : "get",
            dataType : "json",
            data : {
                "ServiceId" : id ,

            },
            // 成功后开启模态框
            success : function(response) {
                closeModal2();
                openModal3();
                if (response.msg == 1){
                    $("#open1").html("订阅审核中");
                    setTimeout(function(){
                        location.reload();
                    },1500);
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

    function open2(){
        var id =cancelId;
        $.ajax({
            url: "/cancelServiceSub",
            async: true,
            type: "get",
            dataType: "json",
            data: {
                "ServiceId": id,

            },
            // 成功后开启模态框
            success: function (response) {
                // alert("请求成功" + response.status)
                if (response.status == 1) {

                } else if (response.status == 2) {

                } else if (response.status == 3) {

                } else if (response.status == 4) {
                    $("#open3").html("取消审核中")
                    location.reload();
                } else if (response.status == 5) {

                } else if (response.status == 6) {

                }
            },
            error: function () {
                alert("请求失败");
            }
        })

    }

    //查看的modal框
    function closeModal() {
        $('.modal_look').removeClass("open_modal")
    }
    function openModal() {
        $('.modal_look').addClass("open_modal")
    }


    //确定提示订阅的modal框
    function closeModal2() {
        $('.model_subscribe_sure').removeClass("open_modal")
    }
    function subscribe(id) {
        $.confirm({
            title: '提示信息',
            content: '确认要订阅吗？',
            icon: 'fa fa-question-circle',
            animation: 'scale',
            closeAnimation: 'scale',
            // opacity: 0.5,
            buttons: {
                'confirm': {
                    text: '确定',
                    btnClass: 'btn-blue',
                    action: function () {
                        $.ajax({
                            url : '${pageContext.request.contextPath}/sub/applySub',
                            //secureuri : false,
                            dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                            data : {
                                id:id
                            },
                            success : function(data, status) {
                                var arr=data.msg;
                                if(arr=="1"){
                                    $.alert({
                                        title: '提示信息',
                                        content: '订阅成功!',
                                        icon: 'fa fa-info-circle',
                                        buttons:{
                                            确定:function(){
                                                window.location.reload();
                                                /* $("#open1").html("订阅审核中");*/
                                            }
                                        },

                                    });
                                }else{
                                    $.alert({
                                        title: '提示信息',
                                        content: '订阅失败!',
                                        icon: 'fa fa-info-circle',
                                        buttons:{
                                            确定:function(){}
                                        },

                                    });

                                }
                            },
                            error : function(data, status, e) {
                                $.alert({
                                    title: '提示信息',
                                    content: '订阅失败!',
                                    icon: 'fa fa-info-circle',
                                    buttons:{
                                        确定:function(){}
                                    },

                                });
                            }
                        });

                    },
                },
                取消: function () {
                    //$.alert('你点击了<strong>取消</strong>');
                }
            }
        });
    }
    //订阅详情的modal框
    function openModal3(data) {
        // $('.model_subscribe').addClass("open_modal modal-warning")
        $('.title_body').addClass("open_modal");
        $(".title_body").fadeToggle(5000);
        setTimeout(hidden , 3000);
    }
    function hidden() {
        // setTimeout(closeModal3() , 4000);
        $('.title_body').removeClass("open_modal");
    }
    //取消订阅
    function cancelSubscribe(id) {
        $.confirm({
            title: '提示信息',
            content: '确认要申请取消订阅吗？',
            icon: 'fa fa-question-circle',
            animation: 'scale',
            closeAnimation: 'scale',
            // opacity: 0.5,
            buttons: {
                'confirm': {
                    text: '确定',
                    btnClass: 'btn-blue',
                    action: function () {
                        $.ajax({
                            url : '${pageContext.request.contextPath}/sub/cancelSub',
                            //secureuri : false,
                            dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                            data : {
                                id:id
                            },
                            success : function(data, status) {
                                var arr=data.result;
                                if(arr=="1"){
                                    $.alert({
                                        title: '提示信息',
                                        content: '申请取消订阅成功!',
                                        icon: 'fa fa-info-circle',
                                        buttons:{
                                            确定:function(){
                                                window.location.reload();
                                                /* $("#open1").html("订阅审核中");*/
                                            }
                                        },

                                    });
                                }else{
                                    $.alert({
                                        title: '提示信息',
                                        content: '申请取消订阅失败!',
                                        icon: 'fa fa-info-circle',
                                        buttons:{
                                            确定:function(){}
                                        },

                                    });

                                }
                            },
                            error : function(data, status, e) {
                                $.alert({
                                    title: '提示信息',
                                    content: '申请取消订阅失败!',
                                    icon: 'fa fa-info-circle',
                                    buttons:{
                                        确定:function(){}
                                    },

                                });
                            }
                        });

                    },
                },
                取消: function () {
                    //$.alert('你点击了<strong>取消</strong>');
                }
            }
        });
    }

    //显示分数
    $(".atar_Show p").each(function(index, element) {
        var num=$(this).attr("tip");
        var www=num*2*16;
        $(this).css("width",www);
    });
    function downServiceFile() {
        var id=$("#id2").val();
        window.location.href="${pageContext.request.contextPath}/service/downServiceFile?id="+id;
    };

</script>

