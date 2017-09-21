package com.gh.service;

import com.gh.dto.PublishForm;
import com.gh.model.Delivery;
import com.gh.util.PageList;

public interface IDeliveryService {

	PageList<Delivery> getDeliveryList(PublishForm publishForm) throws Exception;

	void updateDelivery(Long deliveryId, String status) throws Exception;

}
