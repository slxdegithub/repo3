<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>普惠金融</title>
    <link rel="stylesheet" href="css/index.css" type="text/css">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/home.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iconfont.css" type="text/css">

    <!-- 饼状图 -->
    <script src="js/echarts.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="js/jquery.SuperSlide.2.1.1.js"></script>
    <script src="laydate/laydate.js"></script> <!-- 日期插件 -->
</head>
<!--头部-->
<body  >
<c:import url="header.jsp"></c:import>

<div class="contentbox wid_main bora_5">
    <div class="content">
        <!-- 主体内容框 -->
        <div class="list_box col-xs-12">
            <div class="col-xs-9 about_box_1">
                <div class="col-xs-4 left_box">
                    <div class="img ">
                        <img class="img_b" src="images/about/count.png">
                    </div>
                    <div class="flex-column">
                        <text  class="text-yellow">服务资源个数</text>
                        <a href="#" class="black">已发布${pub}个</a>
                        <a href="#" class="black">已注册${reg}个</a>
                    </div>
                </div>
                <div class="col-xs-4 center_box">
                    <div class="img  ">
                        <img class="img_b"   src="images/about/kind.png">
                    </div>
                    <div class="flex-column">
                        <text  class="text-light-blue">服务类别</text>
                        <a href="#" class="black"> 服务类型${cag}种</a>
                        <a href="#" class="black"> 订阅次数${subCounts}个</a>
                    </div>
                </div>
                <div class="col-xs-4 right_box">
                    <div class="img">
                        <img class="img_b"  src="images/about/cishu.png">
                    </div>
                    <div class="flex-column">
                        <text  class="text-red">服务调用次数</text>
                        <a href="#" class="black"> 共访问${total}次</a>

                    </div>
                </div>


            </div>
        </div>

        <div class="biaoti_box">
            <div class="biaoti">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-fw fa-pie-chart " style="color: #00a7d0" aria-hidden="true"></i>已订阅服务类别占比</div>
            <div class="biaoti">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-fw fa-pie-chart"  style="color: #00a7d0" ></i>已发布服务数量类别占比</div>
            <div class="container_f" style="display: flex">
                <div id="container-a" style=" flex: 1; height: 400px;display: inline-block;"></div>
                <div id="container-c" style=" flex: 1; height: 400px;display: inline-block;"></div>
            </div>
        </div>
        <div class="biaoti_box">
            <div class="count_top">
                <i class="fa fa-fw fa-line-chart" style="color: black" aria-hidden="true"></i>
                系统运行情况
                <div class="seclect_data">
                    <i class="fa fa-fw fa-calendar"></i>
                    <san>选择查询时间  </san>
                    <input type="text" id="chooDate" style="border: 1px solid #aaa;">
                </div>

            </div>
            <div id="container-d" style="height:400px;margin: 0 auto;"></div>
        </div>

    </div>
</div>

<style>
    .biaoti{
        display: inline-block;
        width: 45%;
    }
</style>

<!-- 返回顶部 -->
<div class="side_box">
    <ul>
        <li class="sidetop">
            <span></span>
        </li>
    </ul>
</div>
<!-- 底部 -->
<div class="footerbox bg" style="height: auto;">
    <c:import url="footer.jsp"></c:import>
</div>
<script>

    $(function () {
        // alert(window.location.search)
        var chooDate = GetQueryString("chooDate")
        if (chooDate != null){
            $("#chooDate").attr('value',chooDate )
        }

    });

    //已订阅服务类别占比
    var doma = document.getElementById("container-a");
    var  echartsA = echarts.init(doma);
    echartsA.setOption({
        series: {
            type: 'pie',
            data:${OnePie},
            label : {
                normal : {
                    formatter: '{b}:{c}: ({d}%)',
                    textStyle : {
                        fontWeight : 'normal',
                        fontSize : 14
                    }
                }
            }
        }

    });
    $(window).resize(function(){
        console.log("1");
        echartsA.resize();

    });

    //服务类别占比饼状图
    var domC = document.getElementById("container-c");
    var  echartsC= echarts.init(domC);
    echartsC.setOption({
        series: {
            type: 'pie',
            data:${TolPie},
            label : {
                normal : {
                    formatter: '{b}:{c}: ({d}%)',
                    textStyle : {
                        fontWeight : 'normal',
                        fontSize : 14
                    }
                },
            }
        }

    });
    $(window).resize(function(){
        console.log("2");
        echartsC.resize();

    });
    //双折线图
    var dom = document.getElementById("container-d");
    var myChart = echarts.init(dom);
    var app = {};
    option = null;
    option = {

        tooltip: {
            trigger: 'axis'
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },

        xAxis: {
            type: 'category',
            boundaryGap: false,
            // data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
            data: ${daylist}
        },
        yAxis: {
            type: 'value'
        },
        series: [
            {
                name: '新增注册',
                type: 'line',
                stack: '注册',
                // data: [120, 132, 101, 134, 90, 230, 210]
                data:       [${dayCount0},
                    ${dayCount1},
                    ${dayCount2},
                    ${dayCount3},
                    ${dayCount4},
                    ${dayCount5},
                    ${dayCount6}]
            },
            {
                name: '新增订阅',
                type: 'line',
                stack: '订阅',
                // data: [220, 182, 191, 234, 290, 330, 310]
                data:       [${subCount0},
                    ${subCount1},
                    ${subCount2},
                    ${subCount3},
                    ${subCount4},
                    ${subCount5},
                    ${subCount6}]
            }, {
                name: '新增发布',
                type: 'line',
                stack: '发布',
                // data: [220, 182, 191, 234, 290, 330, 310]
                data: [${pubCount0},
                    ${pubCount1},
                    ${pubCount2},
                    ${pubCount3},
                    ${pubCount4},
                    ${pubCount5},
                    ${pubCount6}]
            }
        ]
    };

    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
    $(window).resize(function(){
        console.log("3");
        myChart.resize();
    });
</script>
<script>
    //执行一个laydate实例
    laydate.render({
        elem: '#chooDate', //指定元素
        format:'yyyy/MM/dd',
        done: function(datas){ //选择日期完毕的回调
            window.location.href =  "/about?chooDate=" +datas
        },
        showBottom: false
    });

    //通过url获取值的工具方法
    function GetQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

</script>
</body>
</html>
