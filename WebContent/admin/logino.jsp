<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>

	<head>
		<base href="base/">
		<meta charset="utf-8">
		<title>登录</title>
		<link rel="stylesheet" href="plugins/layui/css/layui.css" media="all" />
		<link rel="stylesheet" href="css/login.css" />
	</head>

	<body class="beg-login-bg">
		<div class="beg-login-box">
			<header>
				<h1>后台登录</h1>
			</header>
			<div class="beg-login-main">
				<form action="/manage/login" class="layui-form" method="post"><input name="__RequestVerificationToken" type="hidden" value="fkfh8D89BFqTdrE2iiSdG_L781RSRtdWOH411poVUWhxzA5MzI8es07g6KPYQh9Log-xf84pIR2RIAEkOokZL3Ee3UKmX0Jc8bW8jOdhqo81" />
					<div class="layui-form-item">
						<label class="beg-login-icon">
                        <i class="layui-icon">&#xe612;</i>
                    </label>
						<input type="text" id="userName" name="userName" lay-verify="userName" autocomplete="off" placeholder="这里输入登录名" class="layui-input">
					</div>
					<div class="layui-form-item">
						<label class="beg-login-icon">
                        <i class="layui-icon">&#xe642;</i>
                    </label>
						<input type="password" id="password" name="password" lay-verify="password" autocomplete="off" placeholder="这里输入密码" class="layui-input">
					</div>
					<div class="layui-form-item">
						<div class="beg-pull-left beg-login-remember">
							<label>记住帐号？</label>
							<input type="checkbox" name="rememberMe" value="true" lay-skin="switch" checked title="记住帐号">
						</div>
						<div class="beg-pull-right">
							<button class="layui-btn layui-btn-primary" lay-submit lay-filter="login">
                            <i class="layui-icon">&#xe650;</i> 登录
                        </button>
						</div>
						<div class="beg-clear"></div>
					</div>
				</form>
			</div>
			<footer>
				<p id="errorMsg" style="color:#ffffff;"></p>
			</footer>
		</div>
		<script type="text/javascript" src="plugins/layui/layui.js"></script>
		<script>
			layui.use(['layer', 'form'], function() {
				var layer = layui.layer,
					$ = layui.jquery,
					form = layui.form();
				form.on('submit(login)',function(data){
					var username = data.field.userName;
					var password = data.field.password;
					var selpassword = data.field.rememberMe;
					if(username == ''){
						$('#errorMsg').html('用户名不能为空!');
						return false;
					}else if(password == ''){
						$('#errorMsg').html('密码不能为空!');
						return false;
					}
					$.ajax({
						type: "post",
						url: "../../admin/adminLogin",
						async: false, //_config.async,
						dataType: 'json',
						data:{
							'loginType':'login',
							'username':username,
							'password':password
						},
						success: function(data, status, xhr) {
							if(data.result==1){
								if(data.reason==1){
									if(selpassword=='true'){
										SetCookie("userName",username,7);
										SetCookie("password",password,7);
									}else{
										delCookie("userName");
										delCookie("password");
									}
									//var url = data.beforeUrl;
									location.href='../../admin/index';
								}else if(data.reason==-1001){
									$('#errorMsg').html('用户名错误!');
								}else if(data.reason==-1002){
									$('#errorMsg').html('密码错误!');
								}
							}else{
								$('#errorMsg').html('系统错误!');
							}
						}
					});
					return false;
				});
			});
			
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
			    if(cval!=null)
			    	SetCookie(name,null,exp.toGMTString());
			       // document.cookie = name + "="+ escape (cval) + ";expires="+exp.toGMTString();
			}

			  
			/**实现功能，保存用户的登录信息到cookie中。当登录页面被打开时，就查询cookie**/  
			window.onload = function(){  
			    var userNameValue = getCookie("userName");  
			    var userPassValue = getCookie("password");  
			    if(userNameValue!=null&&userPassValue!=null&&userNameValue!='null'){
				    document.getElementById("userName").value = userNameValue;  
				    document.getElementById("password").value = userPassValue; 
			    }
			}  
		</script>
	</body>

</html>