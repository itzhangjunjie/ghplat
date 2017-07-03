<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>媒体列表</title>
<base href="/ghplat/admin/base/">
<link rel="stylesheet" href="plugins/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="css/global.css" media="all">
<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
<link rel="stylesheet" href="css/table.css" />
</head>
<body>
		<form class="layui-form" method="post" action="/ghplat/admin/bannerlist">
			<blockquote class="layui-elem-quote" style="height: 40px;">
					<div class="layui-form-item" style="position: absolute;right: 100px;top: 17px;">
							<label class="layui-form-label">模块：</label>
							<div class="layui-input-inline">
								<select name="start">
									<option value="0" <c:if test="${module==0 }">selected="selected"</c:if>>上架中</option>
									<option value="1" <c:if test="${module==1 }">selected="selected"</c:if>>即将上</option>
									<option value="-1" <c:if test="${module==-1 }">selected="selected"</c:if>>已下架</option>
								</select>
							</div>
							<label class="layui-form-label">状态：</label>
							<div class="layui-input-inline">
								<select name="status">
									<option value="1" <c:if test="${status==1 }">selected="selected"</c:if>>正常</option>
									<option value="-1" <c:if test="${status==-1 }">selected="selected"</c:if>>已删除</option>
								</select>
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
							<tr>
								<th><input type="checkbox" id="selected-all"></th>
								<th>图片</th>
								<th>标题</th>
								<th>类型</th>
								<th>领域</th>
								<th>平台</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${publishListPage.list }" var="publishObj">
								<tr>
									<td><input type="checkbox"></td>
									<td><img src="/ghplat/attachment/banner/${publishObj.image }" width="80px" height="80px" /></td>
									<td>
										${publishObj.publishName }
									</td>
									<td>${publishObj.publishTypeObj.publishFieldName }</td><td>${publishObj.publishField }</td>
									<td>${publishObj.platformName }</td>
									<td><fmt:formatDate value="${publishObj.publishTime }" pattern="yyyy-MM-dd HH:mm" /></td>
									<td>
										<a href="/ghplat/admin/bannerDetails?bannerid=${banner.indexBannerId }" class="layui-btn layui-btn-mini">编辑</a>
										<a  href="javascript:;" data-id="${banner.indexBannerId }" data-opt="del" class="layui-btn layui-btn-danger layui-btn-mini">删除</a>
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
				//page
				laypage({
					cont: 'page',
					pages: '${bannerlist.total+10 }' ,//总页数
					groups: 5 ,//连续显示分页数
					jump: function(obj, first) {
						//得到了当前页，用于向服务端请求对应数据
						var curr = obj.curr;
						if(!first) {
							//layer.msg('第 '+ obj.curr +' 页');
						}
					}
				});
				
				$('.layui-btn-danger').on('click', function(event) {
					var bid = $(this).attr('data-id');
					layer.confirm('确定删除?', function(){ 
						layer.closeAll('dialog');
						location.href='/ghplat/admin/deleteBanner?bannerid='+bid;
					});
				});
				
				
				$('.site-table tbody tr').on('click', function(event) {
					var $this = $(this);
					var $input = $this.children('td').eq(0).find('input');
					$input.on('ifChecked', function(e) {
						$this.css('background-color', '#EEEEEE');
					});
					$input.on('ifUnchecked', function(e) {
						$this.removeAttr('style');
					});
					$input.iCheck('toggle');
				}).find('input').each(function() {
					var $this = $(this);
					$this.on('ifChecked', function(e) {
						$this.parents('tr').css('background-color', '#EEEEEE');
					});
					$this.on('ifUnchecked', function(e) {
						$this.parents('tr').removeAttr('style');
					});
				});
				$('#selected-all').on('ifChanged', function(event) {
					var $input = $('.site-table tbody tr td').find('input');
					$input.iCheck(event.currentTarget.checked ? 'check' : 'uncheck');
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