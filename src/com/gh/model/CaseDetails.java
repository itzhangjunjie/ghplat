package com.gh.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="gh_case_detail")
@SequenceGenerator(name="case_details_seq",sequenceName="seq_case_detail_id")
public class CaseDetails {

	@Id
    @Column(name = "CASE_DETAIL_ID")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="case_details_seq")
	private long caseDetailsId;//案例明细标识
	@Column(name = "CASE_ID")
	private long caseId;//案例标识
	@Column(name = "GHID")
	private String ghid;//标识符
	@Column(name = "PUBLISH_ID")
	private long publishId;//发布标识
	
	@Column(name = "PUBLISH_TYPE")
	private String publishType;//发布类型
	
	
	public long getCaseDetailsId() {
		return caseDetailsId;
	}
	public void setCaseDetailsId(long caseDetailsId) {
		this.caseDetailsId = caseDetailsId;
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
	public long getPublishId() {
		return publishId;
	}
	public void setPublishId(long publishId) {
		this.publishId = publishId;
	}
	public String getPublishType() {
		return publishType;
	}
	public void setPublishType(String publishType) {
		this.publishType = publishType;
	}

	
	
	
}
