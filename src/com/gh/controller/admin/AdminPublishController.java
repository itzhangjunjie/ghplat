package com.gh.controller.admin;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gh.controller.BaseControllerSupport;
import com.gh.dto.PublishForm;
import com.gh.dto.PublishTypeDTO;
import com.gh.model.Media;
import com.gh.model.Publish;
import com.gh.model.PublishArea;
import com.gh.model.PublishPlatform;
import com.gh.service.IBaseService;
import com.gh.service.IPublishService;
import com.gh.util.FileUtil;
import com.gh.util.PageList;
import com.gh.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
@Controller
@RequestMapping("/admin")
public class AdminPublishController extends BaseControllerSupport{

	@Resource
	private IPublishService publishService;
	
	@RequestMapping(value="/platformadd")
	public String platformadd(HttpServletRequest request){
		try {
			List<PublishTypeDTO> ptdto = publishService.getPublishType();
			request.setAttribute("ptdto", ptdto);
		}catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return "/admin/platformadd";
	}
	
	@RequestMapping(value="/addPlatform")
	public String addPlatform(HttpServletRequest request,MultipartFile platformiconfile){
		try {
			String platformname = request.getParameter("platformname");
			String publishtype = request.getParameter("publishtype");
			String platformicon = null;
			if(platformiconfile!=null){
				if (FileUtil.isAllowUp(platformiconfile.getOriginalFilename())) {
					platformicon = uploadImage(platformiconfile, platformiconfile.getOriginalFilename(), request.getSession().getServletContext().getRealPath("/attachment")+"/"+"platform");
				}
			}
			publishService.addPlatform(platformicon,platformname,publishtype);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:platformlist";
	}
	
	@RequestMapping(value="/updatePlatformDetails")
	public String updatePlatformDetails(HttpServletRequest request,MultipartFile platformiconfile){
		try {
			String pfid = request.getParameter("pfid");
			String platformname = request.getParameter("platformname");
			String publishtype = request.getParameter("publishtype");
			String platformicon = null;
			if(platformiconfile!=null){
				if (FileUtil.isAllowUp(platformiconfile.getOriginalFilename())) {
					platformicon = uploadImage(platformiconfile, platformiconfile.getOriginalFilename(), request.getSession().getServletContext().getRealPath("/attachment")+"/"+"platform");
				}
			}
			publishService.updatePlatformDetailss(pfid,platformicon,platformname,publishtype);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:platformlist";
	}
	
	@RequestMapping(value="/delPlatformDetails")
	public @ResponseBody String delPlatformDetails(HttpServletRequest request){
		try {
			String pfid = request.getParameter("pfid");
			publishService.delPlatformDetails(pfid);
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	@RequestMapping(value="/getPlatformDetails")
	public String getPlatformDetails(HttpServletRequest request){
		try {
			String pfid = request.getParameter("pfid");
			PublishPlatform ppf = publishService.getPlatformDetails(pfid);
			request.setAttribute("platform", ppf);
			List<PublishTypeDTO> ptdto = publishService.getPublishType();
			request.setAttribute("ptdto", ptdto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/platformupdate";
	}
	@RequestMapping(value="/platformlist")
	public String platformlist(PublishForm publishForm,HttpServletRequest request){
		try {
			List<PublishPlatform> resultPage = publishService.getPlatFormList(publishForm);
			request.setAttribute("platformList", resultPage);
			List<PublishTypeDTO> ptdto = publishService.getPublishType();
			request.setAttribute("ptdto", ptdto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/platformlist";
	}
	
	@RequestMapping(value="/meitiList")
	public String meitiList(PublishForm publishForm,HttpServletRequest request){
		try {
			PageList<Publish> resultPage = publishService.getPublishStr(publishForm);
			request.setAttribute("publishListPage", resultPage);
			List<PublishTypeDTO> ptdto = publishService.getPublishType();
			request.setAttribute("ptdto", ptdto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/meitiList";
	}
	
	@RequestMapping(value="/meitiupdate")
	public String meitiupdate(HttpServletRequest request){
		try {
			
			List<PublishTypeDTO> ptdto = publishService.getPublishAdd();
			List<PublishArea> publishAreaList = publishService.getPublishAreaList();
			request.setAttribute("ptdto", ptdto);
			request.setAttribute("publishArea", publishAreaList);
			String publishghid = request.getParameter("pghid");
			Publish pdetails = publishService.getpublishDetails(publishghid);
			request.setAttribute("pdetails", pdetails);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/meitiupdate";
	}
	@Resource
	private IBaseService<Publish> baseService;
	
	@RequestMapping(value="/meitidelete")
	public String meitidelete(HttpServletRequest request){
		try {
			String publishghid = request.getParameter("pid");
			publishService.deletePublish(Long.parseLong(publishghid));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:meitiList";
	}
	
	@RequestMapping(value = "/updatePublish", method = {RequestMethod.POST})
	public @ResponseBody String updatePublish(HttpServletRequest request,Publish publish,String infoArray,String priceArray,String infoArrayStr,String priceArrayStr){
		try {
			publish.setLastViewedTime(new Date());
			publish.setPublishTime(new Date());
			publish.setGhid(UUID.randomUUID().toString().replace("-", ""));
			if(publish.getImage()==null){
				jsonObject.put("result", "no");
				jsonObject.put("reason", "noImage");
			}else{
				String srcImage = publish.getImage().replace("/ghplat/attachment/temp", "").replace("/ghplat/attachment/publish", "");
				String beforeUrl = request.getSession().getServletContext().getRealPath("/attachment");
				FileUtil.copyFile(beforeUrl+"/temp"+srcImage, beforeUrl+"/publish"+srcImage);
				FileUtil.delete(beforeUrl+"/temp"+srcImage);
				publish.setImage("/publish"+srcImage);
			}
			publish.setPublishStatus("1");
			if(publish.getMediaId()!=0||publish.getQq()!=null){
				String usql = "update gh_media gm set gm.qq = ? where gm.media_id = ?";
				baseService.executeSql(usql,publish.getQq(),publish.getMediaId());
			}
			if(infoArray!=null){
				StringUtil.setPublishInfo(publish, infoArray);
				StringUtil.setPublishPrice(publish, priceArray);
			}else if(infoArrayStr!=null){
				JSONArray infoarray = JSONArray.fromObject(infoArrayStr);
				 for (Object obj : infoarray) {
			            JSONObject jsonObject = (JSONObject) obj;
			            String ckey = jsonObject.getString("columnKey");
			            String cvalue = jsonObject.getString("columnValue");
			            publishService.updateInfoValue(ckey,cvalue,publish.getId(),publish);
				 }
				 JSONArray pricearray = JSONArray.fromObject(priceArrayStr);
				 for (Object obj : pricearray) {
			            JSONObject jsonObject = (JSONObject) obj;
			            String ckey = jsonObject.getString("columnKey");
			            String cvalue = jsonObject.getString("columnValue");
			            publishService.updatePriceValue(ckey,cvalue,publish.getId(),publish);
				 }
			}
			baseService.update(publish);
			jsonObject.put("result", "yes");
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
}
