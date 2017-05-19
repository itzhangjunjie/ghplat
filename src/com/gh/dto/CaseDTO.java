package com.gh.dto;

import java.util.List;

import com.gh.model.Case;
import com.gh.model.CaseImage;
import com.gh.model.Publish;

public class CaseDTO {

	private Case caseObj;
	private List<Publish> publishList;
	private List<CaseImage> caseImageList;
	
	
	public Case getCaseObj() {
		return caseObj;
	}
	public void setCaseObj(Case caseObj) {
		this.caseObj = caseObj;
	}
	public List<Publish> getPublishList() {
		return publishList;
	}
	public void setPublishList(List<Publish> publishList) {
		this.publishList = publishList;
	}
	public List<CaseImage> getCaseImageList() {
		return caseImageList;
	}
	public void setCaseImageList(List<CaseImage> caseImageList) {
		this.caseImageList = caseImageList;
	}
	
	
}
