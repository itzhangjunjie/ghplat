package com.gh.init.filter;

import java.io.IOException;
import java.util.Map;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gh.controller.BaseControllerSupport;
import com.gh.model.AdminUser;


public class LoginFilter implements Filter {

	@Override
	public void destroy() {

	}

	
	public static void main(String[] args) {
		String requestURI="/admin";
		System.out.println((requestURI.indexOf("/admin")>=0 && !(requestURI.contains("adminLogin")||requestURI.contains("uploadImage")))
					&&(!requestURI.contains(".")|| requestURI.indexOf("/admin/index.html")>=0));
	}
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		if(req.getRequestURI().equals("/")){
			chain.doFilter(req, res);
		}else{
			String requestURI = req.getRequestURI();
//			BaseControllerSupport.logger.error(req.getRequestURI()+"----");
			if ((requestURI.indexOf("/admin")>=0 && !canNoLogin(requestURI))
					&&(!requestURI.contains(".")|| requestURI.indexOf("/admin/index.html")>=0)) {
				HttpSession session = req.getSession();
				AdminUser adminuser = (AdminUser) session.getAttribute("adminUser");
				if (adminuser != null) {
					chain.doFilter(req, res);
				} else {
					String beforeAdminUrl = requestURI;
					Map<String, String[]> params = request.getParameterMap();
					String queryString = "";
					for (String key : params.keySet()) {
						String[] values = params.get(key);
						for (int i = 0; i < values.length; i++) {
							String value = values[i];
							queryString += key + "=" + value + "&";
						}
					}
					// 去掉最后一个空格
					if(!"".equals(queryString)){
						queryString = queryString.substring(0, queryString.length() - 1);
						session.setAttribute("beforeAdminUrl", beforeAdminUrl+"?"+queryString);
					}else{
						session.setAttribute("beforeAdminUrl", beforeAdminUrl);
					}
					res.sendRedirect(req.getContextPath() + "/admin/login.html");
				}
			} else {
				chain.doFilter(req, res);
			}
		}

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

	public boolean canNoLogin(String url) {
		if (url.contains("adminLogin")||url.contains("uploadImage")) {
			return true;
		}
		return false;
	}

}
