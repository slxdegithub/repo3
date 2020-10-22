<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
    <meta charset="utf-8">
    <meta name="applicable-device" content="pc,mobile">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta http-equiv="Cache-Control" content="no-transform"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>普惠金融</title>
    <%--页面css--%>
    <link rel="stylesheet" href="css/home.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iconfont.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
    <link href="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <%--日期插件--%>
    <script src="${pageContext.request.contextPath}/laydate/laydate.js"></script>
       <!-- Ionicons 2.0.0 -->
    <link href="${pageContext.request.contextPath}/css/ionicons.min.css/" rel="stylesheet" type="text/css" />
    <%--查看表格--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index_table.css" type="text/css">

</head>
<body>
<!-- 引入导航栏-->
<c:import url="header.jsp"></c:import>

<!-- 主体内容框 -->
<div class="  h_contentbox  ">
    <div class="content col-xs-10">
        <div class="list_box   col-xs-12">
            <div class="search  ">
                <input type="text" placeholder="搜索数据服务" class="search-input" id="searchName"/>
               <span class="search_icon">
                   <i class="glyphicon glyphicon-search " onclick="search()"></i>
               </span>
            </div>
        </div>
        <%--广告栏 --%>
        <div class="list_box new_div col-xs-12">
            <div class="gong_img">

                <div class="new_right"></div>
                <div class="new_right1"></div>
                <div class="news_title">最新公告</div>
            </div>
            <div id="wrap">
                <div id="first">
                    <span>${notice.title}</span>
                    <c:if test="${notice ne null}">
                        :
                    </c:if>
                    ${notice.content}
                </div>
            </div>
        </div>
        <%--小图标--%>
        <div class="list_box col-xs-12">
            <div class="col-xs-9 box_1">
                <div class="col-xs-4 left_box">
                    <div class="img ">
                        <img class="img_b" src="images/index/ziyuan.png">
                    </div>
                    <div class="flex-column">
                        <text class="text-yellow">${reg}次</text>
                        <a href="#" class="black">已注册服务</a>
                        <text class="text-yellow">${pub}次</text>
                        <a href="#" class="black">已发布服务 </a>
                    </div>
                </div>
                <div class="col-xs-4 center_box">
                    <div class="img  ">
                        <img src="images/index/shuju.png">
                    </div>
                    <div class="flex-column">
                        <text class="text-light-blue">${cag}种</text>
                        <a href="#" class="black">服务目录</a>
                        <text class="text-light-blue">${subCounts}次</text>
                        <a href="#" class="black">订阅次数</a>
                    </div>
                </div>
                <div class="col-xs-4 right_box">
                    <div class="img">
                        <img src="images/index/shenqing.png">
                    </div>
                    <div class="flex-column">

                        <text class="text-red">${total}次</text>
                        <a href="#" class="black">服务调用</a>
                    </div>
                </div>
            </div>
            <div class="img col-xs-3 box_2 flex-column">
                <img class="img_b" src="images/index/zhinan.png">
                <a href="#" class="black" onclick="downloadGuide();" title="点击下载系统操作手册">操作手册</a>
            </div>
        </div>
        <%--最新资源--%>
        <div class="  box-primary res_left col-xs-9">
            <div class="col-xs-12 div-header">
                <div class="left_text">
                    <span class="glyphicon glyphicon-time" style="font-size: 16px;"></span>
                    <span>资源最新更新</span>
                </div>
                <div class="right_text">
                    <a href="javascript:todateSort(1)" >更多
                        <span class="iconfont icon-gengduo"></span>
                    </a>
                </div>
            </div>
            <div class="row col-xs-12">
                <div class=" col-sm-12 col-md-12 col-lg-4  ">
                    <div class=" card ">

                        <div class="card-detail sub_font">
                            ${new0.name}
                        </div>
                        <div class="card-name">
                            ${new0.createTime} <span>更新</span>
                        </div>
                        <div class="card-bottom">
                            <p class="text-describe  list1 sub_font ">目录名称: <span>${new0.cancelTime}</span></p>
                            <p class="text-describe  list2 sub_font">版本号：<span>${new0.version}</span></p>
                            <p class="text-describe  list3 sub_font">服务url：<span>${new0.address}</span></p>
                            <p class="text-function sub_font2">
                                功能描述: <span>${new0.name}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class=" col-sm-12 col-md-12 col-lg-4    ">
                    <div class=" card ">

                        <div class="card-detail sub_font">
                            ${new1.name}
                        </div>
                        <div class="card-name">
                            ${new1.createTime}<span>更新</span>
                        </div>
                        <div class="card-bottom">
                            <p class="text-describe  list1 sub_font ">目录名称: <span>${new1.cancelTime}</span></p>
                            <p class="text-describe  list2 sub_font">版本号：<span>${new1.version}</span></p>
                            <p class="text-describe  list3 sub_font">服务url：<span>${new1.address}</span></p>
                            <p class="text-function sub_font2">
                                功能描述: <span>${new1.name}</span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class=" col-sm-12 col-md-12 col-lg-4  ">
                    <div class=" card ">
                        <div class="card-detail sub_font">
                            ${new2.name}
                        </div>
                        <div class="card-name">
                            ${new2.createTime} <span>更新</span>
                        </div>
                        <div class="card-bottom">
                            <p class="text-describe  list1 sub_font ">目录名称: <span>${new2.cancelTime}</span></p>
                            <p class="text-describe  list2 sub_font">版本号：<span>${new2.version}</span></p>
                            <p class="text-describe  list3 sub_font">服务url：<span>${new2.address}</span></p>
                            <p class="text-function sub_font2">
                                功能描述: <span>${new2.name}</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <%--热门资源--%>
        <div class="  box-primary res_right col-xs-3">
            <div class="col-xs-12 div-header">
                <div class="left_text2 ">
                    <i class="glyphicon glyphicon-fire" style="color: red"></i>
                    <span>热门资源</span>
                </div>
                <div class="right_text">
                    <a href="fuwu?page=1&search=&flag=2" id="hostbox">更多
                        <span class="iconfont icon-gengduo"></span>
                    </a>
                </div>
            </div>
            <div class="col-xs-12 boxbottom">


                <div class="left">
                    <a href="#" onclick="showServiceInfo('${hotService0.id}');" title="查看服务注册详情">
                        <span>${hotService0.name}</span>
                    </a>
                </div>
                <div class="left">
                    <a href="#" onclick="showServiceInfo('${hotService1.id}');" title="查看服务注册详情">
                        <span>${hotService1.name}</span>
                    </a>

                </div>
                <div class="left">
                    <a href="#" onclick="showServiceInfo('${hotService2.id}');" title="查看服务注册详情">
                        <span>${hotService2.name}</span>
                    </a>
                </div>
                <div class="left">
                    <a href="#" onclick="showServiceInfo('${hotService3.id}');" title="查看服务注册详情">
                        <span>${hotService3.name}</span>
                    </a>
                </div>
                <div class="left">
                    <a href="#" onclick="showServiceInfo('${hotService4.id}');" title="查看服务注册详情">
                        <span>${hotService4.name}</span>
                    </a>
                </div>
                <div class="left">
                    <a href="#" onclick="showServiceInfo('${hotService5.id}');" title="查看服务注册详情">
                        <span>${hotService5.name}</span>
                    </a>
                </div>
                <div class="left  sub_font ">
                    <a href="#" onclick="showServiceInfo('${hotService6.id}');" title="查看服务注册详情">
                        <span>${hotService6.name} </span>
                    </a>
                </div>
            </div>
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
                    <button type="button" id="btn_download" class="btn btn-info" style="color: #444" onclick="downServiceFile();"><span class="iconfont icon-wendang" aria-hidden="true"></span>下载附件</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- <引入底部-->
