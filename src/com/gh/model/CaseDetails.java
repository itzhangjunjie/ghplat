package com.gh.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
//	@Column(name = "CASE_ID")
//	private long caseId;//案例标识
	@ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="CASE_ID")
	private Case caseObj;
	@Column(name = "GHID")
	private String ghid;//标识符
//	@Column(name = "PUBLISH_ID")
//	private long publishId;//发布标识
	@ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="PUBLISH_ID")
	private Publish publish;
	
	@Column(name = "PUBLISH_TYPE")
	private String publishType;//发布类型
	
	
	public long getCaseDetailsId() {
		return caseDetailsId;
	}
	public void setCaseDetailsId(long caseDetailsId) {
		this.caseDetailsId = caseDetailsId;
	}
//	public long getCaseId() {
//		return caseId;
//	}
//	public void setCaseId(long caseId) {
//		this.caseId = caseId;
//	}
	public String getGhid() {
		return ghid;
	}
	public void setGhid(String ghid) {
		this.ghid = ghid;
	}
//	public long getPublishId() {
//		return publishId;
//	}
//	public void setPublishId(long publishId) {
//		this.publishId = publishId;
//	}
	public String getPublishType() {
		return publishType;
	}
	public void setPublishType(String publishType) {
		this.publishType = publishType;
	}
	public Case getCaseObj() {
		return caseObj;
	}
	public void setCaseObj(Case caseObj) {
		this.caseObj = caseObj;
	}
	public Publish getPublish() {
		return publish;
	}
	public void setPublish(Publish publish) {
		this.publish = publish;
	}
	@Override
	public String toString() {
		return "CaseDetails [caseDetailsId=" + caseDetailsId + ", caseObj=" + caseObj.getCase_id() + ", ghid=" + ghid + ", publish="
				+ publish.getId() + ", publishType=" + publishType + "]";
	}

	
	
	
	
}
