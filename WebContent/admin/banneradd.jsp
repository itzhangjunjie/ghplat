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
				<legend>新增banner</legend>
			</fieldset>
			<form method="post" enctype="multipart/form-data" class="layui-form" action="/ghplat/admin/addBanner">
				<div class="layui-form-item">
						<label class="layui-form-label">模块</label>
						<div class="layui-input-inline">
							<select name="module" class="moduleSel" lay-filter="moduleSel" onchange="changeModule(this)">
								<option value="首页banner" >首页banner</option>
								<option value="自媒体展示" >自媒体展示</option>
								<option value="联合推广资源" >联合推广资源</option>
								<option value="我们的合作伙伴" >我们的合作伙伴</option>
							</select>
						</div>
						<label class="layui-form-label">类型</label>
						<div class="layui-input-inline">
							<select name="type" lay-filter="typeSel" class="typeSel">
								<option value="静态图 " >静态图 </option>
								<option value="外链" >外链</option>
								<option value="内链" >内链</option>
								<option value="自媒体展示" >自媒体展示</option>
							</select>
						</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">标题</label>
					<div class="layui-input-block">
						<input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item showhide url" style="display:none;">
					<label class="layui-form-label">链接地</label>
					<div class="layui-input-block">
						<input type="text" name="url" autocomplete="off" placeholder="请输入URL" class="layui-input url1">
					</div>
				</div>
				<div class="layui-form-item showhide media" style="display:none;">
					<label class="layui-form-label">自媒体</label>
					<div class="layui-input-block">
<!-- 					<a href="#zimeitiSelectDiv" id="zimeitiId" class="layui-btn layui-btn-small" id="search"> -->
<!-- 						<i class="layui-icon"></i> 自媒体选择 -->
							<input type="text" name="pid" autocomplete="off" placeholder="请输入媒体的id" class="layui-input url2">
<!-- 					</a> -->
					</div>
				</div>
<!-- 				<div style="display:none;"> -->
<!-- 					<div id="zimeitiSelectDiv" style="width:300px;"> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- <!-- 				<script id="publishTmpDiv" type="text/x-dot-template"> --> 
<!-- 						<div style="width:100%;"> -->
<!-- 							<div style="float:left;"><input type="text" id="searchStr" autocomplete="off" placeholder="请输入搜索词" class="layui-input"></div> -->
<!-- 							<div style="float:left;margin-left:10px;line-height: 40px;cursor:pointer;"><i class="layui-icon"></i> 搜索</div> -->
<!-- 						</div> -->
<!-- 						<table style="width:100%;font-size: 14px;color:#333333;font-family: 微软雅黑;border-collapse:separate; border-spacing:0px 5px;margin-top:2px;"> -->
<!-- 							<tr><td>标题</td><td>粉丝数</td><td>类型</td><td>平台</td><td>操作</td></tr> -->
<!-- 					{{for(var i=0;i<it.length;i++){ }}  -->
<!-- 							<tr><td>{{=it[i].publishName}}</td><td>{{=it[i].platformFans}}</td><td>{{=it[i].publishTypeObj.publishFieldName}}</td><td>{{=it[i].platformName}}</td><td><button style="width:40px;height:20px;line-height: 20px;text-align: center;background-color: #009688;border: medium none;border-radius: 2px; color: #fff;cursor: pointer;">选择</button></td></tr> -->
<!-- 					{{ } }}  -->
<!-- 						</table> -->
<!-- 				</script> -->
<!-- <!-- 				<script type="text/javascript"> --> 
<!-- // 				function searchPublish(){ -->
<!-- // 					var pbsearch = $('#searchStr').val(); -->
<!-- // 					var datajson = {}; -->
<!-- // 					datajson.pageCount = 30; -->
<!-- // 					datajson.pageSize = 1; -->
<!-- // 					if(pbsearch!=null&&pbsearch!=''){ -->
<!-- // 						datajson.publishName = pbsearch; -->
<!-- // 					} -->
<!-- // 					$.ajax({ -->
<!-- // 						type: "post", -->
<!-- // 						url: "../../getPublishStr", -->
<!-- // 						async: false, //_config.async, -->
<!-- // 						dataType: 'json', -->
<!-- // 						data:datajson, -->
<!-- // 						success: function(data, status, xhr) { -->
<!-- // 							if(data.result=="yes"){ -->
<!-- // 								var plist = data.datas; -->
<!-- // 								$('#zimeitiSelectDiv').html(""); -->
<!-- // 								var htmla =  doT.template($("#publishTmpDiv").text()); -->
<!-- // 								console.log(htmla(plist)); -->
<!-- // 								$('#zimeitiSelectDiv').html(htmla(plist)); -->
<!-- // 								var pagecount = data.pageCount; -->
<!-- // 								var pagesize = data.pageSize; -->
<!-- // 							} -->
<!-- // 						} -->
<!-- // 					}); -->
<!-- // 				} -->
<!-- <!--  				</script>  --> 
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
						<textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="LAY_demo_editor"></textarea>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">排序</label>
					<div class="layui-inline">
						<input type="text" name="position" lay-verify="position" autocomplete="off" placeholder="请输入位置" class="layui-input">
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