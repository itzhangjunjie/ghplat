package com.gh.dto;

public class PublishForm {

	private String publishField;//领域筛选
	private String platform;//平台筛选
	private String searchStr;//关键字筛选
	private int pageSize = 1;//第几页
	private int pageCount = 15;//一页多少数据
	private String fanCount;//粉丝数筛选 1是5万以下   2是5万-10万  3是10万以上
	private int publishType;//类型筛选
	private String publishStatus;//状态字段 1是正常
	private int pricePosition;//价格的后缀列名
	private String price;//价格的筛选  1是5000一下   2是5000-8000 3是8000以上
	private long mediaId;//媒体id
	private String publishName;//媒体的
	private long publishId;//媒体id
	private String publisharea;//区域筛选 省
	private String publisharea2;//区域筛选  市
	private String publisharea3;//区域筛选  区
	private String usermobile;//用户手机号
	
	
	
	public String getPublisharea2() {
		return publisharea2;
	}
	public void setPublisharea2(String publisharea2) {
		this.publisharea2 = publisharea2;
	}
	public String getPublisharea3() {
		return publisharea3;
	}
	public void setPublisharea3(String publisharea3) {
		this.publisharea3 = publisharea3;
	}
	public String getUsermobile() {
		return usermobile;
	}
	public void setUsermobile(String usermobile) {
		this.usermobile = usermobile;
	}
	public String getPublisharea() {
		return publisharea;
	}
	public void setPublisharea(String publisharea) {
		this.publisharea = publisharea;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public String getPublishName() {
		return publishName;
	}
	public void setPublishName(String publishName) {
		this.publishName = publishName;
	}
	public long getMediaId() {
		return mediaId;
	}
	public void setMediaId(long mediaId) {
		this.mediaId = mediaId;
	}
	public String getPlatform() {
		return platform;
	}
	public void setPlatform(String platform) {
		this.platform = platform;
	}
	public String getSearchStr() {
		return searchStr;
	}
	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}
	public String getFanCount() {
		return fanCount;
	}
	public void setFanCount(String fanCount) {
		this.fanCount = fanCount;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPublishType() {
		return publishType;
	}
	public void setPublishType(int publishType) {
		this.publishType = publishType;
	}
	public String getPublishField() {
		return publishField;
	}
	public void setPublishField(String publishField) {
		this.publishField = publishField;
	}
	public String getPublishStatus() {
		return publishStatus;
	}
	public void setPublishStatus(String publishStatus) {
		this.publishStatus = publishStatus;
	}
	public int getPricePosition() {
		return pricePosition;
	}
	public void setPricePosition(int pricePosition) {
		this.pricePosition = pricePosition;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public long getPublishId() {
		return publishId;
	}
	public void setPublishId(long publishId) {
		this.publishId = publishId;
	}
	
}
