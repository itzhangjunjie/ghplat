<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>案例-列表</title>
<base href="/ghplat/front/">
<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript">




</script>
</head>
<body style="padding:0px;margin:0px;">
<input type="hidden" value="1" id="headType" />
<%@include file="header.jsp" %>
	<div style="width:100%;background:rgb(242,242,242);height:auto;overflow: hidden;">
			<div style="width:1200px;margin:0 auto;height:48px;cursor:pointer;display:none;">
				<a href="../addCase" style="text-decoration: none;color:#333333;"><div class="hoverFont" style="border-raduis:2px;margin-top:20px;width:100px;height:25px;border:1px #333333 solid;text-align: center;line-height: 25px;float:right;">+新增案例</div></a>
			</div>
			<c:forEach var="caseDetailsObj" items="${caseList.list }" >
				<div style="width:1140px;padding:20px 30px 40px 30px;background: white;margin:0 auto;margin-top:15px;margin-bottom:20px;border:1px #eeeeee solid;overflow: hidden;">
					<div style="width:100%;height:24px;">
						<div style="width:80%;float:left;color:#333333;font-weight: bold;font-size:18px;">${caseDetailsObj.caseObj.case_title }</div>
						<div style="width:20%;float:right;color:#333333;font-size:12px;margin-top:8px;display:none;">
							<div class="hoverFont" style="float:right;">删除</div>
							<div class="hoverFont" style="float:right;width:2px;height:14px;background:#707070;margin-right:6px;margin-top:3px;"></div>
							<div class="hoverFont" style="float:right;margin-right:6px;">修改</div>
						</div>
					</div>
					<div style="width:100%;height:1px;background: #eeeeee;margin-top:10px;"></div>
					<div style="width:100%;height:400px;margin-top:20px;">
						<div style="width:600px;height:400px;float:left;"><img style="width:600px;height:400px;" src="../attachment${caseDetailsObj.caseObj.image }"/></div>
						<div style="float:left;margin-left:20px;width:520px;height:400px;font-size:14px;position: relative;">
							<div style="width:100%;height:22px;">
								<div style="float:right;padding:2px 8px;text-align: center;color:white;background: black;">${caseDetailsObj.caseObj.case_Industry }</div>
								<div style="float:right;padding:2px 8px;text-align: center;margin-right:5px;">${caseDetailsObj.caseObj.case_brand }</div>
								<div style="float:right;padding:2px 8px;text-align: center;margin-right:5px;">${caseDetailsObj.caseObj.case_product }</div>
							</div>
							<div style="width:100%;margin-top:20px;text-indent:25px;font-size:14px;line-height:22px;color:#333333;">
								${caseDetailsObj.caseObj.case_desc }
							</div>
							<div style="position: absolute;bottom: 0px;right:0px;width:260px;">
								<div style="float:left;font-size:14px;line-height: 36px;">分享到：</div>
								<ul class="w-wb1">
					            	<li class="f-pr">
					            		<a href="javascript:void(0)" class="wb11" onmouseover="onMouseoverXCode()" onmouseout="onMouseoutXCode()">分享到微信</a>
					            		<div class="towdimcodelayer js-transition" id="layerWxcode">
					            			<div class="arrow js-arrow-down"></div>
					            			<div class="layerbd">
					            				<div class="codebg"><img class="xtag" src="http://www.lofter.com/genBitmaxImage?url=http://183.194.9.134:8089/ghplat/caselist?publishId=${param.publishId }"></div>
					            				<div class="codettl">打开微信扫一扫</div>
					            			</div>
					            		</div>
					            	</li>
					                <li><a href="javascript:void(0)" onclick="dolog('sina', function(){window.open('http://v.t.sina.com.cn/share/share.php?title=' + encodeURIComponent('${caseDetailsObj.caseObj.case_title }') + '&pic=' + encodeURIComponent('http://183.194.9.134:8089/ghplat/attachment${caseDetailsObj.caseObj.image }') + '&sourceUrl=http://183.194.9.134:8089/ghplat/caselist?publishId=${param.publishId }', '_parent', ['toolbar=0,status=0,resizable=1,width=630,height=500,left=',(screen.width-630)/2,',top=',(screen.height-500)/2].join(''));return false;});" class="wb1" title="分享到新浪微博">分享到新浪微博</a></li>
					                <li><a href="javascript:void(0)" onclick="dolog('qq', function(){window.open('http://v.t.qq.com/share/share.php?c=share&a=index&appkey=5bd32d6f1dff4725ba40338b233ff155&title=' + encodeURIComponent('${caseDetailsObj.caseObj.case_title }') + '&pic=' + encodeURIComponent('http://183.194.9.134:8089/ghplat/attachment${caseDetailsObj.caseObj.case_desc }'), '_parent', ['toolbar=0,status=0,resizable=1,width=630,height=500,left=',(screen.width-630)/2,',top=',(screen.height-500)/2].join(''));return false;});" class="wb4" title="分享到腾讯微博">分享到腾讯微博</a></li>
					                <li><a href="javascript:void(0)" onclick="dolog('qzone', function(){window.open('http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?title=' + encodeURIComponent('${caseDetailsObj.caseObj.case_title }') + '&url=' + encodeURIComponent('http://183.194.9.134:8089/ghplat/caselist?publishId=${param.publishId }'), '_parent', ['toolbar=0,status=0,resizable=1,width=600,height=520,left=',(screen.width-600)/2,',top=',(screen.height-520)/2].join(''));return false;});" class="wb5" title="分享到QQ空间">分享到QQ空间</a></li>
					            </ul>
							</div>
						</div>
					</div>
					<div style="width:100%;height:96px;margin-top:20px;">
						<div id="wrap2" style="width:1130px;" attrCount="5">
							<div class="article_pic_left_btn">
							     <img src="images/space_16_23.png" id="cardArrowLeft" class="live_card_arrow_left_physical" />
							 </div>
							<div class="puzzle_card" id="puzzle_card2" style="width:1085px;background: white;margin-left:40px;">
								<div class="showbox" id="showbox2">
								  <ul id="article_pic_slider">
								  		<c:forEach var="ccaseDetailsObj" items="${caseDetailsObj.caseObj.childPublish }" >
									  		<li class="addZiMeiTiSu"><div style="width: 215px; float: left; height: 96px; position: relative; display: block;" class="" attrid="2794364">
												<div style="width:96px;height:96px;float:left;"><img src="../attachment${ccaseDetailsObj.image }" style="width:96px;height:96px;" id="mtImage"></div>
													<div style="float:left;width:100px;height:96px;margin-left:18px;">
														<div style="margin-top:12px;width:90px;height:16px;overflow: hidden;line-height:16px;color:black;font-weight: bold;font-size:14px;" id="mtName">${ccaseDetailsObj.publishName }</div>
														<div style="margin-top:6px;width:70px;height:18px;overflow: hidden;color:#333333;font-size:12px;" id="mtPlatform">${ccaseDetailsObj.platformName }</div>
														<div style="margin-top:6px;width:70px;height:33px;overflow: hidden;color:#333333;font-size:12px;">粉丝数：<br><span id="mtFancount">${ccaseDetailsObj.platformFans }</span></div>
													</div>
												</div>
											</li>
								  		</c:forEach>
								  </ul>
								</div>
							</div>
					        <div class="article_pic_right_btn">
					          <img src="images/space_16_23.png" id="cardArrowRight" class="live_card_arrow_right_physical" />
					        </div>
						</div>
					</div>
					<div class="imageDetailsDiv" style="width:100%;margin-top:30px;display:none;">
						<div class="imageDetailsTitle" style="width:100%;text-align: left;font-weight: bold;font-size:16px;">活动简介</div>
						<div class="imageDetailsDesc" style="width:97%;text-align: left;font-size:14px;text-indent:25px;font-size:14px;line-height:22px;color:#333333;margin-top:5px;">
							活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介活动简介
						</div>
					</div>
					<div style="width:100%;margin-top:30px;">
						<div style="width:100%;text-align: left;font-weight: bold;font-size:16px;">活动图片</div>
						<div style="width:100%;margin-top:15px;">
							<div id="wrap2" attrCount="6" style="width:1130px;height:96px;">
								<div class="article_pic_left_btn">
								     <img src="images/space_16_23.png" id="cardArrowLeft" class="live_card_arrow_left_physical" />
								 </div>
								<div class="puzzle_card" id="puzzle_card2" style="width:1085px;background: white;margin-left:40px;">
									<div class="showbox" id="showbox2">
									  <ul id="article_pic_slider">
									  		<c:forEach var="caseImageObj" items="${caseDetailsObj.caseObj.caseImageList }" >
										 		<li class="addZiMeiTiSu" style="margin-left:0px;width:160px;height:96px;float:left;">
													<img onclick="changeImageDetails(this)" imageTitle="${caseImageObj.imageTitle }" imageDesc="${caseImageObj.imageDesc }" title="${caseImageObj.imageTitle }" src="../attachment${caseImageObj.imageUrl }" style="width:160px;height:96px;" class="mtImage">
												</li>
									 		</c:forEach>
									  </ul>
									</div>
								</div>
						        <div class="article_pic_right_btn">
						          <img src="images/space_16_23.png" id="cardArrowRight" class="live_card_arrow_right_physical" />
						        </div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
	</div>	

<%@include file="footer.jsp" %>
</body>
<script>
function changeImageDetails(tt){
	var title = $(tt).attr('imageTitle');
	var desc = $(tt).attr('imageDesc');
	$('.imageDetailsTitle').html(title);
	$('.imageDetailsDesc').html(desc);
	$('.imageDetailsDiv').show();
}

function dolog(_info, _callback) {
var img = new Image();
img.onload=img.onerror=_callback;
img.src = 'http://www.jq-school.com/images/logo.gif';
}

var layerWxcode = document.getElementById('layerWxcode');
function onMouseoverXCode(){
layerWxcode.className = 'towdimcodelayer js-transition js-show-up';
}
function onMouseoutXCode(){
layerWxcode.className = 'towdimcodelayer js-transition';
}
</script>
</html>