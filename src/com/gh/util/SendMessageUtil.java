package com.gh.util;

import java.net.InetAddress;
import java.net.NetworkInterface;

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
	
	public static void main2(String[] args) {
		sendMessage("【勾画互动】1230", "17602145918");
		
	}
	/**

	 * @param args

	 * @throws UnknownHostException 

	 * @throws SocketException 

	 */

	public static void main(String[] args) throws Exception{

		// TODO Auto-generated method stub

		

		//得到IP，输出PC-201309011313/122.206.73.83

		InetAddress ia = InetAddress.getLocalHost();

		System.out.println(ia);

		getLocalMac(ia);

	}

	public static String getLocalMac(InetAddress ia) throws Exception {

		// TODO Auto-generated method stub

		//获取网卡，获取地址

		byte[] mac = NetworkInterface.getByInetAddress(ia).getHardwareAddress();

		StringBuffer sb = new StringBuffer("");

		for(int i=0; i<mac.length; i++) {

			if(i!=0) {

				sb.append("-");

			}

			//字节转换为整数

			int temp = mac[i]&0xff;

			String str = Integer.toHexString(temp);

			if(str.length()==1) {

				sb.append("0"+str);

			}else {

				sb.append(str);

			}

		}
		return sb.toString();
	}

	
}
