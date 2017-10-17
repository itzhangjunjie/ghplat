package com.gh.controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gh.dto.PublishForm;
import com.gh.model.Advertiser;
import com.gh.model.Delivery;
import com.gh.model.Media;
import com.gh.model.Order;
import com.gh.model.OrderDetails;
import com.gh.service.IBaseService;
import com.gh.service.IDeliveryService;
import com.gh.service.IOrderService;
import com.gh.util.EmailSend;
import com.gh.util.PageList;

@Controller
@RequestMapping("/")
public class DeliveryController extends BaseControllerSupport{

	@Resource
	private IBaseService<Delivery> baseDeliveryService;
	@Resource
	private IDeliveryService deliveryService;
	
	@RequestMapping(value="/deliveryList",method=RequestMethod.GET)
	public String deliveryList(HttpServletRequest request,PublishForm publishForm){
		try {
			String type = (String)request.getSession().getAttribute("type");
			long userid = 0;
			if("自媒体".equals(type)){
				Media media = (Media)request.getSession().getAttribute("user");
				userid = media.getId();
			}else{
				Advertiser adver = (Advertiser)request.getSession().getAttribute("user");
				userid = adver.getId();
			}
			if(userid ==0){
				return "/front/deliverylist";
			}
			publishForm.setPublishId(userid);
			PageList<Delivery> deliveryList = deliveryService.getDeliveryList(publishForm);
			request.setAttribute("deliveryList", deliveryList);
			request.setAttribute("pageSize", publishForm.getPageSize());
			request.setAttribute("totalcount", deliveryList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/deliverylist";
	}
	
	@RequestMapping(value="/saveDelivery")
	public @ResponseBody String saveDelivery(HttpServletRequest request){
		jsonObject.clear();
		try {
			String title = request.getParameter("title");
			String xingshi = request.getParameter("xingshi");
			String ziyuan = request.getParameter("ziyuan");
			String peitao = request.getParameter("peitao");
			String intro = request.getParameter("intro");
			String aid = request.getParameter("advertiserId");
			String yusuan = request.getParameter("yusuan");
			Delivery delivery = new Delivery();
			delivery.setCreateTime(new Date());
			delivery.setIntro(intro);
			delivery.setPeitao(peitao);
			delivery.setTitle(title);
			delivery.setXingshi(xingshi);
			delivery.setZiyuan(ziyuan);
			delivery.setYusuan(yusuan);
			delivery.setStatus(0);
			Advertiser advertiser  = new Advertiser();
			advertiser.setId(Long.parseLong(aid));
			delivery.setAdvertiser(advertiser);
			EmailSend.sendMail("有委托订单生成-广告主", intro+"||后台注意查看");
			baseDeliveryService.save(delivery);
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	
	@RequestMapping(value="/persionmd",method=RequestMethod.GET)
	public String persionmd(HttpServletRequest request){
		try {
			String type = request.getParameter("type");
			if(type!=null){
				request.setAttribute("type", type);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/persionmd";
	}
	
	@RequestMapping(value="/persionad",method=RequestMethod.GET)
	public String persionad(HttpServletRequest request){
		try {
			String type = request.getParameter("type");
			if(type!=null){
				request.setAttribute("type", type);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/persionad";
	}
	
	@RequestMapping(value="/deliveryAdd",method=RequestMethod.GET)
	public String deliveryAdd(HttpServletRequest request){
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/deliveryadd";
	}
	
	@Resource
	private IOrderService orderService;
	
	@RequestMapping(value = "/getmdOrderListNew", method = {RequestMethod.GET})
	public String getmdOrderListNew(PublishForm publishForm,HttpServletRequest request){
		try {
			if(request.getSession().getAttribute("user")==null){
				return "redirect:/";
			}else{
				String type = (String)request.getSession().getAttribute("type");
				long userid = 0;
				if("自媒体".equals(type)){
					Media media = (Media)request.getSession().getAttribute("user");
					userid = media.getId();
				}else{
					Advertiser adver = (Advertiser)request.getSession().getAttribute("user");
					userid = adver.getId();
				}
				PageList<OrderDetails> orderList = orderService.getmdOrderList(publishForm,userid);
				request.setAttribute("orderlist", orderList);
				request.setAttribute("typeFlag", "1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/newmdperson";
	}
	
	@RequestMapping(value = "/getOrderListNew", method = {RequestMethod.GET})
	public String getOrderListNew(PublishForm publishForm,HttpServletRequest request){
		try {
			if(request.getSession().getAttribute("user")==null){
				return "redirect:/";
			}else{
				String type = (String)request.getSession().getAttribute("type");
				long userid = 0;
				if("自媒体".equals(type)){
					Media media = (Media)request.getSession().getAttribute("user");
					userid = media.getId();
				}else{
					Advertiser adver = (Advertiser)request.getSession().getAttribute("user");
					userid = adver.getId();
				}
				PageList<Order> orderList = orderService.getOrderList(publishForm,userid);
				request.setAttribute("orderlist", orderList);
				request.setAttribute("typeFlag", "1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/newperson";
	}
	
}
