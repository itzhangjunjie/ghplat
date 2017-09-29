<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>文章修改</title>
		<base href="/ghplat/admin/base/">
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		<script src="../js/jquery-1.8.2.min.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../../front/js/fancybox/jquery.fancybox.css" media="screen" />
		<script type="text/javascript" src="../../front/js/fancybox/jquery.fancybox.js"></script>
		<script src="../../admin/js/test2.js" type="text/javascript"></script>
		<script src="../../front/js/doT.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="../css/common.css" type="text/css" media="screen" />
		<script type="text/javascript" src="../js/xheditor-1.2.2.min.js"></script>
		<script type="text/javascript" src="../js/zh-cn.js"></script>
		<script type="text/javascript">
		
		$(document).ready(function(){
			 $('#elem1').xheditor({ 
	                upImgUrl: '../upploadImg', upImgExt: 'jpg,jpeg,gif,png'
	            });  

			$(document).delegate('.subButton','click',function(e){
				var dataJson = {};
				var cid = $('#contentId').val();
				dataJson.cid = cid;
				var ctitle = $('.ctitle').val();
				if(ctitle==null||ctitle==''){
					alert('标题不能为空！');
					return;
				}else{
					dataJson.title = ctitle;
				}
				var cauthor = $('.cauthor').val();
				if(cauthor==null||cauthor==''){
					alert('作者不能为空！');
					return;
				}else{
					dataJson.author = cauthor;
				}
				var ctype = $('.ctype').val();
				dataJson.type = ctype;
				var cimage = $('.cimage').val();
				var ccimage = $('#contentImageInput').val();
				var urlc ="../updateContent";
				if(ccimage==null||ccimage==''){
					if(cimage==null||cimage==''){
						alert('图片不能为空');
						return;
					}else{
						//urlc = "../updateContentT";
						dataJson.image = cimage;
					}
				}else{
					dataJson.image = ccimage;
				}
				var meitiSelect = $('.meitiSelect').attr('publishId');
				if(meitiSelect!=0){
					dataJson.publishId = meitiSelect;
				}
				var ccontent = $('#elem1').val();
				if(ccontent==null||ccontent==''){
					alert('文章内容不能为空');
					return;
				}else{
					dataJson.content = ccontent;
					dataJson.dataobj = ccontent;
				}
				var dataStr = JSON.stringify(dataJson);
				//alert(dataStr);
				$.ajaxFileUpload
	            (
	                {
	                    url: urlc, //用于文件上传的服务器端请求地址
	                    secureuri: false, //是否需要安全协议，一般设置为false
	                    fileElementId: 'contentImage', //文件上传域的ID
	                    data:dataJson,
	                    contentType: "application/json",
	                    dataType: 'json', //返回值类型 一般设置为json
	                    success: function (data, status)  //服务器成功响应处理函数
	                    {
	                    	if(data.result=='yes'){
	                    		location.href='../contentlist';
	                    	}
	                    },
	                    error: function (data, status, e)//服务器响应失败处理函数
	                    {
	                    	alert(JSON.stringify(data)); 
	                        alert(e);
	                    }
	                }
	            )
			});
			$(document).delegate('.addMeiTi','click',function(e){
				$($(this).parent().find('.addMeiTiImage')).addClass("selectedDiv");
				$($(this).parent().find('.addMeiTiImage')).show();
				$('.meitiSelect').html($(this).parent().find('.mtName').html());
				$('.meitiSelect').attr('publishId',$(this).parent().attr('attrId'));
				$('.meitiSelect').show();
				$.fancybox.close();
			})
			$("#addPublishA").fancybox({
				'titlePosition': 'inside',
				'transitionIn': 'none',
				'transitionOut': 'none',
				'beforeShow':function(){
					//searchPublish();
				}
			});
		});
		function changeImage(){
			$('#contentImageInput').val('');
		}
		function searchPublish(){
			var pbtype = $('.addPublishDivType').val();
			var pbsearch = $('.searchStrClass').val();
			var datajson = {};
			datajson.pageCount = 30;
			datajson.pageSize = 1;
			if(pbtype!=null&&pbtype!=0){
				datajson.publishType = pbtype;
			}
			if(pbsearch!=null&&pbsearch!=''){
				datajson.publishName = pbsearch;
			}
			$.ajax({
				type: "post",
				url: "../../getPublishStr",
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
					}
				}
			});
		}
		</script>
		<style type="text/css">
		body{
			font: 14px Helvetica Neue,Helvetica,PingFang SC,微软雅黑,Tahoma,Arial,sans-serif;
		}
		input{
			background-color: #fff;
		    border: 1px solid #e6e6e6;
		    border-radius: 2px;
		    height: 38px;
		    line-height: 38px;
		    padding-left: 10px;
    	}
