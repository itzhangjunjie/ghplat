package com.gh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gh.dao.IBaseDao;
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
				hql = hql +" and gp.publishType = "+publishForm.getPublishType();
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
	@Override
	public List<CaseDTO> getCaseList(PublishForm publishForm) throws Exception {
		String hql ="from Case case where 1=1 ";
		if(publishForm!=null){
			if(publishForm.getPublishStatus()!=null){
				hql = hql +" and case.case_status= '"+publishForm.getPublishStatus()+"' ";
			}
			if(publishForm.getMediaId()!=0){
				hql = hql +" and case.media_id= "+publishForm.getMediaId();
			}
		}
		hql = hql +" order by case.case_publish_time desc";
		PageList<Case> resultPage = this.baseCaseDao.findPageList(hql, publishForm.getPageSize(), publishForm.getPageCount());
		List<Long> caseIds = new ArrayList<Long>();
		List<CaseDTO> caseDTOs = new ArrayList<CaseDTO>();
		for(Case caseObj:resultPage.getList()){
			CaseDTO cdto = new CaseDTO();
			cdto.setCaseObj(caseObj);
			caseIds.add(caseObj.getCase_id());
			caseDTOs.add(cdto);
		}
		
		String phql ="from CaseDetails cd where cd.caseId in (?) ";
		List<Publish> plist = this.baseDao.findList(phql, caseIds);
		
		String cimaghql = "from CaseImage ci where ci.caseId in (?)";
		List<CaseImage> pImagelist = this.baseDao.findList(cimaghql, caseIds);
		
		
		for(CaseDTO caseDto:caseDTOs){
			for(Publish pb:plist){
				if(pb.getId()==caseDto.getCaseObj().getCase_id()){
					
				}
			}
		}
		System.out.println(plist.size());
		return null;
	}
	@Resource
	private IBaseDao<CaseImage> baseCaseImage;
	@Resource
	private IBaseDao<CaseDetails> baseCaseDetails;
	
	@Override
	public void saveCase(Case caseObj, String imageArray, String publishArray,String beforeUrl) throws Exception {
		long caseId = this.baseCaseDao.save(caseObj);
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
				cd.setPublishId(jsonObject.getLong("publishId"));
				cd.setPublishType(jsonObject.getString("publishType"));
				cd.setCaseId(caseId);
				cd.setGhid(UUID.randomUUID().toString().replace("-", ""));
				baseCaseDetails.save(cd);
			}
		}
		
	}

}
