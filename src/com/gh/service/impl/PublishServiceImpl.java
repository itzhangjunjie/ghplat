package com.gh.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gh.dao.IBaseDao;
import com.gh.dto.CartListDTO;
import com.gh.dto.CaseDTO;
import com.gh.dto.PublishForm;
import com.gh.dto.PublishTypeDTO;
import com.gh.model.Case;
import com.gh.model.CaseDetails;
import com.gh.model.CaseImage;
import com.gh.model.IndexBanner;
import com.gh.model.Media;
import com.gh.model.Publish;
import com.gh.model.PublishField;
import com.gh.model.PublishInfo;
import com.gh.model.PublishPlatform;
import com.gh.model.PublishPrice;
import com.gh.model.PublishType;
import com.gh.service.IPublishService;
import com.gh.util.FileUtil;
import com.gh.util.PageList;
import com.gh.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
@Service
public class PublishServiceImpl implements IPublishService{

	@Resource
	private IBaseDao<IndexBanner> baseDao;
	
	@Override  
	public List<PublishTypeDTO> getPublishType() throws Exception {
		String sql = "select d.publish_field_id,d.PUBLISH_FIELD_NAME,t.PUBLISH_TYPE_ID,t.PUBLISH_TYPE_NAME "
				+ "from dic_publish_type t "
				+ "left join dic_publish_field d on d.publish_type = t.publish_type_id ";
		List<Object[]> results = this.baseDao.findListBySql(sql);
		List<PublishTypeDTO> ptdtos = new ArrayList<PublishTypeDTO>();
		ArrayList<String> flagArray = new ArrayList<String>();
		for(Object[] obj :results){
			String typeId = (String)obj[2];
			if(!flagArray.contains(typeId)){
				PublishTypeDTO ptdto = new PublishTypeDTO();
				ptdto.setPublishName((String)obj[3]);
				ptdto.setPublishType(typeId);
				List<PublishField> publishFieldList = new ArrayList<PublishField>();
				for(Object[] objj :results){
					if(((String)objj[2]).equals(ptdto.getPublishType())){
						PublishField pf = new PublishField();
						pf.setFieldId((String)objj[0]);
						pf.setPublishFieldName((String)objj[1]);
						publishFieldList.add(pf);
					}
				}
				ptdto.setPublishFieldList(publishFieldList);
				ptdtos.add(ptdto);
				flagArray.add(typeId);
			}
		}
		String sql2 = "select t.PUBLISH_TYPE_ID,t.PUBLISH_TYPE_NAME,dp.platform_id,dp.platform_name,dp.platform_icon "
				+ "from dic_publish_type t "
				+ "left join dic_platform dp on dp.publish_type = t.publish_type_id ";
		List<Object[]> results2 = this.baseDao.findListBySql(sql2);
		for(PublishTypeDTO ptdto:ptdtos){
			List<PublishPlatform> publishPlatform = new ArrayList<PublishPlatform>();
			for(Object[] objj :results2){
				if(((String)objj[0]).equals(ptdto.getPublishType())){
					PublishPlatform ppf = new PublishPlatform();
					ppf.setPlatformId((String)objj[2]);
					ppf.setPlatformName((String)objj[3]);
					ppf.setPlatformIcon((String)objj[4]);
					publishPlatform.add(ppf);
				}
			}
			ptdto.setPublishPlatform(publishPlatform);
		}
		String sql3 = "select t.PUBLISH_TYPE_ID,t.PUBLISH_TYPE_NAME,cpp.column_name,cpp.column_type,cpp.column_position "
				+ "from dic_publish_type t "
				+ "left join cfg_publish_price cpp on cpp.publish_type = t.publish_type_id ";
		List<Object[]> results3 = this.baseDao.findListBySql(sql3);
		for(PublishTypeDTO ptdto:ptdtos){
			List<PublishPrice> publishPrice = new ArrayList<PublishPrice>();
			for(Object[] objj :results3){
				if(((String)objj[0]).equals(ptdto.getPublishType())){
					PublishPrice pp = new PublishPrice();
					pp.setColumnName((String)objj[2]);
					pp.setColumnType((String)objj[3]);
					Object ob = objj[4];
					if(ob!=null){
						pp.setColumnPosition(Integer.parseInt(ob.toString()));
					}
					publishPrice.add(pp);
				}
			}
			ptdto.setPublishPrice(publishPrice);
		}
		return ptdtos;
	}

