package com.gh.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gh.model.Advertiser;
import com.gh.model.IndexBanner;
import com.gh.model.Media;
import com.gh.service.IBaseService;
import com.gh.service.IIndexBannerService;
import com.gh.service.IUserService;
import com.gh.util.PageList;
import com.gh.util.SendMessageUtil;
import com.gh.util.StringUtil;

@Controller
@RequestMapping("/")
public class IndexController extends BaseControllerSupport{

	@Resource
	private IIndexBannerService bannerService;
	@Resource
	private IBaseService<IndexBanner> baseService;
	
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String index(HttpServletRequest request){
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("status", 1);
			map.put("module", "首页banner");// 首页banner  
			page.setRows(5);
			PageList<IndexBanner> banners = bannerService.getBannerList(map,page);
			System.out.println("banners:"+banners.getList().size());
			request.setAttribute("bannerlist", banners);
			map.put("module", "联合推广资源");// 联合推广资源 
			page.setRows(5);
			PageList<IndexBanner> tuiguangs = bannerService.getBannerList(map,page);
			request.setAttribute("tuiguangs", tuiguangs);
			System.out.println("tuiguangs:"+tuiguangs.getList().size());
			map.put("module", "我们的合作伙伴");// 我们的合作伙伴  
			page.setRows(20);
			PageList<IndexBanner> hezuos = bannerService.getBannerList(map,page);
			request.setAttribute("hezuos", hezuos);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("获取banner列表失败!");
		}
		return "/front/index";
	}
	
	
	@Resource
	private IUserService userService;
	@RequestMapping(value="/sendCodeMsg")
	public @ResponseBody String sendCodeMsg(HttpServletRequest request){
		try {
			jsonObject.clear();
			String mobile = request.getParameter("mobile");
			String type = request.getParameter("type");
			if(mobile!=null){
				if(userService.isExistsMobile(mobile, type)==-1){
					String code = StringUtil.getRandStr(4);
					SendMessageUtil.sendMessage("【勾画科技】你正在注册"+type+"，验证码："+code, mobile);
					//request.getSession().setAttribute("regCode", code);
					jsonObject.put("code", code);
					jsonObject.put("result", "yes");
				}else{
					jsonObject.put("result", "no");
					jsonObject.put("reason", "手机号已存在");
				}
			}else{
				jsonObject.put("result", "no");
				jsonObject.put("reason", "手机号为空");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@Resource
	private IBaseService<Media> baseMediaService;
	@Resource
	private IBaseService<Advertiser> baseAdvertiserService;
	@RequestMapping(value="/register")
	public @ResponseBody String register(HttpServletRequest request){
		try {
			 jsonObject.clear();
			 String mobile = request.getParameter("mobile");
			 String username = request.getParameter("username");
			 String email = request.getParameter("email");
			 String password = request.getParameter("password");
			 String qqweixin = request.getParameter("qqweixin");
			 String companyname = request.getParameter("companyname");
			 String type = request.getParameter("type");
			 if("自媒体".equals(type)){
				 Media media = new Media();
				 media.setMobile(mobile);
				 media.setUsername(username);
				 media.setEmail(email);
				 media.setPassword(StringUtil.md5(password));
				 media.setQq(qqweixin);
				 media.setWechat(qqweixin);
				 media.setStatus("1");
				 media.setUserFlag("00000000000000000000");
				 media.setCorporation_name(companyname);
				 media.setGhid(UUID.randomUUID().toString().replace("-", ""));
				 media.setSignUpTime(new Date());
				 baseMediaService.save(media);
			 }else if("广告主".equals(type)){
				 Advertiser ad = new Advertiser();
				 ad.setMobile(mobile);
				 ad.setUsername(username);
				 ad.setEmail(email);
				 ad.setPassword(StringUtil.md5(password));
				 ad.setQq(qqweixin);
				 ad.setWechat(qqweixin);
				 ad.setStatus("1");
				 ad.setUserFlag("00000000000000000000");
				 ad.setCorporation_name(companyname);
				 ad.setGhid(UUID.randomUUID().toString().replace("-", ""));
				 ad.setSignUpTime(new Date());
				 baseAdvertiserService.save(ad);
			 }
			 jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/login")
	public @ResponseBody String login(HttpServletRequest request){
		try {
			 jsonObject.clear();
			 String mobile = request.getParameter("mobile");
			 String password = request.getParameter("password");
			 String type = request.getParameter("type");
			 if("自媒体".equals(type)){
				 Media media = userService.userMediaLogin(mobile, password);
				 if(media!=null){
					 request.getSession().setAttribute("user", media);
					 request.getSession().setAttribute("type", "自媒体");
					 jsonObject.put("result", "yes");
				 }else{
					 jsonObject.put("result", "no");
				 }
			}else if("广告主".equals(type)){
				Advertiser ad = userService.userAdvertiserLogin(mobile, password);
				if(ad!=null){
					 request.getSession().setAttribute("user", ad);
					 request.getSession().setAttribute("type", "广告主");
					 jsonObject.put("result", "yes");
				 }else{
					 jsonObject.put("result", "no");
				 }
			}
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/exit")
	public @ResponseBody String exit(HttpServletRequest request){
		try {
			 jsonObject.clear();
			request.getSession().removeAttribute("user");
			request.getSession().removeAttribute("type");
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
}
