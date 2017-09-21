package com.gh.controller.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gh.controller.BaseControllerSupport;
import com.gh.dto.PublishForm;
import com.gh.model.Delivery;
import com.gh.service.IDeliveryService;
import com.gh.util.PageList;
@Controller
@RequestMapping("/admin")
public class AdminDeliveryController extends BaseControllerSupport{
	
	@Resource
	private IDeliveryService deliverService;
	
	@RequestMapping(value="/deliverylist")
	public String deliverylist(PublishForm publishForm,HttpServletRequest request){
		try {
			PageList<Delivery> resultPage = deliverService.getDeliveryList(publishForm);
			request.setAttribute("deliveryListPage", resultPage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/deliverylist";
	}
	
	@RequestMapping(value="/updateDelivery")
	public @ResponseBody String updateDelivery(HttpServletRequest request){
		try {
			Long deliveryId = Long.parseLong(request.getParameter("deliveryId"));
			String status =  request.getParameter("status");
			deliverService.updateDelivery(deliveryId,status);
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
}
