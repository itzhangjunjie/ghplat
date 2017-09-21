<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>投放列表</title>
</head>
<body>

<div style="width:84%;height:30px;margin-left:30px;margin-top:20px;">
	<div style="float:left;width:3px;height:24px;background: rgb(235,100,100);margin-top:3px;"></div>
	<div style="float:left;margin-left:8px;color:rgb(130,130,130);font-size:18px;line-height: 28px;">投放管理&nbsp;&gt;</div>
	<div style="float:left;margin-left:5px;color:rgb(130,130,130);font-size:16px;line-height: 32px;">投放列表</div>
</div>
<div style="width:90%;height:1px;background: rgb(235,100,100);margin-top:2px;margin-left:30px;"></div>
<div style="width:100%;height:auto;overflow: hidden;margin-top:10px; ">
	<div style="width:90%;padding:20px 30px 40px 30px;background: white;overflow: hidden;">
		<table cellspacing="0px" class="plisDiv" style="width:100%;font-size:14px;border:1px #dfdfdf solid;">
				<tbody><tr valign="middle" height="40px" style="background: #f8f8f8;"><td width="150px" align="center">投放主题</td><td width="170px" align="center">主题形式</td><td width="150px" align="center">主要资源</td>
					<td width="150px" align="center">配套资源</td><td width="150px" align="center">备注</td><td width="150px" align="center">预算</td><td width="150px" align="center">投放时间</td><td width="250px" align="center">投放状态</td></tr>
				</tbody>
				<c:forEach items="${deliveryList.list }" var="delivery">
					<tr valign="middle" height="40px"><td width="150px" align="center">${delivery.title }</td><td width="170px" align="center">${delivery.xingshi }</td><td width="150px" align="center">${delivery.ziyuan }</td>
					<td width="150px" align="center">${delivery.peitao }</td><td width="150px" align="center">${delivery.intro }</td>
					<td width="150px" align="center">${delivery.yusuan }</td>
					<td width="150px" align="center">${delivery.createTime }</td>
					<td width="250px" align="center">
						<c:if test="${delivery.status==0 }">待付款</c:if>
						<c:if test="${delivery.status==1 }">已完成</c:if>
						<c:if test="${delivery.status==2 }">已取消</c:if>
						<c:if test="${delivery.status==3 }">已删除</c:if>
					</td></tr>
				</c:forEach>
		</table>
	</div>
</div>
</body>
</html>