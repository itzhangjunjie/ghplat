package com.gh.service;

import java.util.List;
import java.util.Map;

import com.gh.dto.CartListDTO;
import com.gh.dto.CaseDTO;
import com.gh.dto.PublishForm;
import com.gh.dto.PublishTypeDTO;
import com.gh.model.Case;
import com.gh.model.CaseDetails;
import com.gh.model.Media;
import com.gh.model.Publish;
import com.gh.model.PublishArea;
import com.gh.model.PublishPlatform;
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
	
	/**
	 * 获取自媒体的案例列表
	 */
	PageList<Case> getCaseStr(PublishForm publishForm)throws Exception;

	/**
	 * 保存案例
	 */
	void saveCase(Case caseObj, String imageArray, String publishArray,String beforeUrl) throws Exception;

	void updateCase(Case caseObj, String imageArray, String publishArray, String beforeUrl) throws Exception;

	void delete(Long case_id) throws Exception;

	List<Publish> getCartList(String ids) throws Exception;

	Publish getpublishDetails(String publishghid) throws Exception;

	List<PublishArea> getPublishAreaList() throws Exception;

	void deletePublish(long id) throws Exception;

	void updateInfoValue(String ckey, String cvalue,long pid,Publish publish) throws Exception;

	void updatePriceValue(String ckey, String cvalue, long id,Publish publish) throws Exception;

	List<PublishPlatform> getPlatFormList(PublishForm publishForm) throws Exception;

	void delPlatformDetails(String pfid) throws Exception;

	PublishPlatform getPlatformDetails(String pfid) throws Exception;

	void updatePlatformDetailss(String pfid, String platformicon, String platformname, String publishtype)throws Exception;

	void addPlatform(String platformicon, String platformname, String publishtype) throws Exception;


}