.layui-btn {
    background-color: #009688;
    border: medium none;
    border-radius: 2px;
    color: #fff;
    cursor: pointer;
    display: inline-block;
    height: 38px;
    line-height: 38px;
    opacity: 0.9;
    padding: 0 18px;
    text-align: center;
    white-space: nowrap;
}
		</style>
	</head>

<body>
	<div style="width:100%;">
		<fieldset style="margin-top: 20px;width:94%;margin-left:3%;">
			<legend>新增文章</legend>
			<input type="hidden" value="${content.id }" id="contentId" />
			<input type="hidden" value="${content.image }" id="contentImageInput" />
			<div style="width:90%;margin:0 auto;overflow: hidden;">
				<div style="margin-top:20px;width:100%;overflow: hidden;">
					<div style="float:left;width:50px;line-height: 42px;">标题：</div>
					<div style="float:left;"><input style="width:200px;" class="ctitle" value="${content.title }" placeholder="请输入标题" type="text" /></div>
					<div style="float:left;width:50px;line-height: 42px;margin-left:50px;">作者：</div>
					<div style="float:left;"><input style="width:200px;" class="cauthor" value="${content.author }" placeholder="请输入作者" type="text" /></div>
					<div style="float:left;width:50px;line-height: 42px;margin-left:50px;">类型：</div>
					<div style="float:left;">
						<select class="ctype" style="appearance:none;-moz-appearance:none;-webkit-appearance:none; width:80px;background-color: #fff;border: 1px solid #e6e6e6;border-radius: 2px;height: 38px;line-height: 38px;padding-left: 10px;background: url('../js/timg.jpg') no-repeat scroll right center transparent;">
							<option <c:if test="${content.type=='转载' }">selected="selected"</c:if>>转载</option>
							<option <c:if test="${content.type=='原创' }">selected="selected"</c:if>>原创</option>
						</select>
					</div>
				</div>
				<div style="margin-top:20px;width:100%;overflow: hidden;">
					<div style="float:left;width:50px;line-height: 42px;">图片：</div>
					<div style="float:left;"><input onchange="changeImage()" id="contentImage" class="cimage" style="width:200px;" placeholder="请上传图片" name="fileContent" type="file" /></div>
					<div style="float:left;width:200px;line-height: 42px;margin-left:20px;">（图片尺寸1000*500）</div>
				</div>
				<div style="margin-top:20px;width:100%;overflow: hidden;">
					<div style="float:left;width:120px;line-height: 42px;">添加自媒体关联：</div>
					<div publishId="${content.publish.id}" style="float:left;margin-left:10px;margin-right: 20px;line-height: 38px;height:38px;<c:if test="${content.publish==null }">display:none;</c:if>" class="meitiSelect"><c:if test="${content.publish!=null }">${content.publish.publishName }</c:if></div>
					<div class="addPublishMT" style="float:left;width:96px;height:38px;line-height:38px;border:1px #dfdfdf solid;text-align: center;">
						<a id="addPublishA" href="#addPublishDiv" style="text-decoration: none;">
							选择自媒体
						</a>
					</div>
