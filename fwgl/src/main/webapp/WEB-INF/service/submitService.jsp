<%--
  Created by IntelliJ IDEA.
  User: hdd
  Date: 2020/8/9
  Time: 10:50
  To change this template use File | Settings | File Templates.
--%>
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
    <link href="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
       <!-- Ionicons 2.0.0 -->
    <link href="${pageContext.request.contextPath}/css/ionicons.min.css/" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/laydate/laydate.js"></script>

</head>
<body style="position: relative;min-height: 730px">
<div class="zy_right_con">
    <!-- 内容展示块-->
    <div style="width: 100%;position: relative;">
        <h3>服务挂载管理</h3>

        <input type="hidden" value="${findType}" id="findType">

        <div class="search_div">
            <select class="form-controll" id="selectType">
                <option value="0">选择搜索</option>
                <option value="1">服务名称 </option>
                <option value="2">目录名称 </option>
                <option value="3">注册时间 </option>
            </select>
            <input type="text" class="search-input" id="searchName"  value="${name}" autocomplete="off" />
            <input type="text" class="search-input" id="logDate" placeholder="选择时间范围" value="${time}" autocomplete="off" style="float: left;">
            <button class="butFind" onclick="search(this)" id="search">查询</button>
        </div>

        <button type="button" id="btn_add" name="btn_add" class="btn btn-info" title="刷新" style="margin-left:auto;position:absolute;top: 0;right: 0;bottom: 8px; " onclick="reload();">
            <i class="glyphicon glyphicon-refresh"></i>&nbsp;刷新
        </button>
        <hr style="border-top: 3px solid  #00a2e9;margin-top: 6px;margin-bottom: 0px;">
    </div>
        <div class="change_box"  >
            <table class="table-striped">
                <thead>
                <tr>
                    <td>服务名称</td>
                    <td>目录名称</td>
                    <td>版本</td>
                    <td>服务地址</td>
                    <td>注册日期</td>
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
                        <td>${serviceInfo.categoryName}</td>
                        <td>${serviceInfo.version}</td>
                        <td style="max-width: 200px;">
                            <div class="sub_font"> ${serviceInfo.address}</div>
                        </td>
                        <td>${serviceInfo.createTime}</td>
                        <td>
                            <c:choose>
                                <c:when test="${serviceInfo.status eq 1}">
                                    <span class="label label-default">未审核</span>
                                </c:when>
                                <c:when test="${serviceInfo.status eq 3}">
                                    <span class="label label-warning">未通过</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="label label-info">待挂载</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="todo-list">
                            <div class="tools">
                            <c:if test="${(serviceInfo.status eq 0 or serviceInfo.status eq 3) and loginUser.role eq 2}">
                                <span class="iconfont icon-guazai" title="申请挂载" onclick="submitApply('${serviceInfo.id}')"></span>
                            </c:if>
                            <c:if test="${serviceInfo.status eq 1 and loginUser.role eq 3}">
                                <span class="iconfont icon-shenhejieguo" title="审核" onclick="audit('${serviceInfo.id}')"></span>
                            </c:if>
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
                <button class="btn btn-info mini" onclick="goNext(1);"><i class="fa fa-home"></i>&nbsp;首页</button>
            </c:if>
            <c:if test="${curPage!=1 and totalPage gt 1}">
                <button class="btn btn-info mini" onclick="goNext('${curPage-1}');"><i class="fa fa-angle-left" aria-hidden="true"></i>&nbsp;上一页</button>
            </c:if>
            <c:if test="${curPage!=totalPage and totalPage gt 1}">
                <button class="btn btn-info mini" onclick="goNext('${curPage+1}');">下一页&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-right" aria-hidden="true"></i></button>
            </c:if>
            <c:if test="${totalPage gt 1}">
                <button class="btn btn-info mini" onclick="goNext('${totalPage}');">末页&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-double-right" aria-hidden="true"></i></button>
            </c:if>
        </div>
    </div>
    </div>


    <div class="modal fade bs-example-modal-lg" id="auditModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width:350px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">服务挂载申请审核</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <input type="hidden" id="Sid"  class="form-control">
                    </div>
                    <div class="form-group">
                        <div class="radio">
                            <label>
                                <input type="radio" name="radio" id="accept" value="1" checked>
                                同意
                            </label>&nbsp;&nbsp;&nbsp;
                            <label>
                                <input type="radio" name="radio" id="reject" value="2">
                                拒绝
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="reason">拒绝理由</label>
                        <textarea name="reason" id="reason" cols="15" rows="3" class="form-control" placeholder="请填写拒绝理由(20字以内)" disabled="true" maxlength="20"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="close2" name="close2" class="btn btn-secondary" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                    <button type="button" id="btn_audit" onclick="auditApply()" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>保存</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade bs-example-modal-lg" id="unloadModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width:500px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="infoId">拒绝详情</h4>
                </div>
                <div class="modal-body box">
                    <div align="center">
                       <table id="unloadInfo" class="table  dataTable">
                           <tr>
                               <th class="text-center">序号</th>
                               <th class="text-center">拒绝理由</th>
                               <th class="text-center">拒绝时间</th>
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

    <script src="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.js "></script>

    <script>
        function reload() {
            window.location.reload();
        }
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
                $("#searchName").attr("placeholder","请输入服务名称")
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

        /* 分页 */
        function goNext(pageNo){
            var findType = $("#findType").val();
            if(findType == 0){
                window.location.href="${pageContext.request.contextPath}/submitService?pageNo="+pageNo+"&findType=0&pageSize="+$("#pageSize").val();
            }else if(findType == 1){
                let searchName = $("#searchName").val();
                window.location.href="${pageContext.request.contextPath}/submitService?name="+searchName+"&findType=1&pageNo="+pageNo+"&pageSize="+$("#pageSize").val();
            }else if(findType == 2){
                let searchName = $("#searchName").val();
                window.location.href="${pageContext.request.contextPath}/submitService?name="+searchName+"&findType=2&pageNo="+pageNo+"&pageSize="+$("#pageSize").val();
            }else if(findType == 3){
                var time = $("#logDate").val();
                window.location.href="${pageContext.request.contextPath}/submitService?time="+time+"&findType=3&pageNo="+pageNo+"&pageSize="+$("#pageSize").val();
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

            $('#detailModal').modal('show');
        }

        function audit(id) {
            $("#Sid").val(id);
            $("#auditModal").modal('show');
        }

        $("#close2").click(function () {
            $("#auditModal").modal('hide');
        })

        $("#accept").click(function () {
            $("#reason").attr("disabled", true);
        });
        $("#reject").click(function () {
            $("#reason").removeAttr("disabled");
        });

        function auditApply() {
            var Sid = $("#Sid").val();
            var reason = $("#reason").val();
            var result = $("input[name='radio']:checked").val();
            var auditType = 1;
            $.confirm({
                title: '提示信息',
                content: '确认要提交吗？',
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
                                url : '${pageContext.request.contextPath}/serviceAudit/saveAudit',
                                //secureuri : false,
                                dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                                data : {
                                    Sid:Sid,
                                    reason:reason,
                                    result:result,
                                    auditType:auditType

                                },
                                success : function(data, status) {
                                    if(data=="1"){
                                        $.alert({
                                            title: '提示信息',
                                            content: '提交成功!',
                                            icon: 'fa fa-info-circle',
                                            buttons:{
                                                确定:function(){
                                                    window.location.reload();
                                                }
                                            },

                                        });
                                    }else{
                                        $.alert({
                                            title: '提示信息',
                                            content: '提交失败!',
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
                                        content: '请求失败!',
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

        function submitApply(id) {
            $.confirm({
                title: '提示信息',
                content: '确认要申请挂载服务吗？',
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
                                url : '${pageContext.request.contextPath}/service/applyService',
                                //secureuri : false,
                                dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                                data : {
                                    id:id,
                                    type:1
                                },
                                success : function(data, status) {
                                    if(data=="1"){
                                        $.alert({
                                            title: '提示信息',
                                            content: '申请挂载成功!',
                                            icon: 'fa fa-info-circle',
                                            buttons:{
                                                确定:function(){
                                                    window.location.reload();
                                                }
                                            },

                                        });
                                    }else{
                                        $.alert({
                                            title: '提示信息',
                                            content: '申请挂载失败!',
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
                                        content: '申请挂载失败!',
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
        /* 拒绝详情 */
        function unloadInfo(id) {
            $("#infoId").val(id);
            $.ajax({
                url : "${pageContext.request.contextPath}/serviceAudit/submitInfo",
                async : true,
                type : "POST",
                dataType : "text",
                data : {
                    id:id
                },
                success : function(data) {
                    console.log("data="+data);
                    showUnloadModel(data);
                },
                error : function () {
                    console.log("失败")
                }
            });
        }

        function showUnloadModel(data) {
            /* 将字符串拆分为数字然后写入 unloadModel*/
            $(".auditInfos").remove();
            console.log("dataModel="+data);
            var audits = data.split(",;");
            console.log("dataModel="+audits);
            var i = 0;var j = 1;
            for(;i<audits.length;i++,j++){
                let tr = "<tr class='auditInfos'><td class=\"text-center\">"+j+"</td><td class=\"text-center\">"+audits[i]+"</td><td class=\"text-center\">"+audits[i+1]+"</td></tr>"
                $("#unloadInfo").append(tr);
                i++;
            }
            $("#unloadModel").modal('show');
        }

        $("closeUn").click(function () {
            $("#unloadModel").modal('hide');
        })

        /***********  8-13 查询  findType=1 :名称模糊查询  findType=2 类别查询**********/
        function search(obj) {
            let findType = $("#selectType").val();
            let searchName = $("#searchName").val();
            console.log("findType="+findType+";searchName="+searchName);
            if(findType==0){
                $.alert({
                    title: '提示信息！',
                    content: '请选择查询类型!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){
                            $('#uploadModal').modal('hide');
                        }
                    },
                });
            }else{
                if(searchName.replace(/(^\s*)|(\s*$)/g, "").length ==0&&findType!=3){
                    $.alert({
                        title: '提示信息！',
                        content: '查询内容不能为空!',
                        icon: 'fa fa-info-circle',
                        buttons:{
                            确定:function(){
                                $('#uploadModal').modal('hide');
                            }
                        },
                    });
                }else {
                    if(findType==1){//根据名称查询
                        window.location.href="${pageContext.request.contextPath}/submitService?name="+searchName+"&findType=1&pageNo=1&pageSize="+$("#pageSize").val();
                    }else if(findType == 2){
                        window.location.href="${pageContext.request.contextPath}/submitService?name="+searchName+"&findType=2&pageNo=1&pageSize="+$("#pageSize").val();
                    }else if(findType == 3){
                        let time = $("#logDate").val();
                        if(time.replace(/(^\s*)|(\s*$)/g, "").length ==0){
                            $.alert({
                                title: '提示信息！',
                                content: '请选择时间范围!',
                                icon: 'fa fa-info-circle',
                                buttons:{
                                    确定:function(){
                                        $('#uploadModal').modal('hide');
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
                            window.location.href="${pageContext.request.contextPath}/submitService?time="+time+"&findType=3&pageNo=1&pageSize="+$("#pageSize").val();
                        }
                    }
                }
            }
        }


        /* 时间查询  findType=3 时间查询 */
        laydate.render({
            elem: '#logDate', //指定元素
            range: true,
            theme: '#00c0ef',//主题显示
            trigger: 'click',// 事件类型
            /*done: function(value, date, endDate){
                if(value!=""){
                    console.log("执行按时间查询：value"+value);

                }else {
                    $("#findType").val(0);
                }
            }*/
        });

        function getNowFormatDate() {
            var date = new Date();
            var seperator1 = "-";
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            var currentdate = year + seperator1 + month + seperator1 + strDate;
            return currentdate;
        }
        function downServiceFile(){
            var id=$("#id2").val();
            window.location.href="${pageContext.request.contextPath}/service/downServiceFile?id="+id;
        };
        $("#pageSize").change(function(){
            var pageSize=$("#pageSize").val();
            window.location.href="${pageContext.request.contextPath}/submitService?findType=0&pageNo=1&pageSize="+pageSize;
        });
    </script>

</body>
</html>

