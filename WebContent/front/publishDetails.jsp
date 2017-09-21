<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width initial-scale=1.0 minimum-scale=1.0 maximum-scale=1.0 user-scalable=yes" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详情-媒体</title>
<script src="front/js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="front/js/main.js" type="text/javascript"></script>
<script type="text/javascript">
function addCartDiv(pid){
	var alen = parseInt($('.headCartCount').html())+1;
	$('.headCartCount').html(alen);
	addCart(pid);
	alert('添加成功！');
}
$(document).ready(function(){
	var uesFlag = $('#uesFlag').val(); var flag2 = uesFlag.substring(1,2);
	if(flag2=='1'){
		$('.priceSpanDis').hide();
		$('.priceSpan').show();
	}else{
		$('.priceSpanDis').show();
		$('.priceSpan').hide();
	}
})
</script>
</head>
<body style="padding:0px;margin:0px;">
<input type="hidden" value="1" id="headType" />
<input type="hidden" value="${sessionScope.user.userFlag }" id="uesFlag"/>
<%@include file="header.jsp" %>
<div style="width:100%;background:rgb(242,242,242);height:auto;overflow: hidden;">
	<div style="width:1198px;background: white;margin:0 auto;margin-top:20px;margin-bottom:20px;border:1px #eeeeee solid;overflow: hidden;">
		<div style="width:1140px;margin-left:30px;margin-top:30px;padding-bottom: 20px;overflow: hidden;">
			<div style="width:15%;height:120px;float:left;">
				<div style="float:left;"><img width="150px" height="120px" src="../attachment${pdetails.image }"/></div>
			</div>
			<div style="width:20%;overflow:hidden;float:left;margin-left:1%;">
				<div style="width:100%;overflow:hidden;">
					<div style="float:left;font-size:14px;width:47px;text-align: left;line-height: 30px;color:#707070;">类型</div>
					<div style="float:left;margin-left:13px;line-height: 30px;font-size:14px;max-width:930px;">${pdetails.publishTypeObj.publishFieldName }</div>
				</div>
				<div style="width:100%;overflow:hidden;">
					<div style="float:left;font-size:14px;width:47px;text-align: left;line-height: 30px;color:#707070;">标题</div>
					<div style="float:left;margin-left:13px;line-height: 30px;font-size:14px;max-width:930px;">${pdetails.publishName }</div>
				</div>
				<div style="width:100%;overflow:hidden;">
					<div style="float:left;font-size:14px;width:47px;text-align: left;line-height: 30px;color:#707070;">粉丝数</div>
					<div style="float:left;margin-left:13px;line-height: 30px;font-size:14px;max-width:930px;">${pdetails.platformFans }</div>
				</div>
			</div>
			<div style="width:36%;overflow:hidden;float:left;">
				<div style="width:100%;overflow:hidden;">
					<div style="float:left;font-size:14px;width:25%;text-align: left;line-height: 30px;color:#707070;">所属领域</div>
					<div style="float:left;line-height: 30px;font-size:14px;width:75%;">${pdetails.publishField }</div>
				</div>
				<c:if test="${pdetails.platformName!=null }">
					<div style="width:100%;overflow:hidden;">
						<div style="float:left;font-size:14px;width:25%;text-align: left;line-height: 30px;color:#707070;">平台类型</div>
						<div style="float:left;line-height: 30px;font-size:14px;width:75%;">${pdetails.platformName }</div>
					</div>
				</c:if>
				<c:forEach items="${pdetails.infoMap }" var="infoMap">
					<c:if test="${infoMap.key == '微博链接'||infoMap.key == '视频链接'||infoMap.key == '直播间链接' }">
						<div style="width:100%;overflow:hidden;">
							<div style="float:left;font-size:14px;width:25%;text-align: left;line-height: 30px;color:#707070;">${infoMap.key }</div>
							<div style="float:left;line-height: 30px;font-size:14px;width:75%;"><a target="_blank" href="${infoMap.value }">${infoMap.value }</a></div>
						</div>
					</c:if>
					<c:if test="${infoMap.key != '微博链接'&&infoMap.key != '视频链接'&&infoMap.key != '直播间链接'&&infoMap.key!='视频介绍' }">
						<c:if test="${infoMap.key!='公众号介绍'&&infoMap.key!='主播介绍' }">
							<div style="width:100%;overflow:hidden;">
								<div style="float:left;font-size:14px;width:25%;text-align: left;line-height: 30px;color:#707070;">${infoMap.key }</div>
								<div style="float:left;line-height: 30px;font-size:14px;width:75%;">${infoMap.value }</div>
							</div>
						</c:if>
					</c:if>
				</c:forEach>
			</div>
			<div style="width:25%;overflow:hidden;float:left;padding-left:3%;">
				<c:forEach items="${pdetails.priceMap }" var="priceMap">
					<div style="width:100%;overflow:hidden; ">
						<div style="float:left;font-size:14px;width:120px;text-align: left;line-height: 30px;color:#707070;">${priceMap.key }价格</div>
						<div style="float:left;margin-left:13px;line-height: 30px;font-size:14px;max-width:930px;"><span class="priceSpan">￥${priceMap.value }</span><span class="priceSpanDis" style="display:none;">**</span></div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div style="width:1140px;margin-left:30px;margin-top:10px;">
			<div style="width:95px;font-size: 16px;color:black;font-weight: bold;">
				${pdetails.publishTypeObj.publishFieldName }
			</div>
			<div style="width:100%;height:1px;background: #aeaeae;margin-top:10px;">
				<div style="width:95px;height:1px;background: black;"></div>
			</div>
			<div style="margin-top:15px;font-size:14px;color:#707070;">
				<c:forEach items="${pdetails.infoMap }" var="infoMap">
					<c:if test="${infoMap.key=='公众号介绍' || infoMap.key=='主播介绍' || infoMap.key=='视频介绍'}">${infoMap.value }
					</c:if>
				</c:forEach>
			</div>
		</div>
		<c:if test="${pdetails.publishTypeObj.publishFieldName!='主播' }">
		<div style="width:1140px;margin-left:30px;margin-top:25px;">
			<div style="width:110px;font-size: 16px;color:black;font-weight: bold;">用户数据分析</div>
			<div style="width:100%;height:1px;background: #aeaeae;margin-top:10px;">
				<div style="width:110px;height:1px;background: black;"></div>
			</div>
			<div style="font-size:14px;color:#707070;width:700px;margin:0 auto;margin-top:20px;overflow: hidden;height:220px;">
				<div style="width:230px;float:left;margin-top:60px;margin-bottom: 50px;">
					<div style="width:100%;color:#707070;margin-top:8px;">90天头条平均阅读数：<span style="color:black;">${wxdetails.col3 }</span></div>
					<div style="width:100%;color:#707070;margin-top:12px;">90天次条平均阅读数：<span style="color:black;">${wxdetails.col4 }</span></div>
					<div style="width:100%;color:#707070;margin-top:12px;">90天3-N条平均阅读数：<span style="color:black;">${wxdetails.col5 }</span></div>
				</div>
				<div style="position: relative;margin-left:130px;width:300px;margin-top:-35px;float:left;">
					<div style="position: absolute;top:80px;left:-80px;z-index:2;">近30天原创文章数:${wxdetails.col7 }</div>
					<div style="position: absolute;top: 0px;left:0px;">
						<svg  id="svg1" style="" version="1.1" xmlns="http://www.w3.org/2000/svg">
							<defs id="mydefs">
								<linearGradient id="lightGreenGradient" x1="0%" y1="0%" x2="100%" y2="0%">
									<stop offset="0%" stop-color="#38c19d" stop-opacity="0.2"></stop>
									<stop offset="100%" stop-color="#38c19d" stop-opacity="0.5"></stop>
								</linearGradient>
								<linearGradient id="greenDeepGradient" x1="0%" y1="0%" x2="100%" y2="100%">
									<stop offset="0%" stop-color="#38c19d" stop-opacity="0.5"></stop>
									<stop offset="100%" stop-color="#38c19d" stop-opacity="1"></stop>
								</linearGradient>
								<linearGradient id="greenLightRedGradient" x1="0%" y1="0%" x2="100%" y2="100%">
									<stop offset="0%" stop-color="#38c19d" stop-opacity="1"></stop>
									<stop offset="100%" stop-color="#ff0000" stop-opacity="0.5"></stop>
								</linearGradient>
								<linearGradient id="LightRedGradient" x1="0%" y1="0%" x2="100%" y2="100%">
									<stop offset="0%" stop-color="#ff0000" stop-opacity="0.5"></stop>
									<stop offset="100%" stop-color="#ff0000" stop-opacity="1"></stop>
								</linearGradient>
							</defs>
						</svg>

