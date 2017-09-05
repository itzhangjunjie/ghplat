<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<link rel="stylesheet" href="front/css/menu.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="front/css/style.css" />
<style type="text/css">
.publishAClass:hover img {
    opacity: 0.8;
    transition: all 0.4s ease-out 0s;
}
</style>
</head>
<body style="padding:0px;margin:0px;">
<input type="hidden" value="0" id="headType" />
	<%@include file="header.jsp" %>
		<div style="width:100%;margin:0 auto;">
			<div id="demo01" class="flexslider">
				<ul class="slides">
					<c:forEach var="banner" items="${bannerlist.list }">
						<li><div class="img" style="width:100%;height:360px;background: url(/ghplat/attachment/banner/${banner.image });background-position:center;"></div></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div style="width:100%;background:rgb(242,242,242);height:380px;">
			<div style="font-size:24px;color:#333333;width:1200px;text-align: left;margin:0 auto;padding-top:30px;padding-bottom: 8px;">自媒体展示</div>
			<div style="width:1200px;height:1px;background:#707070;margin:0 auto;"></div>
			<div style="width:1200px;margin:0 auto;margin-top:20px;">
				<c:forEach var="publish" items="${zimeitilist }" varStatus="stt">
					<div style="float:left;width:210px;height:280px;position: relative;background: white;margin-left:4px;<c:if test="${stt.index!=0 }">margin-left:36px;</c:if>margin-top:4px;">
						<div style="z-index:3;position: absolute;top:-4px;left:-4px;width:76px;text-align: center;height:22px;line-height: 22px;font-size:12px;color:#ffffff;background: rgb(37,202,154);">${publish.publishTypeObj.publishFieldName }</div>
						<div style="margin:0 auto;width:100%;height:210px;overflow: hidden;">
							<a class="publishAClass" style="background: black;width:100%;height:210px;display:block;" href="../getPublishDetails?pghid=${publish.ghid }"><img src="/ghplat/attachment${publish.image }" style="width:100%;height: 210px;" /></a>
						</div>
						<div style="width:160px;margin:0 auto;font-size:14px;color:#333333;margin-top:10px;">${publish.publishName }</div>
						<div style="width:160px;margin:0 auto;margin-top:10px;color:#333333;">
							<div style="width:18px;height:18px;float:left;"><img src="front/images/fans.png" width="18px" /></div>
							<div style="float:left;margin-left:8px;font-size:13px;line-height: 18px;">${publish.platformFans }</div>
							<c:if test="${publish.platformIcon!=null }">
								<div style="width:18px;height:18px;float:right;"><img src="/ghplat/attachment/platform/${publish.platformIcon }" width="18px" /></div>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div style="width:100%;background:rgb(242,242,242);">
			<div style="font-size:24px;color:#333333;width:1200px;text-align: left;margin:0 auto;padding-top:30px;padding-bottom: 8px;">联合推广资源</div>
			<div style="width:1200px;height:1px;background:#707070;margin:0 auto;"></div>
			<c:forEach var="tuiguang" items="${tuiguangs.list }">
				<div style="width:1200px;height:88px;margin:0 auto;margin-top:20px;">
					<c:if test="${tuiguang.type=='内链' }"><a href="../getBannerDetails?bannerId=${tuiguang.indexBannerId }" target="_bank">
						<img src="/ghplat/attachment/banner/${tuiguang.image}" width="100%"/></a>
					</c:if>
					<c:if test="${tuiguang.type=='外链' }"><a href="${tuiguang.url }" target="_bank">
						<img src="/ghplat/attachment/banner/${tuiguang.image}" width="100%"/></a>
					</c:if>
					<c:if test="${tuiguang.type!='外链'&&tuiguang.type!='内链' }">
						<img src="/ghplat/attachment/banner/${tuiguang.image}" width="100%"/>
					</c:if>
				</div>
			</c:forEach>
		</div>
		<div style="width:100%;background:rgb(242,242,242);border-bottom: 1px #707070 solid;">
			<div style="font-size:24px;color:#333333;width:1200px;text-align: left;margin:0 auto;padding-top:30px;padding-bottom: 8px;">我们的合作伙伴</div>
			<div style="width:1200px;height:1px;background:#707070;margin:0 auto;"></div>
			<div style="width:1200px;margin:0 auto;margin-bottom: 20px;height:auto;overflow: hidden;">
				<c:forEach var="hezuo" items="${hezuos.list }" varStatus="stt">
					<div style="width:100px;float:left;margin-left:175px;<c:if test="${stt.index%5==0 }">margin-left:0px;</c:if>margin-top:25px;height:100px;overflow: hidden;">
						<a href="${hezuo.url }" target="_bank"><img src="/ghplat/attachment/banner/${hezuo.image}" width="100%"/></a>
					</div>
				</c:forEach>
			</div>
		</div>
		<%@include file="footer.jsp" %>
</body>
</html>