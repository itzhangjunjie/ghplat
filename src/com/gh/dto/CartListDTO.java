package com.gh.dto;

import java.util.ArrayList;
import java.util.List;

import com.gh.model.Publish;
import com.gh.model.PublishInfo;
import com.gh.model.PublishPrice;

public class CartListDTO {

	private String publishType;
	private String publishName;
	private List<PublishPrice> publishPrice = new ArrayList<PublishPrice>();
	
	public String getPublishType() {
		return publishType;
	}
	public void setPublishType(String publishType) {
		this.publishType = publishType;
	}
	public String getPublishName() {
		return publishName;
	}
	public void setPublishName(String publishName) {
		this.publishName = publishName;
	}
	public List<PublishPrice> getPublishPrice() {
		return publishPrice;
	}
	public void setPublishPrice(List<PublishPrice> publishPrice) {
		this.publishPrice = publishPrice;
	}
	
	
}
