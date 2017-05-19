package com.gh.util;

public class SendMessageUtil {

	private static String account="N3572971"; // 发送短信的账号(非登录账号) (示例:N987654) 
	private static String pswd="PorpmC3geF0390";// 发送短信的密码(非登录密码)
	
	//发送验证码
	public static void sendMessage(String message,String mobile){
		try {
			String url = "http://sms.253.com/msg/send";  //应用地址 (无特殊情况时无需修改)
			//String msg = "【勾画科技】你正在找回密码，验证码："+ message; //您的签名+短信内容 
			String extno = null;     	// 扩展码(可选参数,可自定义)
			//String phone="17602145918"  //短信接收号码,多个号码用英文,隔开
			String rd="1";				// 是否需要状态报告(需要:1,不需要:0)
		    System.out.println(HttpSender.SendPost(url,account, pswd,message,mobile,rd,extno)); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		sendMessage("【勾画科技】1230", "17602145918");
	}
	
}
