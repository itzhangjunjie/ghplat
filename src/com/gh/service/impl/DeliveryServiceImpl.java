package com.gh.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gh.dao.IBaseDao;
import com.gh.dto.PublishForm;
import com.gh.model.Delivery;
import com.gh.service.IDeliveryService;
import com.gh.util.PageList;
@Service
public class DeliveryServiceImpl implements IDeliveryService{

	@Resource
	private IBaseDao<Delivery> baseDeliveryDao;
	
	@Override
	public PageList<Delivery> getDeliveryList(PublishForm publishForm) throws Exception {
		String hql = "from Delivery d where 1=1 " ;
		if(publishForm!=null){
			if(publishForm.getSearchStr()!=null&&!"".equals(publishForm.getSearchStr())){
				hql = hql + " and d.title like '%"+publishForm.getSearchStr()+"%'";
			}
			if(publishForm.getPublishStatus()!=null&&!"100".equals(publishForm.getPublishStatus())){
				hql = hql + " and d.status = "+publishForm.getPublishStatus();
			}
			if(publishForm.getPublishName()!=null&&!"".equals(publishForm.getPublishName())){
				hql = hql + " and d.advertiser.username like '%"+publishForm.getPublishName()+"%'";
			}
			if(publishForm.getPublishId()!=0){
				hql = hql + " and d.advertiser.id ="+publishForm.getPublishId();
			}
		}
		hql = hql +" order by d.createTime desc ";
		PageList<Delivery> resultPage = baseDeliveryDao.findPageList(hql, publishForm.getPageSize(), publishForm.getPageCount());
		return resultPage;
	}

	@Override
	public void updateDelivery(Long deliveryId, String status) throws Exception {
		String sql="update gh_delivery gd set gd.status = "+status+" where gd.id = "+deliveryId;
		this.baseDeliveryDao.executeSql(sql);
	}

	
	
}
