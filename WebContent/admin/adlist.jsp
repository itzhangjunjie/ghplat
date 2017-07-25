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
<script src="../js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
function updateUserFlag(mediaid,tt){
	var userflag = $(tt).parent().find('.userflagInput').val();
	$.ajax({
		   type: "POST",
		   url: "../updateUserFlag",
		   data:{
			   'mediaid'  :mediaid,
			   'userflag':userflag,
			   'type':'1'
		   }, 
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				  alert('修改成功');
			   }
		   }
	});
}
</script>
</head>
<body>
		<form class="layui-form" method="post" action="/ghplat/admin/useradlist">
			<blockquote class="layui-elem-quote" style="height: 40px;">
					<div class="layui-form-item" style="position: absolute;right: 100px;top: 17px;">
							<label class="layui-form-label">用户名：</label>
							<div class="layui-input-inline">
								<input type="text" name="searchStr" value="${publishForm.searchStr }" lay-verify="title" autocomplete="off" placeholder="请输入媒体的名称" class="layui-input">
							</div>
							<label class="layui-form-label">手机号：</label>
							<div class="layui-input-inline">
								<input type="text" name="usermobile" value="${publishForm.usermobile }" lay-verify="title" autocomplete="off" placeholder="请输入媒体手机号" class="layui-input">
							</div>
							<button lay-filter="demo1" lay-submit="" class="layui-btn">搜索</button>
					</div>
			</blockquote>
		</form>
		
		<fieldset class="layui-elem-field">
				<legend>数据列表</legend>
				<div class="layui-field-box">
					<div style="width:100%;margin-top:20px;" class="orderDiv divsh">
					<table cellspacing="0px" class="plisDiv" style="width:100%;font-size:14px;border:1px #dfdfdf solid;">
					<tbody><tr valign="middle" height="40px" style="background: #f8f8f8;"><td width="150px" align="center">用户名</td><td width="170px" align="center">手机号</td><td width="150px" align="center">qq</td>
					<td width="150px" align="center">注册时间</td><td width="150px" align="center">登陆时间</td><td width="150px" align="center">权限</td></tr>
		<!-- 			<div style="float:left;"><img src="images/weixin.png" /></div> -->
				</tbody></table>
				<div style="width:100%;overflow: hidden;padding-bottom: 30px;">
						<table cellspacing="0px" class="plisDiv" style="font-size:14px;border:1px #dfdfdf solid;float:left;width:100%;padding-bottom: 20px;">
							<c:forEach items="${adlist.list }" var="media">
								<tr valign="middle" height="40px" style="background: #f8f8f8;"><td width="150px" align="center">${media.username }</td><td width="170px" align="center">${media.mobile }</td><td width="150px" align="center">${media.qq }</td>
									<td width="150px" align="center"><fmt:formatDate value="${media.signUpTime }" pattern="yyyy-MM-dd HH:mm" /></td><td width="150px" align="center"><fmt:formatDate value="${media.lastLoginTime }" pattern="yyyy-MM-dd HH:mm" /></td>
									<td width="150px" align="center"><input value="${media.userFlag }" class="userflagInput"/><button onclick="updateUserFlag(${media.id},this)">更改</button></td>
								</tr>						
							</c:forEach>
					    </table>
				</div>
			</div>
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
				var total = '${adlist.total}';
				total = (total%15==0)?total/15:(parseInt(total/15)+1);
				//page
				laypage({
					cont: 'page',
					pages: total ,//总页数
					groups: 5 ,//连续显示分页数
					 curr: '${adlist.page}',
					jump: function(obj, first) {
						//得到了当前页，用于向服务端请求对应数据
						var curr = obj.curr;
						if(!first) {
							location.href='/ghplat/admin/useradlist?pageSize='+curr;
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