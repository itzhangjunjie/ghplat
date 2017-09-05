package com.gh.util;

import java.util.Properties;  
import javax.mail.Session;  
import javax.mail.Transport;  
import javax.mail.internet.InternetAddress;  
import javax.mail.internet.MimeMessage;  
  
public class EmailSend {  
	
	
	public static void main(String[] args) {
		try {
			sendMail("我是标题!","我是内容。。。");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void sendMail(String title,String content) throws Exception {
		// 发件人的邮箱和密码
		String myEmailAccount = "zmt@ghplat.com";
		String myEmailPassword = "GouHua2016";
		// 发件人邮箱的SMTP服务器地址
		String myEmailSMTPHost = "smtp.exmail.qq.com";
		// 收件人邮箱
		String receiveMailAccount = "kenney@ghplat.com";

		// 参数配置
		Properties props = new Properties();
		// 使用的协议（JavaMail规范要求）
		props.setProperty("mail.transport.protocol", "smtp");
		// 发件人的邮箱的 SMTP 服务器地址
		props.setProperty("mail.smtp.host", myEmailSMTPHost);
		// 需要请求认证
		props.setProperty("mail.smtp.auth", "true");
		String smtpPort = "465";
		props.setProperty("mail.smtp.port", smtpPort);
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.setProperty("mail.smtp.socketFactory.fallback", "false");
		props.setProperty("mail.smtp.socketFactory.port", smtpPort);
		Session session = Session.getDefaultInstance(props);
		MimeMessage message = createMimeMessage(session, myEmailAccount, receiveMailAccount,title,content);
		Transport transport = session.getTransport();
		transport.connect(myEmailAccount, myEmailPassword);
		transport.sendMessage(message, message.getAllRecipients());
		transport.close();
	}
	
	public static MimeMessage createMimeMessage(Session session, String sendMail, String receiveMail,String title,String content) throws Exception {
    	// 创建一封邮件
    	MimeMessage message = new MimeMessage(session);
    	// 发件人
    	message.setFrom(new InternetAddress(sendMail, "勾画互动", "UTF-8"));
    	// 收件人（可以增加多个收件人、抄送、密送）
    	message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "勾画自媒体", "UTF-8"));
    	// 邮件主题
    	message.setSubject(title, "UTF-8");
   	 	// 邮件正文（可以使用html标签）
   	 	message.setContent(content, "text/html;charset=UTF-8");
    	// 设置发件时间
    	message.setSentDate(new java.util.Date());
    	// 保存设置
    	message.saveChanges();

    	return message;
	}
}  

