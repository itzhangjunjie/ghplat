package com.gh.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gh.dto.CartListDTO;
import com.gh.dto.CaseDTO;
import com.gh.dto.PublishForm;
import com.gh.dto.PublishTypeDTO;
import com.gh.dto.Top10;
import com.gh.model.Case;
import com.gh.model.CaseDetails;
import com.gh.model.CaseImage;
import com.gh.model.Media;
import com.gh.model.Publish;
import com.gh.model.PublishArea;
import com.gh.model.WeiXinDetails;
import com.gh.service.IBaseService;
import com.gh.service.IPublishService;
import com.gh.util.DateUtil;
import com.gh.util.FileUtil;
import com.gh.util.ImageMagicTools;
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
	@Resource
	private IBaseService<Case> baseCaseService;
	
	
	@RequestMapping(value = "/getCartList", method = {RequestMethod.POST})
	public @ResponseBody String getCartList(HttpServletRequest request){
		jsonObject.clear();
		try {
			String ids = request.getParameter("pIds");
			List<Publish> publishlist = publishService.getCartList(ids);
			jsonObject.put("publishList", JSONArray.fromObject(publishlist,jsonConfig));
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	
	@RequestMapping(value = "/getPublish", method = {RequestMethod.GET})
	public String getPublish(HttpServletRequest request){
		try {
			List<PublishTypeDTO> ptdto = publishService.getPublishType();
			request.setAttribute("ptdto", ptdto);
			List<PublishArea> publishAreaList = publishService.getPublishAreaList();
			request.setAttribute("publishArea", publishAreaList);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/front/publish";
	}
	
	
	@RequestMapping(value = "/addCase", method = {RequestMethod.GET})
	public String addPublish(HttpServletRequest request){
		try {
			Media media = (Media)request.getSession().getAttribute("user");
			if(media==null){
				return "redirect:/index";
			}else{
				List<PublishTypeDTO> ptdto = publishService.getPublishAdd();
				List<PublishArea> publishAreaList = publishService.getPublishAreaList();
				request.setAttribute("ptdto", ptdto);
				request.setAttribute("publishArea", publishAreaList);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/front/caseadd";
	}
	
	@RequestMapping(value = "/saveCase", method = {RequestMethod.POST})
	public @ResponseBody String addCase(HttpServletRequest request,String imageArray,String publishArray,Case caseObj){
		try {
			jsonObject.clear();
			Media media = (Media)request.getSession().getAttribute("user");
			if(media==null){
				jsonObject.put("result", "no");
				jsonObject.put("reason", "nologin");
			}else{
				String beforeUrl = request.getSession().getServletContext().getRealPath("/attachment");
				caseObj.setMedia_id(media.getId());
				if(caseObj.getImage()==null){
					jsonObject.put("result", "no");
					jsonObject.put("reason", "noImage");
				}else{
					String srcImage = caseObj.getImage().replace("/ghplat/attachment/temp", "").replace("/ghplat/attachment/caseImage", "");
					FileUtil.copyFile(beforeUrl+"/temp"+srcImage, beforeUrl+"/caseImage"+srcImage);
					FileUtil.delete(beforeUrl+"/temp"+srcImage);
					caseObj.setImage("/caseImage"+srcImage);
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
	
	@RequestMapping(value = "/updateCase", method = {RequestMethod.POST})
	public @ResponseBody String updateCase(HttpServletRequest request,String imageArray,String publishArray,Case caseObj){
		try {
			jsonObject.clear();
			Media media = (Media)request.getSession().getAttribute("user");
			if(media==null){
				jsonObject.put("result", "no");
				jsonObject.put("reason", "nologin");
			}else{
				String beforeUrl = request.getSession().getServletContext().getRealPath("/attachment");
				publishService.updateCase(caseObj,imageArray,publishArray,beforeUrl);
				jsonObject.put("result", "yes");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/deleteCase", method = {RequestMethod.POST})
	public @ResponseBody String deleteCase(HttpServletRequest request){
		try {
			jsonObject.clear();
			Media media = (Media)request.getSession().getAttribute("user");
			if(media==null){
				jsonObject.put("result", "no");
				jsonObject.put("reason", "nologin");
			}else{
				Long case_id = Long.parseLong(request.getParameter("case_id"));
				publishService.delete(case_id);
				jsonObject.put("result", "yes");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/deletePublish", method = {RequestMethod.POST})
	public @ResponseBody String deletePublish(HttpServletRequest request,Publish publish){
		try {
			jsonObject.clear();
			Media media = (Media)request.getSession().getAttribute("user");
			if(media==null){
				jsonObject.put("result", "no");
				jsonObject.put("reason", "nologin");
			}else{
				publish.setPublishStatus("-1");
				publishService.deletePublish(publish.getId());
				jsonObject.put("result", "yes");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/updatePublish", method = {RequestMethod.POST})
	public @ResponseBody String updatePublish(HttpServletRequest request,Publish publish,String infoArray,String priceArray,String article_MyPhoto){
		try {
			jsonObject.clear();
			Media media = (Media)request.getSession().getAttribute("user");
			if(media==null){
				jsonObject.put("result", "no");
				jsonObject.put("reason", "nologin");
			}else{
				
				publish.setMediaId(media.getId());
				publish.setLastViewedTime(new Date());
				publish.setPublishTime(new Date());
				publish.setGhid(UUID.randomUUID().toString().replace("-", ""));
				if(publish.getImage()==null){
					jsonObject.put("result", "no");
					jsonObject.put("reason", "noImage");
				}else{
					String srcImage = publish.getImage().replace("/ghplat/attachment/temp", "").replace("/ghplat/attachment/publish", "");
					String beforeUrl = request.getSession().getServletContext().getRealPath("/attachment");
					//FileUtil.copyFile(beforeUrl+"/temp"+srcImage, beforeUrl+"/publish"+srcImage);
					//FileUtil.delete(beforeUrl+"/temp"+srcImage);
					//publish.setImage("/publish"+srcImage);
					if(publish.getImage().indexOf("/temp")>=0){
						cutImage(article_MyPhoto,beforeUrl+"/temp"+srcImage,beforeUrl+"/publish"+srcImage);
					}else{
						cutImage(article_MyPhoto,beforeUrl+"/publish"+srcImage,beforeUrl+"/publish"+srcImage);
					}
					publish.setImage("/publish"+srcImage);
				}
				publish.setPublishStatus("1");
				StringUtil.setPublishInfo(publish, infoArray);
				StringUtil.setPublishPrice(publish, priceArray);
				String picon = publishService.getPlatformDetailsByName(publish.getPlatformName()).getPlatformIcon();
				publish.setPlatformIcon(picon);
				baseService.update(publish);
				jsonObject.put("result", "yes");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/savePublish", method = {RequestMethod.POST})
	public @ResponseBody String savePublish(HttpServletRequest request,Publish publish,String infoArray,String priceArray,String article_MyPhoto){
		try {
			jsonObject.clear();
			Media media = (Media)request.getSession().getAttribute("user");
			if(media==null){
				jsonObject.put("result", "no");
				jsonObject.put("reason", "nologin");
			}else{
				publish.setMediaId(media.getId());
				publish.setPublishTime(new Date());
				publish.setGhid(UUID.randomUUID().toString().replace("-", ""));
				if(publish.getImage()==null){
					jsonObject.put("result", "no");
					jsonObject.put("reason", "noImage");
				}else{
					String srcImage = publish.getImage().replace("/ghplat/attachment/temp", "");
					String beforeUrl = request.getSession().getServletContext().getRealPath("/attachment");
					//FileUtil.copyFile(beforeUrl+"/temp"+srcImage, beforeUrl+"/publish"+srcImage);
					//FileUtil.delete(beforeUrl+"/temp"+srcImage);
					cutImage(article_MyPhoto,beforeUrl+"/temp"+srcImage,beforeUrl+"/publish"+srcImage);
					publish.setImage("/publish"+srcImage);
				}
				publish.setPublishStatus("1");
				StringUtil.setPublishInfo(publish, infoArray);
				StringUtil.setPublishPrice(publish, priceArray);
				String picon = publishService.getPlatformDetailsByName(publish.getPlatformName()).getPlatformIcon();
				publish.setPlatformIcon(picon);
				baseService.save(publish);
				jsonObject.put("result", "yes");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	public static void cutImage(String article_MyPhoto,String oldImage,String newImage){
		JSONObject obj = JSONObject.fromObject(article_MyPhoto);
		int top = 0;
		int left = 0;
		int width = 300;
		int height = 300;
		int showWidth = 300;
		if(obj.containsKey("y")&&obj.containsKey("x")&&obj.containsKey("width")
				&&obj.containsKey("height")&&obj.containsKey("showWidth")){
			 top = (int) Double.parseDouble(obj.getString("y"));
			 left = (int) Double.parseDouble(obj.getString("x"));
			 width = (int) Double.parseDouble(obj.getString("width"));
			 height = (int) Double.parseDouble(obj.getString("height"));
			 showWidth = (int) Double.parseDouble(obj.getString("showWidth"));
			 try {
				ImageMagicTools.saveImage(new java.io.File(oldImage), newImage, top, left, width, height, showWidth,160);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping(value = "/caselist", method = {RequestMethod.GET})
	public String caselist(PublishForm publishForm,HttpServletRequest request){
		try {
			long publishId = Long.parseLong(request.getParameter("publishId"));
			publishForm.setPublishId(publishId);
			if(request.getSession().getAttribute("user")!=null){
				Media media = (Media)request.getSession().getAttribute("user");
				publishForm.setMediaId(media.getId());
			}
			PageList<CaseDetails> caseList = publishService.getCaseList(publishForm);
			request.setAttribute("caseList", caseList);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/front/case";
	}
	
	@RequestMapping(value = "/getPublishStr", method = {RequestMethod.POST})
	public @ResponseBody String getPublishStr(PublishForm publishForm,HttpServletRequest request){
		try {
			jsonObject.clear();
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

	@RequestMapping(value = "/getCaseStr", method = {RequestMethod.POST})
	public @ResponseBody String getCaseStr(PublishForm publishForm,HttpServletRequest request){
		try {
			jsonObject.clear();
			publishForm.setPublishStatus("1");
			PageList<Case> resultPage = publishService.getCaseStr(publishForm);
			jsonObject.put("result", "yes");
			JSONArray ja = new JSONArray();
			for(Case cs:resultPage.getList()){
				ja.add(JSONObject.fromObject(cs,jsonConfig));
			}
			jsonObject.put("datas", ja);
			jsonObject.put("pageSize", publishForm.getPageSize());
			jsonObject.put("pageCount", resultPage.getTotal());
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	@RequestMapping(value = "/getPublishDetails", method = {RequestMethod.GET})
	public String getPublishDetails(HttpServletRequest request){
		try {
			String publishghid = request.getParameter("pghid");
			Publish pdetails = publishService.getpublishDetails(publishghid);
			if("0001".equals(pdetails.getPublishTypeObj().getPublishFieldId())){
				WeiXinDetails wxdetails = publishService.getWxDetails(pdetails.getInfo01());
				setTop10ByWxDetails(wxdetails,pdetails.getPublishName());
				request.setAttribute("wxdetails", wxdetails);
			}
			request.setAttribute("pdetails", pdetails);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/publishDetails";
	}
	
	public static void setTop10ByWxDetails(WeiXinDetails wxdetails,String name){
		if(wxdetails==null||wxdetails.getCol8()==null||wxdetails.getCol9()==null||wxdetails.getCol10()==null){
			return ;
		}
		String[] titles = wxdetails.getCol8().split(";");
		String[] urls = wxdetails.getCol9().split(";");
		String[] createTime = wxdetails.getCol10().split(";");
		String[] viewCounts = wxdetails.getCol11().split(";");
		List<Top10> top10List = new ArrayList<Top10>();
		int ll = 10;
		if(titles.length<10){
			ll = titles.length;
		}
		for(int i=0;i<ll;i++){
			Top10 top = new Top10();
			top.setTitle(titles[i]);
			top.setViewCount(viewCounts[i]);
			top.setName(name);
			top.setUrl(urls[i].replace("\\", ""));
			top.setCreateTime(DateUtil.getShowDate(new Date(Long.parseLong(createTime[i])*1000L)));
			top10List.add(top);
		}
		wxdetails.setTop10list(top10List);
	}
}