<div style="display:none;">
	<div id="addPublishDiv" style="padding:30px 50px;width:400px;background: white;margin:0px;overflow: hidden;">
		<div style="width:400px;height:40px;">
			<div style="width:65px;height:40px;background: white;border:1px #999999 solid;float:left;">
				<select class="addPublishDivType" style="width:60px;height:40px;margin-left:-1px;padding:8px;appearance:none;-moz-appearance:none;-webkit-appearance:none;border: 0px;color: #333333;font-size:14px; background: url('http://ourjs.github.io/static/2015/arrow.png') no-repeat scroll right center transparent;">
					<option id="selectType" value="0" style="text-align: center;font-size:14px;color: #333333;boder:0px;padding:8px 143px;">全部</option>
					<c:forEach var="publish" items="${ptdto }"  varStatus="st" >
						<option value="${publish.publishType }" style="text-align: center;font-size:14px;color: #333333;boder:0px;padding:8px;">${publish.publishName }</option>
					</c:forEach>
				</select>
			</div>
			<div style="border-top:1px #999999 solid;border-bottom:1px #999999 solid;width:265px;height:40px;float:left;">
				<input class="searchStrClass" type="text" placeholder="突然想起某位达人" style="border:0px;text-align:left;margin:0px;padding: 10px 10px 10px 20px;width:265px;height:19px;color:#999999;font-size:14px;"/>
			</div>
			<div onclick="searchPublish()" style="cursor:pointer;background: #333333;width:60px;height:42px;float:left;text-align: center;">
				<img src="../../front/images/search_white.png" style="height:24px;margin-top:9px;" />
			</div>
		</div>
		<div style="width:100%;margin-top:10px;" id="publishDiv">
		</div>
			<script id="publishTmp" type="text/x-dot-template">
		{{for(var i=0;i<it.length;i++){ }} 
			<div attrId="{{=it[i].id}}" attrType="{{=it[i].publishTypeObj.publishFieldId}}" style="width:180px;float:left;height:80px;position: relative;border: 1px #999999 solid;{{? (i+2)%2==0}}margin-right:26px;{{?}}margin-top:20px;">
				<div style="width:80px;height:80px;float:left;"><img class="mtImage" style="width:80px;height:80px;" src="/ghplat/attachment{{=it[i].image}}" /></div>
				<div style="float:left;width:100px;height:80px;">
					<div class="mtName" style="margin-top:13px;margin-left:10px;width:90px;height:16px;overflow: hidden;line-height:16px;color:black;font-weight: bold;font-size:14px;">{{=it[i].publishName}}</div>
					<div class="mtPlatform" style="margin-top:6px;margin-left:10px;width:70px;height:14px;overflow: hidden;color:#333333;font-size:12px;">
						{{=it[i].publishTypeObj.publishFieldName}}
					</div>
					<div class="mtFancount" style="margin-top:6px;margin-left:10px;width:70px;height:14px;overflow: hidden;color:#333333;font-size:12px;">{{=it[i].platformFans}}</div>
				</div>
				<div class="addMeiTi" style="position:absolute ;bottom: -1px; right:-1px;cursor:pointer;width:16px;height:16px;border:1px #333333 solid;z-index:2;"></div>
				<div class="addMeiTiImage" style="display:none;position:absolute ;bottom: 0px; right:0px;cursor:pointer;width:16px;height:16px;border:1px #333333 solid;z-index:3;">
					<img src="../../front/images/check_26.png" width="16px"/>
				</div>
			</div>
		{{ } }} 
			</script>
	</div>
</div>
				</div>
				<div style="margin-top:20px;width:100%;overflow: hidden;">
					<textarea id="elem1" rows="22" cols="80" style="width: 80%">${content.content }</textarea>
				</div>
				<div style="width:440px;margin:0 auto;margin-top:20px;overflow: hidden;">
					<button class="layui-btn subButton">立即提交</button>
				</div>
			</div>
		</fieldset>
	</div>
</body>

</html>