<script>
window.onload=function(){
	var speed=1/30*Math.PI;
	var Q=5/3*Math.PI;
	var time=20;
	createQuaCircle("svg1");
	doAnimation(Q,"svg1",speed,time);
	showText("svg1","近30天总文章数(${wxdetails.col6})","18");
	//创建1/4半圆
}
function doAnimation(Q,id,speed,time){
	  var oSvg=document.getElementById(id);
	  var oSvgWidth=parseInt((oSvg.curentStyle?oSvg.curentStyle:window.getComputedStyle(oSvg,null)).width);
	  console.log(oSvgWidth);
	  oSvg.setAttribute("height",oSvgWidth);
	  //创建use元素的组合
	  var bgCircleG=document.createElementNS("http://www.w3.org/2000/svg","g");
	  bgCircleG.setAttribute("transform","translate("+0.5*oSvgWidth+","+0.5*oSvgWidth+")");
	  createGradientBg(bgCircleG,oSvg,oSvgWidth);
	  var currentAngle=0;
	  var rotateRirection;  //旋转的方向如果Q<=Math.PI rotateRirection 为1 大的弧度，如果Q>Math.PI rotateRirection为0 小的弧度
	  if (Q<=0) {
		//大圆
		var smallCircle=document.createElementNS("http://www.w3.org/2000/svg","circle");
		smallCircle.setAttribute("cx",0);
		smallCircle.setAttribute("cy",0);
		smallCircle.setAttribute("r",0.3*oSvgWidth+1);
		smallCircle.setAttribute("fill","#e5e5e5");
		bgCircleG.appendChild(smallCircle);
		//小圆
		drawSmallCircle(id,bgCircleG,oSvgWidth);
	  }
	  else if (Q>0&&Q<=2*Math.PI) {
		rotateRirection=judgeRirection(currentAngle);
		currentAngle+=speed;
		var tId=null;
		annimationCircle(id,bgCircleG,currentAngle,oSvgWidth,rotateRirection);
		tId=setInterval(function(){
				if (currentAngle<=Q) {
					rotateRirection=judgeRirection(currentAngle);
					annimationCircle(id,bgCircleG,currentAngle,oSvgWidth,rotateRirection);
					currentAngle+=speed;
					if (currentAngle>=Q) {
						currentAngle=Q;
						if (Q>Math.PI) {
						rotateRirection=judgeRirection(currentAngle);
						}
						annimationCircle(id,bgCircleG,currentAngle,oSvgWidth,rotateRirection);
						clearTimeout(tId);

					};
				}
				else {
					currentAngle=Q;
					rotateRirection=judgeRirection(currentAngle);
					annimationCircle(id,bgCircleG,currentAngle,oSvgWidth,rotateRirection);
					clearTimeout(tId);
			
			}
		},time);
	  }
	  else if(Q>2*Math.PI){
		drawSmallCircle(id,bgCircleG,oSvgWidth);
	  }
	  
}
function createQuaCircle(id){
		var oSvg=document.getElementById(id);
		var oSvgWidth=parseInt((oSvg.curentStyle?oSvg.curentStyle:window.getComputedStyle(oSvg,null)).width);
		var cr1=cr2=0.5*oSvgWidth;
		var oPathElement=document.createElementNS("http://www.w3.org/2000/svg","path");
		var d="M0,0"+" L 0,"+-0.3*oSvgWidth+" A"+0.3*oSvgWidth+","+0.3*oSvgWidth+" 0 0,1 "+0.3*oSvgWidth+",0 z";
		oPathElement.id="halfCircle";
		oPathElement.setAttribute("d",d);
		var omydefs=document.getElementById("mydefs");
		omydefs.appendChild(oPathElement);
}
function createGradientBg(bgCircleG,oSvg){
		
		//创建第一个use元素
		var bgCircle1=document.createElementNS("http://www.w3.org/2000/svg","use");
		bgCircle1.setAttribute("fill","url(#lightGreenGradient)");
		bgCircle1.setAttributeNS("http://www.w3.org/1999/xlink","xlink:href","#halfCircle");
		//创建第2个use元素并且旋转90度
		var bgCircle2=document.createElementNS("http://www.w3.org/2000/svg","use");
		bgCircle2.setAttributeNS("http://www.w3.org/1999/xlink","xlink:href","#halfCircle");
		bgCircle2.setAttribute("fill","url(#greenDeepGradient)");
		bgCircle2.setAttribute("transform","rotate(90)");
		//创建第3个use元素并且旋转180度
		var bgCircle3=document.createElementNS("http://www.w3.org/2000/svg","use");
		bgCircle3.setAttributeNS("http://www.w3.org/1999/xlink","xlink:href","#halfCircle");
		bgCircle3.setAttribute("fill","url(#greenLightRedGradient)");
		bgCircle3.setAttribute("transform","rotate(180)");
		//创建第4个use元素并且旋转270度
		var bgCircle4=document.createElementNS("http://www.w3.org/2000/svg","use");
		bgCircle4.setAttributeNS("http://www.w3.org/1999/xlink","xlink:href","#halfCircle");
		bgCircle4.setAttribute("fill","url(#LightRedGradient)");
		bgCircle4.setAttribute("transform","rotate(270)");
		//将use元素追加到组合中
		bgCircleG.appendChild(bgCircle1);
		bgCircleG.appendChild(bgCircle2);
		bgCircleG.appendChild(bgCircle3);
		bgCircleG.appendChild(bgCircle4);
		oSvg.appendChild(bgCircleG);
		}
	  //动态圆遮挡边用灰色填充
