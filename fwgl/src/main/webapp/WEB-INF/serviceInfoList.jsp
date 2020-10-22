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
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/bootstrap/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userCenter.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iconfont.css" type="text/css">

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <%--下拉列表模糊查询样式--%>
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-select.css" rel="stylesheet">
    <%--下拉列表模糊查询js--%>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-select.js"></script>

    <link href="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <%--日期插件--%>
    <script src="${pageContext.request.contextPath}/laydate/laydate.js"></script>
       <!-- Ionicons 2.0.0 -->
    <link href="${pageContext.request.contextPath}/css/ionicons.min.css/" rel="stylesheet" type="text/css" />

</head>
<body style="position: relative;min-height: 730px">
<div class="zy_right_con">
    <!-- 内容展示块-->
    <div style="width: 100%;position: relative;">
        <h3>服务注册管理</h3>
        <%--搜索框--%>
        <input type="hidden" value="${findType}" id="findType">
        <div class="right_btn_div">
            <div class="search">
                <select class="form-controll" id="selectType">
                    <option value="0">选择搜索</option>
                    <option value="1">服务名称 </option>
                    <option value="2">服务目录 </option>
                    <option value="3">创建时间 </option>
                </select>
                <input type="text" class="search-input" id="searchName"  value="${name}" autocomplete="off" />
                <input type="text" class="search-input" id="logDate" placeholder="选择时间范围" value="${time}" autocomplete="off" style="float: left;">
                <button class="butFind" onclick="search(this)" id="search">查询</button>
            </div>
            <c:if test="${loginUser.role eq 2}">
                <button type="button" id="btn_add" name="btn_add" class="btn btn-info" title="新建"   onclick="addInfo();">
                    <i class="fa fa-plus-square"></i>&nbsp;注册服务
                </button>
            </c:if>
        </div>
        <hr style="border-top: 3px solid #00a2e9;margin-top: 6px;margin-bottom: 0px;">
    </div>

    <%--内容展示块一 类别管理 --%>
    <div class="change_box"  >
        <table class="table-striped">
            <thead>
            <tr>
                <td>名称</td>
                <td>服务类型</td>
                <td>公开类型</td>
                <td>版本号</td>
                <td>状态</td>
                <td>所属目录</td>
                <td>注册时间</td>
                <td>操作</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach varStatus="status" items="${serviceInfoList}" var="serviceInfo">
                <tr>
                    <td>
                        <a href="#" onclick="showServiceInfo('${serviceInfo.id}');" title="查看服务注册详情">
                                ${serviceInfo.name}
                        </a>
                    </td>
                    <td>
                       ${dictionaryList[status.index].name}
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${serviceInfo.openType eq 1}">
                                公开
                            </c:when>
                            <c:when test="${serviceInfo.openType eq 2}">
                                半公开
                            </c:when>
                            <c:otherwise>
                                保密
                            </c:otherwise>

                        </c:choose>
                    </td>
                    <td>${serviceInfo.version}</td>
                    <td><span class="label label-default">注册服务</span></td>
                    <td>${categoryList[status.index].cname}</td>
                    <td>${serviceInfo.createTime}</td>
                    <td class="todo-list">
                        <div class="tools">
                            <span class="iconfont icon-bianji" title="编辑接口信息" onclick="editServiceInfo('${serviceInfo.id}') "></span>
                            <span class="iconfont icon-shanchu" title="删除接口信息" onclick="delServiceInfo('${serviceInfo.id}')"></span>
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
<%--修改的modal--%>
<div class="modal fade bs-example-modal-lg" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal_large" role="document"  >
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">修改接口注册信息</h4>
            </div>
            <div class="modal-body box">
                <input type="hidden" id="id">
                <div align="center"  >
                    <table class="modal_table">
                        <tr>
                            <td class="left_td"> 接口名称 </td>
                            <td><input type="text" autocomplete="off" id="cname1" style="width:100%;height:26px;"></td>
                            <td class="d_td">服务类型</td>
                            <td>
                                <select id="stype1" name="stype" style="width:100%;height:26px;">
                                  <%--  <option value="1" selected>RPC</option>
                                    <option value="2">SOAP</option>
                                    <option value="3">REST</option>--%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">协议类型</td>
                            <td>
                                <select id="ptype1"  style=" width:100%;height:26px;">
                                  <%--  <option value="http" selected>http</option>
                                    <option value="https">https</option>--%>
                                </select>
                            </td>
                            <td class="d_td">请求类型 </td>
                            <td>
                                <select id="rtype1"  style=" width:100%;height:26px;">
                                    <option value="POST" selected>POST</option>
                                    <option value="GET">GET</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="d_td">版本号</td>
                            <td>
                                <input type="text" autocomplete="off" id="version1" style="width:100%;height:26px;">
                                <div id="pic1"></div>
                            </td>
                            <td class="d_td">公开类型 </td>
                            <td width="120px">
                                <select id="otype1"  style="width:100%;height:26px;">
                                    <option value="1" selected>公开</option>
                                    <option value="2">半公开</option>
                                    <option value="3">保密</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td" >一级目录</td>
                            <td>
                                <div>
                                    <select class="form-control selectpicker show-tick" data-live-search="true" id="firstCtype1">
                                    </select>
                                </div>
                            </td>
                            <td class="d_td">二级目录</td>
                            <td>
                                <div  >
                                    <select class="form-control selectpicker show-tick" data-live-search="true" id="secondCtype1">
                                        <option value="0">===请选择===</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">请求地址 </td>
                            <td colspan="3">
                                <input type="text" autocomplete="off" id="address1" style="width:100%;height:26px;">
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">功能描述</td>
                            <td colspan="3">
                                <textarea id="desc1" autocomplete="off" rows="2" style="width: 100%; "></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">附件上传</td>
                            <td colspan="3">
                                <label for="uploadFile1" class="ui_upload">上传文件</label>
                                <input type="file" multiple  id="uploadFile1" name="uploadFile" style="width: 100%;outline:none" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="box  modal_table2">
                <div class="box-header ">
                    请求参数信息
                    <div class="btn_tools">
                        <i onclick="addReq1()" class="glyphicon glyphicon-plus-sign" title="表格添加一行"></i>
                        <i class='glyphicon glyphicon-minus-sign' title='删除最后一行' onclick="deleteLastRow1('req1')"></i>
                    </div>
                </div>
                <div class="box-body ">
                    <table id="req1" class="col-xs-12 table table-bordered table-striped  ">
                        <thead>
                        <tr>
                            <th>参数名称</th>
                            <th>参数类型</th>
                            <th>备注信息</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box   modal_table3">
                <div class="box-header ">
                    响应参数信息
                    <div class="btn_tools">
                        <i onclick="addResp1()" class="glyphicon glyphicon-plus-sign" title="表格添加一行"></i>
                        <i class='glyphicon glyphicon-minus-sign' title='删除表格最后一行' onclick="deleteLastRow1('resp1')"></i>
                    </div>
                </div>
                <div class="box-body ">
                    <table class="col-xs-12 table table-bordered table-striped" id="resp1">
                        <thead>
                        <tr>
                            <th>参数名称</th>
                            <th>参数类型</th>
                            <th>备注信息</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="close1" name="close1" class="btn btn-default" data-dismiss="modal" onclick="window.location.reload();"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                <button type="button" id="btn_update" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>更新</button>
            </div>
        </div>
    </div>
