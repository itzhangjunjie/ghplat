package com.gh.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="GH_publish_type")
public class PublishType {

	@Id
	@Column(name="PUBLISH_FIELD_ID")
	private String publishFieldId;//发布领域标识
	@Column(name="PUBLISH_FIELD_NAME")
	private String publishFieldName;//发布领域
	
	public String getPublishFieldId() {
		return publishFieldId;
	}
	public void setPublishFieldId(String publishFieldId) {
		this.publishFieldId = publishFieldId;
	}
	public String getPublishFieldName() {
		return publishFieldName;
	}
	public void setPublishFieldName(String publishFieldName) {
		this.publishFieldName = publishFieldName;
	}
	
	
	
}
