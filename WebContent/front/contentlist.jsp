<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文章列表</title>
<link rel="stylesheet" href="front/css/menu.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="front/css/style.css" />
<script src="front/js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	var total = '${contentPage.total}';
	total = (total%8==0)?total/8:(parseInt(total/8)+1);
	if(total==1){
		$('#pageTotalDiv').hide();
	}else{
		$('#pageTotalDiv').show();
	}
	$('.M-box').pagination(total,{
		 'items_per_page'      : 8,  
        'num_display_entries' : 5, 
        'ellipse_text'        : "...",
        'num_edge_entries'    : 2,  
        'prev_text'           : "上一页",  
        'next_text'           : "下一页",  
        'current_page'        : '${contentPage.page-1}',
        'callback'            : function(page_id,jq){
	       	 searchStr(page_id+1);
	       	 $("body").scrollTop(0);
			 return false;
        }
    });
})
function goPage(){
	var pageInput = $('.pagesizeInput').val();
	console.log(pageInput);
	var reg = new RegExp("^[0-9]*$");
	if(!reg.test(pageInput)){
		alert('填写不正确！');
		return;
	}else{
		searchStr(1);
	}
}
function searchStr(iindex){
	$('#pageSizeInput').val(iindex);
	$('#contentForm').submit();
}
function godetails(cid){
	location.href='contentdetails?cid='+cid;
}
</script>
<style type="text/css">

</style>
</head>
<body style="padding:0px;margin:0px;">
<input type="hidden" value="2" id="headType" />
	<%@include file="header.jsp" %>
	<div style="width:100%;margin:0 auto;">
		<div style="width:1200px;margin:0 auto;overflow: hidden;padding:35px;margin-top:5px;min-height: 420px;">
			<c:forEach items="${contentPage.list }" var="content" varStatus="vstatus" >
				<div style="float:left;width:550px;box-shadow:2px 3px 2px 3px #f5f5f5;height:303px;<c:if test="${vstatus.index%2!=0 }">margin-left:100px;</c:if><c:if test="${vstatus.index>1 }">margin-top:50px;</c:if>">
					<div style="width:100%;cursor: pointer;overflow: hidden;" onclick="godetails(${content.id})"><img src="attachment/content/${content.image }" width="100%" height="240px" /></div>
					<div style="width:100%;height:30px;line-height: 30px;overflow: hidden;margin-top:3px;">
						<div style="overflow: hidden;float:left;font-size:18px;color:#333333;padding-left:5px;">${content.title }</div>
						<div style="float:left;margin-left:8px;margin-top:5px;border-radius:5px;font-size:14px;color:#fc6769;border: 1px #fc6769 solid;padding-left:8px;padding-right:8px;height:20px;line-height: 19px;">${content.type }</div>
					</div>
					<div style="width:100%;height:33px;overflow: hidden;">
						<div style="overflow: hidden;float:left;font-size:14px;color:#666666;padding-left:5px;">${content.publish.publishName }</div>
						<div style="overflow: hidden;float:right;font-size:14px;color:#333333;margin-right:5px;"><fmt:formatDate value="${content.createTime }" pattern="yyyy-MM-dd HH:mm" /></div>
						<div style="float:right;width:1px;background: #333333;height:16px;margin-top:2px;margin-right:6px;"></div>
						<div style="overflow: hidden;float:right;font-size:14px;color:#333333;margin-right:6px;">作者：${content.author }</div>
					</div>
				</div>
			</c:forEach>
		</div>
		<div style="width:1200px;margin:0 auto;overflow: hidden;margin-bottom: 20px;">
			<div style="width:340px;float:left;">
				<form action="contentlist" id="contentForm" method="post">
					<div style="border-top:1px #fc6769 solid;border-bottom:1px #fc6769 solid;border-left:1px #fc6769 solid;width:220px;height:32px;float:left;">
						<input name="searchStr" value="${publishForm.searchStr }" class="publishnameInput" placeholder="突然想起某位达人" style="border:0px;text-align:left;padding-left: 10px;width:365px;height:32px;color:#666666;font-size:14px;" type="text">
					</div>
					<div onclick="searchStr(1)" style="background: #fc6769;width:60px;height:34px;float:left;text-align: center;cursor:pointer;">
						<img src="front/images/search_white.png" style="height:24px;margin-top:5px;">
					</div>
					<input type="hidden" value="${publishForm.pageSize }" id="pageSizeInput" name="pageSize"/>
				</form>
			</div>
			<div id="pageTotalDiv" style="overflow: hidden;float:right;margin-right:5px;">
					<div id="pageDiv" style="float:left;height:32px;overflow: hidden;">
						<div class="M-box" >
						</div>
					</div>
					<div style="float:left;margin-left:10px;"><input style="width:42px;height:32px;" class="pagesizeInput" />
					<button onclick="goPage()" style="width:42px;height:32px;font-size:12px;background:#fc6769;border: 0px;color: white;cursor: pointer;border-radius:5px; ">跳转</button></div>
				</div>
		</div>
	</div>
	<%@include file="footer.jsp" %>
</body>
</html>