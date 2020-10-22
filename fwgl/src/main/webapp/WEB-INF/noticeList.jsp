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
        <h3>公告栏管理</h3>
        <hr style="border-top: 3px solid  #00a2e9;margin-top: 6px;margin-bottom: 0px;">
        <c:if test="${noticeList.size() eq 0}">
            <button type="button" id="btn_add" name="btn_add" class="btn btn-info" title="新建" style="margin-left:auto;position:absolute;top: 0;right: 0;bottom: 8px; " onclick="toAddNotice();">
                <span class="glyphicon glyphicon-plus"></span>&nbsp;新建公告
            </button>
        </c:if>
    </div>

    <%--内容展示块一 类别管理 --%>
    <div class="change_box"  >
        <table class="table-striped">
            <thead>
            <tr>
                <td>序号</td>
                <td>标题</td>
                <td>公告内容</td>
                <td>创建时间</td>
                <td>操作</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach varStatus="status" items="${noticeList}" var="notice">
                <tr>
                    <td>${status.count}</td>
                    <td>${notice.title}</td>
                    <td style="max-width: 200px;">
                        <div class="sub_font">
                          ${notice.content}
                        </div>
                    </td>
                    <td>${notice.releaseTime}</td>
                    <td class="todo-list">
                        <div class="tools">
                            <span class="iconfont icon-bianji" title="编辑公告" onclick="editNotice('${notice.id}') "></span>
                            <span class="iconfont icon-shanchu" title="删除公告" onclick="delNotice('${notice.id}')"></span>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>


</div>
<div class="modal fade bs-example-modal-lg" id="noticeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">公告栏设置</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="title">标题</label>
                    <input type="text" id="title" name="title" class="form-control" placeholder="请输入公告标题">
                </div>
                <div class="form-group">
                    <label for="content">公告内容</label>
                    <textarea cols="20" rows="3" id="content" name="content" class="form-control" placeholder="请输入公告内容" ></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="close" name="close" class="btn btn-default" data-dismiss="modal"><span
                        class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭
                </button>
                <button type="button" id="btn_submitUpdate" class="btn btn-primary" onclick="addNotice()"><span
                        class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>添加
                </button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade bs-example-modal-lg" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <input type="hidden" id="id" name="id">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="updateModalLabel">公告栏内容编辑</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="title">标题</label>
                    <input type="text" id="title1" name="title1" class="form-control" placeholder="请输入公告标题">
                </div>
                <div class="form-group">
                    <label for="content">公告内容</label>
                    <textarea cols="20" rows="3" id="content1" name="content1" class="form-control" placeholder="请输入公告内容" ></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="close1" name="close1" class="btn btn-default" data-dismiss="modal"><span
                        class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭
                </button>
                <button type="button" id="updateNotice" class="btn btn-primary" onclick="updateNotice();"><span
                        class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>更新
                </button>
            </div>
        </div>
    </div>
</div>

 <script>
      function toAddNotice(){
          $('#noticeModal').modal('show');
      }
      function addNotice(){
          var title=$("#title").val();
          if(title==""){
              $.alert({
                  title: '提示信息',
                  content: '公告标题不能为空!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#title").focus();

                      }
                  },

              });
              return;
          }
          var content=$("#content").val();
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
                              url : '${pageContext.request.contextPath}/config/addNotice',
                              //secureuri : false,
                              dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                              data : {
                                  title : title,
                                  content: content

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
      };
      function delNotice(id){
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
                              url : '${pageContext.request.contextPath}/config/delNotice',
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
      function editNotice(id){
          $.ajax({
              url : "${pageContext.request.contextPath}/config/getNotice",
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
          $('#id ').attr("value",data.notice.id );
          $('#title1 ').attr("value",data.notice.title );
          $('#content1').val(data.notice.content );
          $('#updateModal').modal('show');
      }
      function updateNotice(){
          var id=$("#id").val();
          var title=$("#title1").val();
          if(title==""){
              $.alert({
                  title: '提示信息',
                  content: '公告标题不能为空!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#title1").focus();

                      }
                  },

              });
              return;
          }
          var content=$("#content1").val();
          if(content==""){
              $.alert({
                  title: '提示信息',
                  content: '公告内容不能为空!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){
                          $("#content1").focus();

                      }
                  },

              });
              return;
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
                              url : '${pageContext.request.contextPath}/config/updateNotice',
                              dataType : 'json',//此时指定的是后台需要返回json字符串,前端自己解析,可以注释掉.后台直接返回map
                              data : {
                                  id:id,
                                  title: title,
                                  content:content

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
        window.location.href="${pageContext.request.contextPath}/categoryList?pageNo=1";
      }
      function previousPage(pageNo){
          window.location.href="${pageContext.request.contextPath}/categoryList?pageNo="+pageNo;
      }
      function nextPage(pageNo){
          window.location.href="${pageContext.request.contextPath}/categoryList?pageNo="+pageNo;
      }
      function lastPage(pageNo){
          window.location.href="${pageContext.request.contextPath}/categoryList?pageNo="+pageNo;
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
                  alert("请求失败");
              }
          });
      }
      function showDetails(data) {
          $('#cname2 ').attr("value",data.category.cname );
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

 </script>
</body>
</html>
