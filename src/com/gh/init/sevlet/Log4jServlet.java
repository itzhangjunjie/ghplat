package com.gh.init.sevlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import org.apache.log4j.PropertyConfigurator;

public class Log4jServlet extends HttpServlet {

	private static final long serialVersionUID = 7202309430398667280L;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		initLogConfig(config);

	}

	private void initLogConfig(ServletConfig config) {
		String prifix = getServletContext().getRealPath("/");

		String Log4jFile = config.getInitParameter("Log4jFile");
		String filePath =prifix +  Log4jFile ;
		 System.out.println(filePath);
		PropertyConfigurator.configure(filePath);
		Properties props = new Properties();
		try {
			String Log4jFileSavePath = config
					.getInitParameter("Log4jFileSavePath");
			FileInputStream log4jStream = new FileInputStream(filePath);
			props.load(log4jStream);
			log4jStream.close();
			String logFile = prifix + Log4jFileSavePath + File.separator
					+ "error.jsp";
			 System.out.println(logFile);
			 logFile="E:/log/error.log";
			props.setProperty("log4j.appender.AFile.File", logFile);
			PropertyConfigurator.configure(props); 
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