function annimationCircle(id,bgCircleG,Q,oSvgWidth,rotateRirection){
		if (oPathElement2=document.getElementById("half"+id)) {
			bgCircleG.removeChild(oPathElement2);
		};
		var oPathElement2=document.createElementNS("http://www.w3.org/2000/svg","path");
		var d="M0,0"+" L"+(0.3*oSvgWidth)*Math.sin(Q)+","+(-(0.3*oSvgWidth)*Math.cos(Q))+" A"+(0.3*oSvgWidth)+","+(0.3*oSvgWidth)+" 0 "+rotateRirection+",1 "+"0 "+(-0.3*oSvgWidth)+" z";
		oPathElement2.id="half"+id;
		oPathElement2.setAttribute("d",d); 
		oPathElement2.setAttribute("stroke","#e5e5e5");
		oPathElement2.setAttribute("fill","#e5e5e5");
		bgCircleG.appendChild(oPathElement2);
		drawSmallCircle(id,bgCircleG,oSvgWidth);
  }
	// 圆弧中比较小的圆用白色填充
function drawSmallCircle(id,bgCircleG,oSvgWidth){
		if (smallCircle2=document.getElementById("smallCircle"+id)) {
			bgCircleG.removeChild(smallCircle2);
		};
		var smallCircle=document.createElementNS("http://www.w3.org/2000/svg","circle");
		smallCircle.id="smallCircle"+id;
		smallCircle.setAttribute("cx",0);
		smallCircle.setAttribute("cy",0);
		smallCircle.setAttribute("r",0.25*oSvgWidth+1);
		smallCircle.setAttribute("stroke","#FFF");
		smallCircle.setAttribute("stroke-width","4");
		smallCircle.setAttribute("fill","#FFF");
		bgCircleG.appendChild(smallCircle);
}
  //rotateRirection 旋转的方向如果<=Math.PI rotateRirection 为1 大的弧度，如果>Math.PI rotateRirection为0 小的弧度
