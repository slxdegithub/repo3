<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>

    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
    <meta charset="utf-8">
    <meta name="applicable-device" content="pc,mobile">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta http-equiv="Cache-Control" content="no-transform" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userCenter.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iconfont.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
    <%--弹窗三件套--%>
    <link href="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.js "></script>
    <%--日期插件--%>
    <script src="${pageContext.request.contextPath}/laydate/laydate.js"></script>
    <!-- Ionicons 2.0.0 -->
    <link href="${pageContext.request.contextPath}/css/ionicons.min.css/" rel="stylesheet" type="text/css" />

</head>
<body style="position: relative;min-height: 730px">
<div class="zy_right_con">
    <!-- 内容展示块-->
    <div style="width: 100%;position: relative;">
        <h3>我审核的服务列表</h3>
        <%--搜索框--%>
        <input type="hidden" value="${findType}" id="findType">
        <div class="right_btn_div">
            <div class="search">
                <select class="form-controll" id="selectType">
                    <option value="0">选择搜索</option>
                    <option value="1">服务名称 </option>
                    <option value="2">服务目录 </option>
                    <option value="3">审核时间 </option>
                </select>
                <input type="text" class="search-input" id="searchName"  value="${name}" autocomplete="off" />
                <input type="text" class="search-input" id="logDate" placeholder="选择时间范围" value="${time}" autocomplete="off" style="float: left;">
                <button class="butFind" onclick="search(this)" id="search">查询</button>
            </div>
            <button type="button" id="btn_add" name="btn_add" class="btn btn-info" title="刷新"  onclick="reload();">
                <i class="glyphicon glyphicon-refresh"></i>&nbsp;刷新
            </button>
        </div>
        <%--搜索框end--%>

        <hr style="border-top: 3px solid  #00a2e9;margin-top: 6px;margin-bottom: 0px;">
    </div>
        <div class="change_box"  >
            <table class="table-striped">
                <thead>
                <tr>
                    <td>服务名称</td>
                    <td>服务地址</td>
                    <td>目录名称</td>
                    <td>版本</td>
                    <td>申请人</td>
                    <td>申请时间</td>
                    <td>状态</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${serviceInfoList}" var="serviceInfo" varStatus="status">
                    <tr>
                        <td>
                            <a href="#" onclick="showServiceInfo('${serviceInfo.id}');" title="查看服务注册详情">
                                    ${serviceInfo.name}
                            </a>
                        </td>
                        <td>${serviceInfo.address}</td>
                        <td>${categoryList[status.index].cname}</td>
                        <td>${serviceInfo.version}</td>
                        <td>${subscribeList[status.index].subscriber}</td>
                        <td>${subscribeList[status.index].applyTime}</td>
                        <td>
                            <c:choose>
                                <c:when test="${subscribeList[status.index].status eq 1}">
                                    申请订阅
                                </c:when>
                                <c:when test="${subscribeList[status.index].status eq 2}">
                                    订阅成功
                                </c:when>
                                <c:when test="${subscribeList[status.index].status eq 3}">
                                    订阅失败
                                </c:when>
                                <c:when test="${subscribeList[status.index].status eq 4}">
                                    申请取消订阅
                                </c:when>
                                <c:when test="${subscribeList[status.index].status eq 5}">
                                    取消订阅成功
                                </c:when>
                                <c:otherwise>
                                    取消订阅失败
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="todo-list">
                            <div class="tools">
                            <span class="iconfont icon-shenhe" style=" color: #1945dd;cursor:pointer;font-weight: bold;font-size: 15px;" title="查看审核结果" onclick="queryAudit('${subscribeList[status.index].id}')"></span>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    <div class="page_btn" style="width: 100%;position: absolute;bottom: 0px;">
        <span>当前第${curPage}页, 共${totalPage}页</span>,
        每页
        <select name="Table_length" aria-controls="Table_0" id="pageSize">
            <c:choose>
                <c:when test="${pageSize eq 15}">
                    <option value="10">10</option>
                    <option value="15" selected>15</option>
                    <option value="20">20</option>
                </c:when>
                <c:when test="${pageSize eq 20}">
                    <option value="10">10</option>
                    <option value="15">15</option>
                    <option value="20" selected>20</option>
                </c:when>
                <c:otherwise>
                    <option value="10" selected>10</option>
                    <option value="15">15</option>
                    <option value="20">20</option>
                </c:otherwise>
            </c:choose>
        </select>
        条数据,共${totalNum} 条数据
        <div class="btn-group btn-group-sm" style="float:right;margin-bottom: 10px;" data-toggle="buttons">
            <c:if test="${totalPage gt 1}">
                <button class="btn btn-info mini" onclick="homePage();"><i class="fa fa-home"></i>&nbsp;首页</button>
            </c:if>
            <c:if test="${curPage!=1 and totalPage gt 1}">
                <button class="btn btn-info mini" onclick="previousPage('${curPage-1}');"><i class="fa fa-angle-left" aria-hidden="true"></i>&nbsp;上一页</button>
            </c:if>
            <c:if test="${curPage!=totalPage and totalPage gt 1}">
                <button class="btn btn-info mini" onclick="nextPage('${curPage+1}');">下一页&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-right" aria-hidden="true"></i></button>
            </c:if>
            <c:if test="${totalPage gt 1}">
                <button class="btn btn-info mini" onclick="lastPage('${totalPage}');">末页&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-double-right" aria-hidden="true"></i></button>
            </c:if>
        </div>
    </div>
    </div>
