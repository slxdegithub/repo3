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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/page.css">  <!-- 分页的css-->

    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/bootstrap/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userCenter.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iconfont.css" type="text/css">
    <%--下拉列表模糊查询样式--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>

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
        <h3>词典管理</h3>
        <%--搜索框--%>
        <input type="hidden" value="${findType}" id="findType">
        <div class="right_btn_div">
            <div class="search">
                <select class="form-controll" id="selectType">
                    <option value="0">选择搜索</option>
                    <option value="1">词典名称 </option>
                    <option value="2">创建时间 </option>
                    <option value="3">词典类型</option>
                </select>
                <input type="text" class="search-input" id="searchName"  value="${name}" autocomplete="off" />
                <input type="text" class="search-input" id="logDate" placeholder="选择时间范围" value="${time}" autocomplete="off" style="float: left;">
                <%--<input type="text" class="search-input" id="searchTp"  value="${selectDictionaryName}" autocomplete="off" />--%>

                <button class="butFind" onclick="search(this)" id="search">查询</button>
            </div>
            <button type="button" id="btn_add" name="btn_add" class="btn btn-info" title="新建"   onclick="addDictionary();">
                <i class="fa fa-plus-square"></i>&nbsp;添加词典
            </button>
        </div>
        <hr style="border-top: 3px solid #00a2e9;margin-top: 6px;margin-bottom: 0px;">
    </div>

    <%--内容展示块一 词典管理 --%>
    <div class="change_box"  >
        <table class="table-striped">
            <thead>
            <tr>
                <td>词典名称</td>
                <td>更新时间</td>
                <td>词典类型</td>
                <td>描述</td>
                <td>操作</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach  items="${dictionaryList}" var="dic">
                <tr>
                    <td>
                        ${dic.name}
                    </td>
                    <td>
                        ${dic.createTime}
                    </td>
                    <td>
                        <c:if test="${dic.type ==  1 }" >
                            服务类型
                        </c:if>
                        <c:if test="${dic.type eq 2}">
                             协议类型
                        </c:if>
                    </td>
                    <td>${dic.description}</td>
                    <td class="todo-list">
                        <div class="tools">
                            <span class="iconfont icon-bianji" title="编辑接口信息" onclick="editdictionary('${dic.id}') "></span>
                            <span class="iconfont icon-shanchu" title="删除接口信息" onclick="delCategory('${dic.id}')"></span>
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
            条数据</label>

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
        <script>
            function goNext(pageNo){
                window.location.href="${pageContext.request.contextPath}/dictionary/select?page="+pageNo;
            }
        </script>

    </div>

    <script src="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.js "></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.z-pager.js"></script><!-- 分页的js-->


</div>
<%--修改的modal--%>
<div class="modal fade bs-example-modal-lg" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document" style="width:400px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">更新词典</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <input hidden type="text" id="dictionaryId" name="dictionaryId" class="form-control" style="display:none;"  placeholder="0">
                </div>
                <div class="form-group">
                    <label for="cname">词典名称</label>
                    <input type="text" id="cname" name="cname" class="form-control"  placeholder="请输入服务目录名称">
                </div>
                <div class="form-group">
                    <label for="type2">词典类型</label>
                    <select id="type2" name="type2" class="form-control">
                        <option value="1" selected>服务类型</option>
                        <option value="2">协议类型</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="descr">词典描述</label>
                    <textarea rows="2" name="desc" id="descr" class="form-control"  placeholder="请输入服务目录摘要"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="close1" name="close" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                <button type="button"  id="btn_submit1" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>更新</button>
            </div>
        </div>
    </div>
</div>
<%--创建的mdal--%>
<div class="modal fade bs-example-modal-lg" id="addModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document" style="width:400px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">新增词典</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="cname">词典名称</label>
                    <input type="text" id="dname" name="dname" class="form-control"  placeholder="请输入服务目录名称">
                </div>
                <div class="form-group">
                    <label for="type1">词典类型</label>
                    <select id="type1" name="type" class="form-control">
                        <option value="1" selected>服务类型</option>
                        <option value="2">协议类型</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="desc1">词典描述</label>
                    <textarea rows="2" name="desc" id="desc1" class="form-control"  placeholder="请输入服务目录摘要"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="close" name="close" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                <button  type="button" id="btn_submit" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true" ></span>创建</button>
                        <%--onclick="btn_submit()"--%>
            </div>
        </div>
    </div>
</div>


