<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/6
  Time: 22:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="col-xs-12">
    <h4>功能管理</h4>
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">
                <li class=" treeview">
                    <a href="#">
                        <i class="fa fa-dashboard"></i> <span>服务管理</span> <i class="fa fa-angle-left pull-right"></i>
                    </a>
                    <ul class="treeview-menu">
                        <li><a href="categoryList?pageNo=1"><i class="fa fa-circle-o"></i> 服务类别管理 </a></li>
                        <li><a href="serviceInfoList?pageNo=1"><i class="fa fa-circle-o"></i>服务注册管理</a></li>
                        <li><a href="invalidService"><i class="fa fa-circle-o"></i> 服务作废 </a></li>
                    </ul>
                </li>
                <li class="treeview">
                    <a href="userCenter ">
                        <i class="fa fa-files-o"></i>
                        <span>我订阅的服务</span>
                        <span class="label label-primary pull-right">4</span>
                    </a>
                </li>
                <li>
                    <a href=" ">
                        <i class="fa fa-th"></i> <span>统计分析</span> <small class="label pull-right bg-green">new</small>
                    </a>
                </li>

            </ul>
        </section>
        <!-- /.sidebar -->
</div>

</body>
</html>
