package com.gh.controller;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gh.dto.CaseDTO;
import com.gh.dto.PublishForm;
import com.gh.dto.PublishTypeDTO;
import com.gh.model.Case;
import com.gh.model.CaseDetails;
import com.gh.model.CaseImage;
import com.gh.model.Media;
import com.gh.model.Publish;
import com.gh.service.IBaseService;
import com.gh.service.IPublishService;
import com.gh.util.FileUtil;
import com.gh.util.PageList;
import com.gh.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/")
public class PublishController extends BaseControllerSupport{

	@Resource
	private IPublishService publishService;
	@Resource
	private IBaseService<Publish> baseService;
	
	@RequestMapping(value = "/getPublish", method = {RequestMethod.GET})
	public String getPublish(HttpServletRequest request){
		try {
			List<PublishTypeDTO> ptdto = publishService.getPublishType();
			request.setAttribute("ptdto", ptdto);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/front/publish";
	}
	
	
	@RequestMapping(value = "/addCase", method = {RequestMethod.GET})
	public String addPublish(HttpServletRequest request){
		try {
			List<PublishTypeDTO> ptdto = publishService.getPublishAdd();
			request.setAttribute("ptdto", ptdto);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/front/caseadd";
	}
	
	@RequestMapping(value = "/saveCase", method = {RequestMethod.POST})
	public @ResponseBody String addCase(HttpServletRequest request,String imageArray,String publishArray,Case caseObj){
		try {
			Media media = (Media)request.getSession().getAttribute("user");
			if(media==null){
				jsonObject.put("result", "no");
				jsonObject.put("reason", "nologin");
			}else{
				String beforeUrl = request.getSession().getServletContext().getRealPath("/attachment");
				caseObj.setMedia_id(media.getMediaId());
				if(caseObj.getImage()==null){
					jsonObject.put("result", "no");
					jsonObject.put("reason", "noImage");
				}else{
					String srcImage = caseObj.getImage().replace("/ghplat/attachment/temp", "");
					FileUtil.copyFile(beforeUrl+"/temp"+srcImage, beforeUrl+"/case"+srcImage);
					FileUtil.delete(beforeUrl+"/temp"+srcImage);
					caseObj.setImage("/case"+srcImage);
				}
				caseObj.setCase_publish_time(new Date());
				caseObj.setFollow_count(0);
				caseObj.setCase_status("1");
				caseObj.setGhid(UUID.randomUUID().toString().replace("-", ""));
				publishService.saveCase(caseObj,imageArray,publishArray,beforeUrl);
				jsonObject.put("result", "yes");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/savePublish", method = {RequestMethod.POST})
	public @ResponseBody String savePublish(HttpServletRequest request,Publish publish,String infoArray,String priceArray){
		try {
			Media media = (Media)request.getSession().getAttribute("user");
			if(media==null){
				jsonObject.put("result", "no");
				jsonObject.put("reason", "nologin");
			}else{
				publish.setMediaId(media.getMediaId());
				publish.setPublishTime(new Date());
				publish.setGhid(UUID.randomUUID().toString().replace("-", ""));
				if(publish.getImage()==null){
					jsonObject.put("result", "no");
					jsonObject.put("reason", "noImage");
				}else{
					String srcImage = publish.getImage().replace("/ghplat/attachment/temp", "");
					String beforeUrl = request.getSession().getServletContext().getRealPath("/attachment");
					FileUtil.copyFile(beforeUrl+"/temp"+srcImage, beforeUrl+"/publish"+srcImage);
					FileUtil.delete(beforeUrl+"/temp"+srcImage);
					publish.setImage("/publish"+srcImage);
				}
				publish.setPublishStatus("1");
				StringUtil.setPublishInfo(publish, infoArray);
				StringUtil.setPublishPrice(publish, priceArray);
				baseService.save(publish);
				jsonObject.put("result", "yes");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/caselist", method = {RequestMethod.GET})
	public String caselist(PublishForm publishForm,HttpServletRequest request){
		try {
			Media media = (Media)request.getSession().getAttribute("user");
			if(media==null){
				return "redirect:index";
			}else{
				publishForm.setMediaId(media.getMediaId());
				List<CaseDTO> caseList = publishService.getCaseList(publishForm);
				request.setAttribute("caseList", caseList);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/front/case";
	}
	
	@RequestMapping(value = "/getPublishStr", method = {RequestMethod.POST})
	public @ResponseBody String getPublishStr(PublishForm publishForm,HttpServletRequest request){
		try {
			publishForm.setPublishStatus("1");
			PageList<Publish> resultPage = publishService.getPublishStr(publishForm);
			jsonObject.put("result", "yes");
			JSONArray ja = new JSONArray();
			for(Publish pl:resultPage.getList()){
				ja.add(JSONObject.fromObject(pl,jsonConfig));
			}
			jsonObject.put("datas", ja);
			jsonObject.put("pageSize", publishForm.getPageSize());
			jsonObject.put("pageCount", resultPage.getTotal());
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonObject.toString();
	}

}
