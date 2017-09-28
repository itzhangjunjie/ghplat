<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${content.title }</title>
<link rel="stylesheet" href="front/css/menu.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="front/css/style.css" />
<!-- 页面关键词 -->
<meta name="keywords" content="${content.title }"/>
<!-- 搜索引擎抓取 -->
<meta name="robots" content="${content.title }"/>
<script src="front/js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
function golist(){
	location.href='contentlist';
}
function gocontentlist(){
	$('#contentlistForm').submit();
}
function gopublishlist(ghid){
	location.href='getPublishDetails?pghid='+ghid;
}
</script>
<script>
(function(){
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https') {
        bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';        
    }
    else {
        bp.src = 'http://push.zhanzhang.baidu.com/push.js';
    }
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>
<style type="text/css">
#demo16{
  position: relative;
}
#demo16:before {
  border: 10px solid transparent;
  border-right: 10px solid #fff;
  width: 0;
  height: 0;
  position: absolute;
  top: 0;
  content: ' '
}
#demo16:before {
  border-right-color: #f00;
  left: -14px;
}
</style>
</head>
<body style="padding:0px;margin:0px;">
<input type="hidden" value="2" id="headType" />
<div onclick="gopublishlist('${content.publish.ghid}')" id="rightContentDiv" style="width:100%;left:0px;background: white;height:60px;position: fixed;bottom:0px;right:2px;z-index:999;cursor: pointer;">
	<form action="contentlist" method="post" id="contentlistForm">
		<input type="hidden" value="${content.publish.publishName }" name="publishName" />
	</form>
	<div style="background:#fc6769; border-radius:15px;width:150px;margin:0 auto;height:25px;font-size:14px;color:white;line-height: 25px;padding-left:12px;margin-top:20px;">
		关注${content.publish.publishName }的其他内容...
	</div>
</div>
	<%@include file="header.jsp" %>
	<div style="width:100%;margin:0 auto;">
		<div style="width:1200px;margin:0 auto;overflow: hidden;margin-top:20px;position:relative;">
			<div style="position: absolute;top:5px;left:5px;">
				<div style="float:left;" id="demo16"></div>
				<div onclick="golist()" style="float:left;margin-left:12px;font-size:14px;color:#666666;" class="hoverFont">文章列表</div>
			</div>
			<div style="font-size:18px;color:#333333;width:100%;text-align: center;">${content.title }</div>
			<div style="display: table;margin:0 auto;margin-top:10px;overflow: hidden;min-width: 300px;">
				<div style="float:left;border-radius:5px;font-size:14px;color:#fc6769;border: 1px #fc6769 solid;padding-left:8px;padding-right:8px;height:20px;line-height: 19px;margin-top:2px;">${content.type }</div>
				<div style="float:left;margin-left:10px;margin-top:4px;">
					<div style="overflow: hidden;float:right;font-size:14px;color:#333333;margin-right:5px;"><fmt:formatDate value="${content.createTime }" pattern="yyyy-MM-dd HH:mm" /></div>
					<div style="float:right;width:1px;background: #333333;height:16px;margin-top:2px;margin-right:6px;"></div>
					<div style="overflow: hidden;float:right;font-size:14px;color:#333333;margin-right:6px;">作者：${content.author }</div>
				</div>
			</div>
			<div style="width:670px;margin:0 auto;background:;overflow: hidden;margin-top:30px;min-height: 450px;text-align: center;">${content.content }</div>
		</div>
	</div>
	<%@include file="footer.jsp" %>
<div style="width:100%;height:60px;">
</div>
</body>
</html>