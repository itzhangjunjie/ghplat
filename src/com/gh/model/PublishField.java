package com.gh.model;


//@Entity
//@Table(name="GH_publish_field")
public class PublishField {

//	@Id
//	@Column(name="PUBLISH_FIELD_ID")
	private String fieldId;//发布类型
//	@Column(name="PUBLISH_TYPE")
	private String publishType;//标识
//	@Column(name="PUBLISH_FIELD_NAME")
	private String publishFieldName;//发布领域
	
	
	public String getFieldId() {
		return fieldId;
	}
	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
	}
	public String getPublishType() {
		return publishType;
	}
	public void setPublishType(String publishType) {
		this.publishType = publishType;
	}
	public String getPublishFieldName() {
		return publishFieldName;
	}
	public void setPublishFieldName(String publishFieldName) {
		this.publishFieldName = publishFieldName;
	}

	
	
	
}
