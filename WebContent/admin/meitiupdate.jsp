<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>媒体修改</title>
		<base href="/ghplat/admin/base/">
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="format-detection" content="telephone=no">
<script src="../js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="../../front/js/ajaxfileupload.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.uploadClickClass').click(function(){
		$(this).parent().find('.uploadClass').click();
	})
});
function ajaxFileUploadImage(index,type) {
	$('#cimageMsg').hide();
    $.ajaxFileUpload
    (
        {
            url: '/ghplat/admin/uploadImage', //用于文件上传的服务器端请求地址
            secureuri: false, //是否需要安全协议，一般设置为false
            fileElementId: 'uploadImageInput'+index, //文件上传域的ID
            dataType: 'json', //返回值类型 一般设置为json
            success: function (data, status)  //服务器成功响应处理函数
            {
            	if(data.code == 0){
            		if(data.length==1){
            			if(type==2){//2是上传案例图片
            				var anliImageDiv = $('.anliImageDiv').clone();
	            			$(anliImageDiv).show();
	            			$(anliImageDiv).removeClass('anliImageDiv').addClass('anliImageDis');
	            			$(anliImageDiv).find('.imageShowDiv').attr('src',data.imageList[0]);
	            			$('.addImageDiv'+index).before($(anliImageDiv));
            			}else{
		            		$('#uploadImageImg'+index).attr('src',data.imageList[0]);
            			}
            		}else{
            			for(var i=0;i<data.length;i++){
	            			var anliImageDiv = $('.anliImageDiv').clone();
	            			$(anliImageDiv).show();
	            			$(anliImageDiv).removeClass('anliImageDiv').addClass('anliImageDis');
	            			$(anliImageDiv).find('.imageShowDiv').attr('src',data.imageList[i]);
	            			$('.addImageDiv'+index).before($(anliImageDiv));
            			}
            		}
            	}
            }
        }
    )
    return false;
}
function changeArea0(tt){
	$('.areaSelect2').html('');
	var val = $(tt).val();
	$('.attrErCode').hide();
	if(val==0){
		$('.areaSelect2').html('<option value="0">--请选择--</option>');
	}else{
		$($('option[attrErCode="'+val+'"]')[0]).attr('selected','selected');
		$('option[attrErCode="'+val+'"]').show();
		$('.areaSelect2').html($('option[attrErCode="'+val+'"]').clone());
	}
	changeAreaa1($('.areaSelect2'));
}
function changeAreaa1(tt){
	$('.areaSelect3').html('');
	var val = $(tt).val();
	$('.attrSanCode').hide();
	if(val==0){
		$('.areaSelect3').html('<option value="0">--请选择--</option>');
		$('.publisharea').val(0);
	}else{
		$('option[attrSanCode="'+val+'"]').show();
		$($('option[attrSanCode="'+val+'"]')[0]).attr('selected','selected');
		$('.areaSelect3').html($('option[attrSanCode="'+val+'"]').clone());
	}
	//$('option[attrSanCode="'+val+'"]').attr('selected','selected');
}
function sumbitAddPublish(){
	var pbinfoArray = new Array();
	for(var i=0;i<$('.infoInputDiv').length;i++){
			var pbinfoobj = {};
			pbinfoobj.columnKey = $($('.infoInputDiv')[i]).attr('attrKey');
			pbinfoobj.columnValue = $($('.infoInputDiv')[i]).val();
			pbinfoArray.push(pbinfoobj);
	}
	//alert(pbinfoArray[0].columnName+"||"+pbinfoArray[0].columnValue+"||"+pbinfoArray[0].fieldName);
	var pbpriceArray = new Array();
	for(var i=0;i<$('.priceInput').length;i++){
			var pbpriceobj = {};
			pbpriceobj.columnKey = $($('.priceInput')[i]).attr('attrKey');
			pbpriceobj.columnValue = $($('.priceInput')[i]).val();
			pbpriceArray.push(pbpriceobj);
	}
	var pbtypename = $('#pbtype :selected').text();
	var pbtype = $('#pbtype').val();
	var spid = $('#submitAdd').attr('attrPid');
	var pbtype = $('#submitAdd').attr('typeid');
	var pbimage = $('#uploadImageImg1').attr('src');
	var pbname = $('#pbname').val();
	var pbfancount =$('#pbfancount').val();
	var publisharea = $('.areaSelect3').val();
	var pbplatform = $('#pbplatform'+pbtype).val();
	var pbQQ = $('#pbQQ').val();
	var pbfield = $('#pbfield'+pbtype).val();
	var mediaId = $('#pmediaId').val();
	$.ajax({
		type: "post",
		url: "../updatePublish",
		async: false, //_config.async,
		dataType: 'json',
		data:{
			'id':spid,
			'image':pbimage,
			'qq':pbQQ,
			'publishTypeObj.publishFieldId':pbtype,
			'publishTypeObj.publishFieldName':pbtypename,
			'publishName':pbname,
			'publishField':pbfield,
			'platformName':pbplatform,
			'publishRegion':publisharea,
			'platformFans':pbfancount,
			'mediaId':mediaId,
			'infoArrayStr':JSON.stringify(pbinfoArray),
			'priceArrayStr':JSON.stringify(pbpriceArray)
		},
		success: function(data, status, xhr) {
			if(data.result=="yes"){
				//location.reload();
			}
		}
	});
}
</script>
	</head>

	<body>
		<div style="margin: 15px;">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
				<legend>修改媒体</legend>
				<input type="hidden" value="${pdetails.mediaId }" id="pmediaId"/>
				<table style="width:100%;font-size: 14px;color:#333333;font-family: 微软雅黑;border-collapse:separate; border-spacing:0px 30px;" class="addpublishTable">
									<tr><td width="130px" style="vertical-align:top;">上传头像&nbsp;:</td>
										<td width="450px"><div style="width:180px;height:200px;border: 1px #707070 dotted;">
												<div class="uploadClickClass" style="width:180px;height:155px;cursor: pointer;">
													<div style="width:100%;height:100%;"><img id="uploadImageImg1" style="width:180px;height:155px;" src="/ghplat/attachment${pdetails.image }" /></div>
												</div>
												<input id="uploadImageInput1" onchange="ajaxFileUploadImage(1,1)" name="files" class="uploadClass" accept="image/*" type="file" style="display:none;"/>
												<div style="width:180px;height:45px;background: #ededed;">
													<div style="width:100%;height:21px;text-align: center;padding-top:4px;">头像上传（只能上传一张）</div>
													<div style="font-size:12px;text-align: center;">大小不能超过1024kb</div>
												</div>
											</div>
										</td><td><div id="imageMsg" class="wrongClass" style="display:none;font-size:14px;color:#fc6769;height:20px;">没有上传主题图片</div></td>
									</tr>
									<tr><td>类型&nbsp;:
									</td><td>
										${pdetails.publishTypeObj.publishFieldName }