	@Resource
	private IBaseDao<Publish> basePublishDao;
	@Override
	public PageList<Publish> getPublishStr(PublishForm publishForm) throws Exception {
		String hql = "from Publish gp where 1=1 ";
		if(publishForm!=null){
			if(publishForm.getPublishType()!=0){
				hql = hql +" and gp.publishTypeObj.publishFieldId = "+publishForm.getPublishType();
			}
			if(publishForm.getPublishField()!=null){
				hql = hql +" and gp.publishField = '"+ publishForm.getPublishField()+"'";
			}
			if(publishForm.getPlatform() != null){
				hql = hql + " and gp.platformName = '"+publishForm.getPlatform()+"'";
			}
			if(publishForm.getMediaId() != 0){
				hql = hql + " and gp.mediaId = "+publishForm.getMediaId();
			}
			if(publishForm.getPublishName()!=null){
				hql = hql + " and gp.publishName like '%"+publishForm.getPublishName()+"%'";
			}
			if(publishForm.getFanCount() !=null){
				if("1".equals(publishForm.getFanCount())){
					hql = hql +" and gp.platformFans < 50000";
				}else if("2".equals(publishForm.getFanCount())){
					hql = hql +" and gp.platformFans >= 50000 and gp.platformFans <= 100000";
				}else if("3".equals(publishForm.getFanCount())){
					hql = hql +" and gp.platformFans > 100000";
				}
			}
			if(publishForm.getPublishStatus()!=null){
				hql = hql +" and gp.publishStatus = '"+publishForm.getPublishStatus()+"'";
			}
			if(publishForm.getPricePosition()!=0){
				String columnname ="price";
				if(publishForm.getPricePosition()<=9){
					columnname = columnname+"0"+publishForm.getPricePosition();
				}else{
					columnname = columnname+publishForm.getPricePosition();
				}
				if(publishForm.getPrice()!=null){
					if("1".equals(publishForm.getPrice())){
						hql = hql +" and gp."+columnname+" <5000";
					}else if("2".equals(publishForm.getPrice())){
						hql = hql +" and gp."+columnname+" <=5000 and gp."+columnname+" <=10000";
					}else{
						hql = hql +" and gp."+columnname+" >10000";
					}
				}else{
					hql = hql +" and gp."+columnname+" is not null ";
				}
			}
		}
		hql = hql +" order by gp.publishTime desc ";
		PageList<Publish> resultPage = basePublishDao.findPageList(hql, publishForm.getPageSize(), publishForm.getPageCount());
		String medias = "";
		for(Publish publish:resultPage.getList()){
			medias = medias+publish.getMediaId()+",";
		}
		if(!"".equals(medias)){
			medias = medias.substring(0,medias.lastIndexOf(","));
		}
		String msql = "select gm.qq,gm.media_id from gh_media gm where gm.media_id in ("+medias+")";
		List<Object[]> results = this.baseDao.findListBySql(msql);
		for(Object[] obj :results){
			Object ob = obj[1];
			if(ob!=null){
				for(Publish publish:resultPage.getList()){
					if(publish.getMediaId()==Integer.parseInt(ob.toString())){
						publish.setQq((String)obj[0]);
						break;
					}
				}
			}
		}
		return resultPage;
	}
	@Override
	public List<PublishTypeDTO> getPublishAdd() throws Exception {
		String sql = "select d.column_type,d.column_position,d.column_name,t.PUBLISH_TYPE_ID,t.PUBLISH_TYPE_NAME "
				+ "from dic_publish_type t "
				+ "left join cfg_publish_info d on d.publish_type = t.publish_type_id ";
		List<Object[]> results = this.baseDao.findListBySql(sql);
		List<PublishTypeDTO> ptdtos = new ArrayList<PublishTypeDTO>();
		ArrayList<String> flagArray = new ArrayList<String>();
		for(Object[] obj :results){
			String typeId = (String)obj[3];
			if(!flagArray.contains(typeId)){
				PublishTypeDTO ptdto = new PublishTypeDTO();
				ptdto.setPublishName((String)obj[4]);
				ptdto.setPublishType(typeId);
				List<PublishInfo> publishInfo = new ArrayList<PublishInfo>();
				for(Object[] objj :results){
					if(((String)objj[3]).equals(ptdto.getPublishType())){
						PublishInfo pi = new PublishInfo();
						pi.setColumnType((String)objj[0]);
						Object ob = objj[1];
						if(ob!=null){
							pi.setColumnPosition(Integer.parseInt(ob.toString()));
						}
						pi.setColumnName((String)objj[2]);
						publishInfo.add(pi);
					}
				}
				ptdto.setPublishInfo(publishInfo);
				ptdtos.add(ptdto);
				flagArray.add(typeId);
			}
		}
		
		String sql2 = "select t.PUBLISH_TYPE_ID,t.PUBLISH_TYPE_NAME,dp.platform_id,dp.platform_name,dp.platform_icon "
				+ "from dic_publish_type t "
				+ "left join dic_platform dp on dp.publish_type = t.publish_type_id ";
		List<Object[]> results2 = this.baseDao.findListBySql(sql2);
		for(PublishTypeDTO ptdto:ptdtos){
			List<PublishPlatform> publishPlatform = new ArrayList<PublishPlatform>();
			for(Object[] objj :results2){
				if(((String)objj[0]).equals(ptdto.getPublishType())){
					PublishPlatform ppf = new PublishPlatform();
					ppf.setPlatformId((String)objj[2]);
					ppf.setPlatformName((String)objj[3]);
					ppf.setPlatformIcon((String)objj[4]);
					publishPlatform.add(ppf);
				}
			}
			ptdto.setPublishPlatform(publishPlatform);
		}
		
		String sql3 = "select t.PUBLISH_TYPE_ID,t.PUBLISH_TYPE_NAME,cpp.column_name,cpp.column_type,cpp.column_position "
				+ "from dic_publish_type t "
				+ "left join cfg_publish_price cpp on cpp.publish_type = t.publish_type_id ";
		List<Object[]> results3 = this.baseDao.findListBySql(sql3);
		for(PublishTypeDTO ptdto:ptdtos){
			List<PublishPrice> publishPrice = new ArrayList<PublishPrice>();
			for(Object[] objj :results3){
				if(((String)objj[0]).equals(ptdto.getPublishType())){
					PublishPrice pp = new PublishPrice();
					pp.setColumnName((String)objj[2]);
					pp.setColumnType((String)objj[3]);
					Object ob = objj[4];
					if(ob!=null){
						pp.setColumnPosition(Integer.parseInt(ob.toString()));
					}
					publishPrice.add(pp);
				}
			}
			ptdto.setPublishPrice(publishPrice);
		}
		String sql4 = "select d.publish_field_id,d.PUBLISH_FIELD_NAME,t.PUBLISH_TYPE_ID,t.PUBLISH_TYPE_NAME "
				+ "from dic_publish_type t "
				+ "left join dic_publish_field d on d.publish_type = t.publish_type_id ";
		List<Object[]> results4 = this.baseDao.findListBySql(sql4);
		for(PublishTypeDTO ptdto:ptdtos){
			List<PublishField> publishFieldList = new ArrayList<PublishField>();
			for(Object[] objj :results4){
				if(((String)objj[2]).equals(ptdto.getPublishType())){
					PublishField pf = new PublishField();
					pf.setFieldId((String)objj[0]);
					pf.setPublishFieldName((String)objj[1]);
					publishFieldList.add(pf);
				}
			}
			ptdto.setPublishFieldList(publishFieldList);;
		}
		return ptdtos;
	}
	@Resource
	private IBaseDao<Case> baseCaseDao;
	@Resource
	private IBaseDao<CaseDetails> baseCaseDetailsDao;
	@Override
	public PageList<CaseDetails> getCaseList(PublishForm publishForm) throws Exception {
		String hql ="from CaseDetails caseDetails where 1=1 ";
		if(publishForm!=null){
			if(publishForm.getPublishStatus()!=null){
				hql = hql +" and caseDetails.caseObj.case_status= '"+publishForm.getPublishStatus()+"' ";
			}
			if(publishForm.getMediaId()!=0){
				hql = hql +" and caseDetails.caseObj.media_id= "+publishForm.getMediaId();
			}
			if(publishForm.getPublishId()!=0){
				hql = hql +" and caseDetails.publish.id = "+publishForm.getPublishId();
			}
		}
		hql = hql +" order by caseDetails.caseObj.case_publish_time desc";
		PageList<CaseDetails> resultPage = this.baseCaseDetailsDao.findPageList(hql, publishForm.getPageSize(), publishForm.getPageCount());
		//System.out.println(resultPage.getList().get(0).getCaseObj().getCaseImageList().size());
		String caseIdStr = "";
		for(CaseDetails caseDetailsObj:resultPage.getList()){
			caseIdStr = caseIdStr+caseDetailsObj.getCaseObj().getCase_id()+",";
		}
		if(!caseIdStr.equals("")){
			caseIdStr = caseIdStr.substring(0,caseIdStr.length()-1);
		}
		String phql ="from CaseDetails cd where cd.caseObj.case_id in ("+caseIdStr+") ";
		if(!"".equals(caseIdStr)){
			List<CaseDetails> resultPage2 = this.baseCaseDetailsDao.findList(phql);
			if(resultPage.getList().size()>0){
				for(CaseDetails caseDetailsObj:resultPage.getList()){
					if(resultPage2.size()>0){
						List<Publish> childPublish = new ArrayList<Publish>();
						for(CaseDetails ccaseDetailsObj:resultPage2){
							if(ccaseDetailsObj.getCaseObj().getCase_id()==caseDetailsObj.getCaseObj().getCase_id()){
								childPublish.add(ccaseDetailsObj.getPublish());
							}
						}
						caseDetailsObj.getCaseObj().setChildPublish(childPublish);
					}
				}
			}
		}
		return resultPage;
	}
	
	
	@Override
	public PageList<Case> getCaseStr(PublishForm publishForm) throws Exception {
		String hql ="from Case acase where 1=1 ";
		if(publishForm!=null){
			if(publishForm.getPublishStatus()!=null){
				hql = hql +" and acase.case_status= '"+publishForm.getPublishStatus()+"' ";
			}
			if(publishForm.getMediaId()!=0){
				hql = hql +" and acase.media_id= "+publishForm.getMediaId();
			}
		}
		hql = hql +" order by acase.case_publish_time desc";
		PageList<Case> resultPage = this.baseCaseDetailsDao.findPageList(hql, publishForm.getPageSize(), publishForm.getPageCount());
		System.out.println(resultPage.getList().size());
		String caseIdStr = "";
		for(Case acase:resultPage.getList()){
			caseIdStr = caseIdStr+acase.getCase_id()+",";
		}
		if(!caseIdStr.equals("")){
			caseIdStr = caseIdStr.substring(0,caseIdStr.length()-1);
		}
		String phql ="from CaseDetails cd where cd.caseObj.case_id in ("+caseIdStr+") ";
		List<CaseDetails> resultPage2 = this.baseCaseDetailsDao.findList(phql);
		if(resultPage.getList().size()>0){
			for(Case caseObj:resultPage.getList()){
				if(resultPage2.size()>0){
					List<Publish> childPublish = new ArrayList<Publish>();
					for(CaseDetails ccaseDetailsObj:resultPage2){
						if(ccaseDetailsObj.getCaseObj().getCase_id()==caseObj.getCase_id()){
							childPublish.add(ccaseDetailsObj.getPublish());
						}
					}
					caseObj.setChildPublish(childPublish);
				}
			}
		}
		return resultPage;
	}
	
	
	