<%--查看的modal--%>
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
                    <button type="button" id="btn_download" class="btn btn-info" style="color: #444" onclick="downServiceFile();"><span class="iconfont icon-wendang" aria-hidden="true"></span>下载附件</button>
                </div>
            </div>
        </div>
    </div>
</div>

    <div class="modal fade bs-example-modal-lg" id="auditDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width:800px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="infoId">审核详情</h4>
                </div>
                <div class="modal-body box">
                    <div align="center">
                       <table id="unloadInfo" class="table  dataTable">
                           <tr>
                               <th class="text-center">序号</th>
                               <th class="text-center">审核类型</th>
                               <th class="text-center">审核结果</th>
                               <th class="text-center">拒绝理由</th>
                               <th class="text-center">审核时间</th>
                           </tr>
                       </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="closeUn"  class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function reload() {
            window.location.reload();
        }

        /* 分页 */
        function homePage(){
            var findType=$("#findType").val();
            if(findType=="0"){
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo=1&findType="+findType+"&pageSize="+$("#pageSize").val();
            }else if(findType=="1"||findType=="2"){
                var searchName=$("#searchName").val();
                if(searchName==''){
                    if(findType=="1") {
                        $.alert({
                            title: '提示信息',
                            content: '服务名称不能为空!',
                            icon: 'fa fa-info-circle',
                            buttons: {
                                确定: function () {

                                }
                            },

                        });
                    }else{
                        $.alert({
                            title: '提示信息',
                            content: '目录名称不能为空!',
                            icon: 'fa fa-info-circle',
                            buttons: {
                                确定: function () {

                                }
                            },

                        });
                    }
                    return;
                }
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo=1&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
            }else{
                var logDate=$("#logDate").val();
                if(logDate==''){
                    $.alert({
                        title: '提示信息',
                        content: '搜索的时间范围不能为空!',
                        icon: 'fa fa-info-circle',
                        buttons:{
                            确定:function(){

                            }
                        },

                    });
                    return;
                }
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo=1&findType="+findType+"&range="+logDate+"&pageSize="+$("#pageSize").val();
            }
        }
        function previousPage(pageNo){
            var findType=$("#findType").val();
            if(findType=="0"){
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
            }else if(findType=="1"||findType=="2"){
                var searchName=$("#searchName").val();
                if(searchName==''){
                    if(findType=="1") {
                        $.alert({
                            title: '提示信息',
                            content: '服务名称不能为空!',
                            icon: 'fa fa-info-circle',
                            buttons: {
                                确定: function () {

                                }
                            },

                        });
                    }else{
                        $.alert({
                            title: '提示信息',
                            content: '目录名称不能为空!',
                            icon: 'fa fa-info-circle',
                            buttons: {
                                确定: function () {

                                }
                            },

                        });
                    }
                    return;
                }
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo="+pageNo+"&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
            }else{
                var logDate=$("#logDate").val();
                if(logDate==''){
                    $.alert({
                        title: '提示信息',
                        content: '搜索的时间范围不能为空!',
                        icon: 'fa fa-info-circle',
                        buttons:{
                            确定:function(){

                            }
                        },

                    });
                    return;
                }
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo="+pageNo+"&findType="+findType+"&range="+logDate+"&pageSize="+$("#pageSize").val();
            }
        }
        function nextPage(pageNo){
            var findType=$("#findType").val();
            if(findType=="0"){
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
            }else if(findType=="1"||findType=="2"){
                var searchName=$("#searchName").val();
                if(searchName==''){
                    if(findType=="1") {
                        $.alert({
                            title: '提示信息',
                            content: '服务名称不能为空!',
                            icon: 'fa fa-info-circle',
                            buttons: {
                                确定: function () {

                                }
                            },

                        });
                    }else{
                        $.alert({
                            title: '提示信息',
                            content: '目录名称不能为空!',
                            icon: 'fa fa-info-circle',
                            buttons: {
                                确定: function () {

                                }
                            },

                        });
                    }
                    return;
                }
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo="+pageNo+"&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
            }else{
                var logDate=$("#logDate").val();
                if(logDate==''){
                    $.alert({
                        title: '提示信息',
                        content: '搜索的时间范围不能为空!',
                        icon: 'fa fa-info-circle',
                        buttons:{
                            确定:function(){

                            }
                        },

                    });
                    return;
                }
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo="+pageNo+"&findType="+findType+"&range="+logDate+"&pageSize="+$("#pageSize").val();
            }
        }
        function lastPage(pageNo){
            var findType=$("#findType").val();
            if(findType=="0"){
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
            }else if(findType=="1"||findType=="2"){
                var searchName=$("#searchName").val();
                if(searchName==''){
                    if(findType=="1") {
                        $.alert({
                            title: '提示信息',
                            content: '服务名称不能为空!',
                            icon: 'fa fa-info-circle',
                            buttons: {
                                确定: function () {

                                }
                            },

                        });
                    }else{
                        $.alert({
                            title: '提示信息',
                            content: '目录名称不能为空!',
                            icon: 'fa fa-info-circle',
                            buttons: {
                                确定: function () {

                                }
                            },

                        });
                    }
                    return;
                }
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo="+pageNo+"&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
            }else{
                var logDate=$("#logDate").val();
                if(logDate==''){
                    $.alert({
                        title: '提示信息',
                        content: '搜索的时间范围不能为空!',
                        icon: 'fa fa-info-circle',
                        buttons:{
                            确定:function(){

                            }
                        },

                    });
                    return;
                }
                window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?pageNo="+pageNo+"&findType="+findType+"&range="+logDate+"&pageSize="+$("#pageSize").val();
            }
        }

        function showServiceInfo(id){
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
            //$("#stype2").attr("value", "RPC");
            $("#stype2").attr("value",data.serviceType.name);
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

            $('#detailModal').modal('show');
        }
        $("#accept").click(function () {
            $("#reason").attr("disabled", true);
        });
        $("#reject").click(function () {
            $("#reason").removeAttr("disabled");
        });

        function queryAudit(id){
            $.ajax({
                url : "${pageContext.request.contextPath}/sub/getSubscribeAuditList",
                async : true,
                type : "POST",
                dataType : "json",
                data : {
                    "id" : id
                },
                // 成功后开启模态框
                success : showAuditDetail,
                error : function() {
                    alert("请求失败");
                }
            });
        }

        function showAuditDetail(data) {
            $("#unloadInfo tr:not(:first)").remove();
            for(i=0;i<data.subscribeAuditList.length;i++){
                var content="<tr><td align='center'>"+(i+1).toString()+"</td>";
                if(data.subscribeAuditList[i].type==1){
                    content=content+"<td align='center'>订阅申请审核</td>";
                }else{
                    content=content+"<td align='center'>取消订阅申请审核</td>";
                }
                if(data.subscribeAuditList[i].result==1){
                    content=content+"<td align='center'>同意</td>";
                }else if(data.subscribeAuditList[i].result==2){
                    content=content+"<td align='center'>拒绝</td>";
                }else{
                    content=content+"<td align='center'>未审核</td>";
                }
               content=content+"<td align='center'>"+ data.subscribeAuditList[i].reason +"</td>";
               content=content+"<td align='center'>"+ data.subscribeAuditList[i].auditTime +"</td></tr>";
               $('#unloadInfo').append(content);
            }
            $('#auditDetailModal').modal('show');
        }
        /* 搜索 --start-- */
        $(function () {
            let type = $("#findType").val();
            console.log("type="+type);
            $("#selectType option[value='"+type+"']").attr("selected", "selected");
            if(type==0){
                $("#searchName").css("display","block");
                $("#searchName").attr("disabled","disabled");
                $("#logDate").css("display","none");
            }else if (type==1){
                $("#searchName").css("display","block");
                $("#searchName").removeAttr("disabled");
                $("#searchName").attr("placeholder","请输入查询名称")
                $("#logDate").css("display","none");
            } else if(type==2){
                $("#searchName").css("display","block")
                $("#searchName").removeAttr("disabled");
                $("#searchName").attr("placeholder","请输入目录名称")
                $("#logDate").css("display","none");
            }else if(type==3){
                $("#searchName").css("display","none")
                $("#logDate").css("display","block");
            }
        });
        $("#selectType").change(function () {
            let type = $("#selectType").val();
            if(type==0){
                $("#searchName").css("display","block");
                $("#searchName").attr("disabled","disabled");
                $("#searchName").val("");
                $("#searchName").attr("placeholder","")
                $("#logDate").css("display","none");
            }else if (type==1){
                $("#searchName").css("display","block")
                $("#searchName").removeAttr("disabled");
                $("#searchName").attr("placeholder","请输入名称")
                // $("#searchName").val("");
                $("#logDate").css("display","none");
            } else if(type==2){
                $("#searchName").css("display","block");
                $("#searchName").removeAttr("disabled");
                // $("#searchName").val("");
                $("#searchName").attr("placeholder","请输入目录名称")
                $("#logDate").css("display","none");
            }else if(type==3){
                $("#searchName").css("display","none")
                $("#logDate").css("display","block");
            }
        });
        /* 时间查询  findType=3 时间查询 */
        laydate.render({
            elem: '#logDate', //指定元素
            range: true,
            theme: '#00c0ef',//主题显示
            trigger: 'click',// 事件类型
        });
        function search(obj) {
            let findType = $("#selectType").val();
            let searchName = $("#searchName").val();
            console.log("findType="+findType+";searchName="+searchName);
            if(findType==0){
                $.alert({
                    title: '提示信息！',
                    content: '请选择查询类型！！!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){
                        }
                    },
                });
            }else{
                if(searchName.replace(/(^\s*)|(\s*$)/g, "").length ==0&&findType!=3){
                    $.alert({
                        title: '提示信息！',
                        content: '查询内容不能为空！！!',
                        icon: 'fa fa-info-circle',
                        buttons:{
                            确定:function(){
                            },
                        }
                    });
                }else {
                    if(findType==1){//根据名称查询
                        window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?name="+searchName+"&findType=1&pageNo=1&pageSize="+$("#pageSize").val();
                    }else if(findType == 2){
                        window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?name="+searchName+"&findType=2&pageNo=1&pageSize="+$("#pageSize").val();
                    }else if(findType == 3){
                        let time = $("#logDate").val();
                        if(time.replace(/(^\s*)|(\s*$)/g, "").length ==0){
                            $.alert({
                                title: '提示信息！',
                                content: '请选择时间！！!',
                                icon: 'fa fa-info-circle',
                                buttons:{
                                    确定:function(){
                                    }
                                },
                            });
                        }else{
                            startDate=time.substring(0,10);
                            endDate=time.substring(13);
                            //alert(startDate);
                            if(!startDate.match(/^((?:19|20)\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/)){
                                $.alert({
                                    title: '提示信息！',
                                    content: '对不起，您输入的日期格式不正确!',
                                    icon: 'fa fa-info-circle',
                                    buttons:{
                                        确定:function(){
                                        }
                                    },
                                });
                                return;
                            }
                            if(!endDate.match(/^((?:19|20)\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/)){
                                $.alert({
                                    title: '提示信息！',
                                    content: '对不起，您输入的日期格式不正确!',
                                    icon: 'fa fa-info-circle',
                                    buttons:{
                                        确定:function(){
                                        }
                                    },
                                });
                                return;
                            }
                            window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?range="+time+"&findType=3&pageNo=1&pageSize="+$("#pageSize").val();
                        }
                    }
                }
            }
        }
        /* 搜索 --end-- */
        function downServiceFile() {
            var id=$("#id2").val();
            window.location.href="${pageContext.request.contextPath}/service/downServiceFile?id="+id;
        };

        $("#pageSize").change(function(){
            var pageSize=$("#pageSize").val();
            window.location.href="${pageContext.request.contextPath}/mySubscribeAuditList?findType=0&pageNo=1&pageSize="+pageSize;
        });
    </script>

</body>
</html>