<!-- 										<select id="pbtype" onchange="changeType(this)" style="width:200px;color:#333333;height:30px;font-size:14px;padding-left:6px;"> -->
<%-- 											<c:forEach var="publish" items="${ptdto }"  varStatus="st" > --%>
<%-- 												<option value="${publish.publishType }" <c:if test="${pdetails.publishTypeObj.publishFieldId==publish.publishType }">selected="selected"</c:if> style="padding:6px;font-size:14px;color:#333333;">${publish.publishName }</option> --%>
<%-- 											</c:forEach> --%>
<!-- 										</select> -->
									</td><td></td></tr>
									<tr><td>区域&nbsp;:
									</td><td>
										<select class="pbarea" onchange="changeArea0(this)" style="float:left;width:130px;color:#333333;height:35px;font-size:14px;padding-left:6px;margin-top:10px;">
													<option value="0">--请选择--</option>
											<c:forEach var="publisharea" items="${publishArea }"  varStatus="st" >
												<c:if test="${publisharea.priority=='1' }">
													<option value="${publisharea.area_code }" style="padding:6px;font-size:14px;color:#333333;">${publisharea.area_name }</option>
												</c:if>
											</c:forEach>
										</select>
										<select class="areaSelect2" onchange="changeAreaa1(this)" style="float:left;margin-left:10px;width:130px;color:#333333;height:35px;font-size:14px;padding-left:6px;margin-top:10px;">
											<option value="0">--请选择--</option>
										</select>
										<select class="areaSelect3" style="float:left;margin-left:10px;width:130px;color:#333333;height:35px;font-size:14px;padding-left:6px;margin-top:10px;">
											<option value="0">--请选择--</option>
											<c:if test="${pdetails.publishRegion!=null }">
												<option value="${pdetails.publishRegion }" selected="selected" >${pdetails.publishRegion }</option>
											</c:if>
										</select>
										<select onchange="changeAreaa1(this)" style="display:none;float:left;margin-left:10px;width:130px;color:#333333;height:35px;font-size:14px;padding-left:6px;margin-top:10px;margin-left:10px;">
											<option value="0">--请选择--</option>
											<c:forEach var="publisharea" items="${publishArea }"  varStatus="st" >
												<c:if test="${publisharea.priority=='2' }">
													<option class="attrErCode" attrErCode="${publisharea.parent_area_code }" value="${publisharea.area_code }" style="display:none;padding:6px;font-size:14px;color:#333333;">${publisharea.area_name }</option>
												</c:if>
											</c:forEach>
										</select>
										<select onchange="changeArea2(this)" class="publisharea" style="display:none;float:left;margin-left:10px;width:130px;color:#333333;height:35px;font-size:14px;padding-left:6px;margin-top:10px;margin-left:10px;">
											<option value="0">--请选择--</option>
											<c:forEach var="publisharea" items="${publishArea }"  varStatus="st" >
												<c:if test="${publisharea.priority=='3' }">
													<option  class="attrSanCode" attrSanCode="${publisharea.parent_area_code }" value="${publisharea.area_name }" style="display:none;padding:6px;font-size:14px;color:#333333;">${publisharea.area_name }</option>
												</c:if>
											</c:forEach>
										</select>
									</td><td></td></tr>
									<tr><td>QQ&nbsp;:
									</td><td>
										<input id="pbQQ" value="${pdetails.qq}" style="width:350px;height:30px;padding:6px;color:#333333;text-align: left;" type="text" placeholder="请填写QQ" />
									</td><td><div id="nameMsg" class="wrongClass" style="display:none;font-size:14px;color:#fc6769;height:20px;">填写QQ不对</div></td></tr>
									<tr><td>标题&nbsp;:
									</td><td>
										<input id="pbname" value="${pdetails.publishName}" style="width:350px;height:30px;padding:6px;color:#333333;text-align: left;" type="text" placeholder="请填写案例标题" />
									</td><td><div id="nameMsg" class="wrongClass" style="display:none;font-size:14px;color:#fc6769;height:20px;">填写主题标题不对</div></td></tr>
									<tr><td>粉丝数&nbsp;:
									</td><td>
										<input id="pbfancount" value="${pdetails.platformFans}" style="width:350px;height:30px;padding:6px;color:#333333;text-align: left;" type="text" placeholder="请填写粉丝数" />
									</td><td><div id="fancountMsg" class="wrongClass" style="display:none;font-size:14px;color:#fc6769;height:20px;">填写粉丝数不对</div></td></tr>
									<c:forEach var="publisha" items="${ptdto }" varStatus="stt">
										<c:if test="${publisha.publishFieldList.size()>1 }">