	@Resource
	private IBaseDao<CaseImage> baseCaseImage;
	@Resource
	private IBaseDao<CaseDetails> baseCaseDetails;
	
	@Override
	public void saveCase(Case caseObj, String imageArray, String publishArray,String beforeUrl) throws Exception {
		long caseId = this.baseCaseDao.save(caseObj);
		caseObj.setCase_id(caseId);
		if(imageArray!=null){
			JSONArray imageja = JSONArray.fromObject(imageArray);
			for (Object obj : imageja) {
		           JSONObject jsonObject = (JSONObject) obj;
		           CaseImage ci = new CaseImage();
		           String srcImage = jsonObject.getString("url").replace("/ghplat/attachment/temp", "");
		           FileUtil.copyFile(beforeUrl+"/temp"+srcImage, beforeUrl+"/case"+srcImage);
				   FileUtil.delete(beforeUrl+"/temp"+srcImage);
				   ci.setImageUrl("/caseImage"+srcImage);
				   ci.setImageTitle(jsonObject.getString("title"));
				   ci.setImageDesc(jsonObject.getString("details"));
				   ci.setCaseId(caseId);
				   ci.setGhid(UUID.randomUUID().toString().replace("-", ""));
				   baseCaseImage.save(ci);
			}
		}
		if(publishArray!=null){
			JSONArray publishja = JSONArray.fromObject(publishArray);
			for (Object obj : publishja) {
				JSONObject jsonObject = (JSONObject) obj;
				CaseDetails cd = new CaseDetails();
				Publish publish = new Publish();
				publish.setId(jsonObject.getLong("publishId"));
//				PublishType publishTypeObj =  new PublishType();
//				publishTypeObj.setPublishFieldId(publishFieldId);
//				publish.setPublishTypeObj(publishTypeObj);
				cd.setPublish(publish);
				cd.setPublishType(jsonObject.getString("publishType"));
				cd.setCaseObj(caseObj);
				cd.setGhid(UUID.randomUUID().toString().replace("-", ""));
				System.out.println(cd.toString());
				baseCaseDetails.save(cd);
			}
		}
		
	}

	
	@Override
	public void updateCase(Case caseObj, String imageArray, String publishArray,String beforeUrl) throws Exception {
		Case currentCase = this.baseCaseDao.getById(Case.class, caseObj.getCase_id());
		if(caseObj.getImage().contains("/temp")){
			String srcImage = caseObj.getImage().replace("/ghplat/attachment/temp", "");
			FileUtil.copyFile(beforeUrl+"/temp"+srcImage, beforeUrl+"/case"+srcImage);
			FileUtil.delete(beforeUrl+"/temp"+srcImage);
			currentCase.setImage("/case"+srcImage);
		}
		currentCase.setCase_title(caseObj.getCase_title());
		currentCase.setCase_brand(caseObj.getCase_brand());
		currentCase.setCase_desc(caseObj.getCase_desc());
		currentCase.setCase_Industry(caseObj.getCase_Industry());
		currentCase.setCase_product(caseObj.getCase_product());
		if(imageArray!=null){
			String sql = "delete from gh_case_image gci where gci.case_id = ?";
			baseCaseImage.executeSql(sql, currentCase.getCase_id());
			JSONArray imageja = JSONArray.fromObject(imageArray);
			for (Object obj : imageja) {
				JSONObject jsonObject = (JSONObject) obj;
				String image = jsonObject.getString("url");
				CaseImage ci = new CaseImage();
				if(image.contains("/temp")){
					String srcImage = jsonObject.getString("url").replace("/ghplat/attachment/temp", "");
					FileUtil.copyFile(beforeUrl+"/temp"+srcImage, beforeUrl+"/case"+srcImage);
					FileUtil.delete(beforeUrl+"/temp"+srcImage);
					ci.setImageUrl("/caseImage"+srcImage);
				}else{
					ci.setImageUrl(jsonObject.getString("url").substring(jsonObject.getString("url").indexOf("/caseImage")));
				}
				ci.setImageTitle(jsonObject.getString("title"));
				ci.setImageDesc(jsonObject.getString("details"));
				ci.setCaseId(currentCase.getCase_id());
				ci.setGhid(UUID.randomUUID().toString().replace("-", ""));
				baseCaseImage.save(ci);
			}
		}
		if(publishArray!=null){
			String sql = "delete from gh_case_detail gcd where gcd.case_id = ?";
			baseCaseImage.executeSql(sql, currentCase.getCase_id());
			JSONArray publishja = JSONArray.fromObject(publishArray);
			for (Object obj : publishja) {
				JSONObject jsonObject = (JSONObject) obj;
				CaseDetails cd = new CaseDetails();
				Publish publish = new Publish();
				publish.setId(jsonObject.getLong("publishId"));
				cd.setPublish(publish);
				cd.setPublishType(jsonObject.getString("publishType"));
				cd.setCaseObj(caseObj);
				cd.setGhid(UUID.randomUUID().toString().replace("-", ""));
				baseCaseDetails.save(cd);
			}
		}
		baseCaseDao.update(currentCase);
	}
	@Override
	public void delete(Long case_id) throws Exception {
		String isql = "delete from gh_case_image gci where gci.case_id = ?";
		baseCaseImage.executeSql(isql, case_id);
		String dsql = "delete from gh_case_detail gcd where gcd.case_id = ?";
		baseCaseImage.executeSql(dsql, case_id);
		this.baseCaseDao.delete(Case.class, case_id);
	}
	
