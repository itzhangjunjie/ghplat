package com.gh.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

//@Entity
//@Table(name="GH_publish_info")
public class PublishInfo {
	
//	@Column(name="PUBLISH_TYPE")
	private String publishType;//发布类型
//	@Column(name="COLUMN_TYPE")
	private String columnType;//字段类型
//	@Column(name="COLUMN_POSITION")
	private int columnPosition;//字段位置
//	@Column(name="COLUMN_NAME")
	private String columnName;//字段描述

	public String getPublishType() {
		return publishType;
	}
	public void setPublishType(String publishType) {
		this.publishType = publishType;
	}
	public String getColumnType() {
		return columnType;
	}
	public void setColumnType(String columnType) {
		this.columnType = columnType;
	}
	public int getColumnPosition() {
		return columnPosition;
	}
	public void setColumnPosition(int columnPosition) {
		this.columnPosition = columnPosition;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	
}
