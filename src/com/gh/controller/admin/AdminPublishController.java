package com.gh.controller.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gh.controller.BaseControllerSupport;
import com.gh.dto.PublishForm;
import com.gh.model.Publish;
import com.gh.service.IPublishService;
import com.gh.util.PageList;
@Controller
@RequestMapping("/admin")
public class AdminPublishController extends BaseControllerSupport{

	@Resource
	private IPublishService publishService;
	
	@RequestMapping(value="/meitiList",method=RequestMethod.GET)
	public String meitiList(PublishForm publishForm,HttpServletRequest request){
		try {
			PageList<Publish> resultPage = publishService.getPublishStr(publishForm);
			request.setAttribute("publishListPage", resultPage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/meitiList";
	}
}
