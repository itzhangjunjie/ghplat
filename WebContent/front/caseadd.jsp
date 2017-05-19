<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>案例-添加</title>
<base href="/ghplat/front/">
<script src="js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
function ajaxFileUploadImage(index) {
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
            			if(index==3){
            				var anliImageDiv = $('.anliImageDiv').clone();
	            			$(anliImageDiv).show();
	            			$(anliImageDiv).removeClass('anliImageDiv').addClass('anliImageDis');
	            			$(anliImageDiv).find('.imageShowDiv').attr('src',data.imageList[0]);
	            			$('.addImageDiv').before($(anliImageDiv));
            			}else{
		            		$('#uploadImageImg'+index).attr('src',data.imageList[0]);
            			}
            		}else{
            			for(var i=0;i<data.length;i++){
	            			var anliImageDiv = $('.anliImageDiv').clone();
	            			$(anliImageDiv).show();
	            			$(anliImageDiv).removeClass('anliImageDiv').addClass('anliImageDis');
	            			$(anliImageDiv).find('.imageShowDiv').attr('src',data.imageList[i]);
	            			$('.addImageDiv').before($(anliImageDiv));
            			}
            		}
            	}
            }
        }
    )
    return false;
}
function changeDiv(msg,tt){
	if(msg=='anliDiv'){
		$('#submitAdd').attr('attrId',"2");
	}else{
		$('#submitAdd').attr('attrId',"1");
	}
	$('.alldiv').hide();
	$('.'+msg).show();
	$('.alldaodiv').removeClass('currentCas');
	$(tt).addClass('currentCas');
	if(msg=='anliDiv'){
		searchPublish();
	}
}
function changeType(tt){
	$('.allattr').hide();
	var pid = $(tt).val();
	$('.select'+pid).show();
	$('.pplatformtr').hide();
	$('.pplatformtr'+pid).show();
	$('.pfieldtr').hide();
	$('.pfieldtr'+pid).show();
	$('.ppricetr').hide();
	$('.ppricetr'+pid).show();
}
function selectPrice(tt){
	$(tt).css('color','#333333');
	var priceDiv = $('.addpriceDiv').clone();
	var pricevalue = $(tt).find("option:selected").html();
	$(priceDiv).show();
	$(priceDiv).removeClass('addpriceDiv').addClass('priceDiv');
	$($(priceDiv).find('.priceInput')).attr('placeholder',pricevalue);
	$($(priceDiv).find('.priceInput')).attr('columnName',$(tt).val());
	$(tt).parent().parent().append(priceDiv);
}
function colseDiv(tt){
	$(tt).parent().remove();
}

$(document).ready(function(){
	$('.uploadClickClass').click(function(){
		$(this).parent().find('.uploadClass').click();
	})
	$(document).delegate('.addMeiTi','click',function(e){
		$($(this).parent().find('.addMeiTiImage')).addClass("selectedDiv");
		$($(this).parent().find('.addMeiTiImage')).show();
	})
	$(document).delegate('.addMeiTiImage','click',function(e){
		$(this).removeClass("selectedDiv");
		$(this).hide();
	})
	$("#addPublishA").fancybox({
		'titlePosition': 'inside',
		'transitionIn': 'none',
		'transitionOut': 'none',
		'afterClose'        :function(){
			var pdivs = $('#publishDiv').find(".selectedDiv");
			$('.addZiMeiTiSub').remove();
			$('.addZiMeiTiSu').remove();
			for(var i=0;i<pdivs.length;i++){
				var divclone = $('.addZiMeiTi').clone();
				$(divclone).show();
				var pid = $(pdivs[i]).parent().attr('attrId');
				var ptype = $(pdivs[i]).parent().attr('attrType');
				$(divclone).attr('attrId',pid);
				$(divclone).find('#mtName').html($(pdivs[i]).parent().find('.mtName').html());
				$(divclone).find('#mtImage').attr('src',$(pdivs[i]).parent().find('.mtImage').attr('src'));
				$(divclone).find('#mtPlatform').html($(pdivs[i]).parent().find('.mtPlatform').html());
				$(divclone).find('#mtFancount').html($(pdivs[i]).parent().find('.mtFancount').html());
// 				if(pdivs.length<=3){
// 					$(divclone).removeClass("addZiMeiTi").addClass("addZiMeiTiSub");
// 					$('.addPublishMT').before($(divclone));
// 					$('#article_pic_slider').html('');
// 					$('#wrap2').hide();
// 				}else{
					$(divclone).removeClass("addZiMeiTi");
					$('#article_pic_slider').append("<li attrPid="+pid+" attrPtype='"+ptype+"'  class='addZiMeiTiSu'>"+$(divclone).prop("outerHTML")+"</li>");
					$('.wrap').attr('attrCount',3);
					$('.wrap').show();
// 				}
			}
		}
	});
})
// jQuery.fn.shake = function (intShakes /*Amount of shakes*/, intDistance /*Shake distance*/, intDuration /*Time duration*/) {  
//     this.each(function () {  
//         var jqNode = $(this);  
//         jqNode.css({ position: 'relative' });  
//         for (var x = 1; x <= intShakes; x++) {  
//             jqNode.animate({ left: (intDistance * -1) }, (((intDuration / intShakes) / 4)))  
//             .animate({ left: intDistance }, ((intDuration / intShakes) / 2))  
//             .animate({ left: 0 }, (((intDuration / intShakes) / 4)));  
//         }  
//     });  
//     return this;  
// }  