<script>
    //创建
    function addDictionary(){
        $('#addModal1').modal('show');

    };
    //创建检查

    $('#btn_submit').on('click', function() {
    // function btn_submit() {
        var dname=$("#dname").val();
        if(dname==""){
            $.alert({
                title: '提示信息',
                content: '词典名称不能为空!',
                icon: 'fa fa-info-circle',
                buttons:{
                    确定:function(){
                        $("#dname").focus();

                    }
                },

            });
            return;
        }
        // alert("dname="+dname);
        var type=$("#type1").val();
        // alert("type="+type);
        var desc=$("#desc1").val();
       // alert("desc=" + desc )
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
                            url : '${pageContext.request.contextPath}/dictionary/insert',
                            //secureuri : false,
                            dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                            data : {
                                name : dname,
                                type:type,
                                description:desc,

                            },
                            success : function(response) {

                                if(response.status=="1"){
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


    //删除词典
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
                            url : '${pageContext.request.contextPath}/dictionary/delete',
                            //secureuri : false,
                            dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                            data : {
                                id:id
                            },
                            success : function(response) {
                                if(response.status=="1"){
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


    function wawawawa(data) {
        $('#cname').attr("value",data.dictionary.name );
        $('#type2').val(data.dictionary.type);
        $('#descr').val(data.dictionary.description );
        $('#dictionaryId').val(data.dictionary.id );

        $('#updateModal').modal('show');
    }
        //更新弹框
    function editdictionary(id) {
        // alert(id)
        $.ajax({
            url : "${pageContext.request.contextPath}/dictionary/getDictionaryInfo",
            async : true,
            type : "POST",
            dataType : "json",
            data : {
                "id" : id
            },
            // 成功后开启模态框
            success : wawawawa,
            error : function() {
                alert("请求失败");
            }
        });


    }

    //弹框更新的点击事件
    $('#btn_submit1').on('click', function() {
        // alert("666")
        var cname=$("#cname").val();
        var DId=$("#dictionaryId").val();
        if(cname==""){
            $.alert({
                title: '提示信息',
                content: '词典名称不能为空!',
                icon: 'fa fa-info-circle',
                buttons:{
                    确定:function(){
                        $("#cname").focus();

                    }
                },

            });
            return;
        }
        // alert("dname="+dname);
        var type=$("#type2").val();
        // alert("type="+type);
        var desc=$("#descr").val();
        // alert("desc=" + desc )
        $.confirm({
            title: '修改提示',
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
                            url : '${pageContext.request.contextPath}/dictionary/update',
                            //secureuri : false,
                            dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                            data : {
                                name : cname,
                                type:type,
                                description:desc,
                                id:DId,

                            },
                            success : function(response) {

                                if(response.status=="1"){
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
    });


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
            $("#searchName").attr("placeholder","请输入词典名称")
            $("#logDate").css("display","none");
        } else if(type==3){
            $("#searchName").css("display","block");
            $("#searchName").removeAttr("disabled");
            $("#searchName").attr("placeholder","请输入词典类型")
            $("#logDate").css("display","none");

        }else if (type == 2){
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
            $("#searchName").attr("placeholder","请输入词典名称")
            // $("#searchName").val("");
            $("#logDate").css("display","none");
        } else if(type==3){
            $("#searchName").css("display","block")
            $("#searchName").removeAttr("disabled");
            $("#searchName").attr("placeholder","请输入词典类型")
            // $("#searchName").val("");
            $("#logDate").css("display","none");
        }else if (type==2){
            $("#searchName").css("display","none")
            $("#logDate").css("display","block");
            $("#logDate").attr("placeholder","请选择时间范围")

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
                    window.location.href="${pageContext.request.contextPath}/dictionaryList?name="+searchName+"&findType=1&pageNo=1&pageSize="+$("#pageSize").val();
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
                        window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo=1&findType=2&range="+time+"&pageSize="+$("#pageSize").val();
                    }
                }else if (findType == 3){
                    window.location.href="${pageContext.request.contextPath}/dictionaryList?name="+searchName+"&findType=3&pageNo=1&pageSize="+$("#pageSize").val();

                }
            }
        }
    }

    function homePage(){
        var findType=$("#findType").val();
        if(findType=="0"){
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo=1&findType="+findType+"&pageSize="+$("#pageSize").val();
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
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo=1&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
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
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo=1&findType="+findType+"&range="+logDate+"&pageSize="+$("#pageSize").val();
        }
    }
    function previousPage(pageNo){
        var findType=$("#findType").val();
        if(findType=="0"){
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
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
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo="+pageNo+"&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
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
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo="+pageNo+"&findType="+findType+"&range="+logDate+"&pageSize="+$("#pageSize").val();
        }
    }
    function nextPage(pageNo){
        var findType=$("#findType").val();
        if(findType=="0"){
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
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
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo="+pageNo+"&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
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
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo="+pageNo+"&findType="+findType+"&range="+logDate+"&pageSize="+$("#pageSize").val();
        }
    }
    function lastPage(pageNo){
        var findType=$("#findType").val();
        if(findType=="0"){
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo="+pageNo+"&findType="+findType+"&pageSize="+$("#pageSize").val();
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
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo="+pageNo+"&findType="+findType+"&name="+searchName+"&pageSize="+$("#pageSize").val();
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
            window.location.href="${pageContext.request.contextPath}/dictionaryList?pageNo="+pageNo+"&findType="+findType+"&range="+logDate+"&pageSize="+$("#pageSize").val();
        }
    }

    $("#pageSize").change(function(){
        var pageSize=$("#pageSize").val();
        window.location.href="${pageContext.request.contextPath}/dictionaryList?findType=0&pageNo=1&pageSize="+pageSize;
    });
</script>

</body>
</html>
