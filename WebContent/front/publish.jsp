<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>案例</title>
<base href="/ghplat/front/">
<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$('.btmcolor').click(function(){
		$('.selectClass').removeClass('selectClass');
		$(".btmcolor").removeClass("currentbc");
		$(this).addClass("currentbc");
		$('#selectType').html($(this).html());
		var publishType = $(this).attr("attrId");
		$('.publishtplat').hide();
		$('.publishtplat'+publishType).show();
		if(publishType==0){
			$('.publishprice').hide();
		}else{
			$('.publishprice').show();
		}
		$('.publisht').hide();
		$('.publisht'+publishType).show();
		getPublishList(1);
	})
	$('.showhide').click(function(){
		if($(this).text()=='收起'){
			$('.publisht').hide();
			$('.publishprice').hide();
			var publishType = $('.currentbc').attr("attrId");
			$($('.publishtplat'+publishType)[0]).show();
			$($('.publisht'+publishType)[0]).show();
			$(this).text("展开");
		}else if($(this).text()=='展开'){
			var publishType = $('.currentbc').attr("attrId");
			$('.publishtplat'+publishType).show();
			$('.publishprice').show();
			$('.publisht'+publishType).show();
			$(this).text("收起");
		}
	})
});
$(document).ready(function(){
	 //$('.currentbc').click();
	
	 $(document).delegate('.addCart','hover',function(e){
		 if(e.type == "mouseenter"){ //移入  
			 $(this).css('border','0px');
			 $(this).css('color','white');
			 $(this).css('backgroundColor','rgb(255,103,103)');
	     }else{//mouseleave 移出  
			 $(this).css('border','1px #333333 solid');
			 $(this).css('backgroundColor','white');
			 $(this).css('color','#333333');
	     }  
	 });
	 $('.selectRedFont').click(function(){
		 $(this).parent('div').find('.selectRedFont').removeClass('selectClass');
		 if(!$(this).hasClass('selectClass')){
			 $(this).addClass('selectClass');
		 }
		 getPublishList(1);
	 })
})
function getPublishList(gpagesize){
	var typevalue = $('.typeAllDiv').find('.currentbc').attr('attrId');
	var fieldvalue = $('.fieldAllDiv').find('.selectClass').attr('attrId');
	var platvalue = $('.platAllDiv').find('.selectClass').attr('attrId');
	var platfanvalue = $('.platfanAllDiv').find('.selectClass').attr('attrId');
	var cpricevalue = $('.cpriceAllDiv').find('.selectClass').attr('attrId');
	var pricevalue = $('.priceAllDiv').find('.selectClass').attr('attrId');
	var datajson = {};
	datajson.pageSize = gpagesize;
	if(fieldvalue!=0){
		datajson.publishType = typevalue;
	}
	if(fieldvalue!=null){
		datajson.publishField = fieldvalue;
	}
	if(platvalue!=null){
		datajson.platform = platvalue;
	}
	if(platfanvalue!=null){
		datajson.fanCount = platfanvalue;
	}
	if(cpricevalue!=null){
		datajson.pricePosition = cpricevalue;
	}
	if(pricevalue!=null){
		datajson.price = pricevalue;
	}
	$.ajax({
		type: "post",
		url: "../getPublishStr",
		async: false, //_config.async,
		dataType: 'json',
		data:datajson,
		success: function(data, status, xhr) {
			if(data.result=="yes"){
				var plist = data.datas;
				$('#publishDiv').html("");
				var htmla =  doT.template($("#publishTmp").text());
				$('#publishDiv').html(htmla(plist));
				var pagecount = data.pageCount;
				var pagesize = data.pageSize;
				 $('.M-box').pagination(pagecount,{
					 'items_per_page'      : 15,  
			         'num_display_entries' : 5, 
			         'ellipse_text'        : "...",
			         'num_edge_entries'    : 2,  
			         'prev_text'           : "上一页",  
			         'next_text'           : "下一页",  
			         'current_page'        : pagesize-1,
			         'callback'            : function(page_id,jq){
			        	 getPublishList(page_id+1);
			        	 $("body").scrollTop(0);
						 return false;
			         }
			     });
			}
		}
	});
}
</script>
</head>
<body style="padding:0px;margin:0px;">
<input type="hidden" value="1" id="headType" />
	<%@include file="header.jsp" %>
		<div style="width:100%;background:rgb(242,242,242);height:auto; ">
			<div style="width:1200px;margin:0 auto;">
				<div class="typeAllDiv" style="width:100%;height:76px;line-height: 80px;">
					<div attrId="0" class="btmcolor currentbc" style="width:120px;text-align:center;height:76px;color:#333333;font-size:18px;float:left;cursor:pointer;">全部</div>
					<c:forEach var="publish" items="${ptdto }"  varStatus="st" >
						<div attrId="${publish.publishType }" class="btmcolor" style="width:120px;text-align:center;height:76px;color:#333333;font-size:18px;float:left;margin-left:35px;cursor:pointer;">${publish.publishName }</div>
					</c:forEach>
				</div>
				<div style="width:100%;height:1px;background: #aeaeae;"></div>
				<div style="width:100%;background:white;border:1px #33333 solid;overflow: hidden;font-size:12px;margin-top:30px;padding-bottom: 20px;position: relative;">
					<div style="position: absolute;right:20px;top:20px;">
						<div class="showhide" style="float:left;cursor:pointer;">收起</div>
					</div>
					<c:forEach var="publisha" items="${ptdto }" >
						<c:if test="${publisha.publishFieldList.size()>0 }">
							<div class="publisht publisht${publisha.publishType }" style="display:none;">
								<div style="width:100%;overflow: hidden;">
									<div style="padding:20px;color:#707070;float:left;width:70px;">${publisha.publishName }&nbsp;:</div>
									<div class="fieldAllDiv" style="float:left;margin-left:0px;width:920px;padding:20px;">
										<c:forEach var="publishfield" items="${publisha.publishFieldList }" varStatus="fstatus">
											<div attrType="publishField" attrId="${publishfield.publishFieldName }" class="hoverFont selectRedFont" style="float:left;margin-left:30px;color:#333333;margin-bottom: 3px;">${publishfield.publishFieldName }</div>
										</c:forEach>
									</div>
								</div>
								<div style="width:1160px;height:1px;border-top:1px dotted #707070;margin:0 auto;"></div>
							</div>
						</c:if>
						<c:if test="${publisha.publishPlatform.size()>0 }">
							<div class="publisht publisht${publisha.publishType }" style="display:none;">
								<div style="width:100%;overflow: hidden;">
									<div style="padding:20px;color:#707070;float:left;width:70px;">平台类型&nbsp;:</div>
									<div class="platAllDiv" style="float:left;margin-left:0px;width:920px;padding:20px;">
										<c:forEach var="publishplat" items="${publisha.publishPlatform }" varStatus="fstatus">
											<div attrType="platform" attrId="${publishplat.platformName }" class="hoverFont selectRedFont publishtplat publishtplat${publisha.publishType }" style="float:left;margin-left:30px;color:#333333;margin-bottom: 3px;">${publishplat.platformName }</div>
										</c:forEach>
									</div>
								</div>
								<div style="width:1160px;height:1px;border-top:1px dotted #707070;margin:0 auto;"></div>
							</div>
						</c:if>
						<c:if test="${publisha.publishPrice.size()>0 }">
							<div class="publisht publisht${publisha.publishType }" style="display:none;">
								<div style="width:100%;overflow: hidden;">
									<div style="padding:20px;color:#707070;float:left;width:70px;">价格类型&nbsp;:</div>
									<div class="cpriceAllDiv" style="float:left;margin-left:0px;width:920px;padding:20px;">
										<c:forEach var="publishprice" items="${publisha.publishPrice }" varStatus="fstatus">
											<div attrType="price" attrId="${publishprice.columnPosition }" class="hoverFont selectRedFont publishtplat publishtplat${publisha.publishType }" style="float:left;margin-left:30px;color:#333333;margin-bottom: 3px;">${publishprice.columnName }</div>
										</c:forEach>
									</div>
								</div>
								<div style="width:1160px;height:1px;border-top:1px dotted #707070;margin:0 auto;"></div>
							</div>
						</c:if>
					</c:forEach>
					<div class="publishprice" style="display:none;">
						<div style="width:100%;overflow: hidden;">
							<div style="padding:20px;color:#707070;float:left;width:70px;">价格筛选&nbsp;:</div>
							<div class="priceAllDiv" style="float:left;margin-left:0px;width:920px;padding:20px;">
								<div attrType="price" attrId="1" class="hoverFont selectRedFont" style="float:left;margin-left:30px;color:#333333;margin-bottom: 3px;">
								5000以下
								</div>
								<div attrType="price" attrId="2" class="hoverFont selectRedFont" style="float:left;margin-left:30px;color:#333333;margin-bottom: 3px;">
								5000-8000
								</div>
								<div attrType="price" attrId="3" class="hoverFont selectRedFont" style="float:left;margin-left:30px;color:#333333;margin-bottom: 3px;">
								8000以上
								</div>
							</div>
						</div>
						<div style="width:1160px;height:1px;border-top:1px dotted #707070;margin:0 auto;"></div>
					</div>
					<div class="publishtab">
						<div style="width:100%;overflow: hidden;">
							<div style="padding:20px;color:#707070;float:left;width:70px;">粉丝数筛选&nbsp;:</div>
							<div class="platfanAllDiv" style="float:left;margin-left:0px;width:920px;padding:20px;">
								<div attrType="fanCount" attrId="1" class="hoverFont selectRedFont" style="float:left;margin-left:30px;color:#333333;margin-bottom: 3px;">
								5万以下
								</div>
								<div attrType="fanCount" attrId="2" class="hoverFont selectRedFont" style="float:left;margin-left:30px;color:#333333;margin-bottom: 3px;">
								5万-10万
								</div>
								<div attrType="fanCount" attrId="3" class="hoverFont selectRedFont" style="float:left;margin-left:30px;color:#333333;margin-bottom: 3px;">
								10万以上
								</div>
							</div>
						</div>
						<div style="width:1160px;height:1px;border-top:1px dotted #707070;margin:0 auto;"></div>
					</div>
				</div>
			</div>
			<div style="width:1200px;margin:0 auto;margin-top:25px;height:40px;">
				<div style="width:600px;float:left;">
					<div style="width:120px;height:40px;background: white;border:1px #fc6769 solid;float:left;">
						<select disabled="disabled" style="width:100px;height:40px;margin-left:10px; appearance:none;-moz-appearance:none;-webkit-appearance:none;border: 0px;padding:10px;color: #333333;font-size:14px; background: url('http://ourjs.github.io/static/2015/arrow.png') no-repeat scroll right center transparent;">
							<option id="selectType" style="width:100px;text-align: center;font-size:14px;padding:8px;color: #333333;boder:0px;">全部</option>
						</select>
					</div>
					<div style="border-top:1px #fc6769 solid;border-bottom:1px #fc6769 solid;width:365px;height:40px;float:left;">
						<input type="text" placeholder="突然想起某位达人" style="border:0px;text-align:left;margin:0px;padding: 10px 10px 10px 20px;width:365px;height:40px;color:#666666;font-size:14px;"/>
					</div>
					<div style="background: #fc6769;width:95px;height:42px;float:left;text-align: center;">
						<img src="images/search_white.png" style="height:24px;margin-top:9px;" />
					</div>
				</div>
				<div style="width:235px;height:38px;float: right;">
					<div style="width:100px;height:42px;background: white;float:left;line-height: 42px;">
						<div style="cursor:pointer;width:16px;height:16px;border:1px #333333 solid;float:left;margin-top:12px;margin-left:25px;"></div>
						<div style="cursor:pointer;float:left;margin-left:10px;color:#333333;font-size:12px;">全选</div>
					</div>
					<div style="width:135px;height:42px;background: #fc6769;float:left;line-height: 38px;text-align: center;font-size:14px;color:#ffffff;">
						一键加入购物车
					</div>
				</div>
			</div>
			<div style="width:1200px;margin:0 auto;margin-top:30px;">
				<div id="publishDiv" style="width:100%;overflow: hidden;">
				</div>
				<div id="pageDiv" style="margin:0 auto;margin-top:20px;margin-bottom:20px;min-width: 385px;max-width: 470px;height:32px;">
					<div class="M-box" ></div>
				</div>
				<div style="width:100%;height:80px;">
					<div style="width:1002px;height:50px;background: white;float:left;line-height: 50px;border:1px #e0dbe0 solid;boder-right:0px;font-size:14px;color:#333333;">
						<div style="margin-left:14px;">已选择了<span style="color:#fc6769;padding-left:2px;padding-right:2px;">9</span>个项目</div>
					</div>
					<div style="width:196px;height:52px;background: #fc6769;float:left;cursor:pointer;">
						<div style="float:left;width:30px;padding-top:17px;margin-left:30px;"><img src="images/tel_small.png" style="width:20px;"/></div>
						<div style="float:left;width:108px;color:#ffffff;font-size:18px;line-height: 52px;">去购物车结算</div>
					</div>
				</div>
				<script id="publishTmp" type="text/x-dot-template">
					{{for(var i=0;i<it.length;i++){ }} 
						<div style="float:left;{{? (i+6)%5!=0}} margin-right:37px;{{?}}width:210px;height:330px;position: relative;background: white;margin-top:4px;{{? i>4}} margin-top:25px; {{?}}">
							<div style="margin:0 auto;padding-top:30px;padding-left:25px;padding-right:25px;width:160px;height:180px;cursor:pointer;">
								<a href="../caselist?publishId={{=it[i].id}}"><img src="http://61.129.51.62:8080/GhWemediaWar/{{=it[i].image}}" width="160px" height="180px" /></a>
							</div>
							<div style="width:160px;margin:0 auto;font-size:14px;color:#333333;margin-top:10px;">{{=it[i].publishName}}</div>
							<div style="width:160px;margin:0 auto;margin-top:10px;color:#333333;height:20px;">
								<div style="width:18px;height:18px;float:left;"><img src="images/fans.png" width="18px" /></div>
								<div style="float:left;margin-left:8px;font-size:13px;line-height: 18px;">{{=it[i].platformFans}}</div>
								<div style="width:18px;height:18px;float:right;"><img alt="{{=it[i].platformName}}" src="images/weixin.png" width="18px" /></div>
							</div>
							<div style="width:160px;height:1px;border-top:1px dotted #707070;margin:0 auto;margin-top:8px;"></div>
							<div style="width:160px;margin:0 auto;height:24px;margin-top:10px;">
								<div style="float:left;margin-top:4px;"><div style="cursor:pointer;width:16px;height:16px;border:1px #333333 solid;"></div></div>
								<div style="float:right;">
									<div class="addCart" style="width:82px;height:24px;font-size:12px;color:#333333;line-height:23px;text-align:center;border-radius:3px;border:1px #333333 solid;cursor:pointer;">+&nbsp;加入购物车</div>
								</div>
							</div>
						</div>
					{{ } }} 
				</script>
				<script> 
					getPublishList(1);//获取第一页数据
				</script> 
			</div>
		</div>
		<%@include file="footer.jsp" %>
