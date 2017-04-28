package com.gh.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gh.model.IndexBanner;
import com.gh.service.IBaseService;
import com.gh.service.IIndexBannerService;
import com.gh.util.PageList;

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
			System.out.println("hezuos:"+hezuos.getList().size());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("获取banner列表失败!");
		}
		return "/front/index";
	}
	
}
