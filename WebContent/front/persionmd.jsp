<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加投放</title>
<script type="text/javascript" src="front/js/jquery-1.8.2.min.js"></script> 
<script type="text/javascript" src="front/js/delivery/layer.js"></script>
<script type="text/javascript" src="front/js/delivery/H-ui.js"></script>
<script type="text/javascript" src="front/js/delivery/H-ui.admin.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('dt').click(function(){
			$('.backDiv').css('background','');
			$(this).find('.backDiv').css('background','rgb(235,100,100)');
			$('.totalDiv').css('background','');
			$(this).find('.totalDiv').css('background','rgb(46,46,46)');
			$('.imageDiv').attr('src','front/images/4.png');
			$(this).find('.imageDiv').attr('src','front/images/2.png');
		})
	})
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
</script>
<style>
dl>dd>ul>li:hover{
	background: rgb(61,61,61);
}
.hoverFont:hover{color:#fc6769 !important;cursor:pointer;}
</style>
</head>
<body style="font-family: 微软雅黑;padding:0px;margin:0px;">
<div style="width:100%;height:auto;overflow: hidden;background:white;">
	<div style="float:left;padding:10px 0px 7px 30px;">
		<a href="/"><img src="front/images/logo.png" height="40px"/></a>
	</div>
	<div style="float:right;margin-right:0px;margin-top:22px;">
		<div style="float:left;cursor:pointer;margin-top:-1px;"><img src="front/images/pp.png" style="width:25px;" /></div>
		<a href="persionad"><div class="hoverFont" style="float:left;margin-left:6px;color:#333333;font-size:16px;line-height: 24px;">${sessionScope.user.username}</div></a>
		<c:if test="${sessionScope.type=='自媒体' }">
			<a href="addCase"><div class="hoverFont" style="float:left;margin-left:20px;color:#333333;font-size:16px;line-height: 23px;">管理发布</div></a>
		</c:if>
		<div style="float:left;width:1px;height:20px;background:#707070;margin-left:12px;margin-top:3px;"></div>
		<div onclick="exit()" class="hoverFont" style="cursor:pointer;float:right;margin-right:20px;color:rgb(71,71,71);font-size:16px;line-height: 22px;">
		退出</div>
		<div style="float:right;margin-right:6px;margin-left:10px;cursor:pointer;"><img src="front/images/exit.png" style="width:25px;" /></div>
	</div>
</div>
<div style="width:100%;height:1px;background:rgb(71,71,71);box-shadow:0px 2px 2px #afb2af;"></div>
	<div class="Hui-aside" style="width:260px;height:auto;background:rgb(71,71,71);top:58px;bottom:0px;overflow: hidden;position: absolute;">
		<div class="menu_dropdown bk_2">
			<dl id="menu-article" style="pading:0px;margin:0px;">
				<dt>
					<div class="totalDiv" style="width:100%;height:50px;cursor: pointer;">
						<div class="backDiv" style="float:left;width:5px;height:50px;"></div>
						<div style="float:left;padding-top:13px;margin-left:10px;"><img src="front/images/3.png" width="23px" /></div>
						<div style="float:left;color:white;line-height: 50px;font-size:16px;font-weight: bold;margin-left:18px;">订单管理</div>
						<div style="float:right;padding-top:20px;margin-right:10px;"><img class="imageDiv" src="front/images/4.png" width="12px" /></div>
					</div>
				</dt>
				<dd style="padding:0px;margin:0px;">
					<ul style="padding:0px;margin:0px;">
						<li style="text-decoration: none;list-style-type:none;cursor: pointer;"><div style="width:100%;height:30px;line-height: 30px;text-align: center;">
						<a style="text-decoration: none;color:rgb(130,130,130);text-shadow: none;" data-href="getmdOrderListNew" data-title="订单列表" href="javascript:void(0)">订单列表</a></div></li>
				    </ul>
				</dd>
			</dl>
			<dl id="menu-article" style="pading:0px;margin:0px;">
				<dt>
					<div class="totalDiv" style="width:100%;height:50px;cursor: pointer;">
						<div class="backDiv" style="float:left;width:5px;height:50px;"></div>
						<div style="float:left;padding-top:13px;margin-left:10px;"><img src="front/images/3.png" width="23px" /></div>
						<div style="float:left;color:white;line-height: 50px;font-size:16px;font-weight: bold;margin-left:18px;">密码管理</div>
						<div style="float:right;padding-top:20px;margin-right:10px;"><img class="imageDiv" src="front/images/4.png" width="12px" /></div>
					</div>
				</dt>
				<dd style="padding:0px;margin:0px;">
					<ul style="padding:0px;margin:0px;">
						<li style="text-decoration: none;list-style-type:none;cursor: pointer;"><div style="width:100%;height:30px;line-height: 30px;text-align: center;">
						<a style="text-decoration: none;color:rgb(130,130,130);text-shadow: none;" data-href="front/newmdperson.jsp" data-title="修改密码" href="javascript:void(0)">修改密码</a></div></li>
				    </ul>
				</dd>
			</dl>
		</div>
	</div>
	
<section class="Hui-article-box" style="position: absolute;right:0px;left:260px;top:58px;bottom: 0px;overflow: hidden;">
	<div id="iframe_box" class="Hui-article" style="position: absolute;right:0px;left:0px;top:0px;bottom: 0px;overflow: hidden;">
		<div class="show_iframe" style="position: absolute;right:0px;left:0px;top:0px;bottom: 0px;overflow: hidden;">
			<div style="display:none" class="loading"></div>
			<iframe style="width:100%;height:100%;overflow: hidden;padding:0px;margin:0px;" scrolling="yes" frameborder="0" src="getmdOrderListNew"></iframe>
	</div>
</div>
</section>
</body>
</html>