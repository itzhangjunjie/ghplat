package com.gh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gh.model.IndexBanner;
import com.gh.model.Publish;
import com.gh.service.IIndexBannerService;
import com.gh.util.PageList;
import com.gh.dao.IBaseDao;
@Service
public class IndexBannerServiceImpl implements IIndexBannerService{

	@Resource
	private IBaseDao<IndexBanner> baseDao;
	@Override
	public PageList<IndexBanner> getBannerList(Map<String, Object> map, PageList page) throws Exception {
		String hql = "from IndexBanner where 1=1 ";
		if(map!=null){
			if(map.containsKey("status")){//-1是已删除   1是正常
				hql = hql + " and status = "+ (int)map.get("status");
			}
			if(map.containsKey("module")&&map.get("module")!=null){//模块类别
				hql = hql + " and module = '"+ (String)map.get("module") +"'";
			}
		}		
		hql = hql +" order by position desc";
		return baseDao.findPageList(hql, page.getPage(), page.getRows());
	}
	
	@Resource
	private IBaseDao<Publish> basePublishDao;
	@Override
	public List<Publish> getBannerPublishList(Map<String, Object> map) throws Exception {
		String pidsSql="select ib.url,ib.type from gh_indexbanner ib where ib.status = 1 ";
		if(map!=null){
			if(map.containsKey("module")){//-1是已删除   1是正常
				pidsSql = pidsSql + " and ib.module = '"+ (String)map.get("module")+"'";
			}
		}
		pidsSql = pidsSql + " order by ib.position desc ";
		List<Object[]> results = this.baseDao.findListBySql(pidsSql);
		String ids = "";
		for(Object[] obj :results){
			ids = ids+(String)obj[0]+",";
		}
		if(!"".equals(ids)){
			ids = ids.substring(0,ids.lastIndexOf(","));
			String phql ="from Publish gp where 1=1 and gp.id in ("+ids+")";
			return this.basePublishDao.findList(phql);
		}
		return null;
	}
	@Override
	public IndexBanner getBannerDetails(Long bannerId) throws Exception {
		return this.baseDao.getById(IndexBanner.class, bannerId);
	}

}
