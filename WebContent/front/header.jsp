<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<link href="/front/favicon.ico" rel="shortcut icon">
<script src="front/js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="front/js/jquery.backgroundpos.js" type="text/javascript"></script>
<script src="front/js/menu.js" type="text/javascript"></script>
<script type="text/javascript" src="front/js/slider.js"></script> 
<script src="front/js/jquery.fly.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="front/css/menu.css" type="text/css" />
<script src="front/js/ajaxfileupload.js" type="text/javascript"></script>
<script src="front/js/menu.js" type="text/javascript"></script>
<script src="front/js/doT.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="front/js/fancybox/jquery.fancybox.css" media="screen" />
<script type="text/javascript" src="front/js/fancybox/jquery.fancybox.js"></script>
<script type="text/javascript" src="front/js/mySlider.js"></script>
<link rel="stylesheet" href="front/css/pagination.css" type="text/css" />
<script src="front/js/jquery.pagination.js" type="text/javascript"></script>
<script src="front/js/main.js" type="text/javascript"></script>
<script src="front/js/jquery.Jcrop.js" type="text/javascript"></script>
<link rel="stylesheet" href="front/css/jquery.Jcrop.css">
<!-- 页面关键词 -->
<meta name="keywords" content="勾画,自媒体,新媒体,mcn,mpn"/>
<!-- 搜索引擎抓取 -->
<meta name="robots" content="勾画,自媒体,新媒体,mcn,mpn"/>
<meta name="baidu-site-verification" content="Q70aYGh0aa" />
<script type="text/javascript">
$(function(){
	var cartIds = getCookie("cartIds");
	if(cartIds!=null){
		var totalCount = cartIds.split(",").length-1;
		$('.headCartCount').html(totalCount);
	}else{
		$('.headCartCount').html(0);
	}
	$('#demo01').flexslider({
		animation: "slide",
		direction:"horizontal",
		easing:"swing"
	});
	$('.hoverFontb').hover(function(e){
		var classstr = $(this).attr('attrstr');
		if(!$("."+classstr).is(":hidden")){
		   return;
		}
		var imgStr = $($(this).find('img')).attr('src');
		imgStr = imgStr.substring(0,imgStr.indexOf("."))+"_white"+imgStr.substring(imgStr.indexOf("."),imgStr.length);
		$($(this).find('img')).attr('src',imgStr);
		$(this).css('background','#fc6769');
		$('.'+classstr).show();
	},function(e){
		var cname = e.relatedTarget.className;
		console.log(e.relatedTarget.className+"||"+cname.indexOf("div"));
		if(cname.indexOf("div")>=0){
			return;
		}
		var imgStr = $($(this).find('img')).attr('src');
		imgStr = imgStr.substring(0,imgStr.indexOf("_white"))+imgStr.substring(imgStr.indexOf("_white")+6,imgStr.length);
		$($(this).find('img')).attr('src',imgStr);
		$(this).css('background','white');
		var classstr = $(this).attr('attrstr');
		$('.'+classstr).hide();
	});
	$("#zimeitiregA").fancybox({
		'titlePosition': 'inside',
		'transitionIn': 'none',
		'transitionOut': 'none'
	});
	$("#zimeitiloginA").fancybox({
		'titlePosition': 'inside',
		'transitionIn': 'none',
		'transitionOut': 'none'
	});
	$("#qiyeregA").fancybox({
		'titlePosition': 'inside',
		'transitionIn': 'none',
		'transitionOut': 'none'
	});
	$("#qiyeloginA").fancybox({
		'titlePosition': 'inside',
		'transitionIn': 'none',
		'transitionOut': 'none'
	});
});
function register(type){
	$('.errormsg').hide();
	var companyname = null;
	var bname = '#zimeitiregDiv';
	if(type=='自媒体'){
		companyname=null;
		bname = '#zimeitiregDiv';
	}else{
		bname = '#qiyeregDiv';
		companyname = $(bname+' .companyname').val();
		if(companyname==''||companyname.length>12){
			$(bname+' .companynameMsg').html('公司名称不对');
			$(bname+' .companynameMsg').show();
			return;
		}
	}
	var mobile=$(bname+' .mobile').val();
	var mtest = /^1[34578]\d{9}$/;
	if(mobile==''||!mtest.test(mobile)){
		$(bname+' .mobileMsg').html('手机号不对');
		$(bname+' .mobileMsg').show();
		return;
	}
	var username=$(bname+' .username').val();
	if(username==''||username.length>10){
		$(bname+' .usernameMsg').html('姓名不对');
		$(bname+' .usernameMsg').show();
		return;
	}
	var etest = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
	var email= $(bname+' .email').val();
	if(type!='自媒体'){
		if(email==''||!etest.test(email)){
			$(bname+' .emailMsg').html('邮箱不对');
			$(bname+' .emailMsg').show();
			return;
		}
	}
	var password = $(bname+' .password').val();
	if(password==''||password.length>16||password<8){
		$(bname+' .passwordMsg').html('密码格式不对');
		$(bname+' .passwordMsg').show();
		return;
	}
	var repassword = $(bname+' .repassword').val();
	if(repassword!=password){
		$(bname+' .repasswordMsg').html('密码不一致');
		$(bname+' .repasswordMsg').show();
		return;
	}
	var qqweixin = $(bname+' .qqweixin').val();
	if(qqweixin==''||qqweixin.length>20){
		$(bname+' .qqweixinMsg').html('QQ或者微信格式不对');
		$(bname+' .qqweixinMsg').show();
		return;
	}
	var code = $(bname+' .code').val();
	//alert(code+"||regcode:"+regCode);
	if(code!=regCode){
		$(bname+' .codeMsg').html('验证码不正确');
		$(bname+' .codeMsg').show();
		return;
	}
	$.ajax({
		   type: "POST",
		   url: "../register",
		   data:{
			   'companyname':companyname,
			   'mobile'  :mobile,
			   'username'   :username,
			   'email'   :email,
			   'password'   :password,
			   'qqweixin'   :qqweixin,
			   'type'	:type
		   }, 
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				   if(type=='自媒体'){
					   $('#zimeitiloginA').click();
				   }else{
					   $('#qiyeloginA').click();
				   }
			   }
		   }
	});
}
function login(type){
	var bname = '#zimeitiloginDiv';
	if(type=='自媒体'){
		bname = '#zimeitiloginDiv';
	}else{
		bname = '#qiyeloginDiv';
	}
	var mobile=$(bname+' .loginmobile').val();
	var mtest = /^1[34578]\d{9}$/;
	if(mobile==''||!mtest.test(mobile)){
		$(bname+' .loginMsg').html('手机号不对');
		$(bname+' .loginMsg').show();
		return;
	}
	var password =$(bname+' .loginpassword').val();
	if(password==''||password.length>12||password<6){
		$(bname+' .loginMsg').html('密码格式不对');
		$(bname+' .loginMsg').show();
		return;
	}
	var ercode = $(bname+' .authCode').val();
	if(ercode==''||ercode.length!=4){
		$(bname+' .loginMsg').html('验证码不正确');
		$(bname+' .loginMsg').show();
		return;
	}
	$.ajax({
		   type: "POST",
		   url: "../login",
		   data:{
			   'mobile'  :mobile,
			   'password'   :password,
			   'strCode':ercode,
			   'type'   :type
		   }, 
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				   if(type=='自媒体'){
						location.href='../addCase';					   
				   }else{
					   location.reload();
				   }
			   }else{
				   $(bname+' .loginMsg').html(msg.reason);
				   $(bname+' .loginMsg').show();
			   }
		   }
	});
}
function exit(){
	$.ajax({
		   type: "POST",
		   url: "../exit",
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				   location.href="/";
			   }
		   }
	});
}
function vefityMobile(tt,index){
	var mobile = $(tt).val();
	console.log(mobile);
	var mtest = /^1[34578]\d{9}$/;
	if(mobile==''||!mtest.test(mobile)){
		$(tt).parent().find('.mobileMsg').html('手机号不对');
		$(tt).parent().find('.mobileMsg').show();
		return;
	}
	$.ajax({
		   type: "POST",
		   url: "../vefityMobile",
		   data:{
			   'index'  :index,
			   'mobile'   :mobile
		   }, 
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				   $(tt).parent().find('.mobileMsg').hide();
			   }else{
				   $(tt).parent().find('.mobileMsg').html('手机号已存在');
				   $(tt).parent().find('.mobileMsg').show();
			   }
		   }
	});
}
var regCode = 01;
function sendCodeMsg(tt,type){
	var bname = '#zimeitiregDiv';
	if(type=='自媒体'){
		bname = '#zimeitiregDiv';
	}else{
		bname = '#qiyeregDiv';
	}
	var mobile = $(bname+' .mobile').val();
	//alert(mobile);
	var mtest = /^([0-9]){11}$/;
	if(mobile==''||!mtest.test(mobile)){
		$(bname+' .mobileMsg').html('手机号不对');
		$(bname+' .mobileMsg').show();
		return;
	}
	var $this = $(tt);
	if($this.attr('flag')=='-1'){
		return;
	}
	$(bname+' .mobileMsg').hide();
	$.ajax({
		   type: "POST",
		   url: "../sendCodeMsg",
		   data:{
			   'mobile'  :mobile,
			   'type'   :type
		   }, 
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				   regCode = msg.code;
					$(bname+' .timeCount').show();
					$(bname+' .timeFont').html('获取验证码');
					$this.attr('flag','-1');
					$this.css('cursor','not-allowed');
					var time60=setInterval(function(){
						var cc=parseInt($(bname+' .timeCount').html().replace('(','').replace(')',''));
						if(cc==0){
							clearInterval(time60);
							$(bname+' .timeCount').html(' ( 60 )');
							$(bname+' .timeCount').hide();
							$(bname+' .timeFont').html('重新获取');
							$this.attr('flag','1');
							$this.css('cursor','pointer');
						}else{
							$(bname+' .timeCount').html('( '+(cc-1)+' )');
						}
					}, 1000);
			   }else{
				   $(bname+' .mobileMsg').html(msg.reason);
			   }
		   }
	});
}
function chageCode(index){
    $('.codeImage'+index).attr('src','../authCode?abc='+Math.random());//链接后添加Math.random，确保每次产生新的验证码，避免缓存问题。
}
</script>
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;font-family: 微软雅黑;}
a:link {color: #707070} 
.addpublishTable tr td{ text-align: left; vertical-align: middle; }
.hoverFont:hover{color:#fc6769 !important;cursor:pointer;}
.currentCas{border-bottom: 1px #fc6769 solid;color:#fc6769 !important;}
.currentbc{border-bottom:1px #000000 solid;}
.selectClass{color:#fc6769 !important;}
</style>
<div style="width:100%;background:rgb(242,242,242);height:40px;">
	<div style="width:1200px;margin:0 auto;font-size:12px;font-family: 微软雅黑;color:#707070;padding-top:13px;height:27px;">
		<div style="float:left;">
			<div style="float:left;">你好，欢迎来到勾画互动</div>
			<a id="zimeitiloginA" href="#zimeitiloginDiv" style="text-decoration: none;"><div style="float:left;margin-left:17px;" class="hoverFont">自媒体入口</div></a>
			<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
			<a id="zimeitiregA" href="#zimeitiregDiv" style="text-decoration: none;"><div style="float:left;margin-left:10px;" class="hoverFont">注册</div></a>
		</div>
		<div style="float:right;">
			<c:if test="${sessionScope.type==null||sessionScope.type!='自媒体' }">
				<div style="float:left;"><img src="front/images/shopping-cart.png" width="15px"/></div>
				<div onclick="location.href='/front/cartList.jsp'" style="float:left;margin-left:7px;" class="hoverFont"><i id="end"></i>购物车<span class="headCartCount" style="color:#fc6769;margin-left:3px;font-weight: bold;">3</span></div>
				<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
			</c:if>
			<div style="float:left;margin-left:10px;" class="hoverFont">消息中心</div>
			<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
			<div style="float:left;margin-left:10px;" class="hoverFont">帮助中心</div>
			<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
			<div style="float:left;margin-left:10px;" class="hoverFont">新媒体中心</div>
			<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
			<div style="float:left;margin-left:10px;" class="hoverFont"><a target="_blank" href="http://www.ghplat.com:8099/ipcity/">IP·City</a></div>
			<div style="float:left;margin-left:25px;"><img src="front/images/tel_small.png" width="16px"/></div>
			<div style="float:left;margin-left:5px;">18616878426</div>
		</div>
	</div>
</div>
<div style="width:100%;background:white;height:80px;">
	<div style="width:1200px;background:white;margin:0 auto;">
		<div style="float:left;margin-top:25px;">
			<a href="/"><img src="front/images/logo.png" height="40px"/></a>
		</div>
		<div class="header">
			<ul class="menu">
				<li><a href="/">首页</a></li>
				<c:if test="${sessionScope.type==null||sessionScope.type!='自媒体' }">
					<li><a href="getPublish">媒体推广</a></li>
				</c:if>
				<c:if test="${sessionScope.type!=null&&sessionScope.type=='广告主' }">
					<li><a href="persionad">投放中心</a></li>
				</c:if>
<!-- 				<li><a href="http://www.17sucai.com/">媒介合作</a></li> -->
				<li><a href="abortUs">关于我们</a></li>
			</ul>
		</div>
		<c:if test="${sessionScope.type==null }">
			<div style="float:right;margin-right:0px;margin-top:36px;">
				<div style="float:left;"><img src="front/images/login.png" style="width:25px;" /></div>
				<a id="qiyeloginA" href="#qiyeloginDiv" style="text-decoration: none;"><div class="hoverFont" style="float:left;margin-left:10px;color:#333333;font-size:14px;line-height: 25px;">企业主登录</div></a>
				<a id="qiyeregA" href="#qiyeregDiv" style="text-decoration: none;"><div class="hoverFont" style="float:left;margin-left:10px;color:#333333;font-size:14px;line-height: 25px;">注册</div></a>
			</div>
		</c:if>
		<c:if test="${sessionScope.type!=null }">
			<div style="float:right;margin-right:0px;margin-top:36px;">
				<div style="float:left;"><img src="front/images/login.png" style="width:25px;" /></div>
				<c:if test="${sessionScope.type!='自媒体' }">
					<a href="persionad" target="_blank"><div class="hoverFont" style="float:left;margin-left:10px;color:#333333;font-size:14px;line-height: 25px;">${sessionScope.user.username}</div></a>
				</c:if>
				<c:if test="${sessionScope.type=='自媒体' }">
					<a href="getOrderList" target="_blank"><div class="hoverFont" style="float:left;margin-left:10px;color:#333333;font-size:14px;line-height: 25px;">${sessionScope.user.username}</div></a>
					<a href="addCase" target="_blank"><div class="hoverFont" style="float:left;margin-left:15px;color:#333333;font-size:16px;line-height: 23px;">管理发布</div></a>
				</c:if>
				<div onclick="exit()" class="hoverFont" style="float:left;margin-left:15px;color:#333333;font-size:14px;line-height: 25px;">退出</div>
			</div>
		</c:if>
	</div>
</div>
<div id="rightDiv" style="width:56px;right:0px;background: white;position: fixed;top:335px;right:2px;z-index:999;">
	<div style="width:100%;position: relative;">
		<div class="hoverFontb" attrstr="div1" style="cursor:pointer;width: 36px;height:36px;padding:10px;border: 1px rgb(242,242,242) solid;position: relative;">
			<a href="tencent://AddContact/?fromId=45&fromSubId=1&subcmd=all&uin=2997558052&website=www.ghplat.com"><img src="front/images/online.png" /></a>
		</div>
		<div class="div1" style="position: absolute;top:0px;right:55px;width:140px;height:57px;background: white;display:none;">
			<div style="float:left;padding:15px;margin-left:-3px;margin-top:2px;"><img src="front/images/smile.png" width="25px" /></div>
			<div style="float:left;color:#333333;font-size:14px;line-height: 56px;margin-left:-4px;">点击我咨询哦</div>
			<div class="div" style="float:left;  font-size: 0;line-height: 0;border-width: 10px;border-color: white;border-right-width: 0; border-style: dashed;border-left-style: solid;border-top-color: transparent;border-bottom-color: transparent;position: absolute;top:19px;right:-10px;  "></div>
		</div>
		<div class="hoverFontb" attrstr="div2" style="cursor:pointer;width: 36px;height:36px;padding:10px;border: 1px rgb(242,242,242) solid;border-top:0px;border-bottom: 0px;"><img src="front/images/tel.png" /></div>
		<div class="div2" style="position: absolute;top:58px;right:55px;width:140px;height:57px;background: white;display:none;">
			<div style="width:100%;line-height: 57px;">
				<img src="front/images/number.png" style="margin-top:15px;width:93%;margin-left:4%;" />
			</div>
			<div class="div" style="float:left;  font-size: 0;line-height: 0;border-width: 10px;border-color: white;border-right-width: 0; border-style: dashed;border-left-style: solid;border-top-color: transparent;border-bottom-color: transparent;position: absolute;top:19px;right:-10px;  "></div>
		</div>
		<div class="hoverFontb" attrstr="div3" style="cursor:pointer;width: 36px;height:36px;padding:10px;border: 1px rgb(242,242,242) solid;"><img src="front/images/QR-Code.png" /></div>
		<div class="div3" style="position: absolute;top:116px;right:55px;width:140px;height:160px;background: white;display:none;">
			<div style="width:100%;padding:10px;padding-bottom: 0px;">
				<img src="front/images/erweima.jpg" style="width:120px;" />
			</div>
			<div style="width:100%;color:#333333;font-size:14px;text-align: center;padding-bottom: 15px;">扫一扫关注官方微信</div>
			<div class="div" style="float:left;  font-size: 0;line-height: 0;border-width: 10px;border-color: white;border-right-width: 0; border-style: dashed;border-left-style: solid;border-top-color: transparent;border-bottom-color: transparent;position: absolute;top:19px;right:-10px;  "></div>
		</div>
		<div onclick="$('body').scrollTop(0)" style="cursor:pointer;width: 16px;height:16px;padding:20px;border: 1px rgb(242,242,242) solid;border-top:0px;"><img src="front/images/top.png" /></div>
	</div>
</div>

<div style="display:none;">
	<div style="width:450px;height:auto;overflow: hidden;" id="zimeitiregDiv">
		<div style="width:100%;height:36px;color:#333333;font-size:18px;text-align: center;">自媒体注册</div>
		<div style="width:100%;height:1px;background:#e5e5e5;"></div>
		<div style="width:100%;margin-top:10px;">
			<div style="width:320px;margin:0 auto;margin-top:20px;position: relative;">
				<input onblur="vefityMobile(this,'自媒体')" class="mobile" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="用户名(手机号)" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="mobileMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">用户名已存在</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<input class="username" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="姓名" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="usernameMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">姓名不能超过5个字</div>
			</div>
<!-- 			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;"> -->
<!-- 				<input class="email" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="邮箱" /> -->
<!-- 				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span> -->
<!-- 				<div class="emailMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">邮箱格式不正确</div> -->
<!-- 			</div> -->
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<input class="password" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="password" placeholder="密码" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="passwordMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">密码必须6-12位</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<input class="repassword" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="password" placeholder="确认密码" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="repasswordMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">密码不一致</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<input class="qqweixin" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="QQ或者微信" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="qqweixinMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">QQ或者微信至少填写一个</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<div class="codeMsg" class="errormsg" style="display:none;color:red;top:14px;right:152px;position: absolute;font-size:12px;">验证码不正确</div>
				<input class="code" style="margin:0px;width:180px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="验证码" />
				<div onclick="sendCodeMsg(this,'自媒体')" style="float:left;height:42px;line-height: 42px;width:120px;text-align:center;color:black;font-size:14px;border: 1px #ebebeb solid;border-left: 0px;cursor: pointer; ">
				       <span class="timeFont">获取验证码</span><span class="timeCount" style="display:none;"> ( 60 )</span>
				</div>
				<span style="height:44px;margin-left:10px;line-height: 44px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div style="width:320px;margin-top:8px;font-size:12px;">
					注册即表示同意<a target="_blank" href="front/fuwu.html" style="color:#23527c;">服务协议</a>及<a href="#" style="color:#23527c;">隐私条款</a>
				</div>
			</div>
			<div onclick="register('自媒体')" style="width:320px;margin:0 auto;margin-top:12px;">
				<div style="cursor:pointer;width:300px;hegiht:48px;background:#fc6769;color:white; text-align: center;line-height: 48px;">注册</div>
				<div style="float:right;font-size:12px;margin:10px 20px 10px 0px;">已经是勾画会员？<a href="javascript:;" onclick="$('#zimeitiloginA').click();" style="color:#23527c;">登录</a></div>
			</div>
		</div>
	</div>
</div>
<div style="display:none;">
	<div style="width:450px;height:auto;overflow: hidden;" id="zimeitiloginDiv">
		<div style="width:100%;height:36px;color:#333333;font-size:18px;text-align: center;">自媒体登录</div>
		<div style="width:100%;height:1px;background:#e5e5e5;"></div>
		<div style="width:100%;margin-top:10px;">
			<div style="width:320px;margin:0 auto;margin-top:20px;">
				<input class="loginmobile" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="用户名(手机号)" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;">
				<input class="loginpassword" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="password" placeholder="密码" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:5px;height:40px;">
		 	      <div style="width:56px;line-height: 40px;float:left;font-size:14px;">验证码：</div> 
		 	      <div style="float:left;margin-left:3px;"><input style="width:70px;margin:0px;height:38px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" class="authCode" name="authCode" type="text"/></div>
		        <!--这里img标签的src属性的值为后台实现图片验证码方法的请求地址-->
		        <div style="float:left;margin-left:6px;"><img type="image" src="../authCode" class="codeImage1" onclick="chageCode(1)" title="图片看不清？点击重新得到验证码" style="cursor:pointer;"/></div>
		        <div style="width:50px;line-height: 40px;float:left;margin-left:10px;font-size:12px;"><a onclick="chageCode(1)" style="cursor: pointer;">换一张</a></div>
		    </div>
			<div style="width:320px;margin:0 auto;margin-top:12px;">
				<div onclick="login('自媒体')" style="cursor:pointer;width:300px;hegiht:48px;background:#fc6769;color:white; text-align: center;line-height: 48px;">登录</div>
				<div class="loginMsg" class="errormsg" style="display:none;color:red;font-size:12px;float:left;margin-left:5px;margin-top:10px;">用户名和密码不对</div>
				<div style="float:right;font-size:12px;margin:10px 20px 10px 0px;"><a href="front/person.jsp" style="color:#23527c;">忘记密码</a></div>
			</div>
		</div>
	</div>
</div>
<div style="display:none;">
	<div style="width:450px;height:auto;overflow: hidden;" id="qiyeregDiv">
		<div style="width:100%;height:36px;color:#333333;font-size:18px;text-align: center;">企业主注册</div>
		<div style="width:100%;height:1px;background:#e5e5e5;"></div>
		<div style="width:100%;margin-top:10px;">
			<div style="width:320px;margin:0 auto;margin-top:20px;position: relative;">
				<input onblur="vefityMobile(this,'广告主')" class="mobile" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="用户名(手机号)" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="mobileMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">用户名已存在</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<input class="username" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="姓名" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="usernameMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">姓名不能超过5个字</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<input class="companyname" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="企业名称" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="companynameMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">姓名不能超过5个字</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<input class="email" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="邮箱" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="emailMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">邮箱格式不正确</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<input class="password" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="password" placeholder="密码" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="passwordMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">密码必须6-12位</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<input class="repassword" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="password" placeholder="确认密码" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="repasswordMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">密码不一致</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<input class="qqweixin" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="QQ或者微信" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div class="qqweixinMsg" class="errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">QQ或者微信至少填写一个</div>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;position: relative;">
				<div class="codeMsg" class="errormsg" style="display:none;color:red;top:14px;right:152px;position: absolute;font-size:12px;">验证码不正确</div>
				<input class="code" style="margin:0px;width:180px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="验证码" />
				<div onclick="sendCodeMsg(this,'广告主')" style="float:left;height:42px;line-height: 42px;width:120px;text-align:center;color:black;font-size:14px;border: 1px #ebebeb solid;border-left: 0px;cursor: pointer; ">
				       <span class="timeFont">获取验证码</span><span class="timeCount" style="display:none;"> ( 60 )</span>
				</div>
				<span style="height:44px;margin-left:10px;line-height: 44px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
				<div style="width:320px;margin-top:8px;font-size:12px;">
					注册即表示同意<a target="_blank" href="front/fuwu.html" style="color:#23527c;">服务协议</a>及<a href="#" style="color:#23527c;">隐私条款</a>
				</div>
			</div>
			<div onclick="register('广告主')" style="width:320px;margin:0 auto;margin-top:12px;">
				<div style="cursor:pointer;width:300px;hegiht:48px;background:#fc6769;color:white; text-align: center;line-height: 48px;">注册</div>
				<div style="float:right;font-size:12px;margin:10px 20px 10px 0px;">已经是勾画会员？<a href="javascript:;" onclick="$('#qiyeloginA').click();" style="color:#23527c;">登录</a></div>
			</div>
		</div>
	</div>
</div>
<div style="display:none;">
	<div style="width:450px;height:auto;overflow: hidden;" id="qiyeloginDiv">
		<div style="width:100%;height:36px;color:#333333;font-size:18px;text-align: center;">企业主登录</div>
		<div style="width:100%;height:1px;background:#e5e5e5;"></div>
		<div style="width:100%;margin-top:10px;">
			<div style="width:320px;margin:0 auto;margin-top:20px;">
				<input class="loginmobile" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="用户名(手机号)" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:10px;">
				<input class="loginpassword" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="password" placeholder="密码" />
				<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
			</div>
			<div style="width:320px;margin:0 auto;margin-top:5px;height:40px;">
		 	      <div style="width:56px;line-height: 40px;float:left;font-size:14px;">验证码：</div> 
		 	      <div style="float:left;margin-left:3px;"><input style="width:70px;margin:0px;height:38px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" class="authCode" name="authCode" type="text"/></div>
		        <!--这里img标签的src属性的值为后台实现图片验证码方法的请求地址-->
		        <div style="float:left;margin-left:6px;"><img type="image" src="../authCode" class="codeImage2" onclick="chageCode(2)" title="图片看不清？点击重新得到验证码" style="cursor:pointer;"/></div>
		        <div style="width:50px;line-height: 40px;float:left;margin-left:10px;font-size:12px;"><a onclick="chageCode(2)" style="cursor: pointer;">换一张</a></div>
		    </div>
			<div style="width:320px;margin:0 auto;margin-top:12px;">
				<div onclick="login('广告主')" style="cursor:pointer;width:300px;hegiht:48px;background:#fc6769;color:white; text-align: center;line-height: 48px;">登录</div>
				<div class="loginMsg" class="errormsg" style="display:none;color:red;font-size:12px;float:left;margin-left:5px;margin-top:10px;">用户名和密码不对</div>
				<div style="float:right;font-size:12px;margin:10px 20px 10px 0px;"><a href="front/person.jsp" style="color:#23527c;">忘记密码</a></div>
			</div>
		</div>
	</div>
</div>
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?e8e9bd8552554338ed8bf193c027c620";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
<script>
(function(){
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https'){
   bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';
  }
  else{
  bp.src = 'http://push.zhanzhang.baidu.com/push.js';
  }
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>