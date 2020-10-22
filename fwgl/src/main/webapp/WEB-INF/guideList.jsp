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
    <!-- Ionicons 2.0.0 -->
    <link href="${pageContext.request.contextPath}/css/ionicons.min.css/" rel="stylesheet" type="text/css" />

</head>
<body style="position: relative;min-height: 730px">
<div class="zy_right_con">
    <!-- 内容展示块-->
    <div style="width: 100%;position: relative;">
        <h3>系统操作指南管理</h3>
        <c:if test="${guideList.size() eq 0}">
          <button type="button" id="btn_add" name="btn_add" class="btn btn-info" title="新建" style="margin-left:auto;position:absolute;top: 0;right: 0;bottom: 8px; " onclick="toUploadGuide();">
             <i class="fa fa-upload"></i>&nbsp;上传操作指南
          </button>
        </c:if>
        <hr style="border-top: 3px solid  #00a2e9;margin-top: 6px;margin-bottom: 0px;">
    </div>

    <%--内容展示块一 类别管理 --%>
    <div class="change_box"  >
        <table class="table-striped">
            <thead>
            <tr>
                <td>序号</td>
                <td>文件名称</td>
                <td>后缀名</td>
                <td>文件路径</td>
                <td>上传时间</td>
                <td>操作</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach varStatus="status" items="${guideList}" var="guide">
                <tr>
                    <td>${status.count}</td>
                    <td>${guide.fileName}</td>
                    <td>${guide.suffix}</td>
                    <td>${guide.filePath}</td>
                    <td>${guide.uploadTime}</td>
                    <td class="todo-list">
                        <div class="tools">
                            <span class="iconfont icon-xiazai" title="下载操作指南文件" onclick="downloadGuide('${guide.id}') "></span>
                            <span class="iconfont icon-shanchu" title="删除文件" onclick="delGuide('${guide.id}')"></span>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="modal fade bs-example-modal-lg" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myUploadModalLabel2">请选择上传文件<span style="color: red;font-size: large">(word或者pdf文档)</span></h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="uploadFile" class="ui_upload">上传文件</label>
                    <input type="file" multiple  id="uploadFile" name="uploadFile" style="width: 100%;outline:none" />
                </div>
                <div class="modal-footer">
                    <button type="button" id="close1" name="close" class="btn btn-secondary" data-dismiss="modal"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭</button>
                    <button type="button" id="btn_upload" class="btn btn-primary" onclick="ajaxFileUpload()"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>上传</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
 <script>
      function toUploadGuide(){
          $('#uploadModal').modal('show');
      }
      function delGuide(id){
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
                              url : '${pageContext.request.contextPath}/config/delGuide',
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
      function ajaxFileUpload() {
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
          if(ext!="pdf"&&ext!="docx"&&ext!="doc"&&ext!="DOCX"&&ext!="DOC"){
              $.alert({
                  title: '提示信息',
                  content: '请上传word或者pdf文件!',
                  icon: 'fa fa-info-circle',
                  buttons:{
                      确定:function(){}
                  },

              });
              return;
          }
          $.confirm({
              title: '提示信息',
              content: '确认上传文件吗？',
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
                              //contentType: false,//'multipart/form-data',
                              url : '${pageContext.request.contextPath}/config/uploadGuide',
                              type: 'POST',
                              secureuri : false,
                              fileElementId : 'uploadFile',
                              dataType : 'json',
                              data : {},
                              success : function(data) {
                                  var attr=data.result;
                                  if(attr==1){
                                      $.alert({
                                          title: '提示信息',
                                          content: '上传成功!',
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
                                          content: '上传文件失败!',
                                          icon: 'fa fa-info-circle',
                                          buttons:{
                                              确定:function(){}
                                          },

                                      });
                                  }
                              },
                              error : function() {
                                  $.alert({
                                      title: '提示信息',
                                      content: '上传文件失败!',
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
                  }
              }
          });
      }
      function downloadGuide(id){
          window.location.href="config/downloadfile";
      }
 </script>
</body>
</html>
