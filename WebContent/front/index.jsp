<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<base href="/ghplat/front/">
<link rel="stylesheet" href="css/menu.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="js/jquery.backgroundpos.js" type="text/javascript"></script>
<script src="js/menu.js" type="text/javascript"></script>
<script type="text/javascript" src="js/slider.js"></script> 
<script type="text/javascript">
$(function(){
	$('#demo01').flexslider({
		animation: "slide",
		direction:"horizontal",
		easing:"swing"
	});
	$('.hoverFontb').hover(function(){
		var imgStr = $($(this).find('img')).attr('src');
		imgStr = imgStr.substring(0,imgStr.indexOf("."))+"_white"+imgStr.substring(imgStr.indexOf("."),imgStr.length);
		$($(this).find('img')).attr('src',imgStr);
		$(this).css('background','#fc6769');
	},function(){
		var imgStr = $($(this).find('img')).attr('src');
		imgStr = imgStr.substring(0,imgStr.indexOf("_white"))+imgStr.substring(imgStr.indexOf("_white")+6,imgStr.length);
		$($(this).find('img')).attr('src',imgStr);
		$(this).css('background','white');
	});
});
</script>
<style type="text/css">
.hoverFont:hover{color:#fc6769;cursor:pointer;}
</style>
</head>
<body style="padding:0px;margin:0px;">
	<div style="width:100%;background:rgb(242,242,242);height:40px;">
		<div style="width:1200px;margin:0 auto;font-size:12px;font-family: 微软雅黑;color:#707070;padding-top:13px;height:27px;">
			<div style="float:left;">
				<div style="float:left;">你好，欢迎来到勾画互动</div>
				<div style="float:left;margin-left:17px;" class="hoverFont">企业主入口</div>
				<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
				<div style="float:left;margin-left:10px;" class="hoverFont">自媒体入口</div>
			</div>
			<div style="float:right;">
				<div style="float:left;"><img src="images/shopping-cart.png" width="15px"/></div>
				<div style="float:left;margin-left:7px;" class="hoverFont">购物车<span style="color:#fc6769;margin-left:3px;font-weight: bold;">3</span></div>
				<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
				<div style="float:left;margin-left:10px;" class="hoverFont">消息中心</div>
				<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
				<div style="float:left;margin-left:10px;" class="hoverFont">帮助中心</div>
				<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
				<div style="float:left;margin-left:10px;" class="hoverFont">新媒体中心</div>
				<div style="float:left;margin-left:25px;"><img src="images/tel_small.png" width="16px"/></div>
				<div style="float:left;margin-left:5px;">18616878426</div>
			</div>
		</div>
	</div>
	<div style="width:100%;background:white;height:40px;">
		<div style="width:1200px;background:white;margin:0 auto;">
			<div style="float:left;margin-top:25px;">
				<img src="images/logo.png" height="40px"/>
			</div>
			<div class="header">
				<ul class="menu">
					<li class="current first"><a href="http://www.17sucai.com/">首页</a></li>
					<li><a href="http://www.17sucai.com/">案例</a></li>
					<li><a href="http://www.17sucai.com/">媒介合作</a></li>
					<li><a class="noclick" href="http://www.17sucai.com/">关于我们</a></li>
				</ul>
			</div>
		</div>
	</div>
		<div style="width:100%;margin:0 auto;">
			<div id="demo01" class="flexslider">
				<ul class="slides">
					<c:forEach var="banner" items="${bannerlist.list }">
						<li><div class="img"><img src="/ghplat/attachment/banner/${banner.image }" width="100%" alt="" /></div></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div style="width:100%;background:rgb(242,242,242);height:380px;">
			<div style="font-size:24px;color:#333333;width:1200px;text-align: left;margin:0 auto;padding-top:30px;padding-bottom: 8px;">自媒体展示</div>
			<div style="width:1200px;height:1px;background:#707070;margin:0 auto;"></div>
			<div style="width:1200px;margin:0 auto;margin-top:20px;">
				<div style="float:left;width:210px;height:280px;position: relative;background: white;margin-left:4px;margin-top:4px;">
					<div style="position: absolute;top:-4px;left:-4px;width:76px;text-align: center;height:22px;line-height: 22px;font-size:12px;color:#ffffff;background: rgb(37,202,154);">微信公众号</div>
					<div style="margin:0 auto;padding-top:30px;padding-left:25px;padding-right:25px;width:160px;height:180px;">
						<img src="images/a11.png" width="160px" height="180px" />
					</div>
					<div style="width:160px;margin:0 auto;font-size:14px;color:#333333;margin-top:10px;">MMMMIKA_米大仙</div>
					<div style="width:160px;margin:0 auto;margin-top:10px;color:#333333;">
						<div style="width:18px;height:18px;float:left;"><img src="images/fans.png" width="18px" /></div>
						<div style="float:left;margin-left:8px;font-size:13px;line-height: 18px;">14152</div>
						<div style="width:18px;height:18px;float:right;"><img src="images/weixin.png" width="18px" /></div>
					</div>
				</div>
				<div style="float:left;width:210px;height:280px;position: relative;background: white;margin-left:36px;margin-top:4px;">
					<div style="position: absolute;top:-4px;left:-4px;width:76px;text-align: center;height:22px;line-height: 22px;font-size:12px;color:#ffffff;background: rgb(37,202,154);">微信公众号</div>
					<div style="margin:0 auto;padding-top:30px;padding-left:25px;padding-right:25px;width:160px;height:180px;">
						<img src="images/a11.png" width="160px" height="180px" />
					</div>
					<div style="width:160px;margin:0 auto;font-size:14px;color:#333333;margin-top:10px;">MMMMIKA_米大仙</div>
					<div style="width:160px;margin:0 auto;margin-top:10px;color:#333333;">
						<div style="width:18px;height:18px;float:left;"><img src="images/fans.png" width="18px" /></div>
						<div style="float:left;margin-left:8px;font-size:13px;line-height: 18px;">14152</div>
						<div style="width:18px;height:18px;float:right;"><img src="images/weixin.png" width="18px" /></div>
					</div>
				</div>
				<div style="float:left;width:210px;height:280px;position: relative;background: white;margin-left:36px;margin-top:4px;">
					<div style="position: absolute;top:-4px;left:-4px;width:76px;text-align: center;height:22px;line-height: 22px;font-size:12px;color:#ffffff;background: rgb(37,202,154);">微信公众号</div>
					<div style="margin:0 auto;padding-top:30px;padding-left:25px;padding-right:25px;width:160px;height:180px;">
						<img src="images/a11.png" width="160px" height="180px" />
					</div>
					<div style="width:160px;margin:0 auto;font-size:14px;color:#333333;margin-top:10px;">MMMMIKA_米大仙</div>
					<div style="width:160px;margin:0 auto;margin-top:10px;color:#333333;">
						<div style="width:18px;height:18px;float:left;"><img src="images/fans.png" width="18px" /></div>
						<div style="float:left;margin-left:8px;font-size:13px;line-height: 18px;">14152</div>
						<div style="width:18px;height:18px;float:right;"><img src="images/weixin.png" width="18px" /></div>
					</div>
				</div>
				<div style="float:left;width:210px;height:280px;position: relative;background: white;margin-left:36px;margin-top:4px;">
					<div style="position: absolute;top:-4px;left:-4px;width:76px;text-align: center;height:22px;line-height: 22px;font-size:12px;color:#ffffff;background: rgb(37,202,154);">微信公众号</div>
					<div style="margin:0 auto;padding-top:30px;padding-left:25px;padding-right:25px;width:160px;height:180px;">
						<img src="images/a11.png" width="160px" height="180px" />
					</div>
					<div style="width:160px;margin:0 auto;font-size:14px;color:#333333;margin-top:10px;">MMMMIKA_米大仙</div>
					<div style="width:160px;margin:0 auto;margin-top:10px;color:#333333;">
						<div style="width:18px;height:18px;float:left;"><img src="images/fans.png" width="18px" /></div>
						<div style="float:left;margin-left:8px;font-size:13px;line-height: 18px;">14152</div>
						<div style="width:18px;height:18px;float:right;"><img src="images/weixin.png" width="18px" /></div>
					</div>
				</div>
				<div style="float:left;width:210px;height:280px;position: relative;background: white;margin-left:36px;margin-top:4px;">
					<div style="position: absolute;top:-4px;left:-4px;width:76px;text-align: center;height:22px;line-height: 22px;font-size:12px;color:#ffffff;background: rgb(37,202,154);">微信公众号</div>
					<div style="margin:0 auto;padding-top:30px;padding-left:25px;padding-right:25px;width:160px;height:180px;">
						<img src="images/a11.png" width="160px" height="180px" />
					</div>
					<div style="width:160px;margin:0 auto;font-size:14px;color:#333333;margin-top:10px;">MMMMIKA_米大仙</div>
					<div style="width:160px;margin:0 auto;margin-top:10px;color:#333333;">
						<div style="width:18px;height:18px;float:left;"><img src="images/fans.png" width="18px" /></div>
						<div style="float:left;margin-left:8px;font-size:13px;line-height: 18px;">14152</div>
						<div style="width:18px;height:18px;float:right;"><img src="images/weixin.png" width="18px" /></div>
					</div>
				</div>
			</div>
		</div>
		<div style="width:100%;background:rgb(242,242,242);">
			<div style="font-size:24px;color:#333333;width:1200px;text-align: left;margin:0 auto;padding-top:30px;padding-bottom: 8px;">联合推广资源</div>
			<div style="width:1200px;height:1px;background:#707070;margin:0 auto;"></div>
			<c:forEach var="tuiguang" items="${tuiguangs.list }">
				<div style="width:1200px;height:88px;margin:0 auto;margin-top:20px;">
					<img src="/ghplat/attachment/banner/${tuiguang.image}" width="100%"/>
				</div>
			</c:forEach>
		</div>
		<div style="width:100%;background:rgb(242,242,242);border-bottom: 1px #707070 solid;">
			<div style="font-size:24px;color:#333333;width:1200px;text-align: left;margin:0 auto;padding-top:30px;padding-bottom: 8px;">我们的合作伙伴</div>
			<div style="width:1200px;height:1px;background:#707070;margin:0 auto;"></div>
			<div style="width:1200px;margin:0 auto;margin-top:20px;margin-bottom: 20px;height:220px;">
				<c:forEach var="hezuo" items="${hezuos.list }">
					<div style="width:224px;height:88px;float:left;margin-left:0px;">
						<img src="/ghplat/attachment/banner/${hezuo.image}" width="100%"/>
					</div>
				</c:forEach>
				<div style="width:224px;height:88px;float:left;margin-left:20px;">
					<img src="images/ahezuo1.png" width="100%"/>
				</div>
				<div style="width:224px;height:88px;float:left;margin-left:20px;">
					<img src="images/ahezuo1.png" width="100%"/>
				</div>
				<div style="width:224px;height:88px;float:left;margin-left:20px;">
					<img src="images/ahezuo1.png" width="100%"/>
				</div>
				<div style="width:224px;height:88px;float:left;margin-left:20px;">
					<img src="images/ahezuo1.png" width="100%"/>
				</div>
				<div style="width:224px;height:88px;float:left;margin-left:0px;margin-top:20px;">
					<img src="images/ahezuo1.png" width="100%"/>
				</div>
				<div style="width:224px;height:88px;float:left;margin-left:20px;margin-top:20px;">
					<img src="images/ahezuo1.png" width="100%"/>
				</div>
				<div style="width:224px;height:88px;float:left;margin-left:20px;margin-top:20px;">
					<img src="images/ahezuo1.png" width="100%"/>
				</div>
				<div style="width:224px;height:88px;float:left;margin-left:20px;margin-top:20px;">
					<img src="images/ahezuo1.png" width="100%"/>
				</div>
				<div style="width:224px;height:88px;float:left;margin-left:20px;margin-top:20px;">
					<img src="images/ahezuo1.png" width="100%"/>
				</div>
			</div>
		</div>
		<div style="width:100%;height:110px;background: white;">
			<div style="width:275px;margin:0 auto;padding-top:20px;font-size:12px;color:#707070">
				<div style="width:100%;text-align:center;height: 15px;">
					<div style="float:left;margin-left:10px;" class="hoverFont">关于我们</div>
					<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
					<div style="float:left;margin-left:10px;" class="hoverFont">联系我们</div>
					<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
					<div style="float:left;margin-left:10px;" class="hoverFont">商家帮助</div>
					<div style="float:left;width:1px;height:11px;background:#707070;margin-left:10px;margin-top:3px;"></div>
					<div style="float:left;margin-left:10px;" class="hoverFont">友情链接</div>
				</div>
				<div style="width:100%;text-align: center;margin-top:10px;">
					版权所有© 2016 勾画互动 沪ICP备 16039901号
				</div>
				<div style="width:100%;text-align: center;margin-top:10px;">
					上海勾画网络科技有限公司
				</div>
			</div>
		</div>
<div id="rightDiv" style="width:56px;right:0px;background: white;position: fixed;top:200px;right:2px;">
	<div style="width:100%;position: relative;">
		<div class="hoverFontb" style="cursor:pointer;width: 36px;height:36px;padding:10px;border: 1px rgb(242,242,242) solid;position: relative;">
			<img src="images/online.png" />
			<div style="position: absolute;top:0px;right:57px;width:140px;height:56px;background: white;">
				<div style="float:left;padding:16px;margin-left:-7px;"><img src="images/smile.png" width="24px" /></div>
				<div style="float:left;color:#333333;font-size:14px;line-height: 56px;margin-left:-7px;">点击我咨询哦</div>
				<div style="float:left;  font-size: 0;line-height: 0;border-width: 10px;border-color: red;border-right-width: 0; border-style: dashed;border-left-style: solid;border-top-color: transparent;border-bottom-color: transparent;  "></div>
			</div>
		</div>
		<div class="hoverFontb" style="cursor:pointer;width: 36px;height:36px;padding:10px;border: 1px rgb(242,242,242) solid;border-top:0px;border-bottom: 0px;"><img src="images/tel.png" /></div>
		<div class="hoverFontb" style="cursor:pointer;width: 36px;height:36px;padding:10px;border: 1px rgb(242,242,242) solid;"><img src="images/QR-Code.png" /></div>
		<div style="cursor:pointer;width: 16px;height:16px;padding:20px;border: 1px rgb(242,242,242) solid;border-top:0px;"><img src="images/top.png" /></div>
	</div>
</div>
</body>
</html>