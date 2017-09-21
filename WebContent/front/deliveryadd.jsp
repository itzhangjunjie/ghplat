<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加投放</title>
<script type="text/javascript" src="front/js/jquery-1.8.2.min.js"></script> 
<script type="text/javascript">
	$(document).ready(function(){
		$('.xingshi').click(function(){
			var vval = $(this).attr("xingshi");
			if(vval==1){
				$(this).css('background','');
				$(this).css('color','rgb(93,93,93)');
				$(this).attr("xingshi","-1");
			}else{
				$(this).css('background','rgb(235,100,100)');
				$(this).css('color','white');
				$(this).attr('xingshi',"1");
			}
		})
		$('.ziyuan').click(function(){
			var vval = $(this).attr('ziyuan');
			if(vval==1){
				$(this).css('background','');
				$(this).css('color','rgb(93,93,93)');
				$(this).attr('ziyuan','-1');
			}else{
				$(this).css('background','rgb(235,100,100)');
				$(this).css('color','white');
				$(this).attr('ziyuan',"1");
			}
		})
		$('.peitao').click(function(){
			var ssrc = $(this).find('img').attr('src');
			if(ssrc.indexOf('r1')>0){
				$(this).find('img').attr('src','front/images/r2.png');
				$(this).attr('peitao','1');
			}else{
				$(this).find('img').attr('src','front/images/r1.png');
				$(this).attr('peitao','-1');
			}
		})
		$('.restartClass').click(function(){
			$('.zhuti').val('');
			$('.peitao').find('img').attr('src','front/images/r1.png');
			$('.ziyuan').css('background','');
			$('.ziyuan').css('color','rgb(93,93,93)');
			$('.ziyuan').attr('ziyuan','-1');
			$('.xingshi').css('background','');
			$('.xingshi').css('color','rgb(93,93,93)');
			$('.xingshi').attr('xingshi','-1');
			$('.beizhu').val('');
		})
		var sflag = true;
		$('.submitClass').click(function(){
			if(sflag){
				sflag = false;
				var title = $('.zhuti').val();
				var datajson ={};
				if(title==''){
					alert('主题不能为空!')
					return false;
				}else{
					if(title.length>30){
						alert('主题不能超过30字！');
						return false;
					}
					datajson.title = title;
				}
				var xingshi = $('[xingshi="1"]').html();
				if(xingshi==''||xingshi==null){
					alert('主题形式是必选项！');
					return false;
				}else{
					datajson.xingshi = xingshi;
				}
				var ziyuan = $('[ziyuan="1"]').html();
				if(ziyuan==''||ziyuan==null){
					alert('主要资源是必选项!');
					return false;
				}else{
					datajson.ziyuan = ziyuan;
				}
				var peitao = new Array();
				for(var i=0;i<$('[peitao="1"]').length;i++){
					peitao.push($($('[peitao="1"]')[i]).find('.peitaohtml').html());
				}
				if(peitao!=null){
					datajson.peitao = JSON.stringify(peitao);
				}
				var yusuan = $('.yusuan').val();
				if(yusuan==''||yusuan==null){
					alert('预算不能为空！');
					return false;
				}else{
					var szi = /^[0-9]*$/;
					if(!szi.test(yusuan)){
						alert('预算只能是数字！');
						return false;
					}else{
						datajson.yusuan = yusuan;
					}
				}
				var intro = $('.beizhu').val();
				if(intro==''||intro==null){
					alert('备注不能为空！');
					return false;
				}else{
					if(intro.length>300){
						alert('备注不能超过300字！');
						return false;
					}else{
						datajson.intro = intro;
					}
				}
				datajson.advertiserId = $('#auserId').val();
				$.ajax({
					type: "post",
					url: "saveDelivery",
					async: false, //_config.async,
					dataType: 'json',
					data:datajson,
					success: function(data, status, xhr) {
						if(data.result=='yes'){
							sflag = true;
							location.href="deliveryList?publishForm.pageSize=1";
						}else{
							alert('系统错误！');
						}
					}
				});
			}
		})
	})