</div>
<%--注册的mdal--%>
<div class="modal fade bs-example-modal-lg" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal_large" role="document"  >
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
                            <td><input type="text" autocomplete="off" id="cname" style="width:100%;height:26px;"></td>
                            <td class="d_td">服务类型</td>
                            <td>
                                <select id="stype" name="stype" style="width:100%;height:26px;">
                                    <option value="0">===请选择===</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">协议类型</td>
                            <td>
                                <select id="ptype"  style=" width:100%;height:26px;">
                                    <option value="0">===请选择===</option>
                                </select>
                            </td>
                            <td class="d_td">请求类型 </td>
                            <td>
                                <select id="rtype"  style=" width:100%;height:26px;">
                                    <option value="POST" selected>POST</option>
                                    <option value="GET">GET</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="d_td">版本号</td>
                            <td>
                                <input type="text" autocomplete="off" id="version" style="width:100%;height:26px;">
                                <div id="pic"></div>
                            </td>
                            <td class="d_td">公开类型 </td>
                            <td width="120px">
                                <select id="otype"  style="width:100%;height:26px;">
                                    <option value="1" selected>公开</option>
                                    <option value="2">半公开</option>
                                    <option value="3">保密</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td" >一级目录</td>
                            <td>
                                <div>
                                    <select  class="form-control selectpicker" data-live-search="true" id="firstCtype">
                                    </select>
                                </div>
                            </td>
                            <td class="d_td">二级目录</td>
                            <td>
                                <div  >
                                    <select class="form-control selectpicker show-tick" data-live-search="true" id="secondCtype">
                                        <option value='0'>===请选择===</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">请求地址 </td>
                            <td colspan="3">
                                <input type="text" autocomplete="off" id="address" style="width:100%;height:26px;">
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">功能描述</td>
                            <td colspan="3">
                                <textarea id="desc" autocomplete="off" rows="2" style="width: 100%; " maxlength="60" placeholder="最多输入60个字"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="left_td">附件上传</td>
                            <td colspan="3">
                                <label for="uploadFile" class="ui_upload">上传文件</label>
                                <input type="file" multiple  id="uploadFile" name="uploadFile" style="width: 100%;outline:none" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="box  modal_table2">
                <div class="box-header  ">
                    请求参数信息
                    <div class="btn_tools">
                        <i onclick="addReq()" class="glyphicon glyphicon-plus-sign" title="表格添加一行"></i>
                        <i class='glyphicon glyphicon-minus-sign' title='删除最后一行' onclick="deleteLastRow('req')"></i>
                    </div>
                </div>
                <div class="box-body ">
                    <table id="req" class="col-xs-12 table table-bordered table-striped  ">
                        <thead>
                        <tr>
                            <td>参数名称</td>
                            <td>参数类型</td>
                            <td>备注信息</td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr role="row" class="odd">
                            <td><input type="text"  autocomplete="off" id="reqName1" ></td>
                            <td>
                                <select id="reqType1"  style=" width:100px;height:26px;">
                                    <option value="String" selected>String</option>
                                    <option value="Number">Number</option>
                                    <option value="boolean">boolean</option>
                                    <option value="Object">Object</option>
                                </select>
                            </td>
                            <td><input autocomplete="off" type="text" id="reqBz1" ></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box   modal_table3">
                <div class="box-header  ">
                    响应参数信息
                    <div class="btn_tools">
                        <i onclick="addResp( )" class="glyphicon glyphicon-plus-sign" title="表格添加一行"></i>
                        <i class='glyphicon glyphicon-minus-sign' title='删除表格最后一行' onclick="deleteLastRow('resp')"></i>
                    </div>
                </div>
                <div class="box-body ">
                    <table class="col-xs-12 table table-bordered table-striped" id="resp">
                        <thead>
                        <tr>
                            <td>参数名称</td>
                            <td>参数类型</td>
                            <td>备注信息</td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr role="row" class="odd">
                            <td><input autocomplete="off" type="text" id="respName1" ></td>
                            <td>
                                <select id="respType1" style=" width:100%;height:26px;">
                                    <option value="String" selected>String</option>
                                    <option value="Number">Number</option>
                                    <option value="boolean">boolean</option>
                                    <option value="Object">Object</option>
                                </select>
                            </td>
                            <td><input autocomplete="off" type="text" id="respBz1"  style="width:100%;height:26px;" ></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            <div class="modal-footer">
                <button type="button" id="close" name="close1" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                <button type="button" id="btn_submit" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>注册</button>
            </div>
        </div>
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
                <h4 class="modal-title" id="myModalLabel2">注册接口服务</h4>
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
<script src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>

 <script>
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
             $("#searchName").attr("placeholder","请输入服务名称")
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
      function addInfo(){
          $.getJSON("${pageContext.request.contextPath}/category/getFirstCategoryList",function(data){
              $("#firstCtype").empty();
              let text = "<option value='0'>===请选择===</option>";
              $("#firstCtype").append(text);
              for(i=0;i<data.firstCategoryList.length;i++) {
                  var id =data.firstCategoryList[i].id;
                  var name =data.firstCategoryList[i].cname;
                  // text = "<li data-value='"+name+"'  data-id='"+ id+"'>"+name+"</li>"
                  let text = "<option value='" + data.firstCategoryList[i].id + "'>"+data.firstCategoryList[i].cname+"</option>";
                  $("#firstCtype").append(text);
              }
              $(".selectpicker").selectpicker('refresh');
              $("#stype").empty();
              let stext = "<option value='0'>===请选择===</option>";
              $("#stype").append(text);
              for(i=0;i<data.serviceTypeList.length;i++) {
                  var id =data.serviceTypeList[i].id;
                  var name =data.serviceTypeList[i].name;
                   stext = "<option value='" + id + "'>"+name+"</option>";
                  $("#stype").append(stext);
              }
              $("#ptype").empty();
              let ptext = "<option value='0'>===请选择===</option>";
              $("#ptype").append(text);
              for(i=0;i<data.protocalTypeList.length;i++) {
                  var id =data.protocalTypeList[i].id;
                  var name =data.protocalTypeList[i].name;
                  ptext = "<option value='" + id + "'>"+name+"</option>";
                  $("#ptype").append(ptext);
              }
              $('#addModal').modal('show');
         });
      }
     function homePage(){
         var findType=$("#findType").val();
         if(findType=="0"){
             window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo=1&findType="+findType+"&pageSize="+$("#pageSize").val();
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
             window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo=1&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
         }else{
             var time=$("#logDate").val();
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
                 window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo=1&findType="+findType+"&range="+time+"&pageSize="+$("#pageSize").val();
             }

         }
     }
     function previousPage(pageNo){
         var findType=$("#findType").val();
         if(findType=="0"){
             window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
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
             window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo="+pageNo+"&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
         }else{
             var time=$("#logDate").val();
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
                 window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo="+pageNo+"&findType="+findType+"&range="+time+"&pageSize="+$("#pageSize").val();
             }

         }
     }
     function nextPage(pageNo){
         var findType=$("#findType").val();
         if(findType=="0"){
             window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
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
             window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo="+pageNo+"&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
         }else{
             var time=$("#logDate").val();
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
                 window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo="+pageNo+"&findType="+findType+"&range="+time+"&pageSize="+$("#pageSize").val();
             }

         }
     }
     function lastPage(pageNo){
         var findType=$("#findType").val();
         if(findType=="0"){
             window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
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
             window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo="+pageNo+"&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
         }else{
             var time=$("#logDate").val();
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
                 window.location.href="${pageContext.request.contextPath}/serviceInfoList?pageNo="+pageNo+"&findType="+findType+"&range="+time+"&pageSize="+$("#pageSize").val();
             }

         }
     }
     /*添加请求参数行*/
     function addReq(){
         var tab = document.getElementById("req") ;
         var rows = tab.rows.length ;
         //alert('reqName'+rows+"; reqType"+rows+";reqBz="+rows);
          $('#req').append("<tr role='row' class='even'>" +
              "<td><input type='text' id='reqName"+rows.toString()+"' autocomplete='off'></td>"+
              "<td><select id='reqType"+rows.toString()+"'  style='width:100px;height:26px;'>"+
              "<option value='String' selected>String</option>"+
              "<option value='Number'>Number</option>"+
              "<option value='boolean'>boolean</option>"+
              "<option value='Object'>Object</option>"+
              "</select></td>"+
              "<td ><input type='text' id='reqBz"+rows.toString()+"' autocomplete='off'></td> </tr>"
          );

     }
      function addReq1(){
          var tab = document.getElementById("req1") ;
          var rows = tab.rows.length ;
          //alert('reqName'+rows+"; reqType"+rows+";reqBz="+rows);
          $('.modal_table2 .box-body table tbody').append("<tr role='row' class='even'>" +
              "<td><input type='text' id='reqName1"+rows.toString()+"' autocomplete='off'></td>"+
              "<td><select id='reqType1"+rows.toString()+"'  style='width:100px;height:26px;'>"+
              "<option value='String' selected>String</option>"+
              "<option value='Number'>Number</option>"+
              "<option value='boolean'>boolean</option>"+
              "<option value='Object'>Object</option>"+
              "</select></td>"+
              "<td ><input type='text' id='reqBz1"+rows.toString()+"'  autocomplete='off'></td> </tr>"
          );

      }
    /* 添加响应参数行*/
      function addResp(){
          var tab = document.getElementById("resp") ;
          var rows = tab.rows.length ;
          $('#resp').append("<tr role='row' class='even'>" +
              "<td><input type='text' id='respName"+rows.toString()+"'></td>"+
              "<td  ><select id='respType"+rows.toString()+"' style='width:100px;height:26px;'>"+
              "<option value='String' selected>String</option>"+
              "<option value='Number'>Number</option>"+
              "<option value='boolean'>boolean</option>"+
              "<option value='Object'>Object</option>"+
              "</select></td>"+
              "<td class='del_btn'><input type='text' id='respBz"+rows.toString()+"' ></td> </tr>"
          )
      }
      function addResp1(){
          var tab = document.getElementById("resp1") ;
          var rows = tab.rows.length ;
          $('.modal_table3 .box-body table tbody').append("<tr role='row' class='even'>" +
              "<td><input type='text' id='respName1"+rows.toString()+"'></td>"+
              "<td  ><select id='respType1"+rows.toString()+"' style='width:100px;height:26px;'>"+
              "<option value='String' selected>String</option>"+
              "<option value='Number'>Number</option>"+
              "<option value='boolean'>boolean</option>"+
              "<option value='Object'>Object</option>"+
              "</select></td>"+
              "<td class='del_btn'><input type='text' id='respBz1"+rows.toString()+"' ></td> </tr>"
          )
      }
      //删除接口
     function deleteLastRow(type){
          if(type=='req') {
              var tab = document.getElementById("req") ;
              var rows = tab.rows.length ;
              if(rows>1) {
                  $("#req tr:last").remove();
              }else{
                  $.alert({
                      title: '提示信息',
                      content: '不能删除表头!',
                      icon: 'fa fa-info-circle',
                      buttons:{
                          确定:function(){
                              $("#address").focus();

                          }
                      },

                  });
              }
          }else{
              var tab = document.getElementById("resp") ;
              var rows = tab.rows.length ;
              if(rows>1) {
                  $("#resp tr:last").remove();
              }else{
                  $.alert({
                      title: '提示信息',
                      content: '不能删除表头!',
                      icon: 'fa fa-info-circle',
                      buttons:{
                          确定:function(){

                          }
                      },

                  });
              }
          }
      }
      //删除接口
      function deleteLastRow1(type){
          if(type=='req1') {
              var tab = document.getElementById("req1") ;
              var rows = tab.rows.length ;
              if(rows>1) {
                  $("#req1 tr:last").remove();
              }else{
                  $.alert({
                      title: '提示信息',
                      content: '不能删除表头!',
                      icon: 'fa fa-info-circle',
                      buttons:{
                          确定:function(){

                          }
                      },

                  });
              }
          }else{
              var tab = document.getElementById("resp1") ;
              var rows = tab.rows.length ;
              if(rows>1) {
                  $("#resp1 tr:last").remove();
              }else{
                  $.alert({
                      title: '提示信息',
                      content: '不能删除表头!',
                      icon: 'fa fa-info-circle',
                      buttons:{
                          确定:function(){

                          }
                      },

                  });
              }
          }
      }

      $('#btn_submit').on('click', function() {
          var cname=$("#cname").val();
          if(cname==""){
              $.alert({
                  title: '提示信息',
                  content: '接口名称不能为空!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#cname").focus();

                      }
                  },

              });
              return;
          }
          var stype=$("#stype").val();
          if(stype==0){
              $.alert({
                  title: '提示信息',
                  content: '请选择服务类型!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#stype").focus();

                      }
                  },

              });
              return;
          }
          var otype=$("#otype").val();
          var ctype=$("#ctype").val();
          var ptype=$("#ptype").val();
          if(ptype==0){
              $.alert({
                  title: '提示信息',
                  content: '请选择协议类型!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#ptype").focus();

                      }
                  },

              });
              return;
          }
          var rtype=$("#rtype").val();
          var address=$("#address").val();
          if(address==""){
              $.alert({
                  title: '提示信息',
                  content: '请求地址不能为空!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#address").focus();

                      }
                  },

              });
              return;
          }
          var version=$("#version").val();
          if(version==""){
              $.alert({
                  title: '提示信息',
                  content: '版本号不能为空!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#version").focus();

                      }
                  },

              });
              return;
          }
          var firstId=$("#firstCtype").val();
          if(firstId==0){
              $.alert({
                  title: '提示信息',
                  content: '请选择一级目录!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#firstCtype").focus();

                      }
                  },

              });
              return;
          }
          var secondId=$("#secondCtype").val();
          var desc=$("#desc").val();
          var tab = document.getElementById("req") ;
          var rows = tab.rows.length ;
          var reqParams='';
          for(i=1;i<rows;i++){
              var idName='reqName'+i.toString();
              var idType='reqType'+i.toString();
              var idBz='reqBz'+i.toString();
              reqParams+=$("#"+idName).val()+","+$("#"+idType).val()+","+$("#"+idBz).val()+";";
          }
          var tab1 = document.getElementById("resp") ;
          var rows1 = tab1.rows.length ;
          var respParams='';
          for(i=1;i<rows1;i++){
              var idName='respName'+i.toString();
              var idType='respType'+i.toString();
              var idBz='respBz'+i.toString();
              respParams+=$("#"+idName).val()+","+$("#"+idType).val()+","+$("#"+idBz).val()+";";
          }
          var filename=$('#uploadFile').val();
          if (filename==""){
              $.alert({
                  title: '提示信息',
                  content: '请选择上传的文件!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){}
                  },

              });
              return;
          }
          var index = filename.lastIndexOf(".");
          var ext = filename.substr(index+1);
          if(ext!="doc"&&ext!="docx"){
              $.alert({
                  title: '提示信息',
                  content: '请上传word文件!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){}
                  },

              });
              return;
          }
          $.confirm({
              title: '添加提示',
              content: '确认要添加吗？',
              icon: 'fa fa-question-circle',
              animation: 'scale',
              closeAnimation: 'scale',
              // opacity: 0.5,
              buttons: {
                  'confirm': {
                      text: '确定',
                      btnClass: 'btn-blue',
                      action: function () {
                          //layer.load();
                          $.ajaxFileUpload({
                              url : '/service/addServiceInfo',
                              type: 'POST',
                              secureuri : false,
                              fileElementId : 'uploadFile',
                              dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                              data : {
                                  cname : cname,
                                  stype:stype,
                                  otype:otype,
                                  ctype:ctype,
                                  ptype:ptype,
                                  rtype:rtype,
                                  address:address,
                                  version:version,
                                  reqParams:reqParams,
                                  respParams:respParams,
                                  desc:desc,
                                  firstId:firstId,
                                  secondId:secondId
                              },
                              success : function(data, status) {
                                  //var arr=data.msg;
                                  if(data=="1"){
                                      $.alert({
                                          title: '提示信息',
                                          content: '添加成功!',
                                          icon: 'fa fa-info-circle',
                                          buttons:{
                                              确定:function(){
                                                  window.location.reload();
                                              }
                                          },

                                      });
                                  }else if(data=="2"){
                                      $.alert({
                                          title: '提示信息',
                                          content: '已存在同名的接口信息!',
                                          icon: 'fa fa-info-circle',
                                          buttons:{
                                              确定:function(){
                                                  // window.location.reload();
                                              }
                                          },

                                      });
                                  }else{
                                      $.alert({
                                          title: '提示信息',
                                          content: '添加失败!',
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
      });
      function delServiceInfo(id){
          $.confirm({
              title: '提示信息',
              content: '确认要删除吗？',
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
                              url : '${pageContext.request.contextPath}/service/delServiceInfo',
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
                                          content: '删除成功!',
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
                                          content: '删除失败!',
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
                                      content: '删除失败!',
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
      };
      function editServiceInfo(id){
          $.ajax({
              url : "${pageContext.request.contextPath}/service/getServiceInfo",
              async : true,
              type : "POST",
              dataType : "json",
              data : {
                  "id" : id
              },
              // 成功后开启模态框
              success : showUpdate,
              error : function() {
                  alert("请求失败");
              }
          });
      }
      function showUpdate(data) {
          $('#id ').attr("value",data.serviceInfo.id );
          $('#cname1 ').attr("value",data.serviceInfo.name );
          //$("#stype1").val(data.serviceInfo.serviceType);
          $("#stype1").empty();
          let stext = "<option value='0'>===请选择===</option>";
          $("#stype1").append(stext);
          if(data.serviceTypeList!=null&&data.serviceTypeList.length>0) {
              for (i = 0; i < data.serviceTypeList.length; i++) {
                  stext = "<option value='" + data.serviceTypeList[i].id + "'>" + data.serviceTypeList[i].name + "</option>";
                  $("#stype1").append(stext);
              }
              $("#stype1").val(data.serviceType.id);
          }
          $("#otype1").val(data.serviceInfo.openType);
          $("#firstCtype1").empty();
          let  text = "<option value='0'>===请选择===</option>";
          $("#firstCtype1").append(text);
          for(i=0;i<data.firstCategoryList.length;i++){
              text = "<option value='" + data.firstCategoryList[i].id + "'>" + data.firstCategoryList[i].cname + "</option>";;
              $("#firstCtype1").append(text);
          }
          $("#firstCtype1").val(data.firstCategory.id);
          $(".selectpicker").selectpicker('refresh');
          $("#secondCtype1").empty();
          let text1 = "<option value='0'>===请选择===</option>";
          $("#secondCtype1").append(text1);
          if(data.secondCategoryList!=null&&data.secondCategoryList.length>0) {
              for (i = 0; i < data.secondCategoryList.length; i++) {
                  text1 = "<option value='" + data.secondCategoryList[i].id + "'>" + data.secondCategoryList[i].cname + "</option>";
                  $("#secondCtype1").append(text1);
              }
              $("#secondCtype1").val(data.secondCategory.id);
              $(".selectpicker").selectpicker('refresh');
          }
          $("#ptype1").empty();
          let ptext = "<option value='0'>===请选择===</option>";
          $("#ptype1").append(ptext);
          if(data.protocalTypeList!=null&&data.protocalTypeList.length>0) {
              for (i = 0; i < data.protocalTypeList.length; i++) {
                  ptext = "<option value='" + data.protocalTypeList[i].id + "'>" + data.protocalTypeList[i].name + "</option>";
                  $("#ptype1").append(ptext);
              }
              $("#ptype1").val(data.pType.id);
          }
        //  $("#ptype1").val(data.serviceInfo.protocolType);
          $("#rtype1").val(data.serviceInfo.reqMethod);
          $('#address1 ').attr("value",data.serviceInfo.address );
          $('#version1 ').attr("value",data.serviceInfo.version );
          $('#desc1').val(data.serviceInfo.description );
          $('#uploadFile1').html(data.serviceInfo.fileName );
          var reqParams=data.serviceInfo.reqParams.split(";");
          var length=reqParams.length;
          var reqtab = document.getElementById("req1") ;
          $("#req1 tr:not(:first)").remove();
          var reqrows = reqtab.rows.length ;
          if(length>reqrows){
              for(i=0;i<length-reqrows;i++){
                  $('#req1').append("<tr role='row' class='even'>" +
                      "<td><input type='text' value='' id='reqName1"+(i+1).toString()+"' autocomplete='off'></td>"+
                      "<td><select id='reqType1"+(i+1).toString()+"'  style='width:100px;height:26px;'>"+
                      "<option value='String' selected>String</option>"+
                      "<option value='Number'>Number</option>"+
                      "<option value='boolean'>boolean</option>"+
                      "<option value='Object'>Object</option>"+
                      "</select></td>"+
                      "<td ><input type='text' id='reqBz1"+(i+1).toString()+"'  autocomplete='off'></td> </tr>"
                  );
              }
          }
          for(i=0;i<length;i++){
              var reqParam=reqParams[i].split(",");
              var reqName=reqParam[0];
              var reqType=reqParam[1];
              var reqBz=reqParam[2];
              var idName='reqName1'+(i+1).toString();
              var idType="reqType1"+(i+1).toString();
              var idBz="reqBz1"+(i+1).toString();
              $("#"+idName).attr("value",reqName);
              $("#"+idType).val(reqType);
              $("#"+idBz).attr("value",reqBz);
          }
          var resParams=data.serviceInfo.resParams.split(";");
          var length=resParams.length;
          var restab = document.getElementById("resp1") ;
          $("#resp1 tr:not(:first)").remove();
          var resrows = restab.rows.length ;
          if(length>resrows){
              for(i=0;i<length-resrows;i++){
                  $('.modal_table3 .box-body table tbody').append("<tr role='row' class='even'>" +
                      "<td><input type='text' id='respName1"+(i+1).toString()+"'></td>"+
                      "<td  ><select id='respType1"+(i+1).toString()+"' style='width:100px;height:26px;'>"+
                      "<option value='String' selected>String</option>"+
                      "<option value='Number'>Number</option>"+
                      "<option value='boolean'>boolean</option>"+
                      "<option value='Object'>Object</option>"+
                      "</select></td>"+
                      "<td class='del_btn'><input type='text' id='respBz1"+(i+1).toString()+"' ></td> </tr>"
                  )
              }
          }
          for(i=0;i<length;i++){
              var resParam=resParams[i].split(",");
              var respName=resParam[0];
              var respType=resParam[1];
              var respBz=resParam[2];
              var idName='respName1'+(i+1).toString();
              var idType="respType1"+(i+1).toString();
              var idBz="respBz1"+(i+1).toString();
              $("#"+idName).attr("value",respName);
              $("#"+idType).val(respType);
              $("#"+idBz).attr("value",respBz);
          }

          $('#updateModal').modal('show');
      }
      $('#btn_update').on('click', function() {
          var id=$("#id").val();
          var cname=$("#cname1").val();
          if(cname==""){
              $.alert({
                  title: '提示信息',
                  content: '接口名称不能为空!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#cname1").focus();

                      }
                  },

              });
              return;
          }
          var stype=$("#stype1").val();
          if(stype==0){
              $.alert({
                  title: '提示信息',
                  content: '请选择服务类型!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#stype1").focus();

                      }
                  },

              });
              return;
          }
          var otype=$("#otype1").val();
          var firstCtype=$("#firstCtype1").val();
          if(firstCtype==0){
              $.alert({
                  title: '提示信息',
                  content: '一级目录不能为空!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#firstCtype1").focus();

                      }
                  },

              });
              return;
          }
          var secondCtype=$("#secondCtype1").val();
          var ptype=$("#ptype1").val();
          if(ptype==0){
              $.alert({
                  title: '提示信息',
                  content: '请选择协议类型!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#ptype1").focus();

                      }
                  },

              });
              return;
          }
          var rtype=$("#rtype1").val();
          var address=$("#address1").val();
          if(address==""){
              $.alert({
                  title: '提示信息',
                  content: '请求地址不能为空!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#address1").focus();

                      }
                  },

              });
              return;
          }
          var version=$("#version1").val();
          if(version==""){
              $.alert({
                  title: '提示信息',
                  content: '版本号不能为空!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#version1").focus();

                      }
                  },

              });
              return;
          }
          var desc=$("#desc1").val();
          var tab = document.getElementById("req1") ;
          var rows = tab.rows.length ;
          var reqParams='';
          for(i=1;i<rows;i++){
              var idName='reqName1'+i.toString();
              var idType='reqType1'+i.toString();
              var idBz='reqBz1'+i.toString();
              reqParams+=$("#"+idName).val()+","+$("#"+idType).val()+","+$("#"+idBz).val()+";";
          }
          var tab1 = document.getElementById("resp1") ;
          var rows1 = tab1.rows.length ;
          var resParams='';
          for(i=1;i<rows1;i++){
              var idName='respName1'+i.toString();
              var idType='respType1'+i.toString();
              var idBz='respBz1'+i.toString();
              resParams+=$("#"+idName).val()+","+$("#"+idType).val()+","+$("#"+idBz).val()+";";
          }
          $.confirm({
              title: '更新提示',
              content: '确认要更新吗？',
              icon: 'fa fa-question-circle',
              animation: 'scale',
              closeAnimation: 'scale',
              // opacity: 0.5,
              buttons: {
                  'confirm': {
                      text: '确定',
                      btnClass: 'btn-blue',
                      action: function () {
                          $.ajaxFileUpload({
                              url : '/service/updateServiceInfo',
                              secureuri : false,
                              fileElementId : 'uploadFile1',
                              dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                              data : {
                                  id:id,
                                  cname : cname,
                                  stype:stype,
                                  otype:otype,
                                  firstCtype:firstCtype,
                                  secondCtype:secondCtype,
                                  ptype:ptype,
                                  rtype:rtype,
                                  address:address,
                                  version:version,
                                  reqParams:reqParams,
                                  resParams:resParams,
                                  desc:desc
                              },
                              success : function(data, status) {
                                  if(data=="1"){
                                      $.alert({
                                          title: '提示信息',
                                          content: '更新成功!',
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
                                          content: '更新失败!',
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
      });
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
                     window.location.href="${pageContext.request.contextPath}/serviceInfoList?name="+searchName+"&findType=1&pageNo=1"+"&pageSize="+$("#pageSize").val();
                 }else if(findType == 2){
                     window.location.href="${pageContext.request.contextPath}/serviceInfoList?name="+searchName+"&findType=2&pageNo=1"+"&pageSize="+$("#pageSize").val();
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
                         window.location.href="${pageContext.request.contextPath}/serviceInfoList?range="+time+"&findType=3&pageNo=1"+"&pageSize="+$("#pageSize").val();
                     }
                 }
             }
         }
     }
     $("#firstCtype").change(function(){
         var firstId=$("#firstCtype").val();
         $.getJSON("${pageContext.request.contextPath}/category/getSecondCategoryByFirst?firstId="+firstId,function(data){
             $("#secondCtype").empty();
             let  text = "<option value='0'>===请选择===</option>";
             $("#secondCtype").append(text);
             for(i=0;i<data.secondCategoryList.length;i++) {
                 //let text="<li data='"+data.secondCategoryList[i].id+"'>"+data.secondCategoryList[i].cname+"</li>";
                 text = "<option value='" + data.secondCategoryList[i].id + "'>"+data.secondCategoryList[i].cname+"</option>";
                 $("#secondCtype").append(text);
             }
             $(".selectpicker").selectpicker('refresh');
         });
     });
     $("#firstCtype1").change(function(){
         var firstId=$("#firstCtype1").val();
         $.getJSON("${pageContext.request.contextPath}/category/getSecondCategoryByFirst?firstId="+firstId,function(data){
             $("#secondCtype1").empty();
             let  text = "<option value='0'>===请选择===</option>";
             $("#secondCtype1").append(text);
             for(i=0;i<data.secondCategoryList.length;i++) {
                 text = "<option value='" + data.secondCategoryList[i].id + "'>"+data.secondCategoryList[i].cname+"</option>";
                 $("#secondCtype1").append(text);
             }
             $(".selectpicker").selectpicker('refresh');
         });
     });

     function downServiceFile() {
         var id=$("#id2").val();
        window.location.href="${pageContext.request.contextPath}/service/downServiceFile?id="+id;
     };
     // 选择目录事件
     // function al( ) {
     //     var id =$(this).innerHTML;
     //     alert(id );
     // };
     /*$("#typeselect").change(function(){
         let id = $("#typeselect").val();
         $.ajax({
             url:"{:url('otherajax')}",
             data:{id:id},
             type:'post',
             success:function(data){
                 let option= '<option>---请选择商品---</option>';
                 for(let i=0;i<data.length;i++){
                     option += '<option value="' + data[i].id + '">' + data[i].other_name + data[i].other_model + '</option>';
                 }
                 $("#otherselect").html(option);
                 $(".selectpicker").selectpicker('refresh');
             }
         })
     });*/
     $("#pageSize").change(function(){
         var pageSize=$("#pageSize").val();
         window.location.href="${pageContext.request.contextPath}/serviceInfoList?findType=0&pageNo=1&pageSize="+pageSize;

     });
 </script>
</body>
</html>
