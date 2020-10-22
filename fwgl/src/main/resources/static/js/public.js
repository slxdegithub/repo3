

$(function(){
   // 侧边栏
   //  $(".el-submenu").attr('aria-expanded="true"');
   //  $(".el-submenu").addClass("is-opened");
   //  $(".el-menu--inline").css('display','block');
   // 底部高度自适应
    function footerPosition(){
        $(".footerbox").removeClass("fixed-bottom");
        var contentHeight = document.body.scrollHeight,//网页正文全文高度
            winHeight = window.innerHeight;//可视窗口高度，不包括浏览器顶部工具栏
        if(!(contentHeight > winHeight)){
//当网页正文高度小于可视窗口高度时，为footer添加类fixed-bottom
            $(".footerbox").addClass("fixed-bottom");
        } else {
            $(".footerbox").removeClass("fixed-bottom");
        }
    }
    footerPosition();
    // $(window).resize(footerPosition);
    window.onresize = function(){
        footerPosition();
    }
})