</script>
<style>
.ttiletd {
	text-align: center;
	vertical-align: middle;
	border-right: 1px solid rgb(190,190,190);
	border-bottom: 1px solid rgb(190,190,190);
	height:58px;
}
.tdetailstd{
	vertical-align: middle;
	border-right: 1px solid rgb(190,190,190);
	border-bottom: 1px solid rgb(190,190,190);
	height:58px;
	text-align: left;
	margin-left:5px;
}
</style>
</head>
<body style="font-family: 微软雅黑;padding:15px;margin:0px;">
<input type="hidden" value="${sessionScope.user.id}" id="auserId" />
	<div style="width:84%;height:30px;margin-left:30px;margin-top:20px;">
		<div style="float:left;width:3px;height:24px;background: rgb(235,100,100);margin-top:3px;"></div>
		<div style="float:left;margin-left:8px;color:rgb(130,130,130);font-size:18px;line-height: 28px;">投放管理&nbsp;&gt;</div>
		<div style="float:left;margin-left:5px;color:rgb(130,130,130);font-size:16px;line-height: 32px;">添加投放</div>
	</div>
	<div style="width:84%;height:1px;background: rgb(235,100,100);margin-top:2px;margin-left:30px;"></div>
	<div style="width:84%;margin-top:14px;margin-left:30px;">
		<table style="font-size:14px;color: rgb(93,93,93);width:100%;border-spacing: 0;border-collapse: separate;border-top:1px solid rgb(190,190,190);border-left:1px solid rgb(190,190,190);">
			<tr><td class="ttiletd" width="120px"><span style="width:5px;color:red;font-size:14px;margin-right:5px;">*</span>广告主题</td>
				<td class="tdetailstd"><input class="zhuti" style="margin-left:13px;border: 1px rgb(193,193,193) solid;width:360px;height:35px;padding-left:6px;color:#333333;text-align:left;background: white;" placeholder="填写广告的主题" type="text"></td>
			</tr>
			<tr><td class="ttiletd" width="120px"><span style="width:5px;color:red;font-size:14px;margin-right:5px;">*</span>主题形式</td>
				<td class="tdetailstd"><div class="xingshi" style="cursor:pointer;float:left;margin-left:13px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">页面导流</div>
					<div class="xingshi" style="cursor:pointer;float:left;margin-left:20px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">文案推广</div>
					<div class="xingshi" style="cursor:pointer;float:left;margin-left:20px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">商品介绍</div>
					<div class="xingshi" style="cursor:pointer;float:left;margin-left:20px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">公众号吸粉</div>
					<div class="xingshi" style="cursor:pointer;float:left;margin-left:20px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">其他</div>
				</td>
			</tr>
			<tr><td class="ttiletd" width="120px"><span style="width:5px;color:red;font-size:14px;margin-right:5px;">*</span>主要资源</td>
				<td class="tdetailstd">
					<div style="width:100%;margin-top:16px;height:25px;">
						<div class="ziyuan" style="cursor:pointer;float:left;margin-left:13px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">公众号投放</div>
						<div class="ziyuan" style="cursor:pointer;float:left;margin-left:20px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">短视频植入</div>
						<div class="ziyuan" style="cursor:pointer;float:left;margin-left:20px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">大V代言</div>
						<div class="ziyuan" style="cursor:pointer;float:left;margin-left:20px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">自媒体曝光</div>
					</div>
					<div style="width:100%;margin-top:12px;margin-bottom: 16px;height:28px;">
						<div class="ziyuan" style="cursor:pointer;float:left;margin-left:10px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">海外大V曝光</div>
						<div class="ziyuan" style="cursor:pointer;float:left;margin-left:20px;width:-moz-max-content;text-align: center;padding:3px 18px;border: 1px rgb(193,193,193) solid;border-radius:20px;">主播现场报道</div>
					</div>
				</td>
			</tr>
			<tr><td class="ttiletd" width="120px">配套资源</td>
				<td class="tdetailstd">
					<div style="width:100%;margin-top:12px;margin-bottom: 10px;height:24px;">
						<div class="peitao" style="width:-moz-max-content;cursor:pointer;float:left;margin-left:13px;">
							<div style="float:left;"><img src="front/images/r1.png" style="width:22px;" /></div>
							<div class="peitaohtml" style="float:left;margin-left:3px;line-height: 22px;">MINI SITE定制</div>
						</div>
						<div class="peitao" style="width:-moz-max-content;cursor:pointer;float:left;margin-left:22px;">
							<div style="float:left;"><img src="front/images/r1.png" style="width:22px;" /></div>
							<div class="peitaohtml" style="float:left;margin-left:3px;line-height: 22px;">网站建设</div>
						</div>
						<div class="peitao" style="width:-moz-max-content;cursor:pointer;float:left;margin-left:22px;">
							<div style="float:left;"><img src="front/images/r1.png" style="width:22px;" /></div>
							<div class="peitaohtml" style="float:left;margin-left:3px;line-height: 22px;">软文撰写</div>
						</div>
						<div class="peitao" style="width:-moz-max-content;cursor:pointer;float:left;margin-left:22px;">
							<div style="float:left;"><img src="front/images/r1.png" style="width:22px;" /></div>
							<div class="peitaohtml" style="float:left;margin-left:3px;line-height: 22px;">LOGO设计</div>
						</div>
						<div class="peitao" style="width:-moz-max-content;cursor:pointer;float:left;margin-left:22px;">
							<div style="float:left;"><img src="front/images/r1.png" style="width:22px;" /></div>
							<div class="peitaohtml" style="float:left;margin-left:3px;line-height: 22px;">HTML5设计</div>
						</div>
					</div>
					<div style="width:100%;margin-bottom: 16px;height:24px;">
						<div class="peitao" style="width:-moz-max-content;cursor:pointer;float:left;margin-left:13px;">
							<div style="float:left;"><img src="front/images/r1.png" style="width:22px;" /></div>
							<div class="peitaohtml" style="float:left;margin-left:3px;line-height: 22px;">海报单页设计</div>
						</div>
						<div class="peitao" style="width:-moz-max-content;cursor:pointer;float:left;margin-left:22px;">
							<div style="float:left;"><img src="front/images/r1.png" style="width:22px;" /></div>
							<div class="peitaohtml" style="float:left;margin-left:3px;line-height: 22px;">宣传册设计</div>
						</div>
						<div class="peitao" style="width:-moz-max-content;cursor:pointer;float:left;margin-left:22px;">
							<div style="float:left;"><img src="front/images/r1.png" style="width:22px;" /></div>
							<div class="peitaohtml" style="float:left;margin-left:3px;line-height: 22px;">产品包装设计</div>
						</div>
						<div class="peitao" style="width:-moz-max-content;cursor:pointer;float:left;margin-left:22px;">
							<div style="float:left;"><img src="front/images/r1.png" style="width:22px;" /></div>
							<div class="peitaohtml" style="float:left;margin-left:3px;line-height: 22px;">UI设计</div>
						</div>
						<div class="peitao" style="width:-moz-max-content;cursor:pointer;float:left;margin-left:22px;">
							<div style="float:left;"><img src="front/images/r1.png" style="width:22px;" /></div>
							<div class="peitaohtml" style="float:left;margin-left:3px;line-height: 22px;">影视拍摄及后期</div>
						</div>
					</div>
				</td>
			</tr>
			<tr><td class="ttiletd" width="120px"><span style="width:5px;color:red;font-size:14px;margin-right:5px;">*</span>广告预算</td>
				<td class="tyusuantd"><input class="yusuan" style="margin-left:13px;border: 1px rgb(193,193,193) solid;width:360px;height:35px;padding-left:6px;color:#333333;text-align:left;background: white;" placeholder="填写广告的预算" type="text"></td>
			</tr>
			<tr><td class="ttiletd" width="120px"><span style="width:5px;color:red;font-size:14px;margin-right:5px;">*</span>项目推广描述</td>
				<td class="tdetailstd">
					<div style="padding:15px 13px;">
						<textarea class="beizhu" style="overflow: hidden;resize:none;color:rgb(93,93,93)" placeholder="备注" rows="10" cols="75"></textarea>
					</div>
				</td>
			</tr>
		</table>
		<div style="width:240px;margin:0 auto;margin-top:15px;">
			<div class="restartClass" style="cursor:pointer;background: rgb(71,71,71);font-size:16px;color:white;padding:6px 20px;float:left;border-radius:4px;">重置</div>
			<div class="submitClass" style="cursor:pointer;background: rgb(235,100,100);font-size:16px;color:white;padding:6px 20px;float:left;margin-left:50px;border-radius:4px;">提交</div>
		</div>
	</div>
</body>
</html>