function judgeRirection(angle){
		if (angle<=Math.PI) {
				rotateRirection=1;
		}
		else {
				rotateRirection=0;
		}
		return rotateRirection;
}
function showText(id,value,fontSize){
	var oSvg=document.getElementById(id);
	var oSvgWidth=parseInt((oSvg.curentStyle?oSvg.curentStyle:window.getComputedStyle(oSvg,null)).width);
	if (oSvgWidth<480) {
		fontSize=0.8*parseInt(fontSize);
	};
	var otext=document.createElementNS("http://www.w3.org/2000/svg","text");
	var oTspan=document.createElementNS("http://www.w3.org/2000/svg","tspan");
	otext.setAttribute("x",parseInt(0.5*oSvgWidth));
	otext.setAttribute("y",parseInt(0.5*oSvgWidth));
	otext.setAttribute("font-size",fontSize);
	otext.setAttribute("z-index",99999);
	otext.setAttribute("font-weight","500");
	otext.setAttribute("font-family","微软雅黑");
	otext.setAttribute("text-anchor","middle");
	otext.setAttribute("dominant-baseline","middle");
	otext.setAttribute("fill","#000000");
	var oTextCon=document.createTextNode(value);
	otext.appendChild(oTextCon);
	oSvg.appendChild(otext);
}
</script>
					</div>
				</div>
			</div>
	<div style="width:100%;margin-top:25px;">
			<div style="width:110px;font-size: 16px;color:black;font-weight: bold;">热文TOP10</div>
			<div style="width:100%;height:1px;background: #aeaeae;margin-top:10px;margin-bottom: 15px;">
				<div style="width:110px;height:1px;background: black;"></div>
			</div>
			<c:forEach items="${wxdetails.top10list }" var="wxdetailsObj">
				<div style="width:98%;margin-left:2%;margin-top:8px;height:20px;">
					<div style="overflow: hidden;float:left;font-size:14px;"><a target="_blank" href="${wxdetailsObj.url }">${wxdetailsObj.title }</a></div>
					<div style="width:40px;overflow: hidden;float:right;margin-right:10px;color:#707070;font-size:12px;">${wxdetailsObj.createTime }</div>
					<div style="width:90px;overflow: hidden;float:right;margin-right:10px;color:#707070;font-size:12px;">阅读数：${wxdetailsObj.viewCount }</div>
					<div style="width:100px;height:17px;overflow: hidden;margin-right:5px;float:right;color:#707070;font-size:12px;"><a target="_blank" href="${wxdetails.col12 }">${wxdetailsObj.name }</a></div>
				</div>
			</c:forEach>
	</div>
		</div>
</c:if>
		<div style="width:100%;height:50px;margin-top:25px;margin-bottom: 20px;">
			<div style="width:300px;margin:0 auto;">
				<div style="float:left;cursor:pointer;background: #fc6769;width:140px;font-size:16px;color: white;text-align: center;line-height: 40px;height:40px;"><a href="../caselist?publishId=${pdetails.id }" style="text-decoration: none;width:140px;color: white;">查看案例</a></div>
				<div onclick="addCartDiv(${pdetails.id })" style="float:left;margin-left:20px;cursor:pointer;background: #fc6769;width:140px;font-size:16px;color: white;text-align: center;line-height: 40px;height:40px;">加入购物车</div>
			</div>
		</div>
	</div>
</div>
<%@include file="footer.jsp" %>
</body>
</html>