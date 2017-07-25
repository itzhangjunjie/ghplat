<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>banner新增</title>
		<base href="/ghplat/admin/base/">
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
		<script src="../js/jquery-1.8.2.min.js" type="text/javascript"></script>
		<script src="../js/doT.min.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../js/fancybox/jquery.fancybox.css" media="screen" />
		<script type="text/javascript" src="../js/fancybox/jquery.fancybox.js"></script>
		<link rel="stylesheet" href="plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
		<script type="text/javascript">
		
// 		$("#zimeitiId").fancybox({
// 			'titlePosition': 'inside',
// 			'transitionIn': 'none',
// 			'transitionOut': 'none',
// 			'beforeShow':function(){
// 				searchPublish();
// 			}
// 		});
		</script>
	</head>

	<body>
		<div style="margin: 15px;">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
				<legend>新增平台</legend>
			</fieldset>
			<form method="post" enctype="multipart/form-data" class="layui-form" action="/ghplat/admin/addPlatform">
				<div class="layui-form-item">
						<label class="layui-form-label">类型</label>
						<div class="layui-input-inline">
							<select name="publishtype" class="moduleSel" lay-filter="moduleSel">
								<c:forEach var="publish" items="${ptdto }"  varStatus="st" >
										<option value="${publish.publishType}" <c:if test="${publish.publishType==ptype }">selected="selected"</c:if>>${publish.publishName }</option>
									</c:forEach>
							</select>
						</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">平台名称</label>
					<div class="layui-input-block">
						<input type="text" name="platformname" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item showhide image">
					<label class="layui-form-label">图片</label>
					<div class="layui-inline">
						<input type="file" name="platformiconfile" lay-verify="file" autocomplete="off" placeholder="请输入URL" class="layui-input">
					</div>
					<div class="layui-inline">
						<label class="layui-inline">（图片尺寸60*60）</label>
					</div>
				</div>
				<div class="layui-form-item" style="margin-top:15px;">
					<div class="layui-input-block">
						<button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
						<button type="reset" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div>
		<script type="text/javascript" src="plugins/layui/layui.js"></script>
		<script>
			var $ = null;
			layui.use(['form', 'layedit', 'laydate'], function() {
				var form = layui.form(),
				     $ = layui.jquery,
					layer = layui.layer,
					layedit = layui.layedit,
					laydate = layui.laydate;
				});

		</script>
	</body>

</html>