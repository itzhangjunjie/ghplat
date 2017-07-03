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
						<div style="position: absolute;top:-4px;left:-4px;width:76px;text-align: center;height:22px;line-height: 22px;font-size:12px;color:#ffffff;background: rgb(37,202,154);">${publish.publishTypeObj.publishFieldName }</div>
						<div style="margin:0 auto;padding-top:30px;padding-left:25px;padding-right:25px;width:160px;height:180px;">
							<a href="../getPublishDetails?pghid=${publish.ghid }"><img src="/ghplat/attachment${publish.image }" width="160px" height="180px" /></a>
						</div>
						<div style="width:160px;margin:0 auto;font-size:14px;color:#333333;margin-top:10px;">${publish.publishName }</div>
						<div style="width:160px;margin:0 auto;margin-top:10px;color:#333333;">
							<div style="width:18px;height:18px;float:left;"><img src="images/fans.png" width="18px" /></div>
							<div style="float:left;margin-left:8px;font-size:13px;line-height: 18px;">${publish.platformFans }</div>
							<c:if test="${publish.platformIcon!=null }">
								<div style="width:18px;height:18px;float:right;"><img src="${publish.platformIcon }" width="18px" /></div>
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
						<img src="/ghplat/attachment/banner/${hezuo.image}" height="100%"/>
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
		<%@include file="footer.jsp" %>
</body>
</html>