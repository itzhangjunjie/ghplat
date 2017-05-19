package com.gh.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="gh_case_image")
@SequenceGenerator(name="case_image_seq",sequenceName="seq_case_image_id")
public class CaseImage {
	@Id
    @Column(name = "CASE_IMAGE_ID")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="case_image_seq")
	private long caseImageId;//案例图片标识
	@Column(name = "CASE_ID")
	private long caseId;//案例标识
	@Column(name = "GHID")
	private String ghid;//标识符
	@Column(name = "IMAGE_TITLE")
	private String imageTitle;//图片标题
	@Column(name = "IMAGE_URL")
	private String imageUrl;//图片URL
	@Column(name = "IMAGE_DESC")
	private String imageDesc;//图片描述

	
	public long getCaseImageId() {
		return caseImageId;
	}
	public void setCaseImageId(long caseImageId) {
		this.caseImageId = caseImageId;
	}
	public long getCaseId() {
		return caseId;
	}
	public void setCaseId(long caseId) {
		this.caseId = caseId;
	}
	public String getGhid() {
		return ghid;
	}
	public void setGhid(String ghid) {
		this.ghid = ghid;
	}
	public String getImageTitle() {
		return imageTitle;
	}
	public void setImageTitle(String imageTitle) {
		this.imageTitle = imageTitle;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getImageDesc() {
		return imageDesc;
	}
	public void setImageDesc(String imageDesc) {
		this.imageDesc = imageDesc;
	}
	
	
	

}
