<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/8
  Time: 15:57
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
        <h3>服务目录管理</h3>
        <%--搜索框--%>
        <%--<input type="hidden" value="${findType}" id="findType">--%>
        <input type="hidden" value="${findType}" id="findType">
        <div class="right_btn_div">
            <div class="search">
                <select class="form-controll" id="selectType">
                            <option value="0">选择搜索</option>
                            <option value="1">目录名称 </option>
                            <option value="2">创建时间 </option>
                </select>
                <input type="text" class="search-input" id="searchName"  value="${name}" autocomplete="off" />
                <input type="text" class="search-input" id="logDate" placeholder="请选择时间范围" value="${time}" autocomplete="off" style="float: left;">
                <button class="butFind" onclick="search(this)" id="search">查询</button>
            </div>
            <c:if test="${loginUser.role eq 2}">
            <button type="button" id="btn_add" name="btn_add" class="btn btn-info" title="新建" onclick="addCategory();">
                <i class="fa fa-plus-square"></i>&nbsp;创建服务目录
            </button>
            </c:if>
        </div>
        <hr style="border-top: 3px solid  #00a2e9;margin-top: 6px;margin-bottom: 0px;">
    </div>

    <%--内容展示块一 类别管理 --%>
    <div class="change_box"  >
        <table class="table-striped">
            <thead>
            <tr>
                <td>名称</td>
                <td>备注</td>
                <td>类型</td>
                <td>上级目录</td>
                <td>创建日期</td>
                <td>审核日期</td>
                <td>审核结果</td>
                <td>状态</td>
                <td>操作</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach varStatus="status" items="${categoryList}" var="category">
                <tr>
                    <td>
                        <a href="#" onclick="getCategory('${category.id}');" title="查看服务详情">
                                ${category.cname}
                        </a>
                    </td>
                    <td style="max-width: 200px;">
                        <div class="sub_font">${category.description}</div>
                    </td>
                    <td style="max-width: 200px;">
                        <div class="sub_font">
                            <c:choose>
                                <c:when test="${category.type eq 1}">
                                    一级目录
                                </c:when>
                                <c:otherwise>
                                    二级目录
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                    <td style="max-width: 200px;">
                        <div class="sub_font">
                            <c:choose>
                                <c:when test="${category.type eq 2}">
                                    ${firstCategoryList[status.index].cname}
                                </c:when>
                                <c:otherwise>
                                    无
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                    <td>${category.createTime}</td>
                    <td>
                        <c:choose>
                            <c:when test="${category.status eq 0}">
                                未提交审核
                            </c:when>
                            <c:when test="${category.status eq 1}">
                                待审核
                            </c:when>
                            <c:otherwise>
                                ${category.auditTime}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${category.result eq null or category.result eq ''}">
                                未审核
                            </c:when>
                            <c:otherwise>
                                ${category.result}
                            </c:otherwise>
                        </c:choose>

                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${category.status eq 0}">
                                <span class="label label-default">创建类别</span>
                            </c:when>
                            <c:when test="${category.status eq 1}">
                                <span class="label label-info">类别审核</span>
                            </c:when>
                            <c:when test="${category.status eq 2}">
                                <span class="label label-success">审核通过</span>
                            </c:when>
                            <c:otherwise>
                                <span class="label label-warning">审核未通过</span>
                            </c:otherwise>
                        </c:choose>

                    </td>
                    <td class="todo-list">
                        <div class="tools">
                            <c:if test="${category.status eq 0 and loginUser.role eq 2}">
                                <span class="iconfont icon-bianji" title="编辑目录信息" onclick="editCategory('${category.id}') "></span>
                                <span class="iconfont icon-shanchu" title="删除目录信息" onclick="delCategory('${category.id}')"></span>
                                <span class="iconfont icon-shenqing" title="提交审核"     onclick="submitCategory('${category.id}')"></span>
                            </c:if>
                            <c:if test="${category.status eq 1 and loginUser.role eq 3}">
                                <span class="iconfont icon-shenhejieguo"  title="审核目录信息" onclick="auditCategory('${category.id}')"></span>
                            </c:if>
                            <c:if test="${category.status eq 3}">
                                <c:if test="${(category.result ne null) and  (category.result ne '') }">
                                    <span class="iconfont icon-shenhe"  title="查看审核详情" onclick="queryAudit('${category.id}')"></span>
                                </c:if>
                                <c:if test="${loginUser.role eq 2}">
                                <span class="iconfont icon-bianji" title="编辑目录信息" onclick="editCategory('${category.id}') "></span>
                                <span class="iconfont icon-shenqing"  title="再次提交审核" onclick="submitCategory('${category.id}')"></span>
                                </c:if>
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
<div class="modal fade bs-example-modal-lg" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document" style="width:400px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增服务目录</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="cname">目录名称</label>
                    <input type="text" id="cname" name="cname" class="form-control"  placeholder="请输入服务目录名称">
                </div>
                <div class="form-group">
                    <label for="type">目录类型</label>
                    <select id="type" name="type" class="form-control">
                        <option value="1" selected>一级目录</option>
                        <option value="2">二级目录</option>
                    </select>
                </div>
                <div class="form-group" id="pre" style="display: none">
                    <label for="pre">上级目录</label>
                    <select id="preCategory" name="preCategory" class="form-control">
                    </select>
                </div>
                <div class="form-group">
                    <label for="desc">目录摘要</label>
                    <textarea rows="2" name="desc" id="desc" class="form-control"  placeholder="请输入长度少于30的服务目录摘要" maxlength="29"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="close" name="close" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                <button type="button" id="btn_submit" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>创建</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade bs-example-modal-lg" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">更新服务目录</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" name="id" id="id">
                <div class="form-group">
                    <label for="cname1">目录名称</label>
                    <input type="text" id="cname1" name="cname1" class="form-control"  placeholder="请输入服务目录名称">
                </div>
                <div class="form-group">
                    <label for="type1">目录类型</label>
                    <select id="type1" name="type1" class="form-control">
                        <option value="1" selected>一级目录</option>
                        <option value="2">二级目录</option>
                    </select>
                </div>
                <div class="form-group" id="pre1" style="display: none">
                    <label for="pre">上级目录</label>
                    <select id="preCategory1" name="preCategory1" class="form-control">
                    </select>
                </div>
                <div class="form-group">
                    <label for="desc1">目录摘要</label>
                    <textarea rows="2" name="desc1" id="desc1" class="form-control"  placeholder="请输入长度小于30的服务目录摘要">
                    </textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" id="close1" name="close1" class="btn btn-secondary" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                    <button type="button" id="btn_update" class="btn btn-primary" onclick="updateCategory();"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>修改</button>
                </div>
            </div>
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
                <h4 class="modal-title" id="myModalLabel2">服务目录审核</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <input type="hidden" id="id1" name="id1" class="form-control">
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
                    <textarea name="reason" id="reason" cols="15" rows="3" class="form-control"
                              placeholder="请填写拒绝理由" disabled="true"></textarea>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="close2" name="close2" class="btn btn-secondary" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                <button type="button" id="btn_audit" class="btn btn-primary" onclick="auditApply();"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>提交</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade bs-example-modal-lg" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="detailModalLabel">服务目录信息</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="cname1">目录名称</label>
                    <input type="text" id="cname2" name="cname2" class="form-control"  readonly>
                </div>
                <div class="form-group">
                    <label for="type1">目录类型</label>
                    <input type="text" id="type2" name="type2" class="form-control"  readonly>
                    </select>
                </div>
                <div class="form-group" id="pre2" style="display: none">
                    <label for="preCategory2">上级目录</label>
                    <input type="text" id="preCategory2" name="preCategory2" class="form-control"  readonly>
                </div>
                <div class="form-group">
                    <label for="desc2">目录摘要</label>
                    <textarea rows="2" name="desc2" id="desc2" class="form-control" readonly>
                    </textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" id="close3" name="close3" class="btn btn-secondary" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade bs-example-modal-lg" id="auditDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document" style="width:700px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="infoId">服务目录审核详情</h4>
            </div>
            <div class="modal-body box">
                <div align="center">
                    <table id="detailInfo" class="table  dataTable">
                        <tr>
                            <th class="text-center">审核结果</th>
                            <th class="text-center">拒绝理由</th>
                            <th class="text-center">审核时间</th>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="closeUn"  class="btn btn-default" data-dismiss="modal" ><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
            </div>
        </div>
    </div>
