<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文章列表</title>
<base href="/ghplat/admin/base/">
<link rel="stylesheet" href="plugins/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="css/global.css" media="all">
<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
<link rel="stylesheet" href="css/table.css" />
<script src="../js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
function updateContent(cid){
	location.href='../updateContentOne?cid='+cid;
}
function deleteContent(cid){
	if (confirm("你确定要删除吗？")){
		$.ajax({
			type: "post",
			url: "../mdContent",
			async: false, //_config.async,
			dataType: 'json',
			data:{'cid':cid,
				'status':'-1'},
			success: function(data, status, xhr) {
				if(data.result=="yes"){
					location.href='../contentlist';
				}
			}
		});
	}
}
</script>
</head>
<body>
<form class="layui-form" method="post" action="/ghplat/admin/contentlist">
			<blockquote class="layui-elem-quote" style="height: 40px;">
					<div class="layui-form-item" style="position: absolute;right: 100px;top: 17px;">
							<c:set value="${publishForm.publishStatus}" var="ptype"></c:set>
							<label class="layui-form-label">类型：</label>
							<div class="layui-input-inline">
								<select name="publishStatus">
									<option value="100" <c:if test="${ptype==100 }">selected="selected"</c:if>>全部</option>
									<option value="0" <c:if test="${ptype==0 }">selected="selected"</c:if>>刚创建</option>
									<option value="1" <c:if test="${ptype==1 }">selected="selected"</c:if>>已发布</option>
									<option value="-1" <c:if test="${ptype==-1 }">selected="selected"</c:if>>已删除</option>
								</select>
							</div>
							<label class="layui-form-label">内容标题：</label>
							<div class="layui-input-inline">
								<input type="text" name="searchStr" value="${publishForm.searchStr }" lay-verify="searchStr" autocomplete="off" placeholder="请输入投放人的昵称" class="layui-input">
							</div>
							<label class="layui-form-label">媒体名字：</label>
							<div class="layui-input-inline">
								<input type="text" name="publishName" value="${publishForm.publishName }" lay-verify="publishName" autocomplete="off" placeholder="请输入投放的标题" class="layui-input">
							</div>
							<button lay-filter="demo1" lay-submit="" class="layui-btn">搜索</button>
					</div>
			</blockquote>
		</form>
<fieldset class="layui-elem-field">
				<legend>数据列表</legend>
				<div class="layui-field-box">
					<table class="site-table table-hover">
						<thead>
							<tr valign="middle" height="40px" style="background: #f8f8f8;">
									<td width="150px" align="center">文章标题</td><td width="150px" align="center">文章图片</td><td width="170px" align="center">文章关联号</td><td width="150px" align="center">文章关联类型</td>
					<td width="150px" align="center">文章来源</td><td width="150px" align="center">作者</td><td width="150px" align="center">文章时间</td><td width="250px" align="center">文章状态</td><td width="250px" align="center">操作</td></tr>
						</thead>
						<tbody>
							<c:forEach items="${contentPage.list }" var="content">
							<tr valign="middle" height="40px"><td width="150px" align="center">${content.title }</td><td width="150px" align="center"><img width="80px" height="65px" src="../../attachment/content/${content.image }" /></td><td width="170px" align="center">${content.publish.publishName }</td><td width="150px" align="center">${content.publish.publishTypeObj.publishFieldName }</td>
								<td width="150px" align="center">${content.type}</td>
								<td width="150px" align="center">${content.author}</td><td width="150px" align="center">${content.createTime}</td>
								<td width="150px" align="center">
									<c:if test="${content.status==0 }">新建的</c:if>
									<c:if test="${content.status==1 }">已发布</c:if>
									<c:if test="${content.status==-1 }">已删除</c:if>
								</td>
								<td width="150px" align="center"><button onclick="updateContent(${content.id})">修改</button>
								||<button onclick="deleteContent(${content.id})">删除</button>
								 </td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
		</fieldset>
		<div class="admin-table-page">
			<div id="page" class="page">
			</div>
		</div>
		<script type="text/javascript" src="plugins/layui/layui.js"></script>
		<script>
			layui.config({
				base: 'plugins/layui/modules/'
			});
			layui.use(['icheck', 'laypage','layer'], function() {
				var $ = layui.jquery,
					laypage = layui.laypage,
					layer = parent.layer === undefined ? layui.layer : parent.layer;
				$('input').iCheck({
					checkboxClass: 'icheckbox_flat-green'
				});
				var total = '${deliveryListPage.total}';
				total = (total%15==0)?total/15:(parseInt(total/15)+1);
				//page
				laypage({
					cont: 'page',
					pages: total ,//总页数
					groups: 5 ,//连续显示分页数
					 curr: '${deliveryListPage.page}',
					jump: function(obj, first) {
						//得到了当前页，用于向服务端请求对应数据
						var curr = obj.curr;
						if(!first) {
							location.href='/ghplat/admin/deliverylist?pageSize='+curr;
							//layer.msg('第 '+ obj.curr +' 页');
						}
					}
				});
				
				$('.deliverystatus').on('change', function(event) {
					var bid = $(this).attr('dataId');
					var status = $(this).val();
					$.ajax({
						type: "post",
						url: "../updateDelivery",
						async: false, //_config.async,
						dataType: 'json',
						data:{
							'deliveryId':bid,
							'status':status
						},
						success: function(data, status, xhr) {
							alert('修改成功');
						}
					});
				});
			});
		
			layui.use(['form', 'layedit', 'laydate'], function() {
				var form = layui.form();
				//监听提交
				form.on('submit(demo1)', function(data) {
// 					layer.alert(JSON.stringify(data.field), {
// 						title: '最终的提交信息'
// 					})
					//return false;
				});
			});
		</script>
</body>
</html>