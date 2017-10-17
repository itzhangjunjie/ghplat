<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购物车</title>
<base href="/">
<script src="front/js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="front/js/main.js" type="text/javascript"></script>
<script type="text/javascript">
var userflagv = 0;
$(document).ready(function(){
	var cartIds = getCookie("cartIds");
	console.log(cartIds+".....");
	getCartList(cartIds);
	var uesFlag = $('#uesFlag').val(); var flag2 = uesFlag.substring(1,2);
	userflagv = flag2;
	if(flag2=='1'){
		$('#imprtDataDiv').show();
	}else{
		$('.moneytotal').html('**');
	}
	$("#beizhuA").fancybox({
		'titlePosition': 'inside',
		'transitionIn': 'none',
		'transitionOut': 'none'
	});
})
function getCartList(ids){
	if(ids!=null&&ids!=''){
		$.ajax({
			   type: "POST",
			   url: "../getCartList",
			   data:{
				   'pIds'  :ids
			   }, 
			   dataType:"json",
			   success: function(msg){
				   var htmla =  doT.template($("#publishlistTmpDiv").text());
					$('.plisDiv').append(htmla(msg));
					selecttotal();
			   }
		});
	}
}
function selectPrice(tt,pid){
	$(tt).parent().parent().find('.priceclass').hide();
	var column = $(tt).val();
	$('span[attrStr='+column+'-'+pid+']').show();
	selecttotal();
}
function selecttotal(){
	var totalCount = $('.selectedPublish[addflag=1]').length;
	$('.cartCount').html(totalCount);
	$('.headCartCount').html(totalCount);
	var totalFans = 0;
	for(var i=0;i<$('tr[attrflag="1"]').find('.fansTd').length;i++){
		totalFans = totalFans+parseInt($($('tr[attrflag="1"]').find('.fansTd')[i]).html());	
	}
	$('.cartPersonCount').html(totalFans);
	$('.cartViewCount').html(parseInt(totalFans*0.6));
	if(userflagv==1){
		var totalPrice =0;
		for(var i=0;i<$('tr[attrflag="1"]').find('.priceclass').length;i++){
			if($($('tr[attrflag="1"]').find('.priceclass')[i]).css('display')!='none'){
				totalPrice= totalPrice+parseInt($($('tr[attrflag="1"]').find('.priceclass')[i]).html());
			}
		}
		$('.moneytotal').html(totalPrice);
	}else{
		$('.moneytotal').html('**');
	}
	$('.elem1').xheditor({ 
        upImgUrl: 'upploadImg', upImgExt: 'jpg,jpeg,gif,png'
    });  
}
function selectAddCart(tt){
	if($(tt).find('.selectedPublish').css('display')=='none'){
		$(tt).find('.selectedPublish').show();
		$(tt).find('.selectedPublish').attr('addflag','1');
		$(tt).parent().parent().attr('attrflag','1');
	}else{
		$(tt).find('.selectedPublish').hide();
		$(tt).find('.selectedPublish').attr('addflag','-1');
		$(tt).parent().parent().attr('attrflag','-1');
	}
	selecttotal();
}
function allSelectAddCart(tt){
	if($(tt).find('div').css('display')=='none'){
		$(tt).find('div').show();
		$('.selectedPublish').show();
		$('.selectedPublish').attr('addflag','1');
		$('.publishTr').attr('attrflag','1');
	}else{
		$(tt).find('div').hide();
		$('.selectedPublish').hide();
		$('.selectedPublish').attr('addflag','-1');
		$('.publishTr').attr('attrflag','-1');
	}
	selecttotal();
}
function deleteAll(){
	if(confirm("确定要全部删除吗？")){
		//delCookie('cartIds');
		SetCookie("cartIds","",15);
		$('.publishTr').remove();
		selecttotal();
	}
}
function deleteCPublish(tt,pid){
	if(confirm("确定要删除吗？")){
		$(tt).parent().parent().remove();
		var tcontet = $(tt).parent().parent().attr('attrPid');
		$('#textare'+tcontet).remove();
		deleteCart(pid);
		selecttotal();
	}
}
function saveOrder(){
	var user= $('#userType').val();
	if(user==null||user==''){
		$('#qiyeloginA').click();
	}else{
		var totalPrice = 0;
		var orderArray = new Array();
		var beizhuArray = new Array();
		for(var i=0;i<$('tr[attrflag="1"]').length;i++){
			var orderObj = {};
			orderObj.publishId = $($('tr[attrflag="1"]')[i]).attr('attrPid');
			orderObj.priceStr = $($('tr[attrflag="1"]')[i]).find('.priceStrSel').val();
			var attrStr = orderObj.priceStr+'-'+orderObj.publishId;
			orderObj.price = $($($('tr[attrflag="1"]')[i]).find('span[attrStr="'+attrStr+'"]')).html();
			orderObj.publishType = $($('tr[attrflag="1"]')[i]).attr('attrPtype');
			totalPrice = totalPrice+parseInt(orderObj.price);
			orderArray.push(orderObj);
			var contentObj = {};
			contentObj.content = $($('tr[attrflag="2"]')[i]).find('.elem1').val();
			beizhuArray.push(contentObj);
		}
		var flage = $('.wdtlSelectDiv').attr('wdtlflag');
		//alert(JSON.stringify(beizhuArray));
		//return;
		$.ajax({
			   type: "POST",
			   url: "../saveOrder",
			   data:{
				   'totalPrice'  :totalPrice,
				   'wtdlfalge':flage,
				   'orderArray':JSON.stringify(orderArray),
				   'beizhuArray':JSON.stringify(beizhuArray)
			   }, 
			   dataType:"json",
			   success: function(msg){
				   if(msg.result=='yes'){
					   //delCookie('cartIds');
					   SetCookie("cartIds","",15);
					   location.href="../getOrderList";
				   }else{
					   $('#qiyeloginA').click();
				   }
			   }
		});
	}
}
function dataExport(){
	var user= $('#userType').val();
	if(user==null||user==''){
		$('#qiyeloginA').click();
	}else{
		var totalPrice = 0;
		var orderArray = new Array();
		for(var i=0;i<$('tr[attrflag="1"]').length;i++){
			var orderObj = {};
			orderObj.publishId = $($('tr[attrflag="1"]')[i]).attr('attrPid');
			orderObj.priceStr = $($('tr[attrflag="1"]')[i]).find('.priceStrSel').val();
			var attrStr = orderObj.priceStr+'-'+orderObj.publishId;
			orderObj.price = $($($('tr[attrflag="1"]')[i]).find('span[attrStr="'+attrStr+'"]')).html();
			orderObj.publishType = $($('tr[attrflag="1"]')[i]).attr('attrPtype');
			totalPrice = totalPrice+parseInt(orderObj.price);
			orderArray.push(orderObj);
		}
		var flage = $('.wdtlSelectDiv').attr('wdtlflag');
		$.ajax({
			   type: "POST",
			   url: "../orderExport",
			   data:{
				   'totalPrice'  :totalPrice,
				   'wtdlfalge':flage,
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
function importData(){
	dataExport();
// 	var user= $('#userType').val();
// 	if(user==null||user==''){
// 		$('#qiyeloginA').click();
// 	}else{
		
// 	}
}
var totalMany = 0;
function selectWtdl(tt){
	if($(tt).find('.wdtlSelectDiv').css('display')=='none'){
		$(tt).find('.wdtlSelectDiv').show();
		$(tt).find('.wdtlSelectDiv').attr('wdtlflag','1');
		totalMany = $('.moneytotal').html();
		$('.moneytotal').html(parseInt(totalMany)+parseInt(parseInt(totalMany)*0.06));
	}else{
		$(tt).find('.wdtlSelectDiv').hide();
		$(tt).find('.wdtlSelectDiv').attr('wdtlflag','-1');
		$('.moneytotal').html(totalMany);
	}
}
function textSelct(pid){
	$('#textare'+pid).toggle();
}
</script>
</head>
<body style="padding:0px;margin:0px;">
<input type="hidden" value="${sessionScope.user.id}" id="userType" />
<input type="hidden" value="${sessionScope.user.userFlag }" id="uesFlag"/>
<%@include file="header.jsp" %>
<div style="width:1200px;margin:0 auto;height:1px;background: rgb(242,242,242);"></div>
<div style="width:1200px;margin:30px auto 10px;overflow: hidden;">
	<div style="width:100%;overflow: hidden;">
		<div style="width:150px;height:42px;background: white;float:left;line-height: 42px;">
			<div onclick="allSelectAddCart(this)" style="cursor:pointer;width:16px;height:16px;border:1px #333333 solid;float:left;position: relative;">
				<div style="position: absolute;top:0px;left:0px;"><img src="front/images/check_26.png" width="100%" /></div>	
			</div>
			<div style="cursor:pointer;float:left;margin-left:10px;color:#333333;font-size:12px;line-height: 20px;">全选</div>
			<div onclick="deleteAll()" style="cursor:pointer;float:left;margin-left:30px;font-size:14px;line-height: 19px;" class="hoverFont">全部删除</div>
		</div>
		<div id="imprtDataDiv" onclick="importData()" style="display:none;width:70px;height:22px;border:1px #333333 solid;text-align: center;line-height: 22px;float: right;font-size:14px;cursor:pointer;">导出方案</div>
		<div style="width:110px;margin-top:2px;height:22px;text-align: center;line-height: 22px;float: right;font-size:14px;cursor:pointer;margin-right:20px;">
			<div style="cursor:pointer;width:16px;height:16px;border:1px #333333 solid;position: relative;float:left;" onclick="selectWtdl(this)">
				<div wdtlflag="-1" class="wdtlSelectDiv" style="position: absolute;top:0px;left:0px;display:none;">
					<img width="100%" src="front/images/check_26.png">
				</div>
			</div>
			<div style="float:left;margin-left:5px;line-height: 19px;">委托平台代理</div>
		</div>
	</div>
	<div style="width:1198px;border:1px #dfdfdf solid;overflow: hidden;">
		<table style="width:100%;font-size:14px;" cellspacing="0px" class="plisDiv">
			<tr valign="middle" height="40px" style="background: #f8f8f8;"><td width="32px" align="center">&nbsp;</td><td width="150px" align="center">广告主题</td><td width="100px" align="center">投放主题</td><td width="250px" align="center">广告类型</td>
			<td  width="100px" align="center">阅读量</td><td  width="300px" align="center">位置</td><td width="100px" align="center">报价</td><td width="150px" align="center">备注</td><td width="150px" align="center">操作</td></tr>
			<script id="publishlistTmpDiv" type="text/x-dot-template">
			{{for(var i=0;i<it.publishList.length;i++){ }} 
			<tr valign="middle" attrPtype="{{=it.publishList[i].publishTypeObj.publishFieldId}}" attrPid="{{=it.publishList[i].id}}" class="publishTr{{=it.publishList[i].id}} publishTr" attrflag="1" height="80px"><td align="center"><div onclick="selectAddCart(this)" style="cursor:pointer;width:16px;height:16px;border:1px #333333 solid;position: relative;float:right;">
				<div class="selectedPublish" addflag="1" style="position: absolute;top:0px;left:0px;"><img src="front/images/check_26.png" width="100%" /></div>	
			</div></td>
			<td><img width="48px" height="48px" src="/attachment{{=it.publishList[i].image}}" /></td>
        <td><div style="margin-top:1px;">{{=it.publishList[i].publishName}}</div></td>
			<td><div style="margin-top:1px;">{{=it.publishList[i].publishTypeObj.publishFieldName}}</div></td>
			<td class="fansTd">{{=it.publishList[i].platformFans}}</td>
			<td>
			<select class="priceStrSel" style="width:100px;height:25px;text-align: center;" onchange="selectPrice(this,{{=it.publishList[i].id}})">
				{{ for(var prop in it.publishList[i].priceMap) { }}
				<option value="{{=prop}}">{{=prop}}</option>
				{{}}}
			</select>
			</td><td>
				{{ var ind = 0; for(var prop in it.publishList[i].priceMap) { ind=ind+1;var uesFlag = $('#uesFlag').val(); var flag2 = uesFlag.substring(1,2);}}
				<span attrStr="{{=prop}}-{{=it.publishList[i].id}}" style="{{? ind!=1}}display:none;{{?}}" class="priceclass">{{? flag2==1}}{{=it.publishList[i].priceMap[prop]}}{{?}}{{? flag2!=1}}**{{?}}</span>
				{{}}}
			</td>
			<td><a onclick="textSelct({{=it.publishList[i].id}})" href="javascript:;" style="text-decoration: none;">添加备注</a></td>
			<td><span onclick="deleteCPublish(this,{{=it.publishList[i].id}})" class="hoverFont">删除</span></td></tr>
<tr attrflag="2" class="textTr" id="textare{{=it.publishList[i].id}}" style="display:none;margin-top:-5px;"><td colspan="9">
<div style="width:100%;overflow: hidden;">
			<textarea class="elem1"  style="width: 100%"></textarea>
		</div>
</td></tr>
			{{}}}
			</script>
<!-- 			<div style="float:left;"><img src="front/images/weixin.png" /></div> -->
		</table>
	</div>
	<div style="width:1200px;height:52px;margin-top:50px;">
		<div style="width:1060px;border: 1px #dfdfdf solid;border-right: 0px;font-size:14px;float:left;">
			<span style="line-height: 52px;margin-left:30px;">投放数量<span class="cartCount" style="color:red;margin-left:1px;">0</span>个</span>
			<span style="margin-left:10px;">预计覆盖人数<span class="cartPersonCount" style="color:red;margin-left:3px;">0</span></span>
			<span style="margin-left:10px;">预计阅读人数<span class="cartViewCount" style="color:red;margin-left:3px;">0</span></span>
			<span style="float:right;margin-right:15px;line-height: 45px;">合计：<span class="moneytotal" style="color:red;font-size:24px;">0</span></span>
		</div>
		<div onclick="saveOrder()" style="width:139px;height:54px;color:white;font-size:18px;float:left;background: #fc6769;line-height: 54px;text-align: center;cursor: pointer;">立即推广</div>
	</div>
</div>
<div style="margin-top:20px;width:100%;overflow: hidden;">
			<textarea id="elem1"  style="width: 100%"></textarea>
		</div>
<%@include file="footer.jsp" %>
</body>
</html>