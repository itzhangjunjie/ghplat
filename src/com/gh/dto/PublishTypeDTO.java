package com.gh.dto;

import java.util.ArrayList;
import java.util.List;

import com.gh.model.PublishField;
import com.gh.model.PublishInfo;
import com.gh.model.PublishPlatform;
import com.gh.model.PublishPrice;

public class PublishTypeDTO {

	private String publishType;
	private String publishName;
	//媒体列表用
	private List<PublishField> publishFieldList = new ArrayList<PublishField>();
	private List<PublishPlatform> publishPlatform = new ArrayList<PublishPlatform>();
	private List<PublishPrice> publishPrice = new ArrayList<PublishPrice>();
	//添加案例用
	private List<PublishInfo> publishInfo = new ArrayList<PublishInfo>();
	
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
	public List<PublishField> getPublishFieldList() {
		return publishFieldList;
	}
	public void setPublishFieldList(List<PublishField> publishFieldList) {
		this.publishFieldList = publishFieldList;
	}
	public List<PublishPlatform> getPublishPlatform() {
		return publishPlatform;
	}
	public void setPublishPlatform(List<PublishPlatform> publishPlatform) {
		this.publishPlatform = publishPlatform;
	}
	
	public List<PublishPrice> getPublishPrice() {
		return publishPrice;
	}
	public void setPublishPrice(List<PublishPrice> publishPrice) {
		this.publishPrice = publishPrice;
	}
	public List<PublishInfo> getPublishInfo() {
		return publishInfo;
	}
	public void setPublishInfo(List<PublishInfo> publishInfo) {
		this.publishInfo = publishInfo;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((publishType == null) ? 0 : publishType.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PublishTypeDTO other = (PublishTypeDTO) obj;
		if (publishType == null) {
			if (other.publishType != null)
				return false;
		} else if (!publishType.equals(other.publishType))
			return false;
		return true;
	}
	
	
	
}
