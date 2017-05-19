var $cur = 1;//初始化显示的版面
var $i = 3;//每版显示数
var $len = 5;//计算列表总长度(个数)
var $pages = Math.ceil($len / $i);//计算展示版面数量
var $w = 600;//取得展示区外围宽度
var $showbox = null;

$(document).ready(function(){
	
	 //@Mr.Think***向前滚动
	$(document).delegate('.article_pic_left_btn','click',function(e){
		$i = $(this).parent('div').attr('attrCount');//每版显示数
		$len = $(this).parent('div').find('.showbox>ul>li').length;
		$pages = Math.ceil($len / $i);//计算展示版面数量
		$w = $(this).parent('div').find('.puzzle_card').width();//取得展示区外围宽度
		console.log($i+"||len:"+$len+"||pages:"+$pages+"||w:"+$w);
		$showbox = $(this).parent('div').find('.showbox');
        if (!$showbox.is(':animated')) {  //判断展示区是否动画
            if ($cur == 1) {   //在第一个版面时,再向前滚动到最后一个版面
                $showbox.animate({
                   'margin-left': '-=' + $w * ($pages - 1)
                }, 500); //改变left值,切换显示版面,500(ms)为滚动时间,下同
                $cur = $pages; //初始化版面为最后一个版面
            }
            else {
                $showbox.animate({
                	'margin-left': '+=' + $w
                }, 500); //改变left值,切换显示版面
                $cur--; //版面累减
            }
        }
    });
    //@Mr.Think***向后滚动
	$(document).delegate('.article_pic_right_btn','click',function(e){
		$i = $(this).parent('div').attr('attrCount');//每版显示数
		$len = $(this).parent('div').find('.showbox>ul>li').length;
		$pages = Math.ceil($len / $i);//计算展示版面数量
		$w = $(this).parent('div').find('.puzzle_card').width();//取得展示区外围宽度
		console.log($i+"||len:"+$len+"||pages:"+$pages+"||w:"+$w);
		$showbox = $(this).parent('div').find('.showbox');
        if (!$showbox.is(':animated')) { //判断展示区是否动画
            if ($cur == $pages) {  //在最后一个版面时,再向后滚动到第一个版面
                $showbox.animate({
                	'margin-left': 0
                }, 500); //改变left值,切换显示版面,500(ms)为滚动时间,下同
                $cur = 1; //初始化版面为第一个版面
            }
            else {
                $showbox.animate({
                	'margin-left': '-=' + $w
                }, 500);//改变left值,切换显示版面
                $cur++; //版面数累加
            }
        }
    });
	
//	 //@Mr.Think***向前滚动
//	$(document).delegate('#cardArrowLeft','click',function(e){
//        if (!$showbox.is(':animated')) {  //判断展示区是否动画
//            if ($cur == 1) {   //在第一个版面时,再向前滚动到最后一个版面
//                $showbox.animate({
//                   'margin-left': '-=' + $w * ($pages - 1)
//                }, 500); //改变left值,切换显示版面,500(ms)为滚动时间,下同
//                $cur = $pages; //初始化版面为最后一个版面
//            }
//            else {
//                $showbox.animate({
//                	'margin-left': '+=' + $w
//                }, 500); //改变left值,切换显示版面
//                $cur--; //版面累减
//            }
//        }
//    });
//    //@Mr.Think***向后滚动
//	$(document).delegate('#cardArrowRight','click',function(e){
//        if (!$showbox.is(':animated')) { //判断展示区是否动画
//            if ($cur == $pages) {  //在最后一个版面时,再向后滚动到第一个版面
//                $showbox.animate({
//                	'margin-left': 0
//                }, 500); //改变left值,切换显示版面,500(ms)为滚动时间,下同
//                $cur = 1; //初始化版面为第一个版面
//            }
//            else {
//                $showbox.animate({
//                	'margin-left': '-=' + $w
//                }, 500);//改变left值,切换显示版面
//                $cur++; //版面数累加
//            }
//        }
//    });
})
   