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
import com.gh.dto.PublishForm;
import com.gh.model.AdminUser;
import com.gh.model.Advertiser;
import com.gh.model.Media;
import com.gh.model.Order;
import com.gh.service.IBaseService;
import com.gh.service.IUserService;
import com.gh.util.PageList;
@Controller
@RequestMapping("/admin")
public class AdminUserController extends BaseControllerSupport{

	@Resource
	private IBaseService<AdminUser> baseService;
	@Resource
	private IUserService userService;
	
	@RequestMapping(value="/updateUserFlag")
	public @ResponseBody String updateUserFlag(HttpServletRequest request){
		try {
			long userid = Long.parseLong(request.getParameter("mediaid"));
			String userflag = request.getParameter("userflag");
			int type = Integer.parseInt(request.getParameter("type"));
			userService.updateUserFlag(userid,userflag,type);
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		} 
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/usermedialist")
	public String usermedialist(PublishForm publishForm,HttpServletRequest request){
		try {
			PageList<Media> resultPage =userService.getUserlist(publishForm);
			request.setAttribute("medialist", resultPage);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("后台登录错误！");
		} 
		return "/admin/medialist";
	}
	@RequestMapping(value="/useradlist")
	public String useradlist(PublishForm publishForm,HttpServletRequest request){
		try {
			PageList<Advertiser> resultPage =userService.getUserAdlist(publishForm);
			request.setAttribute("adlist", resultPage);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("后台登录错误！");
		} 
		return "/admin/adlist";
	}
	
	@RequestMapping(value="/login")
	public String login(HttpServletRequest request){
		System.out.println("testse");
		return "/admin/logino";
	}
	
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request){
		return "/admin/indexo";
	}
	
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
					//BaseControllerSupport.logger.error(request.getSession().getId()+"......save");
					request.getSession().setAttribute("adminUser", adminUser);
					jsonObject.put("reason", "1");//用户名和密码正确
					//System.out.println(request.getSession().getAttribute("beforeAdminUrl"));
					String url = (request.getSession().getAttribute("beforeAdminUrl")==null)?"/admin/index":(String)request.getSession().getAttribute("beforeAdminUrl");
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
