package com.gh.service;

import com.gh.dto.PublishForm;
import com.gh.model.Order;
import com.gh.util.PageList;

public interface IOrderService {

	public void saveOrder(int type,long userid,String publishArray,String totalCount,String flag) throws Exception;

	public PageList<Order> getOrderList(PublishForm publishForm, long userid) throws Exception;

	public void deleteOrder(long orderId) throws Exception;

	public PageList<Order> getOrderList(PublishForm publishForm) throws Exception;

	public void updateOrder(Long orderid, String status) throws Exception;
	
}