	@Override
	public List<Publish> getCartList(String ids) throws Exception {
		ids = ids.substring(0,ids.lastIndexOf(","));
		String hql ="from Publish gp where gp.id in ("+ids+")";
		List<Publish> plist = this.basePublishDao.findList(hql);
		String psql ="select cpp.column_name,cpp.publish_type,cpp.column_position from cfg_publish_price cpp ";
		List<Object[]> results = this.baseDao.findListBySql(psql);
		for(Publish publish:plist){
			String pricelist = StringUtil.getPublishPrice(publish);
			Map<String,String> priceMap = new HashMap<String,String>();
			for(Object[] objj :results){
				String ptype = (String)objj[1];
				Object ob = objj[2];
				String cposition = null;
				if(ob!=null){
					cposition = String.valueOf(Integer.parseInt(ob.toString()));
				}
				if(ptype.equals(publish.getPublishTypeObj().getPublishFieldId())&&pricelist.contains(cposition)){
					priceMap.put((String)objj[0], StringUtil.getPublishColumnValue(publish, cposition));
				}
				
			}
			publish.setPriceMap(priceMap);
		}
		return plist;
	}
	@Override
	public Publish getpublishDetails(String publishghid) throws Exception {
		String phql = "from Publish p where p.ghid = ?";
		Publish publish = this.basePublishDao.findObject(phql,publishghid);
		String psql ="select cpp.column_name,cpp.publish_type,cpp.column_position from cfg_publish_price cpp ";
		List<Object[]> results = this.baseDao.findListBySql(psql);
		String pricelist = StringUtil.getPublishPrice(publish);
		Map<String,String> priceMap = new HashMap<String,String>();
		for(Object[] objj :results){
			String ptype = (String)objj[1];
			Object ob = objj[2];
			String cposition = null;
			if(ob!=null){
				cposition = String.valueOf(Integer.parseInt(ob.toString()));
			}
			if(ptype.equals(publish.getPublishTypeObj().getPublishFieldId())&&pricelist.contains(cposition)){
				priceMap.put((String)objj[0], StringUtil.getPublishColumnValue(publish, cposition));
			}
			
		}
		publish.setPriceMap(priceMap);
		String infosql = "select cpi.publish_type,cpi.column_name,cpi.column_position from cfg_publish_info cpi";
		List<Object[]> resultsinfo = this.baseDao.findListBySql(infosql);
		String infolist = StringUtil.getPublishInfo(publish);
		Map<String,String> infoMap = new HashMap<String,String>();
		for(Object[] objj :resultsinfo){
			String ptype = (String)objj[0];
			Object ob = objj[2];
			String cposition = null;
			if(ob!=null){
				cposition = String.valueOf(Integer.parseInt(ob.toString()));
			}
			if(ptype.equals(publish.getPublishTypeObj().getPublishFieldId())&&infolist.contains(cposition)){
				infoMap.put((String)objj[1], StringUtil.getPublishColumnValueInfo(publish, cposition));
			}
		}
		publish.setInfoMap(infoMap);
		return publish;
	}

}