</div>

<script>
    function addCategory(){
        $('#addModal').modal('show');
    }
    $('#btn_submit').on('click', function() {
        var cname=$("#cname").val();
        if(cname==""){
            $.alert({
                title: '提示信息',
                content: '类别名称不能为空!',
                icon: 'fa fa-info-circle',
                buttons:{
                    确定:function(){
                        $("#cname").focus();

                    }
                },

            });
            return;
        }
        var type=$("#type").val();
        var preCategory;
        if(type==2){
            preCategory=$("#preCategory").val();
            if(preCategory==null || preCategory==""){
                $.alert({
                    title: '提示信息',
                    content: '二级目录不能为空!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){
                        }
                    },

                });
                return;
            }

        }
        var desc=$("#desc").val();
        if(desc!=null &&desc!=""){
            if(desc.length>=30){
                $.alert({
                    title: '提示信息',
                    content: '目录摘要长度超出范围!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){
                        }
                    },

                });
                return;
            }
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
                        $.ajax({
                            url : '${pageContext.request.contextPath}/category/addCategory',
                            //secureuri : false,
                            dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                            data : {
                                cname : cname,
                                type:type,
                                preCategory:preCategory,
                                desc:desc

                            },
                            success : function(data, status) {
                                var arr=data.msg;
                                if(arr=="1"){
                                    $.alert({
                                        title: '提示信息',
                                        content: '创建成功!',
                                        icon: 'fa fa-info-circle',
                                        buttons:{
                                            确定:function(){
                                                window.location.reload();
                                            }
                                        },

                                    });
                                }else if(arr=="2"){
                                    $.alert({
                                        title: '提示信息',
                                        content: '已存在同名的服务类别!',
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
                                        content: '创建失败!',
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
    function delCategory(id){
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
                            url : '${pageContext.request.contextPath}/category/delCategory',
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
    function editCategory(id){
        $.ajax({
            url : "${pageContext.request.contextPath}/category/getCategory",
            async : true,
            type : "POST",
            dataType : "json",
            data : {
                "id" : id
            },
            // 成功后开启模态框
            success : showUpdate,
            error : function() {
                $.alert({
                    title: '提示信息',
                    content: '请求失败!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){

                        }
                    },

                });
            }
        });
    }
    function showUpdate(data) {
        $('#id ').attr("value",data.category.id );
        $('#cname1 ').attr("value",data.category.cname );
        var type=data.category.type;
        var preCategory=data.category.preCategory;
        $("#type1").val(type);
        if(type==2) {
            for (i = 0; i < data.firstCategoryList.length; i++) {
                let text = "<option value='" + data.firstCategoryList[i].id + "'>" + data.firstCategoryList[i].cname + "</option>";
                $("#preCategory1").append(text);
            }
            $("#preCategory1").val(preCategory);
            $("#pre1").css('display','block');

        }
        $('#desc1').val(data.category.description );
        $('#updateModal').modal('show');
    }
    function updateCategory(){
        var id=$("#id").val();
        var cname=$("#cname1").val();
        if(cname==""){
            $.alert({
                title: '提示信息',
                content: '类别名称不能为空!',
                icon: 'fa fa-info-circle',
                buttons:{
                    确定:function(){
                        $("#cname1").focus();

                    }
                },

            });
            return;
        }
        var type=$("#type1").val();
        var preCategory;
        if(type==2){
            preCategory=$("#preCategory1").val();
            if(preCategory==null || preCategory==""){
                $.alert({
                    title: '提示信息',
                    content: '二级目录不能为空!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){
                        }
                    },

                });
                return;
            }

        }
        var desc=$("#desc1").val();
        if(desc!=null &&desc!=""){
            if(desc.length>=30){
                $.alert({
                    title: '提示信息',
                    content: '目录摘要长度超出范围!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){
                        }
                    },

                });
                return;
            }
        }
        $.confirm({
            title: '提示信息',
            content: '确认要修改吗？',
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
                        $.ajax({
                            url : '${pageContext.request.contextPath}/category/updateCategory',
                            dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                            data : {
                                id:id,
                                cname: cname,
                                type:type,
                                preCategory:preCategory,
                                desc:desc

                            },
                            success : function(data, status) {
                                var arr=data.msg;
                                if(arr=="1"){
                                    $.alert({
                                        title: '提示信息',
                                        content: '修改成功!',
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
                                        content: '修改失败!',
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
    };
    function submitCategory(id){
        $.confirm({
            title: '提示信息',
            content: '确认要提交审核吗？',
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
                            url : '${pageContext.request.contextPath}/category/submitCategory',
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
    };
    function homePage(){
        var findType=$("#findType").val();
        if(findType=="0"){
          window.location.href="${pageContext.request.contextPath}/categoryList?pageNo=1&findType="+findType+"&pageSize="+$("#pageSize").val();
        }else if(findType=="1"){
            var searchName=$("#searchName").val();
            if(searchName==''){
                $.alert({
                    title: '提示信息',
                    content: '目录名称不能为空!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){

                        }
                    },

                });
                return;
            }
           window.location.href="${pageContext.request.contextPath}/categoryList?pageNo=1&findType="+findType+"&searchName="+searchName+"&pageSize="+$("#pageSize").val();
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
                window.location.href="${pageContext.request.contextPath}/categoryList?pageNo=1&findType="+findType+"&range="+time+"&pageSize="+$("#pageSize").val();
            }

        }
    }
    function previousPage(pageNo){
        var findType=$("#findType").val();
        if(findType=="0"){
            window.location.href="${pageContext.request.contextPath}/categoryList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
        }else if(findType=="1"){
            var searchName=$("#searchName").val();
            if(searchName==''){
                $.alert({
                    title: '提示信息',
                    content: '目录名称不能为空!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){

                        }
                    },

                });
                return;
            }
            window.location.href="${pageContext.request.contextPath}/categoryList?pageNo"+pageNo+"&findType="+findType+"&searchName="+searchName+"&pageSize="+$("#pageSize").val();
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
                window.location.href="${pageContext.request.contextPath}/categoryList?pageNo="+pageNo+"&findType="+findType+"&range="+time+"&pageSize="+$("#pageSize").val();
            }

        }
    }
    function nextPage(pageNo){
        var findType=$("#findType").val();
        if(findType=="0"){
            window.location.href="${pageContext.request.contextPath}/categoryList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
        }else if(findType=="1"){
            var searchName=$("#searchName").val();
            if(searchName==''){
                $.alert({
                    title: '提示信息',
                    content: '目录名称不能为空!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){

                        }
                    },

                });
                return;
            }
            window.location.href="${pageContext.request.contextPath}/categoryList?pageNo"+pageNo+"&findType="+findType+"&searchName="+searchName+"&pageSize="+$("#pageSize").val();
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
                window.location.href="${pageContext.request.contextPath}/categoryList?pageNo="+pageNo+"&findType="+findType+"&range="+time+"&pageSize="+$("#pageSize").val();
            }

        }
    }
    function lastPage(pageNo){
        var findType=$("#findType").val();
        if(findType=="0"){
            window.location.href="${pageContext.request.contextPath}/categoryList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
        }else if(findType=="1"){
            var searchName=$("#searchName").val();
            if(searchName==''){
                $.alert({
                    title: '提示信息',
                    content: '目录名称不能为空!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){

                        }
                    },

                });
                return;
            }
            window.location.href="${pageContext.request.contextPath}/categoryList?pageNo"+pageNo+"&findType="+findType+"&searchName="+searchName+"&pageSize="+$("#pageSize").val();
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
                window.location.href="${pageContext.request.contextPath}/categoryList?pageNo="+pageNo+"&findType="+findType+"&range="+time+"&pageSize="+$("#pageSize").val();
            }

        }
    }
    function auditCategory(id){
        $.ajax({
            url : "${pageContext.request.contextPath}/category/getCategory",
            async : true,
            type : "POST",
            dataType : "json",
            data : {
                "id" : id
            },
            // 成功后开启模态框
            success : showAudit,
            error : function() {
                alert("请求失败");
            }
        });
    };
    function showAudit(data) {
        $('#id1 ').attr("value",data.category.id );
        $('#cname2 ').attr("value",data.category.cname );
        $('#auditModal').modal('show');
    }
    $("#accept").click(function () {
        $("#reason").attr("disabled", true);
    });
    $("#reject").click(function () {
        $("#reason").removeAttr("disabled");
    });
    function auditApply(){
        var id=$("#id1").val();
        var result=$('input:radio:checked').val();
        var reason=$("#reason").val();
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
                            url : '${pageContext.request.contextPath}/category/auditCategory',
                            //secureuri : false,
                            dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                            data : {
                                id:id,
                                result:result,
                                reason:reason

                            },
                            success : function(data, status) {
                                var arr=data.msg;
                                if(arr=="1"){
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
    };
    function getCategory(id){
        $.ajax({
            url : "${pageContext.request.contextPath}/category/getCategory",
            async : true,
            type : "POST",
            dataType : "json",
            data : {
                "id" : id
            },
            // 成功后开启模态框
            success : showDetails,
            error : function() {
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
    }
    function showDetails(data) {
        $("#pre2").css('display','none');
        $('#cname2 ').attr("value",data.category.cname );
        if(data.category.type==1) {
            $('#type2 ').attr("value", "一级目录");
        }else{
            $('#type2 ').attr("value", "二级目录");
            $('#preCategory2').attr("value", data.preCategory.cname);
            $("#pre2").css('display','block');
        }
        $('#desc2').val(data.category.description );
        $('#detailModal').modal('show');
    }
    function queryAudit(id){
        $.ajax({
            url : "${pageContext.request.contextPath}/category/getCategory",
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
        $("#detailInfo tr:not(:first)").remove();
        var content="<tr>";
        content=content+"<td align='center'>"+data.category.result+"</td>";
        content=content+"<td align='center'>"+data.category.reason+"</td>";
        content=content+"<td align='center'>"+ data.category.auditTime +"</td></tr>";
        $('#detailInfo').append(content);
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
            $("#searchName").attr("placeholder","请输入目录名称")
            // $("#searchName").val("");
            $("#logDate").css("display","none");
        } else if(type==2){
            $("#searchName").css("display","none")
            $("#logDate").css("display","block");
        }
    });
    laydate.render({
        elem: '#logDate', //指定元素
        range: true,
        theme: '#00c0ef',//主题显示
        trigger: 'click',// 事件类型
    });
    /* 搜索 --end-- */
    function search(obj) {
        let findType = $("#selectType").val();
        let searchName = $("#searchName").val();
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
            return;
        }else{
            if(searchName.replace(/(^\s*)|(\s*$)/g, "").length ==0&&findType!=2){
                $.alert({
                    title: '提示信息！',
                    content: '查询内容不能为空！！!',
                    icon: 'fa fa-info-circle',
                    buttons:{
                        确定:function(){
                        }
                    },
                });
                return;
            }else {
                if(findType==1){//根据名称查询
                    window.location.href="${pageContext.request.contextPath}/categoryList?searchName="+searchName+"&findType=1&pageNo=1&pageSize="+$("#pageSize").val();
                }else if(findType == 2){
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
                        return;
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
                        window.location.href="${pageContext.request.contextPath}/categoryList?range="+time+"&findType=2&pageNo=1&pageSize="+$("#pageSize").val();
                    }
                }
            }
        }
    }
    $("#type").change(function(){
        var type=$("#type").val();
        if(type==2){
            $.getJSON("${pageContext.request.contextPath}/category/getFirstCategory",function(data){
                for(i=0;i<data.categoryList.length;i++) {
                    let text = "<option value='" + data.categoryList[i].id + "'>"+data.categoryList[i].cname+"</option>";
                    $("#preCategory").append(text);
                }
            });
            $("#pre").css('display','block');
        }else{
            $("#pre").css('display','none');
        }

    });
    $("#type1").change(function(){
        var type=$("#type1").val();
        if(type==2){
            $.getJSON("${pageContext.request.contextPath}/category/getFirstCategory",function(data){
                for(i=0;i<data.categoryList.length;i++) {
                    let text = "<option value='" + data.categoryList[i].id + "'>"+data.categoryList[i].cname+"</option>";
                    $("#preCategory1").append(text);
                }
            });
            $("#pre1").css('display','block');
        }else{
            $("#pre1").css('display','none');
        }

    });

    $("#pageSize").change(function(){
        var pageSize=$("#pageSize").val();
        window.location.href="${pageContext.request.contextPath}/categoryList?findType=0&pageNo=1&pageSize="+pageSize;
    });
</script>
</body>
</html>
