<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详情-媒体</title>
<base href="/ghplat/front/">
<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript">

function addCartDiv(){
	var alen = parseInt($('.headCartCount').html())+1;
	$('.headCartCount').html(alen);
	alert('添加成功！');
}
</script>
</head>
<body style="padding:0px;margin:0px;">
<input type="hidden" value="1" id="headType" />
<%@include file="header.jsp" %>
<div style="width:100%;background:rgb(242,242,242);height:auto;overflow: hidden;">
	<div style="width:1198px;background: white;margin:0 auto;margin-top:20px;margin-bottom:20px;border:1px #eeeeee solid;overflow: hidden;">
		<div style="width:1140px;margin-left:30px;margin-top:30px;padding-bottom: 20px;">
			<div style="width:100%;height:155px;">
				<div style="float:left;font-size:14px;width:130px;text-align: left;line-height: 120px;">头像：</div>
				<div style="float:left;margin-left:20px;"><img width="150px" height="120px" src="../attachment${pdetails.image }"/></div>
			</div>
			<div style="width:100%;height:40px;margin-top:20px;">
				<div style="float:left;font-size:14px;width:130px;text-align: left;line-height: 40px;">类型：</div>
				<div style="float:left;margin-left:20px;height:40px;line-height: 40px;font-size:14px;">${pdetails.publishTypeObj.publishFieldName }</div>
			</div>
			<div style="width:100%;height:40px;margin-top:20px;">
				<div style="float:left;font-size:14px;width:130px;text-align: left;line-height: 40px;">标题：</div>
				<div style="float:left;margin-left:20px;height:40px;line-height: 40px;font-size:14px;">${pdetails.publishName }</div>
			</div>
			<div style="width:100%;height:40px;margin-top:20px;">
				<div style="float:left;font-size:14px;width:130px;text-align: left;line-height: 40px;">粉丝数：</div>
				<div style="float:left;margin-left:20px;height:40px;line-height: 40px;font-size:14px;">${pdetails.platformFans }</div>
			</div>
			<div style="width:100%;height:40px;margin-top:20px;">
				<div style="float:left;font-size:14px;width:130px;text-align: left;line-height: 40px;">平台类型：</div>
				<div style="float:left;margin-left:20px;height:40px;line-height: 40px;font-size:14px;">${pdetails.platformName }</div>
			</div>
			<c:forEach items="${pdetails.priceMap }" var="priceMap">
				<div style="width:100%;height:40px;margin-top:20px;">
					<div style="float:left;font-size:14px;width:130px;text-align: left;line-height: 40px;">${priceMap.key }价格：</div>
					<div style="float:left;margin-left:20px;height:40px;line-height: 40px;font-size:14px;">￥${priceMap.value }</div>
				</div>
			</c:forEach>
			<c:forEach items="${pdetails.infoMap }" var="infoMap">
				<div style="width:100%;height:40px;margin-top:20px;">
					<div style="float:left;font-size:14px;width:130px;text-align: left;line-height: 40px;">${infoMap.key }：</div>
					<div style="float:left;margin-left:20px;height:40px;line-height: 40px;font-size:14px;">${infoMap.value }</div>
				</div>
			</c:forEach>
			<div style="width:100%;height:50px;margin-top:20px;">
				<div style="width:300px;margin:0 auto;">
					<div style="float:left;cursor:pointer;background: #fc6769;width:140px;font-size:16px;color: white;text-align: center;line-height: 40px;height:40px;"><a href="../caselist?publishId=${pdetails.id }" style="text-decoration: none;width:140px;color: white;">查看案例</a></div>
					<div onclick="addCartDiv()" style="float:left;margin-left:20px;cursor:pointer;background: #fc6769;width:140px;font-size:16px;color: white;text-align: center;line-height: 40px;height:40px;">加入购物车</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="footer.jsp" %>
</body>

</html>