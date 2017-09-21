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
function removeOrder(tt,orderid){
	if(confirm("确定删除订单吗?")){
		$.ajax({
			   type: "POST",
			   url: "../../deleteOrder",
			   data:{
				   'orderId'  :orderid
			   }, 
			   dataType:"json",
			   success: function(msg){
				   if(msg.result=='yes'){
					   $(tt).parent().parent().remove();
				   }
			   }
		});
	}
}
function selectChange(orderid,tt){
	var val  = $(tt).val();
	$.ajax({
		   type: "POST",
		   url: "../updateOrder",
		   data:{
			   'orderid'  :orderid,
			   'status':val
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
		<form class="layui-form" method="post" action="/ghplat/admin/orderList">
			<blockquote class="layui-elem-quote" style="height: 40px;">
					<div class="layui-form-item" style="position: absolute;right: 100px;top: 17px;">
							<label class="layui-form-label">类型：</label>
							<div class="layui-input-inline">
								<select name="publishStatus">
									<option value="all" <c:if test="${publishForm.publishStatus=='all'||publishForm.publishStatus==null }">selected="selected"</c:if>>全部</option>
									<option value="0" <c:if test="${publishForm.publishStatus=='0' }">selected="selected"</c:if>>待付款</option>
									<option value="1" <c:if test="${publishForm.publishStatus=='1' }">selected="selected"</c:if>>已完成</option>
									<option value="2" <c:if test="${publishForm.publishStatus=='2' }">selected="selected"</c:if>>已取消</option>
									<option value="3" <c:if test="${publishForm.publishStatus=='3' }">selected="selected"</c:if>>已删除</option>
								</select>
							</div>
							<label class="layui-form-label">订单号：</label>
							<div class="layui-input-inline">
								<input type="text" name="searchStr" value="${publishForm.searchStr }" lay-verify="title" autocomplete="off" placeholder="请输入媒体的标题" class="layui-input">
							</div>
							<button lay-filter="demo1" lay-submit="" class="layui-btn">搜索</button>
					</div>
			</blockquote>
		</form>
		
		<fieldset class="layui-elem-field" style="margin-bottom: 40px;">
				<legend>数据列表</legend>
				<div class="layui-field-box">
					<div style="width:100%;margin-top:20px;" class="orderDiv divsh">
					<table cellspacing="0px" class="plisDiv" style="width:100%;font-size:14px;border:1px #dfdfdf solid;">
					<tbody><tr valign="middle" height="40px" style="background: #f8f8f8;"><td width="150px" align="center">广告主题</td><td width="170px" align="center">投放主体</td><td width="150px" align="center">广告类型</td>
					<td width="150px" align="center">阅读量</td><td width="150px" align="center">位置</td><td width="150px" align="center">报价</td><td width="250px" align="center">订单状态</td><td width="200px" align="center">总金额</td></tr>
		<!-- 			<div style="float:left;"><img src="images/weixin.png" /></div> -->
				</tbody></table>
					<c:forEach items="${orderListPage.list }" var="order">
				<div style="width:100%;overflow: hidden;<c:if test="${order.orderDetailsList.size() == 0 }">display:none;</c:if>">
						<div style="width:100%;height:40px;background: #f8f8f8;margin-top:20px;line-height: 40px;border:1px #dfdfdf solid;border-bottom: 0px;font-size:14px;">
							<span style="margin-left:20px;float:left;">${order.order_createtime }</span><span style="float:left;margin-left:20px;">订单编号：${order.ghid }</span>
							<span style="float:left;margin-left:40px;">用户名：${order.advertiser.username }</span><span style="float:left;margin-left:40px;">手机号：${order.advertiser.mobile }</span>
							<span style="float:left;margin-left:40px;">企业名称：${order.advertiser.corporation_name }</span>
							<span onclick="removeOrder(this,${order.order_id})" class="hoverFont" style="float:right;margin-right:10px;cursor:pointer;">删除订单</span>
							<div class="imprtDataDiv" onclick="dataExport(this)" style="display:none;width:70px;height:22px;border:1px #333333 solid;text-align: center;line-height: 22px;float: right;font-size:14px;cursor:pointer;margin-top:8px;margin-right:10px;">导出方案</div>
						</div>
						<table cellspacing="0px" class="plisDiv" style="font-size:14px;border:1px #dfdfdf solid;float:left;width:100%;padding-bottom: 20px;">
						<c:forEach items="${order.orderDetailsList }" var="orderDetails"  varStatus="stt">
								<tr valign="middle" height="60px" class="publishTr" attrPid="${orderDetails.publish.id }" attrPriceStr="${orderDetails.publish_pricestr }" attrPrice="${orderDetails.publish_price }" attrPtype="${orderDetails.publish.publishTypeObj.publishFieldName }">
									 <td width="150px" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " align="center"><img width="48px" height="48px" src="/ghplat/attachment${orderDetails.publish.image }"></td>
									 <td width="150px" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " align="center"><div style="margin-top:1px;" >${orderDetails.publish.publishName }</div></td>
									 <td width="150px" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " align="center"><div style="margin-top:1px;" >${orderDetails.publish.publishTypeObj.publishFieldName }</div></td>
									 <td class="fansTd" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " width="150px" align="center">${orderDetails.publish.platformFans }</td>
									 <td width="150px" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " align="center">${orderDetails.publish_pricestr }</td>
									 <td width="150px" style="border-top:1px #dfdfdf solid;<c:if test="${stt.index==0 }">border:0px;</c:if> " align="center"><span class="priceclass">${orderDetails.publish_price }</span></td>
							    	 <c:if test="${stt.index==0 }">
								    	 <td width="250px" style="border-left:1px #dfdfdf solid;" align="center" rowspan="${order.orderDetailsList.size()}">
								    	 	<select onchange="selectChange(${order.order_id },this)">
												<option value="0" <c:if test="${order.order_status=='0' }">selected="selected"</c:if>>待付款</option>
												<option value="1" <c:if test="${order.order_status=='1' }">selected="selected"</c:if>>已完成</option>
												<option value="2" <c:if test="${order.order_status=='2' }">selected="selected"</c:if>>已取消</option>
												<option value="3" <c:if test="${order.order_status=='3' }">selected="selected"</c:if>>已删除</option>
											</select>
								    	 	
								    	 </td>
								    	 <td width="150px" style="border-left:1px #dfdfdf solid;" align="center" rowspan="${order.orderDetailsList.size()}">${order.order_contentbudget }</td>
							    	 </c:if>
							     </tr> 
						</c:forEach>
					    </table>
				</div>
					</c:forEach>
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
				var total = '${orderListPage.total}';
				total = (total%15==0)?total/15:(parseInt(total/15)+1);
				//page
				laypage({
					cont: 'page',
					pages: total ,//总页数
					groups: 5 ,//连续显示分页数
					 curr: '${orderListPage.page}',
					jump: function(obj, first) {
						//得到了当前页，用于向服务端请求对应数据
						var curr = obj.curr;
						if(!first) {
							var status = $('[name="publishStatus"]').val();
							location.href='/ghplat/admin/orderList?pageSize='+curr+'&publishStatus='+status;
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