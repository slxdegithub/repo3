
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
    <link href="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- Ionicons 2.0.0 -->
    <link href="${pageContext.request.contextPath}/css/ionicons.min.css/" rel="stylesheet" type="text/css" />
<%--时间插件--%>
    <script src="${pageContext.request.contextPath}/laydate/laydate.js"></script>
</head>
<body style="position: relative;min-height: 730px">
<div class="zy_right_con">
    <!-- 内容展示块-->
    <div style="width: 100%;position: relative;">
        <h3>操作日志列表</h3>
        <div class="layui-inline">
            <div class="loginfo">
                <input type="text" class="search-input" id="logDate"  value="${time}" placeholder="选择时间范围" autocomplete="off" style="display: inline">
                <button class="butFind" onclick="queryLog();" id="search" style="height: 32px;">查询</button>
            </div>
        </div>
        <hr style="border-top: 3px solid #00a2e9;margin-top: 6px;margin-bottom: 0px;">
    </div>

    <%--内容展示块一 类别管理 --%>
    <div class="change_box"  >
        <table class="table-striped">
            <thead>
            <tr>
                <td>序号</td>
                <td>用户名称</td>
                <td>操作内容</td>
                <td>访问时间</td>
                <td>ip地址</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach varStatus="status" items="${logInfoList}" var="logInfo">
                <tr>
                    <td>${status.count+(curPage-1)*pageSize}</td>
                    <td>${logInfo.userName}</td>
                    <td>${logInfo.content}</td>
                    <td>${logInfo.accessTime}</td>
                    <td>${logInfo.ipAddress}</td>
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
</div>
<script src="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.js "></script>


 <script>
      function homePage(){
        window.location.href="${pageContext.request.contextPath}/logInfoList?pageNo=1&range="+$("#logDate").val()+"&pageSize="+$("#pageSize").val();
      }
      function previousPage(pageNo){
          window.location.href="${pageContext.request.contextPath}/logInfoList?pageNo="+pageNo+"&range="+$("#logDate").val()+"&pageSize="+$("#pageSize").val();
      }
      function nextPage(pageNo){
          window.location.href="${pageContext.request.contextPath}/logInfoList?pageNo="+pageNo+"&range="+$("#logDate").val()+"&pageSize="+$("#pageSize").val();
      }
      function lastPage(pageNo){
          window.location.href="${pageContext.request.contextPath}/logInfoList?pageNo="+pageNo+"&range="+$("#logDate").val()+"&pageSize="+$("#pageSize").val();
      };
      /* 时间查询  findType=3 时间查询 */
      laydate.render({
          elem: '#logDate', //指定元素
          range: true,
          theme: '#00c0ef',//主题显示
          trigger: 'click',// 事件类型
      });
     function queryLog(){
      var range=$("#logDate").val();
         startDate=range.substring(0,10);
         endDate=range.substring(13);
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
        window.location.href="${pageContext.request.contextPath}/logInfoList?range="+range+"&pageNo=1&pageSize="+$("#pageSize").val();
     }

      $("#pageSize").change(function(){
          var pageSize=$("#pageSize").val();
          var range=$("#logDate").val();
          window.location.href="${pageContext.request.contextPath}/logInfoList?range="+range+"&pageNo=1&pageSize="+pageSize;
      });
 </script>
</body>
</html>
