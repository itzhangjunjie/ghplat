
function SetCookie(name,value,days)//两个参数，一个是cookie的名子，一个是值
{
    var Days = 30;
    if(typeof(days)=="undefined"||isNaN(days))
        Days=parseInt(days.toString());
     //此 cookie 将被保存 30 天 -1为浏览器关闭　　
    if(Days!=-1){
        var exp = new Date();    //new Date("December 31, 9998");
        exp.setTime(exp.getTime() + Days*24*60*60*1000);
        document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString()+";path=/";
    }else{
        document.cookie = name + "="+ escape (value) + ";expires=-1"+";path=/";
    }
}

/**
 * 操作Cookie 提取   后台必须是escape编码
 * @param name
 * @return
 */
function getCookie(name)//取cookies函数
{
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
    if(arr != null) return unescape(arr[2]); return null;
}
/**
 * 操作Cookie 删除
 * @param name
 * @return
 */
function delCookie(name)//删除cookie
{   
    var exp = new Date();
    exp.setTime(exp.getTime() - 1000);
    var cval=getCookie(name);
   // console.log("...."+cval);
    if(cval!=null)
    	SetCookie(name,",",exp.toGMTString());
       // document.cookie = name + "="+ escape (cval) + ";expires="+exp.toGMTString();
}

function  deleteCart(id){
	var cartIds = getCookie("cartIds");
	if(cartIds!=null){
		if(cartIds.indexOf(id+",")>=0){
			cartIds = cartIds.replace(id+",",'');
			SetCookie("cartIds",cartIds,15);
		}
	}
}

function addCart(id){
	var cartIds = getCookie("cartIds");
	console.log(cartIds+".....");
	if(cartIds!=null){
		if(cartIds.indexOf(id+",")<0){
			cartIds = cartIds+id+",";
			SetCookie("cartIds",cartIds,15);
		}
	}else{
		cartIds = id+",";
		SetCookie("cartIds",cartIds,15);
	}
}
function addCartMany(){
	var ll = $('.selectAddCart[addflag=1]').length;
	var cartIds = getCookie("cartIds");
	for(var i=0;i<ll;i++){
		var aid = $($('.selectAddCart[addflag=1]')[i]).attr('attrId');
		if(cartIds!=null){
			if(cartIds.indexOf(aid+",")<0){
				cartIds = cartIds+aid+",";
			}
		}else{
			cartIds = aid+",";
		}
	}
	$('.selectAddCart').hide();
	SetCookie("cartIds",cartIds,15);
	var alenf = $('.selectAddCart[addflag=1]').length;
	var alen = parseInt($('.headCartCount').html())+alenf;
	$('.headCartCount').html(alen);
}