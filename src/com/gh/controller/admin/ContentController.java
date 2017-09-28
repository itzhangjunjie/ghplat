package com.gh.controller.admin;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gh.controller.BaseControllerSupport;
import com.gh.dto.PublishForm;
import com.gh.dto.PublishTypeDTO;
import com.gh.model.Content;
import com.gh.model.Publish;
import com.gh.service.IBaseService;
import com.gh.service.IContentService;
import com.gh.service.IPublishService;
import com.gh.util.FileUtil;
import com.gh.util.PageList;

@Controller
@RequestMapping("/admin")
public class ContentController extends BaseControllerSupport{

	@Resource
	private IPublishService publishService;
	
	@RequestMapping(value="/updateContentOne",method=RequestMethod.GET)
	public String updateContentOne(HttpServletRequest request){
		try {
			String cid = request.getParameter("cid");
			Content content = baseContentService.getById(Content.class, Long.parseLong(cid));
			request.setAttribute("content", content);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/contentupdate";
	}
	
	@RequestMapping(value="/contentadd",method=RequestMethod.GET)
	public String persionad(HttpServletRequest request){
		try {
			List<PublishTypeDTO> ptdto = publishService.getPublishType();
			request.setAttribute("ptdto", ptdto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/contentadd";
	}
	
	@Resource
	private IBaseService<Content> baseContentService;
	
	@Resource
	private IContentService contentSerivce;
	
	@RequestMapping(value="/contentlist")
	public String contentlist(PublishForm publishForm,HttpServletRequest request){
		try {
			PageList<Content> clist = contentSerivce.getContentList(publishForm);
			request.setAttribute("contentPage", clist);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/contentlist";
	} 
	
	@RequestMapping(value="/updateContent",method=RequestMethod.POST)
	public @ResponseBody String updateContent(@RequestParam(value="fileContent",required=false) MultipartFile file,HttpServletRequest request){
		jsonObject.clear();
		try {
			System.out.println("///"+request.getParameter("dataobj"));
			String title = request.getParameter("title");
			String author = request.getParameter("author");
			String type = request.getParameter("type");
			String publishId = request.getParameter("publishId");
			String contentStr = request.getParameter("content");
			System.out.println(contentStr+"...");
			String cid = request.getParameter("cid");
			Content content = new Content();
			content.setId(Long.parseLong(cid));
			if(publishId!=null&&!"".equals(publishId)){
				Publish publish  = new Publish();
				publish.setId(Long.parseLong(publishId));
				content.setPublish(publish);
			}
			if(file!=null){
				if (FileUtil.isAllowUp(file.getOriginalFilename())) {
					String pcImageName = uploadImage(file, file.getOriginalFilename(), request.getSession().getServletContext().getRealPath("/attachment")+"/"+"content");
					content.setImage(pcImageName);
				}else{
					String contentImage = request.getParameter("image");
					content.setImage(contentImage);
				}
			}else{
				String contentImage = request.getParameter("image");
				content.setImage(contentImage);
			}
			content.setTitle(title);
			content.setAuthor(author);
			content.setType(type);
			content.setStatus(0);
			content.setContent(contentStr);
			content.setCreateTime(new Date());
			baseContentService.update(content);
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/saveContent",method=RequestMethod.POST)
	public @ResponseBody String saveContent(@RequestParam("file") MultipartFile file,HttpServletRequest request){
		jsonObject.clear();
		try {
			String title = request.getParameter("title");
			String author = request.getParameter("author");
			String type = request.getParameter("type");
			String publishId = request.getParameter("publishId");
			String contentStr = request.getParameter("content");
			Content content = new Content();
			if(publishId!=null&&!"".equals(publishId)){
				Publish publish  = new Publish();
				publish.setId(Long.parseLong(publishId));
				content.setPublish(publish);
			}
			if(file!=null){
				if (FileUtil.isAllowUp(file.getOriginalFilename())) {
					String pcImageName = uploadImage(file, file.getOriginalFilename(), request.getSession().getServletContext().getRealPath("/attachment")+"/"+"content");
					content.setImage(pcImageName);
					content.setTitle(title);
					content.setAuthor(author);
					content.setType(type);
					content.setStatus(0);
					content.setContent(contentStr);
					content.setCreateTime(new Date());
					baseContentService.save(content);
					jsonObject.put("result", "yes");
				}
			}else{
				jsonObject.put("result", "no");
			}
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/mdContent",method=RequestMethod.POST)
	public @ResponseBody String mdContent(HttpServletRequest request){
		jsonObject.clear();
		try {
			String cid = request.getParameter("cid");
			String status = request.getParameter("status");
			contentSerivce.updateContent(Long.parseLong(cid),status);
			jsonObject.put("result", "yes");
		}catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
}