<footer class="footer col-xs-12">
    <c:import url="footer.jsp"></c:import>
</footer>
<script src="${pageContext.request.contextPath}/plugins/jqueryComfirm/jquery-confirm.min.js "></script>
<script>

    var storge = window.localStorage;

    function todateSort(data) {

        // storge.flag == data
        // alert(data)
        // alert(storge.flag)
        storge.searchs = 666
        window.location.href = "fuwu?page=1&search=&flag=1"
    }

    function tohotSort(data) {
        // storge.flag == data
        // alert(data)
        // alert(storge.flag)
        storge.searchs = 666
        window.location.href = "/fuwu?page=1&search=&flag=2"

    }

    <%--跑马灯--%>
    function scroll(obj) {
        var tmp = (obj.scrollLeft)++;
        //当滚动条到达右边顶端时
        if (obj.scrollLeft==tmp) obj.innerHTML += obj.innerHTML;
        //当滚动条滚动了初始内容的宽度时滚动条回到最左端
        if (obj.scrollLeft>=obj.firstChild.offsetWidth) obj.scrollLeft=0;
    }
    setInterval("scroll(document.getElementById('wrap'))",20);

    function downloadGuide(){
        window.location.href="config/downloadfile";
    }

</script>
<script>
    var a = document.getElementById("searchName");
    function search() {
        storge.searchName = a.value
        // storge.indexSearch = a.value
        // storge.flag = 666 ;
        // alert(storge.flag.toString())
        // alert(storge.searchName)
        // window.location.href = "/fuwu?page=1&search="+a.value ;

        // storge.searchName = a.value
        storge.searchs = 666;
        storge.flag = 0;
        // alert(storge.flag.toString())
        // alert(storge.searchName)
        window.location.href = "/fuwu?page=1&search=" + a.value + "&flag=" + storge.flag;
    }
    //输入框调用回车事件 按类别搜索
    $('#searchName').bind('keypress',function(event){
        if(event.keyCode == "13")
        {
            search();
        }
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
        $("#stype2").attr("value",data.serviceType.name);
        //$("#stype2").attr("value", "RPC");
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
</script>
</body>
</html>
