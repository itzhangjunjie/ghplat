package com.gh.service;

import java.util.List;
import java.util.Map;

import com.gh.dto.CaseDTO;
import com.gh.dto.PublishForm;
import com.gh.dto.PublishTypeDTO;
import com.gh.model.Case;
import com.gh.model.CaseDetails;
import com.gh.model.Media;
import com.gh.model.Publish;
import com.gh.util.PageList;

import net.sf.json.JSONObject;


public interface IPublishService {

	/**
	 * 获取媒体列表的类型
	 */
	List<PublishTypeDTO> getPublishType() throws Exception;

	/**
	 * 获取媒体列表 
	 */
	PageList<Publish> getPublishStr(PublishForm publishForm) throws Exception;

	/**
	 * 添加案例  获取类型
	 */
	List<PublishTypeDTO> getPublishAdd()throws Exception;

	/**
	 * 获取自媒体的案例列表
	 */
	PageList<CaseDetails> getCaseList(PublishForm publishForm)throws Exception;

	void saveCase(Case caseObj, String imageArray, String publishArray,String beforeUrl) throws Exception;

}
