package com.gh.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gh.dao.IBaseDao;
import com.gh.dto.PublishForm;
import com.gh.model.Order;
import com.gh.model.OrderDetails;
import com.gh.model.Publish;
import com.gh.service.IOrderService;
import com.gh.util.PageList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
@Service
public class OrderServiceImpl implements IOrderService{

	@Resource
	private IBaseDao<Order> baseOrderDao;
	@Resource
	private IBaseDao<OrderDetails> baseOrderDetailsDao;
	
	
	public void saveOrder(int type, long userid, String publishArray,String totalCount,String flag) throws Exception {
		if(publishArray!=null&&!"".equals(publishArray)){
			Order order = new Order();
			order.setGhid(UUID.randomUUID().toString().replace("-", ""));
			order.setOrder_createtime(new Date());
			order.setOrder_user_id(String.valueOf(type));//1是媒体    2是广告主
			order.setOrder_advertiser_id(userid);
			order.setOrder_type(flag);//订单类型  -1是用户自理  1是平台代理
			order.setOrder_status("0");
			order.setOrder_contentbudget(totalCount);
			long orderId = baseOrderDao.save(order);
			order.setOrder_id(orderId);
			JSONArray jaobj = JSONArray.fromObject(publishArray);
			for(int i=0;i<jaobj.size();i++){
				JSONObject obj = (JSONObject)jaobj.get(i);
				long publishId = Long.parseLong(obj.getString("publishId"));
				String priceStr = obj.getString("priceStr");
				String price = obj.getString("price");
				String publishType = obj.getString("publishType");
				OrderDetails orderDetails =  new OrderDetails();
				orderDetails.setOrder(order);
				Publish publishobj = new Publish();
				publishobj.setId(publishId);
				orderDetails.setPublish(publishobj);
				orderDetails.setPublish_price(price);
				orderDetails.setPublish_pricestr(priceStr);
				orderDetails.setPublish_type(publishType);
				orderDetails.setGhid(UUID.randomUUID().toString().replace("-", ""));
				System.out.println(orderDetails.toString());
				baseOrderDetailsDao.save(orderDetails);
			}
		}
		
	}


	@Override
	public PageList<Order> getOrderList(PublishForm publishForm, long userid) throws Exception {
		String hql ="from Order order where 1=1 "
				+ " and order.order_advertiser_id = ? "
				+ " order by order.order_createtime desc ";
//		System.out.println(publishForm.getPageSize()+"||"+publishForm.getPageCount());
		PageList<Order> orderlist =  this.baseOrderDao.findPageList(hql, publishForm.getPageSize(),publishForm.getPageCount(),userid);
//		System.out.println(orderlist.getList().get(0).getOrderDetailsList().get(0).getGhid());
		String orderids = "";
		for(Order order:orderlist.getList()){
			orderids = orderids+order.getOrder_id()+",";
		}
//		System.out.println(orderids+"||"+orderlist.getList().size());
		if(!"".equals(orderids)){
			orderids = orderids.substring(0,orderids.lastIndexOf(","));
			String odhql = "from OrderDetails god where god.order.order_id in("+orderids+")";
			List<OrderDetails> orderDetailslist = this.baseOrderDetailsDao.findList(odhql);
			for(Order order:orderlist.getList()){
				List<OrderDetails> bods = new ArrayList<OrderDetails>();
				for(OrderDetails od:orderDetailslist){
					if(od.getOrder().getOrder_id()==order.getOrder_id()){
						bods.add(od);
					}
				}
				order.setOrderDetailsList(bods);
			}
		}
		return orderlist;
	}

}