<div id="rightDiv" style="width:56px;right:0px;background: white;position: fixed;top:335px;right:2px;">
	<div style="width:100%;position: relative;">
		<div class="hoverFontb" attrstr="div1" style="cursor:pointer;width: 36px;height:36px;padding:10px;border: 1px rgb(242,242,242) solid;position: relative;">
			<img src="images/online.png" />
		</div>
		<div class="div1" style="position: absolute;top:0px;right:55px;width:140px;height:57px;background: white;display:none;">
			<div style="float:left;padding:15px;margin-left:-3px;margin-top:2px;"><img src="images/smile.png" width="25px" /></div>
			<div style="float:left;color:#333333;font-size:14px;line-height: 56px;margin-left:-4px;">点击我咨询哦</div>
			<div class="div" style="float:left;  font-size: 0;line-height: 0;border-width: 10px;border-color: white;border-right-width: 0; border-style: dashed;border-left-style: solid;border-top-color: transparent;border-bottom-color: transparent;position: absolute;top:19px;right:-10px;  "></div>
		</div>
		<div class="hoverFontb" attrstr="div2" style="cursor:pointer;width: 36px;height:36px;padding:10px;border: 1px rgb(242,242,242) solid;border-top:0px;border-bottom: 0px;"><img src="images/tel.png" /></div>
		<div class="div2" style="position: absolute;top:58px;right:55px;width:140px;height:57px;background: white;display:none;">
			<div style="width:100%;line-height: 57px;">
				<img src="images/number.png" style="margin-top:15px;width:93%;margin-left:4%;" />
			</div>
			<div class="div" style="float:left;  font-size: 0;line-height: 0;border-width: 10px;border-color: white;border-right-width: 0; border-style: dashed;border-left-style: solid;border-top-color: transparent;border-bottom-color: transparent;position: absolute;top:19px;right:-10px;  "></div>
		</div>
		<div class="hoverFontb" attrstr="div3" style="cursor:pointer;width: 36px;height:36px;padding:10px;border: 1px rgb(242,242,242) solid;"><img src="images/QR-Code.png" /></div>
		<div class="div3" style="position: absolute;top:116px;right:55px;width:140px;height:160px;background: white;display:none;">
			<div style="width:100%;padding:10px;padding-bottom: 0px;">
				<img src="images/erweima.jpg" style="width:120px;" />
			</div>
			<div style="width:100%;color:#333333;font-size:14px;text-align: center;padding-bottom: 15px;">扫一扫关注官方微信</div>
			<div class="div" style="float:left;  font-size: 0;line-height: 0;border-width: 10px;border-color: white;border-right-width: 0; border-style: dashed;border-left-style: solid;border-top-color: transparent;border-bottom-color: transparent;position: absolute;top:19px;right:-10px;  "></div>
		</div>
		<div onclick="$('body').scrollTop(0)" style="cursor:pointer;width: 16px;height:16px;padding:20px;border: 1px rgb(242,242,242) solid;border-top:0px;"><img src="images/top.png" /></div>
	</div>
</div>
</body>
</html>