<%-- 										<c:if test="${stt.index<1 }"> --%>
											<tr class="pfieldtr pfieldtr${publisha.publishType }" style="<c:if test="${publisha.publishType!=pdetails.publishTypeObj.publishFieldId }">display:none;</c:if>"><td>所属领域&nbsp;:</td><td>
												<select id="pbfield${publisha.publishType }" style="width:350px;color:#333333;height:30px;font-size:14px;padding-left:6px;">
													<c:forEach var="publishField" items="${publisha.publishFieldList }" >
														<option style="padding:6px;font-size:14px;color:#333333;" <c:if test="${publishField.publishFieldName==pdetails.publishField }">selected="selected"</c:if> value="${publishField.publishFieldName }">${publishField.publishFieldName }</option>
													</c:forEach>
													
												</select>
											</td><td></td></tr>
										</c:if>
										<c:if test="${publisha.publishPlatform.size()>1 }">
											<tr class="pplatformtr pplatformtr${publisha.publishType }" style="<c:if test="${publisha.publishType!=pdetails.publishTypeObj.publishFieldId }">display:none;</c:if>"><td>平台类型&nbsp;:</td><td>
												<select id="pbplatform${publisha.publishType }" style="width:350px;color:#333333;height:30px;font-size:14px;padding-left:6px;">
													<c:forEach var="publishplatform" items="${publisha.publishPlatform }" >
														<option style="padding:6px;font-size:14px;color:#333333;" <c:if test="${publishplatform.platformName==pdetails.platformName }">selected="selected"</c:if> value="${publishplatform.platformName }">${publishplatform.platformName }</option>
													</c:forEach>
												</select>
											</td><td></td></tr>
										</c:if>
									</c:forEach>
									<c:forEach items="${pdetails.infoMap }" var="infoMap">
									<tr><td>${infoMap.key }&nbsp;:</td><td>
												<div style="float:left;line-height: 40px;font-size:14px;max-width:930px;">
													<input class="infoInputDiv" attrKey="${infoMap.key }" style="width:350px;height:30px;padding:6px;color:#333333;text-align:left;" type="text" value="${infoMap.value }" placeholder="请填写${infoMap.key }" />
												</div>
											</td></tr>
										</c:forEach>
									<c:forEach items="${pdetails.priceMap }" var="priceMap">
										<tr><td><div class="priceFontDiv" style="float:left;overflow: hidden;height:48px;line-height: 48px;">${priceMap.key }&nbsp;:</div></td><td>
	<div class="addpriceDiv" style="height:25px;float:left;position: relative;">
		<div style="float:left;width:50px;">
			<input class="priceInput" attrKey="${priceMap.key }" style="width:50px;height:18px;padding:6px;color:#333333;" placeholder="请填写案例主题" type="text" value="${priceMap.value }" />
		</div>
	</div>
										</td></tr>
									</c:forEach>
								</table>
				<div class="saveanliDiv" style="width:100%;height:45px;">
						<div style="width:320px;margin:0 auto;margin-top:5px;">
							<div id="submitAdd" typeid="${pdetails.publishTypeObj.publishFieldId }"  attrPid="${pdetails.id }" onclick="sumbitAddPublish()" style="width:140px;height:48px;background: #fc6769;color:white;font-size:18px;line-height: 48px;float:left;border-radius:5px;text-align: center;cursor: pointer;">修&nbsp;改</div>
						</div>
					</div>
			</fieldset>
		</div>
	</body>

</html>