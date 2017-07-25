<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>banner修改</title>
		<base href="/ghplat/admin/base/">
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">

		<link rel="stylesheet" href="plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
	</head>

	<body>
	<input type="hidden" id="moduleInput" value="${bannerDetails.module }">
		<div style="margin: 15px;">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
				<legend>修改banner</legend>
			</fieldset>
			<form method="post" enctype="multipart/form-data" class="layui-form" action="/ghplat/admin/updateBanner">
				<input type="hidden" value="${bannerDetails.indexBannerId }" name="indexBannerId"/>
				<div class="layui-form-item">
						<label class="layui-form-label">模块</label>
						<div class="layui-input-inline">
							<select name="module" class="moduleSel" lay-filter="moduleSel" onchange="changeModule(this)">
								<option value="首页banner" <c:if test="${bannerDetails.module=='首页banner' }">selected="selected"</c:if> >首页banner</option>
								<option value="自媒体展示" <c:if test="${bannerDetails.module=='自媒体展示' }">selected="selected"</c:if> >自媒体展示</option>
								<option value="联合推广资源" <c:if test="${bannerDetails.module=='联合推广资源' }">selected="selected"</c:if> >联合推广资源</option>
								<option value="我们的合作伙伴" <c:if test="${bannerDetails.module=='我们的合作伙伴' }">selected="selected"</c:if> >我们的合作伙伴</option>
							</select>
						</div>
						<label class="layui-form-label">类型</label>
						<div class="layui-input-inline">
							<select name="type" lay-filter="typeSel" class="typeSel">
								<option value="静态图 " <c:if test="${bannerDetails.type=='静态图' }">selected="selected"</c:if> >静态图 </option>
								<option value="外链" <c:if test="${bannerDetails.type=='外链' }">selected="selected"</c:if> >外链</option>
								<option value="内链" <c:if test="${bannerDetails.type=='内链' }">selected="selected"</c:if> >内链</option>
								<option value="自媒体展示" <c:if test="${bannerDetails.type=='自媒体展示' }">selected="selected"</c:if> >自媒体展示</option>
							</select>
						</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">标题</label>
					<div class="layui-input-block">
						<input type="text" value="${bannerDetails.title }" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
					</div>
				</div>
				<c:if test="${bannerDetails.type!='自媒体展示' }">
					<div class="layui-form-item showhide url" style="display:none;">
						<label class="layui-form-label">链接地</label>
						<div class="layui-input-block">
							<input type="text" value="${bannerDetails.url }" name="url" autocomplete="off" placeholder="请输入URL" class="layui-input">
						</div>
					</div>
				</c:if>
				<c:if test="${bannerDetails.type=='自媒体展示' }">
					<div class="layui-form-item showhide media" style="display:none;">
						<label class="layui-form-label">自媒体</label>
						<div class="layui-input-block">
	<!-- 					<a href="#zimeitiSelectDiv" id="zimeitiId" class="layui-btn layui-btn-small" id="search"> -->
	<!-- 						<i class="layui-icon"></i> 自媒体选择 -->
								<input type="text" name="url" value="${bannerDetails.url }" autocomplete="off" placeholder="请输入媒体的id" class="layui-input">
	<!-- 					</a> -->
						</div>
					</div>
				</c:if>
				<div class="layui-form-item showhide image">
					<label class="layui-form-label">图片</label>
					<div class="layui-inline">
						<input type="file" name="pcImageFile" lay-verify="file" autocomplete="off" placeholder="请输入URL" class="layui-input">
					</div>
					<div class="layui-inline">
						<label class="layui-inline">（图片尺寸1000*500）</label>
					</div>
				</div>
				<div class="layui-form-item layui-form-text showhide content" style="display:none;">
					<label class="layui-form-label">编辑器</label>
					<div class="layui-input-block">
						<textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="LAY_demo_editor">${bannerDetails.content }</textarea>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">排序</label>
					<div class="layui-inline">
						<input type="text" value="${bannerDetails.position }" name="position" lay-verify="position" autocomplete="off" placeholder="请输入位置" class="layui-input">
					</div>
					<div class="layui-inline">
						<label class="layui-inline" >(越大越靠前)</label>
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
				//创建一个编辑器
				layedit.set({
				  uploadImage: {
				    url: '/ghplat/admin/uploadContent' ,//接口url
				    type: 'post' //默认post
				  }
				});
				var moduleStr = $('#moduleInput').val();
				$('.showhide').hide();
				if(moduleStr=='首页banner'){
					  $('.image').show();
				  }else if(moduleStr=='联合推广资源'){
					  $('.image').show();
					  $('.content').show();
				  }else if(moduleStr=='自媒体展示'){
					  $('.media').show();
				  }else if(moduleStr=='我们的合作伙伴'){
					  $('.image').show();
					  $('.url').show();
				  }
				form.on('select(moduleSel)', function(data){
					  var moduleVal = data.value;
					  $('.typeSel option').removeAttr('selected');
					  if(moduleVal=='首页banner'){
						  moduleVal = '静态图';
					  }else if(moduleVal=='联合推广资源'){
						  moduleVal = '内链';
					  }else if(moduleVal=='自媒体展示'){
						  moduleVal = '自媒体展示';
					  }else if(moduleVal=='我们的合作伙伴'){
						  moduleVal = '外链';
					  }
					  $($('.typeSel').parent().find('.layui-input')).val(moduleVal);
					  $('[name="type"]').val(moduleVal);
					  if(moduleVal=='首页banner'){
						  $('.typeSel [value="静态图"]').attr("selected","selected");
					  }else if(moduleVal=='联合推广资源'){
						  $('.typeSel [value="内链"]').attr("selected","selected");
					  }else if(moduleVal=='自媒体展示'){
						  $('.typeSel [value="自媒体展示"]').attr("selected","selected");
					  }else if(moduleVal=='我们的合作伙伴'){
						  $('.typeSel [value="外链"]').attr("selected","selected");
					  }
				});      
				form.on('select', function(data){
					  console.log(data.value); //得到被选中的值
					  var moduleVal = data.value;
					  $('.showhide').hide();
					  if(moduleVal=='首页banner'||moduleVal=='静态图'){
						  $('.image').show();
					  }else if(moduleVal=='联合推广资源'||moduleVal=='内链'){
						  $('.image').show();
						  $('.content').show();
					  }else if(moduleVal=='自媒体展示'||moduleVal=='自媒体展示'){
						  $('.media').show();
					  }else if(moduleVal=='我们的合作伙伴'||moduleVal=='外链'){
						  $('.image').show();
						  $('.url').show();
					  }
				});      
				//创建一个编辑器
				var editIndex = layedit.build('LAY_demo_editor');
				//自定义验证规则
				form.verify({
					title: function(value) {
						if(value.length < 3) {
							return '标题至少得3个字符啊';
						}
					},
// 					url: function(value){
// 						if(value!=null&&value!=''){
// 							var re = new RegExp("/(http):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?/");
// 							if(!re.test(value)){
// 								return "URL地址不对！";
// 							}
// 						}
// 					},
					content: function(value) {
						value = layedit.getContent(editIndex);
						if(value!=null&&value!='') {
							document.getElementById("LAY_demo_editor").innerHTML=value;
						}
					},
					position:function(value){
						var re = new RegExp("^[0-9]*$");
						if(value==null||value==''){
							return "排序不能为空！";
						}else if(!re.test(value)){
							return "排序只能是数字!";
						}
					}
				});

				//监听提交
				form.on('submit(demo1)', function(data) {
					
					layer.alert(JSON.stringify(data.field), {
						title: '最终的提交信息'
					})
					//return false;
				});
			});
		</script>
	</body>

</html>