package com.gh.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.gh.dto.PublishForm;
import com.gh.model.Content;
import com.gh.service.IBaseService;
import com.gh.service.IContentService;
import com.gh.util.PageList;

@Controller
@RequestMapping("/")
public class ContentIndexController extends BaseControllerSupport{

	@Resource
	private IContentService contentSerivce;
	@Resource
	private IBaseService<Content> baseContentService;
	
	
	@RequestMapping(value="/contentlist")
	public String contentlist(PublishForm publishForm,HttpServletRequest request){
		try {
			publishForm.setPageCount(8);
			PageList<Content> clist = contentSerivce.getContentList(publishForm);
			request.setAttribute("contentPage", clist);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/contentlist";
	} 
	
	@RequestMapping(value="/contentdetails")
	public String contentdetails(HttpServletRequest request){
		try {
			String cid = request.getParameter("cid");
			Content content = baseContentService.getById(Content.class, Long.parseLong(cid));
			request.setAttribute("content", content);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/contentdetails";
	} 
	
}
