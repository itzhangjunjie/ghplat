package com.gh.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gh.dao.IBaseDao;
import com.gh.dto.PublishForm;
import com.gh.model.Advertiser;
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
	
	
	public void saveOrder(int type, long userid, String publishArray,String beizhuArray,String totalCount,String flag) throws Exception {
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
			JSONArray contentObj = JSONArray.fromObject(beizhuArray);
			for(int i=0;i<jaobj.size();i++){
				JSONObject obj = (JSONObject)jaobj.get(i);
				JSONObject contentSobj = (JSONObject)contentObj.get(i);
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
				orderDetails.setContent(contentSobj.getString("content"));
				//System.out.println(orderDetails.toString());
				baseOrderDetailsDao.save(orderDetails);
			}
		}
		
	}


	@Override
	public PageList<Order> getOrderList(PublishForm publishForm, long userid) throws Exception {
		String hql ="from Order order where 1=1 and order.order_status != 3"
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


	@Override
	public void deleteOrder(long orderId) throws Exception {
		String sql="update gh_order god set god.order_status = 3 where god.order_id = "+orderId;
		this.baseOrderDao.executeSql(sql);
	}

	@Resource
	private IBaseDao<Advertiser> baseAdvertiserDao;
	@Override
	public PageList<Order> getOrderList(PublishForm publishForm) throws Exception {
		String hql ="from Order order where 1=1 ";
		if(publishForm!=null){
			if(publishForm.getSearchStr()!=null&&!"".equals(publishForm.getSearchStr())){//订单号
				hql = hql +" and order.ghid = '"+publishForm.getSearchStr()+"'";
			}
			if(publishForm.getPublishStatus()!=null&&!"".equals(publishForm.getPublishStatus())&&!"all".equals(publishForm.getPublishStatus())){//订单状态
				hql = hql +" and order.order_status = '"+publishForm.getPublishStatus()+"'";
			}else{
				hql = hql +" and order.order_status != 3 ";
			}
			if(publishForm.getMediaId()!=0){//用户名  用户的订单
				hql = hql +" and order.order_advertiser_id = "+publishForm.getMediaId();
			}
		}
		hql = hql + " order by order.order_createtime desc ";
		PageList<Order> orderlist =  this.baseOrderDao.findPageList(hql, publishForm.getPageSize(),publishForm.getPageCount());
		String orderids = "";
		String userids = "";
		for(Order order:orderlist.getList()){
			orderids = orderids+order.getOrder_id()+",";
			userids = userids+order.getOrder_advertiser_id()+",";
		}
		if(!"".equals(userids)){
			userids = userids.substring(0,userids.lastIndexOf(","));
			String odhql = "from Advertiser ad where ad.id in("+userids+")";
			List<Advertiser> orderDetailslist = this.baseAdvertiserDao.findList(odhql);
			for(Order order:orderlist.getList()){
				for(Advertiser ad:orderDetailslist){
					if(ad.getId()==order.getOrder_advertiser_id()){
						order.setAdvertiser(ad);
						break;
					}
				}
			}
		}
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


	@Override
	public void updateOrder(Long orderid, String status) throws Exception {
		String sql="update gh_order god set god.order_status = '"+status+"' where god.order_id = "+orderid;
		this.baseOrderDao.executeSql(sql);
	}


	@Override
	public PageList<OrderDetails> getmdOrderList(PublishForm publishForm, long userid) {
		String hql ="from OrderDetails god where 1=1 and god.publish.mediaId = ?"
				+ " and god.order.order_status != 3 "
				+ " order by god.order.order_createtime desc ";
		PageList<OrderDetails> orderlist =  this.baseOrderDetailsDao.findPageList(hql, publishForm.getPageSize(),publishForm.getPageCount(),userid);
		String orderids = "";
		String userids = "";
		for(OrderDetails orderDetails:orderlist.getList()){
			orderids = orderids+orderDetails.getOrder().getOrder_id()+",";
			userids = userids+orderDetails.getOrder().getOrder_advertiser_id()+",";
		}
		if(!"".equals(userids)){
			userids = userids.substring(0,userids.lastIndexOf(","));
			String odhql = "from Advertiser ad where ad.id in("+userids+")";
			List<Advertiser> orderDetailslist = this.baseAdvertiserDao.findList(odhql);
			for(OrderDetails orderDetails:orderlist.getList()){
				for(Advertiser ad:orderDetailslist){
					if(ad.getId()==orderDetails.getOrder().getOrder_advertiser_id()){
						orderDetails.getOrder().setAdvertiser(ad);
						break;
					}
				}
			}
		}
		return orderlist;
	}


	@Override
	public void updateOrder(Long orderid, String status, String admincontent) {
		String sql="update gh_order god set god.order_status = '"+status+"' , god.admincontent = '"+admincontent+"' where god.order_id = "+orderid ;
		this.baseOrderDao.executeSql(sql);
	}

}
