package com.gh.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.gh.model.IndexBanner;
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

}
