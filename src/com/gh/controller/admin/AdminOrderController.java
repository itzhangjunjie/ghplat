package com.gh.controller.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gh.controller.BaseControllerSupport;
import com.gh.dto.PublishForm;
import com.gh.model.Order;
import com.gh.model.Publish;
import com.gh.service.IOrderService;
import com.gh.util.PageList;
@Controller
@RequestMapping("/admin")
public class AdminOrderController extends BaseControllerSupport{

	@Resource
	private IOrderService orderService;
	
	@RequestMapping(value="/orderList")
	public String orderList(PublishForm publishForm,HttpServletRequest request){
		try {
			System.out.println(publishForm.getPublishStatus()+"...");
			PageList<Order> resultPage = orderService.getOrderList(publishForm);
			request.setAttribute("orderListPage", resultPage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/admin/orderList";
	}
	
	@RequestMapping(value="/updateOrder")
	public @ResponseBody String updateOrder(HttpServletRequest request){
		try {
			Long orderid = Long.parseLong(request.getParameter("orderid"));
			String status =  request.getParameter("status");
			orderService.updateOrder(orderid,status);
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
}