function sumbitAddPublish(){
	var statusflag = $('#submitAdd').attr('attrId');
	if(statusflag==1){
		$('.wrongClass').hide();
		var pbimage = $('#uploadImageImg1').attr('src');
		if(pbimage.indexOf('addImage')>=0){
			$('body').scrollTop(50);
			$('#imageMsg').show();
			//$('#imageMsg').shake(2, 20, 400);
			return false;
		}
		var pbtype = $('#pbtype').val();
		var pbname = $('#pbname').val();
		if(pbname==''||pbname.length>100||pbname.length==0){
			$('body').scrollTop($('#pbname').offsetTop);
			$('#nameMsg').show();
			//$('#nameMsg').shake(2, 20, 500);
			return false;
		}
		var pbfancount =$('#pbfancount').val();
		var s = /^[0-9]*$/;
		if(pbfancount==''||!s.test(pbfancount)){
			$('body').scrollTop($('#pbfancount').offsetTop);
			$('#fancountMsg').show();
			//$('#fancountMsg').shake(2, 20, 500);
			return false;
		}
		var pbfield = $('#pbfield'+pbtype).val();
		var pbplatform = $('#pbplatform'+pbtype).val();
		var pbinfoArray = new Array();
		for(var i=0;i<$('.pbinfoInput'+pbtype).length;i++){
			var pbinfo = $($('.pbinfoInput'+pbtype)[i]).val();
			if(pbinfo==''||pbinfo.length>100||pbinfo.length==0){
				$('body').scrollTop($($('.pbinfoInput'+pbtype)[i]).offsetTop);
				$($('.pbinfoInput'+pbtype)[i]).parent().parent().find('.wrongClass').html("填写"+$($('.pbinfoInput'+pbtype)[i]).attr('fieldName')+"不对");
				$($('.pbinfoInput'+pbtype)[i]).parent().parent().find('.wrongClass').show();
				//$($('.pbinfoInput'+pbtype)[i]).parent().parent().find('.wrongClass').shake(2, 20, 500);
				return false;
			}else{
				var pbinfoobj = {};
				pbinfoobj.columnName = $($('.pbinfoInput'+pbtype)[i]).attr('columnName');
				pbinfoobj.columnValue = $($('.pbinfoInput'+pbtype)[i]).val();
				pbinfoobj.fieldName = $($('.pbinfoInput'+pbtype)[i]).attr('fieldName');
				pbinfoArray.push(pbinfoobj);
			}
		}
		//alert(pbinfoArray[0].columnName+"||"+pbinfoArray[0].columnValue+"||"+pbinfoArray[0].fieldName);
		
		var pbpriceArray = new Array();
		if($('.priceDiv').length==0){
			alert('价格不能为空');
			return false;
		}
		for(var i=0;i<$('.priceDiv').length;i++){
			var pbprice = $($('.priceDiv')[i]).find('.priceInput');
			var s = /^[0-9]*$/;
			if($(pbprice).val()==''||!s.test($(pbprice).val())){
				alert('价格填写不对');
				return false;
			}else{
				var pbpriceobj = {};
				pbpriceobj.columnName = $(pbprice).attr('columnName');
				pbpriceobj.columnValue = $(pbprice).val();
				pbpriceobj.fieldName = $(pbprice).attr('placeholder');
				pbpriceArray.push(pbpriceobj);
			}
		}
		//alert(pbpriceArray[0].columnName+"||"+pbpriceArray[0].columnValue+"||"+pbpriceArray[0].fieldName);
		
		$.ajax({
			type: "post",
			url: "../savePublish",
			async: false, //_config.async,
			dataType: 'json',
			data:{
				'image':pbimage,
				'publishType':pbtype,
				'publishName':pbname,
				'publishField':pbfield,
				'platformName':pbplatform,
				'platformFans':pbfancount,
				'infoArray':JSON.stringify(pbinfoArray),
				'priceArray':JSON.stringify(pbpriceArray)
			},
			success: function(data, status, xhr) {
				if(data.result=="yes"){
				}
			}
		});
	}else{
		var ctitle = $('#ctitle').val();
		if(ctitle==''||ctitle.length>40){
			$('#ctitleMsg').val('填写主题错误');
			$('#ctitleMsg').show();
			return;
		}
		var cbrand = $('#cbrand').val();
		if(cbrand==''||cbrand.length>10){
			$('#cbrandMsg').val('填写品牌错误');
			$('#cbrandMsg').show();
			return;
		}
		var cindustry = $('#cindustry').val();
		if(cindustry==''||cindustry.length>10){
			$('#cindustryMsg').val('填写行业错误');
			$('#cindustryMsg').show();
			return;
		}
		var cproduct = $('#cproduct').val();
		if(cproduct==''||cproduct.length>10){
			$('#cproductMsg').val('填写产品错误');
			$('#cproductMsg').show();
			return;
		}
		var cdesc = $('#cdesc').val();
		if(cdesc==''||cdesc.length>10){
			$('#cdescMsg').val('填写详情错误');
			$('#cdescMsg').show();
			return;
		}
		var cimage = $('#uploadImageImg2').attr('src');
		if(cimage.indexOf('addImage')>=0){
			$('body').scrollTop(50);
			$('#cimageMsg').show();
			return;
		}
		var imageArray = new Array();
		console.log($('.anliImageDis').length);
		for(var i=0;i<$('.anliImageDis').length;i++){
			var imageObj = {};
			imageObj.url = $($('.anliImageDis')[i]).find(".imageShowDiv").attr('src');
			imageObj.title = $($('.anliImageDis')[i]).find(".cimageTitle").val();
			imageObj.details = $($('.anliImageDis')[i]).find(".cimageDetails").val();
			imageArray.push(imageObj);
		}
		var publishArray = new Array();
		for(var i=0;i<$('.wrap').find('.addZiMeiTiSu').length;i++){
			var publishObj = {};
			publishObj.publishId = $($('.wrap').find('.addZiMeiTiSu')[i]).attr("attrPid");
			publishObj.publishType = $($('.wrap').find('.addZiMeiTiSu')[i]).attr("attrPtype");
			publishArray.push(publishObj);
		}
		$.ajax({
			type: "post",
			url: "../saveCase",
			async: false, //_config.async,
			dataType: 'json',
			data:{
				'case_title':ctitle,
				'case_brand':cbrand,
				'case_Industry':cindustry,
				'case_product':cproduct,
				'case_desc':cdesc,
				'image':cimage,
				'imageArray':JSON.stringify(imageArray),
				'publishArray':JSON.stringify(publishArray)
			},
			success: function(data, status, xhr) {
				if(data.result=="yes"){
				}
			}
		});
	}
}
function searchPublish(){
		var pbtype = $('.addPublishDivType').val();
		var pbsearch = $('.searchStrClass').val();
		var pbmediaid = 2300;
		var datajson = {};
		datajson.pageCount = 30;
		datajson.pageSize = 1;
		if(pbtype!=null&&pbtype!=0){
			datajson.publishType = pbtype;
		}
		if(pbsearch!=null){
			datajson.publishName = pbsearch;
		}
		if(pbmediaid!=null){
			datajson.mediaId = pbmediaid;
		}
		$.ajax({
			type: "post",
			url: "../getPublishStr",
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
</head>
<body style="padding:0px;margin:0px;">
	<%@include file="header.jsp" %>
	<div style="width:100%;background:rgb(242,242,242);height:auto;overflow: hidden;">
			<div style="width:1198px;background: white;margin:0 auto;margin-top:20px;margin-bottom:20px;border:1px #eeeeee solid;overflow: hidden;">
				<div style="width:1140px;margin-left:30px;margin-top:30px;">
					<div style="width:100%;height:36px;border-bottom: 1px #707070 solid;">
						<div onclick="changeDiv('basemsgDiv',this)" class="currentCas alldaodiv" style="cursor:pointer;height:36px;font-size: 18px;color:#333333;float:left;width:100px;text-align: center;">发布管理</div>
						<div onclick="changeDiv('anliDiv',this)" class="alldaodiv" style="cursor:pointer;height:36px;font-size: 18px;color:#333333;float:left;width:100px;text-align: center;margin-left:25px;">案例管理</div>
					</div>
					<div style="width:100%;">
						<table class="alldiv basemsgDiv" style="width:100%;font-size: 14px;color:#333333;font-family: 微软雅黑;border-collapse:separate; border-spacing:0px 30px;" class="addpublishTable">
							<tr><td width="130px" style="vertical-align:top;">上传头像&nbsp;:</td>
								<td width="450px"><div style="width:180px;height:200px;border: 1px #707070 dotted;">
										<div class="uploadClickClass" style="width:180px;height:155px;cursor: pointer;">
											<div style="width:100%;height:100%;"><img id="uploadImageImg1" style="width:180px;height:155px;" src="images/addImage.png" /></div>
										</div>
										<input id="uploadImageInput1" onchange="ajaxFileUploadImage(1)" name="files" class="uploadClass" accept="image/*" type="file" style="display:none;"/>
										<div style="width:180px;height:45px;background: #ededed;">
											<div style="width:100%;height:21px;text-align: center;padding-top:4px;">头像上传（只能上传一张）</div>
											<div style="font-size:12px;text-align: center;">大小不能超过1024kb</div>
										</div>
									</div>
								</td><td><div id="imageMsg" class="wrongClass" style="display:none;font-size:14px;color:#fc6769;height:20px;">没有上传主题图片</div></td>
							</tr>
							<tr><td>类型&nbsp;:
							</td><td>
								<select id="pbtype" onchange="changeType(this)" style="width:350px;color:#333333;height:48px;font-size:14px;padding-left:6px;">
									<c:forEach var="publish" items="${ptdto }"  varStatus="st" >
										<option value="${publish.publishType }" style="padding:6px;font-size:14px;color:#333333;">${publish.publishName }</option>
									</c:forEach>
								</select>
							</td><td></td></tr>
							<tr><td>标题&nbsp;:
							</td><td>
								<input id="pbname" style="width:350px;height:48px;padding:6px;color:#333333;text-align: left;" type="text" placeholder="请填写案例标题" />
							</td><td><div id="nameMsg" class="wrongClass" style="display:none;font-size:14px;color:#fc6769;height:20px;">填写主题标题不对</div></td></tr>
							<tr><td>粉丝数&nbsp;:
							</td><td>
								<input id="pbfancount" style="width:350px;height:48px;padding:6px;color:#333333;text-align: left;" type="text" placeholder="请填写粉丝数" />
							</td><td><div id="fancountMsg" class="wrongClass" style="display:none;font-size:14px;color:#fc6769;height:20px;">填写粉丝数不对</div></td></tr>
							<c:forEach var="publisha" items="${ptdto }" varStatus="stt">
								<c:if test="${publisha.publishFieldList.size()>1 }">
									<tr class="pfieldtr pfieldtr${publisha.publishType }" style="<c:if test='${stt.index!=0 }'>display:none;</c:if>"><td>所属领域&nbsp;:</td><td>
										<select id="pbfield${publisha.publishType }" style="width:350px;color:#333333;height:48px;font-size:14px;padding-left:6px;">
											<c:forEach var="publishField" items="${publisha.publishFieldList }" >
												<option style="padding:6px;font-size:14px;color:#333333;" value="${publishField.publishFieldName }">${publishField.publishFieldName }</option>
											</c:forEach>
										</select>
									</td><td></td></tr>
								</c:if>
								<c:if test="${publisha.publishPlatform.size()>1 }">
									<tr class="pplatformtr pplatformtr${publisha.publishType }" style="<c:if test='${stt.index!=0 }'>display:none;</c:if>"><td>平台类型&nbsp;:</td><td>
										<select id="pbplatform${publisha.publishType }" style="width:350px;color:#333333;height:48px;font-size:14px;padding-left:6px;">
											<c:forEach var="publishplatform" items="${publisha.publishPlatform }" >
												<option style="padding:6px;font-size:14px;color:#333333;" value="${publishplatform.platformName }">${publishplatform.platformName }</option>
											</c:forEach>
										</select>
									</td><td></td></tr>
								</c:if>
								<c:forEach var="publishinfo" items="${publisha.publishInfo }" >
									<c:if test="${publishinfo.columnName!=null }">
										<tr class="allattr select${publisha.publishType }" style="<c:if test='${stt.index!=0 }'>display:none;</c:if>"><td>${publishinfo.columnName }&nbsp;:</td><td>
											<c:if test="${publishinfo.columnType=='TEXT' }"><input class="pbinfoInput${publisha.publishType }" columnName="${publishinfo.columnPosition }" fieldName="${publishinfo.columnName }" style="width:350px;height:48px;padding:6px;color:#333333;text-align:left;" type="text" placeholder="请填写${publishinfo.columnName }" /></c:if>
											<c:if test="${publishinfo.columnType=='CHECKBOX'&&publishinfo.columnName=='性别' }">
												<select style="width:350px;color:#333333;height:48px;font-size:14px;padding-left:6px;">
													<option style="padding:6px;font-size:14px;color:#333333;" value="女">女</option>
													<option style="padding:6px;font-size:14px;color:#333333;" value="男">男</option>
												</select>
											</c:if>
										</td><td><div class="wrongClass" style="display:none;font-size:14px;color:#fc6769;height:20px;">填写主题标题不对</div></td></tr>
									</c:if>
								</c:forEach>
								<c:if test="${publisha.publishPrice.size()>1 }">
									<tr class="ppricetr ppricetr${publisha.publishType }" style="<c:if test='${stt.index!=0 }'>display:none;</c:if>"><td>价格定义&nbsp;:</td><td colspan="2">
										<div style="float:left;width:140px;">
											<select onchange="selectPrice(this)" style="width:140px;color:#999999;height:48px;font-size:14px;padding-left:6px;">
												<option style="display:none;" value="0">请选择价格类型</option>
												<c:forEach var="publishprice" items="${publisha.publishPrice }" >
													<option style="padding:6px;font-size:14px;color:#333333;" value="${publishprice.columnPosition }">${publishprice.columnName }</option>
												</c:forEach>
											</select>
										</div>
									</td></tr>
								</c:if>
							</c:forEach>
						</table>
						<div class="alldiv anliDiv" style="display:none;width:100%;border:1px #999999 solid;height:auto;background: #fbfbfb;margin-top:30px;margin-bottom: 30px;overflow: hidden;">
							<div style="padding:30px;font-size:14px;color:#333333;">
								<div style="width:100%;height:48px;">
									<div style="width:100px;height:48px;line-height: 48px;float:left;">案例主题&nbsp;:</div>
									<div style="width:400px;height:48px;line-height: 48px;float:left;position: relative;"><input id="ctitle" style="width:400px;height:48px;padding:6px;color:#333333;text-align: left;" placeholder="请填写案例主题" type="text" />
										<div class="ctitleMsg" class="errormsg" style="display:none;color:red;top:0px;right:8px;position: absolute;font-size:12px;">姓名不能超过5个字</div>
								    </div>
									<div style="width:100px;height:48px;line-height: 48px;float:left;"></div>
								</div>
								<div style="width:100%;margin-top:30px;height:48px;">
									<div style="width:100px;height:48px;line-height: 48px;float:left;">品牌&nbsp;:</div>
									<div style="width:200px;height:48px;line-height: 48px;float:left;position: relative;"><input id="cbrand" style="width:200px;height:48px;padding:6px;color:#333333;text-align: left;" placeholder="请填写品牌" type="text" /> 
											<div class="cbrandMsg" class="errormsg" style="display:none;color:red;top:4px;right:8px;position: absolute;font-size:12px;">姓名不能超过5个字</div>
									</div>
									<div style="width:60px;height:48px;line-height: 48px;float:left;margin-left:30px;">行业&nbsp;:</div>
									<div style="width:200px;height:48px;line-height: 48px;float:left;position: relative"><input id="cindustry" style="width:200px;height:48px;padding:6px;color:#333333;text-align: left;" placeholder="请填写品牌" type="text" /> 
										<div class="cindustryMsg" class="errormsg" style="display:none;color:red;top:4px;right:8px;position: absolute;font-size:12px;">姓名不能超过5个字</div>
									</div>
									<div style="width:60px;height:48px;line-height: 48px;float:left;margin-left:30px;">产品&nbsp;:</div>
									<div style="width:200px;height:48px;line-height: 48px;float:left;position: relative"><input id="cproduct" style="width:200px;height:48px;padding:6px;color:#333333;text-align: left;" placeholder="请填写品牌" type="text" />
										<div class="cproductMsg" class="errormsg" style="display:none;color:red;top:4px;right:8px;position: absolute;font-size:12px;">姓名不能超过5个字</div>
									</div>
								</div>
								<div style="width:100%;margin-top:30px;height:75px;">
									<div style="width:100px;height:60px;line-height: 18px;float:left;">案例描述&nbsp;:</div>
									<div style="width:980px;float:left;position: relative"><input id="cdesc" style="width:980px;height:75px;color:#333333;padding: 0 10px 43px;text-align: left;" placeholder="请填写案例描述" type="text" /> 
										<div class="cdescMsg" class="errormsg" style="display:none;color:red;top:50px;right:8px;position: absolute;font-size:12px;">姓名不能超过5个字</div>
									</div>
								</div>
								<div style="width:100%;margin-top:30px;height:98px;">
									<div style="width:100px;height:96px;line-height: 18px;float:left;line-height: 96px;">案例置顶图&nbsp;:</div>
									<div style="float:left;width:96px;height:96px;border:1px #dfdfdf solid;">
										<div class="uploadClickClass" style="width:100%;height:100%;cursor: pointer;">
											<div style="width:100%;height:100%;position: relative;"><img id="uploadImageImg2" style="width:96px;height:96px;" src="images/addImage.png" />
												<div id="cimageMsg" class="wrongClass" style="display:none;font-size:12px;color:#fc6769;height:20px;position: absolute;bottom: 3px;left:12px;">上传主图错误</div>
											</div>
										</div>
										<input id="uploadImageInput2" onchange="ajaxFileUploadImage(2)" accept="image/*" name="files" class="uploadClass" type="file" style="display:none;"/>
									</div>
									<div style="width:100px;height:96px;line-height: 18px;float:left;line-height: 96px;margin-left:25px;">自媒体弹窗&nbsp;:</div>
									<div  class="addZiMeiTi" style="width:200px;float:left;height:96px;position: relative;display:none;">
										<div style="width:96px;height:96px;float:left;"><img id="mtImage" style="width:96px;height:96px;" src="http://61.129.51.62:8080/GhWemediaWar//images/2300/201612021204profilePhoto陈翔六点半.jpg" /></div>
										<div style="float:left;width:100px;height:96px;">
											<div id="mtName" style="margin-top:12px;margin-left:15px;width:90px;height:16px;overflow: hidden;line-height:16px;color:black;font-weight: bold;font-size:14px;">陈翔</div>
											<div id="mtPlatform" style="margin-top:6px;margin-left:15px;width:70px;height:18px;overflow: hidden;color:#333333;font-size:12px;">秒拍</div>
											<div style="margin-top:6px;margin-left:15px;width:70px;height:33px;overflow: hidden;color:#333333;font-size:12px;">粉丝数：<br/><span id="mtFancount">2837000</span></div>
										</div>
									</div>
									<div id="wrap2" class="wrap" attrCount="3" style="display:none;">
										<div class="article_pic_left_btn">
										     <img src="images/space_16_23.png" id="cardArrowLeft" class="live_card_arrow_left_physical" />
										 </div>
										<div class="puzzle_card" id="puzzle_card2">
											<div class="showbox" id="showbox2">
											  <ul id="article_pic_slider">
											  </ul>
											</div>
										</div>
								        <div class="article_pic_right_btn">
								          <img src="images/space_16_23.png" id="cardArrowRight" class="live_card_arrow_right_physical" />
								        </div>
									</div>
									<div class="addPublishMT" style="float:left;width:96px;height:96px;border:1px #dfdfdf solid;">
										<a id="addPublishA" href="#addPublishDiv" style="text-decoration: none;">
											<div class="fbClickClass" style="width:100%;height:100%;cursor: pointer;">
												<div style="width:100%;height:100%;"><img style="width:96px;height:96px;" src="images/addImage.png" /></div>
											</div>
										</a>
									</div>
								</div>
								<div style="width:100%;margin-top:30px;height:98px;">
									<div style="width:100px;height:96px;line-height: 18px;float:left;"><div style="width:100%;margin-top:25px;">案例照片&nbsp;:</div><div style="font-size:12px;">(可上传多张)</div></div>
									<div class="addImageDiv" style="float:left;width:96px;height:96px;border:1px #dfdfdf solid;">
										<div class="uploadClickClass" style="width:100%;height:100%;cursor: pointer;">
											<div style="width:100%;height:100%;"><img id="uploadImageImg3" style="width:96px;height:96px;" src="images/addImage.png" />
												<div id="cimage2Msg" class="wrongClass" style="display:none;font-size:12px;color:#fc6769;height:20px;position: absolute;bottom: 3px;left:12px;">至少上传一张</div>
											</div>
										</div>
										<input id="uploadImageInput3" multiple="multiple" accept="image/*" onchange="ajaxFileUploadImage(3)" name="files" class="uploadClass" type="file" style="display:none;"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div style="width:100%;height:75px;">
						<div style="width:320px;margin:0 auto;margin-top:5px;">
							<div id="submitAdd" attrId="1" onclick="sumbitAddPublish()" style="width:140px;height:48px;background: #fc6769;color:white;font-size:18px;line-height: 48px;float:left;border-radius:5px;text-align: center;cursor: pointer;">保&nbsp;存</div>
							<div style="width:140px;height:48px;background: #fc6769;color:white;font-size:18px;line-height: 48px;float:left;margin-left:30px;border-radius:5px;text-align: center;cursor: pointer;">取&nbsp;消</div>
						</div>
					</div>
				</div>
			</div>
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
				<input class="searchStrClass" type="text" placeholder="突然想起某位达人" style="border:0px;text-align:left;margin:0px;padding: 10px 10px 10px 20px;width:265px;height:40px;color:#999999;font-size:14px;"/>
			</div>
			<div onclick="searchPublish()" style="cursor:pointer;background: #333333;width:60px;height:42px;float:left;text-align: center;">
				<img src="images/search_white.png" style="height:24px;margin-top:9px;" />
			</div>
		</div>
		<div style="width:100%;margin-top:10px;" id="publishDiv">
		</div>
			<script id="publishTmp" type="text/x-dot-template">
		{{for(var i=0;i<it.length;i++){ }} 
			<div attrId="{{=it[i].id}}" attrType="{{=it[i].publishType}}" style="width:180px;float:left;height:80px;position: relative;border: 1px #999999 solid;{{? (i+2)%2==0}}margin-right:26px;{{?}}margin-top:20px;">
				<div style="width:80px;height:80px;float:left;"><img class="mtImage" style="width:80px;height:80px;" src="http://61.129.51.62:8080/GhWemediaWar/{{=it[i].image}}" /></div>
				<div style="float:left;width:100px;height:80px;">
					<div class="mtName" style="margin-top:13px;margin-left:10px;width:90px;height:16px;overflow: hidden;line-height:16px;color:black;font-weight: bold;font-size:14px;">{{=it[i].publishName}}</div>
					<div class="mtPlatform" style="margin-top:6px;margin-left:10px;width:70px;height:14px;overflow: hidden;color:#333333;font-size:12px;">{{=it[i].platformName}}</div>
					<div class="mtFancount" style="margin-top:6px;margin-left:10px;width:70px;height:14px;overflow: hidden;color:#333333;font-size:12px;">{{=it[i].platformFans}}</div>
				</div>
				<div class="addMeiTi" style="position:absolute ;bottom: -1px; right:-1px;cursor:pointer;width:16px;height:16px;border:1px #333333 solid;z-index:2;"></div>
				<div class="addMeiTiImage" style="display:none;position:absolute ;bottom: 0px; right:0px;cursor:pointer;width:16px;height:16px;border:1px #333333 solid;z-index:3;">
					<img src="images/check_26.png" width="16px"/>
				</div>
			</div>
		{{ } }} 
			</script>
	</div>
</div>
<div style="float:left;width:230px;height:96px;border:1px #dfdfdf solid;margin-right:20px;position: relative;display:none;" class="anliImageDiv">
	<div class="uploadClickClass" style="width:96px;height:96px;cursor: pointer;float:left;">
		<div style="width:100%;height:100%;"><img class="imageShowDiv" style="width:96px;height:96px;" src="images/addImage.png" /></div>
	</div>
	<div style="width:114px;height:96px;float:left;">
		<div style="margin-top:6px;height:24px;"><input class="cimageTitle" placeholder="填写图片的标题" style="padding:2px;color:#333333;text-align: left;width:110px;height:24px;" /></div>
		<div style="margin-top:8px;margin-left:5px;">
			<textarea placeholder="填写图片的描述" class="cimageDetails" style="padding:2px;color:#333333;text-align: left;width:110px;height:50px;" rows="20" cols="3"></textarea>
		</div>
	</div>
	<div onclick="colseDiv(this)" style="float:left;cursor:pointer;width:22px;position: absolute;top:-5px;right:-5px;"><img src="images/colse.jpg" style="height:22px;"/></div>
</div>
<div class="addpriceDiv" style="width:140px;height:48px;float:left;position: relative;margin-left:20px;display:none;">
	<div style="float:left;width:140px;">
		<input class="priceInput" style="width:140px;height:48px;padding:6px;color:#333333;" placeholder="请填写案例主题" type="text" />
	</div>
	<div onclick="colseDiv(this)" style="float:left;cursor:pointer;width:22px;position: absolute;top:-5px;right:-5px;"><img src="images/colse.jpg" style="height:22px;"/></div>
</div>

<div class="alldiv anliDiv" style="display:none;width:100%;border:1px #999999 solid;height:auto;background: #fbfbfb;margin-top:30px;margin-bottom: 30px;overflow: hidden;">
	<div style="padding:30px;font-size:14px;color:#333333;">
		<div style="width:100%;height:48px;">
			<div style="width:100px;height:48px;line-height: 48px;float:left;">案例主题&nbsp;:</div>
			<div style="width:400px;height:48px;line-height: 48px;float:left;"><input style="width:400px;height:48px;padding:6px;color:#333333;text-align: left;" disabled="disabled" placeholder="请填写案例主题" type="text" /> </div>
			<div style="width:100px;height:48px;line-height: 48px;float:left;"></div>
		</div>
		<div style="width:100%;margin-top:30px;height:48px;">
			<div style="width:100px;height:48px;line-height: 48px;float:left;">品牌&nbsp;:</div>
			<div style="width:200px;height:48px;line-height: 48px;float:left;"><input style="width:200px;height:48px;padding:6px;color:#333333;text-align: left;" disabled="disabled" placeholder="请填写品牌" type="text" /> </div>
			<div style="width:60px;height:48px;line-height: 48px;float:left;margin-left:30px;">行业&nbsp;:</div>
			<div style="width:200px;height:48px;line-height: 48px;float:left;"><input style="width:200px;height:48px;padding:6px;color:#333333;text-align: left;" disabled="disabled" placeholder="请填写品牌" type="text" /> </div>
			<div style="width:60px;height:48px;line-height: 48px;float:left;margin-left:30px;">产品&nbsp;:</div>
			<div style="width:200px;height:48px;line-height: 48px;float:left;"><input style="width:200px;height:48px;padding:6px;color:#333333;text-align: left;" disabled="disabled" placeholder="请填写品牌" type="text" /> </div>
		</div>
		<div style="width:100%;margin-top:30px;height:75px;">
			<div style="width:100px;height:60px;line-height: 18px;float:left;">案例描述&nbsp;:</div>
			<div style="width:980px;float:left;"><input style="width:980px;height:75px;color:#333333;padding: 0 10px 43px;text-align: left;" disabled="disabled" placeholder="请填写案例描述" type="text" /> </div>
		</div>
		<div style="width:100%;margin-top:30px;height:98px;">
			<div style="width:100px;height:96px;line-height: 18px;float:left;line-height: 96px;">案例置顶图&nbsp;:</div>
			<div style="float:left;width:96px;height:96px;border:1px #dfdfdf solid;">
				<div class="uploadClickClass" style="width:100%;height:100%;cursor: pointer;">
					<div style="width:100%;height:100%;"><img id="uploadImageImg2" style="width:96px;height:96px;" src="images/addImage.png" /></div>
				</div>
				<input id="uploadImageInput2" onchange="ajaxFileUploadImage(2)" accept="image/*" name="files" class="uploadClass" type="file" style="display:none;"/>
			</div>
			<div style="width:100px;height:96px;line-height: 18px;float:left;line-height: 96px;margin-left:25px;">自媒体弹窗&nbsp;:</div>
			<div id="wrap2" class="wrap2" attrCount="3">
				<div class="article_pic_left_btn">
				     <img src="images/space_16_23.png" id="cardArrowLeft" class="live_card_arrow_left_physical" />
				 </div>
				<div class="puzzle_card" id="puzzle_card2">
					<div class="showbox" id="showbox2">
					  <ul id="article_pic_slider">
					  	<li>
					  		<div style="width: 200px; float: left; height: 96px; position: relative; display: block;" class="addZiMeiTiSub" attrid="2794432">
								<div style="width:96px;height:96px;float:left;"><img src="http://61.129.51.62:8080/GhWemediaWar//images/2300/201612021234profilePhoto652508343044804040.jpg" style="width:96px;height:96px;" id="mtImage"></div>
								<div style="float:left;width:100px;height:96px;">
									<div style="margin-top:12px;margin-left:15px;width:90px;height:16px;overflow: hidden;line-height:16px;color:black;font-weight: bold;font-size:14px;" id="mtName">冷姿君</div>
									<div style="margin-top:6px;margin-left:15px;width:70px;height:18px;overflow: hidden;color:#333333;font-size:12px;" id="mtPlatform">秒拍</div>
									<div style="margin-top:6px;margin-left:15px;width:70px;height:33px;overflow: hidden;color:#333333;font-size:12px;">粉丝数：<br><span id="mtFancount">2612000</span></div>
								</div>
							</div>
					  	</li>
					  </ul>
					</div>
				</div>
		        <div class="article_pic_right_btn">
		          <img src="images/space_16_23.png" id="cardArrowRight" class="live_card_arrow_right_physical" />
		        </div>
			</div>
		</div>
		<div style="width:100%;margin-top:30px;height:98px;">
			<div style="width:100px;height:96px;line-height: 18px;float:left;"><div style="width:100%;margin-top:25px;">案例照片&nbsp;:</div><div style="font-size:12px;">(可上传多张)</div></div>
			<div class="canliImageDis" style="float: left; width: 96px; height: 96px; border: 1px solid rgb(223, 223, 223); margin-right: 20px; position: relative; display: block;">
				<div style="width:100%;height:100%;cursor: pointer;" class="uploadClickClass">
					<div style="width:100%;height:100%;"><img src="/ghplat/attachment/temp/201705181258329762.jpg" style="width:96px;height:96px;" class="imageShowDiv"></div>
				</div>
			</div>
			<div class="canliImageDis" style="float: left; width: 96px; height: 96px; border: 1px solid rgb(223, 223, 223); margin-right: 20px; position: relative; display: block;">
				<div style="width:100%;height:100%;cursor: pointer;" class="uploadClickClass">
					<div style="width:100%;height:100%;"><img src="/ghplat/attachment/temp/201705181258329762.jpg" style="width:96px;height:96px;" class="imageShowDiv"></div>
				</div>
			</div>
		</div>
	</div>
</div>

</body>
</html>