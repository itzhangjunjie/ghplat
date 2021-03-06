<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人主页</title>
<base href="/">
<script src="front/js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($('#userflag').val()==''){
		changeDiv('passwordDiv',$('#passwdbtn'));
	}
	var uesFlag = $('#uesFlag').val(); var flag2 = uesFlag.substring(1,2);
	if(flag2=='1'){
		$('.imprtDataDiv').show();
	}
})
function gostep2(){
	var pcode = $('.pcode').val();
	var mobile = $('.pmobile').val();
	if(mobile!=mobileStr){
		$('.pmobileMsg').html('手机号不对');
		$('.pmobileMsg').show();
		return;
	}
	if(regCode==pcode){
		$('.stepImage').attr('src','front/images/step02.png');
		$('.step').hide();
		$('.step02').show();
	}else{
		$('.pcodeMsg').show();
	}
}
function gostep3(){
	var ppsd = $('.ppassword').val();
	var prpsd = $('.rppassword').val();
	if(ppsd==''||ppsd.length>12||ppsd<6){
		$('.ppasswordMsg').show();
		return;
	}
	if(ppsd!=prpsd){
		$('.prpasswordMsg').show();
	}else{
		$.ajax({
			   type: "POST",
			   url: "../updatePassword",
			   data:{
				   'mobile'  :$('.pmobile').val(),
				   'password'   :prpsd
			   }, 
			   dataType:"json",
			   success: function(msg){
				   if(msg.result=='yes'){
						$('.stepImage').attr('src','front/images/step03.png');
						$('.step').hide();
						$('.step03').show();
				   }else{
					   $('.prpasswordMsg').html('手机号错误！');
					   $('.prpasswordMsg').show();
				   }
			   }
		});
	}
}
var regCode = 01;
var mobileStr = null;
function sendCodeMsgPwd(tt,type){
	var mobile = $('.pmobile').val();
	console.log(mobile);
	var mtest = /^([0-9]){11}$/;
	if(mobile==''||!mtest.test(mobile)){
		$('.pmobileMsg').html('手机号不对');
		$('.pmobileMsg').show();
		return;
	}
	var $this = $(tt);
	if($this.attr('flag')=='-1'){
		return;
	}
	$('.pmobileMsg').hide();
	$.ajax({
		   type: "POST",
		   url: "../sendPasswordCodeMsg",
		   data:{
			   'mobile'  :mobile,
			   'type'   :type
		   }, 
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				   mobileStr = mobile;
				   regCode = msg.code;
					$('.ptimeCount').show();
					$('.ptimeFont').html('获取验证码');
					$this.attr('flag','-1');
					$this.css('cursor','not-allowed');
					var time60=setInterval(function(){
						var cc=parseInt($('.ptimeCount').html().replace('(','').replace(')',''));
						if(cc==0){
							clearInterval(time60);
							$('.ptimeCount').html(' ( 60 )');
							$('.ptimeCount').hide();
							$('.ptimeFont').html('重新获取');
							$this.attr('flag','1');
							$this.css('cursor','pointer');
						}else{
							$('.ptimeCount').html('( '+(cc-1)+' )');
						}
					}, 1000);
			   }else{
				   $('.pmobileMsg').html(msg.reason);
			   }
		   }
	});
}
function removeOrder(tt,orderid){
	if(confirm("确定删除订单吗?")){
		$.ajax({
			   type: "POST",
			   url: "../deleteOrder",
			   data:{
				   'orderId'  :orderid
			   }, 
			   dataType:"json",
			   success: function(msg){
				   if(msg.result=='yes'){
					   $(tt).parent().parent().remove();
				   }
			   }
		});
	}
}
function dataExport(tt){
	var user= $('#userType').val();
	if(user==null||user==''){
		$('#qiyeloginA').click();
	}else{
		var totalPrice = 0;
		var orderArray = new Array();
		for(var i=0;i<$(tt).parent().parent().find('.publishTr').length;i++){
			var orderObj = {};
			orderObj.publishId = $($(tt).parent().parent().find('.publishTr')[i]).attr('attrPid');
			orderObj.priceStr = $($(tt).parent().parent().find('.publishTr')[i]).attr('attrPriceStr');
			orderObj.price = $($(tt).parent().parent().find('.publishTr')[i]).attr('attrPrice');
			orderObj.publishType = $($(tt).parent().parent().find('.publishTr')[i]).attr('attrPtype');
			totalPrice = totalPrice+parseInt(orderObj.price);
			orderArray.push(orderObj);
		}
		$.ajax({
			   type: "POST",
			   url: "../orderExport",
			   data:{
				   'totalPrice'  :totalPrice,
				   'orderArray':JSON.stringify(orderArray)
			   }, 
			   dataType:"json",
			   success: function(msg){
				   if(msg.result=='yes'){
					   window.open("../downFile")
				   }else{
					   $('#qiyeloginA').click();
				   }
			   }
		});
	}
}
function changeDiv(cls,tt){
	$('.divsh').hide();
	$('.'+cls).show();
	$('.alldaodiv').removeClass('currentCas');
	$(tt).addClass('currentCas');
}
</script>
</head>
<body style="padding:0px;margin:0px;">
<%@include file="header.jsp" %>
<input type="hidden" value="${sessionScope.user.id}" id="userType" />
<input type="hidden" value="${sessionScope.type}" id="userflag" />
<input type="hidden" value="${sessionScope.user.userFlag }" id="uesFlag"/>
	<div style="width:100%;background:rgb(242,242,242);height:auto;overflow: hidden; ">
		<div style="width:1140px;padding:20px 30px 40px 30px;background: white;margin:0 auto;margin-top:15px;margin-bottom:20px;border:1px #eeeeee solid;overflow: hidden;">
			<div style="width:100%;height:36px;border-bottom: 1px #707070 solid;">
				<div style="cursor:pointer;height:36px;font-size: 18px;color:#333333;float:left;width:100px;text-align: center;" class="alldaodiv currentCas" onclick="changeDiv('orderDiv',this)">我的订单</div>
				<div style="cursor:pointer;height:36px;font-size: 18px;color:#333333;float:left;width:100px;text-align: center;margin-left:25px;" id="passwdbtn" class="alldaodiv" onclick="changeDiv('passwordDiv',this)">密码修改</div>
			</div>
			<div style="width:100%;margin-top:20px;" class="orderDiv divsh">
					<table cellspacing="0px" class="plisDiv" style="width:100%;font-size:14px;border:1px #dfdfdf solid;">
					<tbody><tr valign="middle" height="40px" style="background: #f8f8f8;"><td width="150px" align="center">广告主题</td><td width="170px" align="center">投放主体</td><td width="150px" align="center">广告类型</td>
					<td width="150px" align="center">阅读量</td><td width="150px" align="center">位置</td><td width="150px" align="center">报价</td><td width="250px" align="center">订单状态</td><td width="200px" align="center">总金额</td></tr>
		<!-- 			<div style="float:left;"><img src="front/images/weixin.png" /></div> -->
				</tbody></table>
					<c:forEach items="${orderlist.list }" var="order">
				<div style="width:100%;overflow: hidden;">
						<div style="width:1138px;height:40px;background: #f8f8f8;margin-top:20px;line-height: 40px;border:1px #dfdfdf solid;border-bottom: 0px;font-size:14px;">
							<span style="margin-left:20px;float:left;">${order.order_createtime }</span><span style="float:left;margin-left:20px;">订单编号：${order.ghid }</span>
							<span onclick="removeOrder(this,${order.order_id})" class="hoverFont" style="float:right;margin-right:10px;">取消订单</span>
							<div class="imprtDataDiv" onclick="dataExport(this)" style="display:none;width:70px;height:22px;border:1px #333333 solid;text-align: center;line-height: 22px;float: right;font-size:14px;cursor:pointer;margin-top:8px;margin-right:10px;">导出方案</div>
						</div>
						<table cellspacing="0px" class="plisDiv" style="font-size:14px;border:1px #dfdfdf solid;float:left;width:1140px;">
						<c:forEach items="${order.orderDetailsList }" var="orderDetails"  varStatus="stt">
								<tr valign="middle" height="60px" class="publishTr" attrPid="${orderDetails.publish.id }" attrPriceStr="${orderDetails.publish_pricestr }" attrPrice="${orderDetails.publish_price }" attrPtype="${orderDetails.publish.publishTypeObj.publishFieldName }">
									 <td width="150px" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " align="center"><img width="48px" height="48px" src="/attachment${orderDetails.publish.image }"></td>
									 <td width="150px" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " align="center"><div style="margin-top:1px;" >${orderDetails.publish.publishName }</div></td>
									 <td width="150px" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " align="center"><div style="margin-top:1px;" >${orderDetails.publish.publishTypeObj.publishFieldName }</div></td>
									 <td class="fansTd" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " width="150px" align="center">${orderDetails.publish.platformFans }</td>
									 <td width="150px" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " align="center">${orderDetails.publish_pricestr }</td>
									 <td width="150px" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " align="center"><span class="priceclass">${orderDetails.publish_price }</span></td>
							    	 <c:if test="${stt.index==0 }">
								    	 <td width="250px" style="border-left:1px #dfdfdf solid;" align="center" rowspan="${order.orderDetailsList.size()}">
								    	 	<c:if test="${order.order_status==0 }">待付款</c:if><c:if test="${order.order_status==1 }">已完成</c:if><c:if test="${order.order_status==2 }">已取消</c:if>
								    	 </td>
								    	 <td width="150px" style="border-left:1px #dfdfdf solid;" align="center" rowspan="${order.orderDetailsList.size()}">${order.order_contentbudget }</td>
							    	 </c:if>
							     </tr> 
						</c:forEach>
					    </table>
				</div>
					</c:forEach>
			</div>
			<div class="passwordDiv divsh" style="display:none;">
				<div style="width:100%;height:auto;overflow: hidden;">
					<div style="width:868px;height:90px;margin:40px auto 0px;"><img class="stepImage" src="front/images/step01.png"/></div>
				</div>
				<div class="step01 step" style="margin-top:50px;padding-bottom: 20px;">
					<div style="width:320px;margin:0 auto;position: relative;">
						<input class="pmobile" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="用户名(手机号)" />
						<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
						<div class="pmobileMsg errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">用户名已存在</div>
					</div>
					<div style="width:320px;margin:0 auto;margin-top:20px;position: relative;overflow: hidden;">
						<div class="pcodeMsg errormsg" style="display:none;color:red;top:14px;right:152px;position: absolute;font-size:12px;">验证码不正确</div>
						<input class="pcode" style="margin:0px;width:180px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="验证码" />
						<div onclick="sendCodeMsgPwd(this,'修改密码')" style="float:left;height:42px;line-height: 42px;width:120px;text-align:center;color:black;font-size:14px;border: 1px #ebebeb solid;border-left: 0px;cursor: pointer; ">
						       <span class="ptimeFont">获取验证码</span><span class="ptimeCount" style="display:none;"> ( 60 )</span>
						</div>
					</div>
					<div onclick="gostep2()" style="width:302px;margin:20px 410px 0px;height:48px;background: #fc6769;color:white;font-size:18px;line-height: 48px;border-radius:5px;text-align: center;cursor: pointer;">
						确定
					</div>
				</div>
				<div  class="step02 step" style="margin-top:50px;padding-bottom: 20px;display:none;">
					<div style="width:320px;margin:0 auto;position: relative;">
						<input class="ppassword" type="password" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="密码" />
						<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
						<div class="ppasswordMsg errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">密码不对</div>
					</div>
					<div style="width:320px;margin:0 auto;margin-top:20px;position: relative;overflow: hidden;">
						<input type="password" class="rppassword" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="再次输入密码" />
						<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
						<div class="prpasswordMsg errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">密码不一致</div>
					</div>
					<div onclick="gostep3()" style="width:302px;margin:20px 410px 0px;height:48px;background: #fc6769;color:white;font-size:18px;line-height: 48px;border-radius:5px;text-align: center;cursor: pointer;">
						确定
					</div>
				</div>
				<div class="step03 step" style="margin-top:50px;padding-bottom: 20px;display:none;">
					<div style="width:320px;margin:0 auto;position: relative;text-align: center;color:28px;margin-top:60px;">
						修改密码成功！
					</div>
				</div>
			</div>
		</div>
	</div>
<%@include file="footer.jsp" %>
</body>
</html>