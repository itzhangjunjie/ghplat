package com.gh.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.gh.controller.BaseControllerSupport;
import com.gh.model.IndexBanner;
import com.gh.service.IBaseService;
import com.gh.service.IIndexBannerService;
import com.gh.util.FileUtil;
import com.gh.util.PageList;
@Controller
@RequestMapping("/admin")
public class BannerController extends BaseControllerSupport{
	
	
	@RequestMapping(value="/banneradd",method=RequestMethod.GET)
	public String banneradd(){
		return "/admin/banneradd";
	}
	
	
	@Resource
	private IIndexBannerService bannerService;
	@Resource
	private IBaseService<IndexBanner> baseService;
	
	@RequestMapping(value="/bannerAdd",method=RequestMethod.GET)
	public String bannerAdd(){
		return "/admin/banneradd";
	}
	
	@RequestMapping(value="/addBanner",method=RequestMethod.POST)
	public String addBanner(HttpServletRequest request,MultipartFile pcImageFile,IndexBanner banner){
		try {
			if(pcImageFile!=null){
				if (FileUtil.isAllowUp(pcImageFile.getOriginalFilename())) {
					String pcImageName = uploadImage(pcImageFile, pcImageFile.getOriginalFilename(), request.getSession().getServletContext().getRealPath("/attachment")+"/"+"banner");
					banner.setImage(pcImageName);
					banner.setCreateTime(new Date());
					banner.setStatus(1);
					baseService.save(banner);
				}else{
					String pid = request.getParameter("pid");
					banner.setUrl(pid);
					banner.setCreateTime(new Date());
					banner.setStatus(1);
					baseService.save(banner);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("保存Banner失败!");
		}
		return "redirect:bannerlist";
	}
	
	@RequestMapping(value="/updateBanner",method=RequestMethod.POST)
	public String updateBanner(HttpServletRequest request,MultipartFile pcImageFile,MultipartFile mbImageFile,
			IndexBanner banner){
		try {
			IndexBanner cbanner = baseService.loadById(IndexBanner.class, banner.getIndexBannerId());
			if(pcImageFile!=null){
				if (FileUtil.isAllowUp(pcImageFile.getOriginalFilename())) {
					String pcImageName = uploadImage(pcImageFile, pcImageFile.getOriginalFilename(), request.getSession().getServletContext().getRealPath("/attachment")+"/"+"banner");
					FileUtil.delete(request.getSession().getServletContext().getRealPath("/attachment")+"/"+"banner/"+cbanner.getImage());
					cbanner.setImage(pcImageName);
				}
			}
			cbanner.setTitle(banner.getTitle());
			cbanner.setPosition(banner.getPosition());
			cbanner.setUrl(banner.getUrl());
			cbanner.setType(banner.getType());
			cbanner.setModule(banner.getModule());
			cbanner.setCreateTime(new Date());
			baseService.update(cbanner);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("更新Banner失败!");
		}
		return "redirect:bannerlist";
	}
	
	@RequestMapping(value="/bannerDetails",method=RequestMethod.GET)
	public String bannerDetails(HttpServletRequest request){
		try {
			long bid = Long.parseLong(request.getParameter("bannerid"));
			IndexBanner banner = baseService.getById(IndexBanner.class, bid);
			request.setAttribute("bannerDetails", banner);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("获取banner详情失败!");
		}
		return "/admin/bannerupdate";
	}
	
	@RequestMapping(value="/bannerlist")
	public String bannerlist(HttpServletRequest request){
		try {
			int status = Integer.parseInt((request.getParameter("status")==null)?"1":request.getParameter("status"));
			String module = request.getParameter("module");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("status", status);
			map.put("module", module);
			String pstr = request.getParameter("pageSize");
			if(pstr==null){
				page.setPage(1);
			}else{
				page.setPage(Integer.parseInt(pstr));
			}
			PageList<IndexBanner> banners = bannerService.getBannerList(map,page);
			request.setAttribute("bannerlist", banners);
			request.setAttribute("module", module);
			request.setAttribute("status", status);
			request.setAttribute("pageSize", page.getPage());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("获取banner列表失败!");
		}
		return "/admin/bannerlist";
	}
	
	
	@RequestMapping(value="/deleteBanner",method=RequestMethod.GET)
	public  String deleteBanner(HttpServletRequest request){
		try {
			long bid = Long.parseLong(request.getParameter("bannerid"));
			baseService.delete(IndexBanner.class, bid);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("删除Banner失败!");
		}
		return "redirect:bannerlist";
	}
	
}
