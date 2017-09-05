<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${bannerDetails.title }</title>
</head>
<body style="padding:0px;margin:0px;">
<%@include file="header.jsp" %>
<div style="width:100%;background:rgb(242,242,242);height:auto;overflow: hidden; ">
	<div style="width:1140px;padding:20px 30px 40px 30px;background: white;margin:0 auto;margin-top:15px;margin-bottom:20px;border:1px #eeeeee solid;overflow: hidden;">
		${bannerDetails.content }
	</div>
</div>
<%@include file="footer.jsp" %>
</body>
</html>