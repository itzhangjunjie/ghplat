package com.gh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gh.dao.IBaseDao;
import com.gh.dto.PublishForm;
import com.gh.model.Content;
import com.gh.service.IContentService;
import com.gh.util.PageList;
@Service
public class ContentServiceImpl implements IContentService{

	@Resource
	private IBaseDao<Content> baseContentDao;
	
	@Override
	public PageList<Content> getContentList(PublishForm publishForm) {
		String hql = "from Content c where 1=1 " ;
		if(publishForm!=null){
			if(publishForm.getSearchStr()!=null&&!"".equals(publishForm.getSearchStr())){
				hql = hql + " and c.title like '%"+publishForm.getSearchStr()+"%'";
			}
			if(publishForm.getPublishStatus()!=null&&!"100".equals(publishForm.getPublishStatus())){
				hql = hql + " and c.status = "+publishForm.getPublishStatus();
			}else{
				hql = hql +" and c.status != '-1' ";
			}
			if(publishForm.getPublishName()!=null&&!"".equals(publishForm.getPublishName())){
				hql = hql + " and c.publish.publishName like '%"+publishForm.getPublishName()+"%'";
			}
		}
		hql = hql +" order by c.createTime desc ";
		PageList<Content> resultPage = baseContentDao.findPageList(hql, publishForm.getPageSize(), publishForm.getPageCount());
		return resultPage;
	}

	@Override
	public void updateContent(long parseLong, String status) {
		String sql="update gh_content gd set gd.status = "+status+" where gd.id = "+parseLong;
		this.baseContentDao.executeSql(sql);
	}

}
