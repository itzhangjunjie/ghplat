package com.gh.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.gh.controller.BaseControllerSupport;
import com.gh.model.AdminUser;
import com.gh.service.IBaseService;
@Controller
@RequestMapping("/admin")
public class AdminUserController extends BaseControllerSupport{

	@Resource
	private IBaseService<AdminUser> baseService;
	
	@RequestMapping(value="/adminLogin",method=RequestMethod.POST)
	public @ResponseBody String adminLogin(HttpServletRequest request){
		try {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("username", username);
			AdminUser adminUser = baseService.findObjByProperty(AdminUser.class, map);
			if(adminUser!=null){
				if(password.equals(adminUser.getPassword())){
					request.getSession().setAttribute("adminUser", adminUser);
					jsonObject.put("reason", "1");//用户名和密码正确
					String url = (request.getSession().getAttribute("beforeAdminUrl")==null)?"/admin/index.html":(String)request.getSession().getAttribute("beforeAdminUrl");
					jsonObject.put("beforeUrl", url);
				}else{
					jsonObject.put("reason", "-1002");//密码错误
				}
			}else{
				jsonObject.put("reason", "-1001");//用户名错误
			}
			jsonObject.put("result", "1");//接口正常
		} catch (Exception e) {
			jsonObject.put("result", "-1");//系统错误
			e.printStackTrace();
			logger.error("后台登录错误！");
		} 
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/outLogin",method=RequestMethod.GET)
	public String outLogin(HttpServletRequest request){
		request.getSession().invalidate();
		return "/admin/login";
	}
	
}
