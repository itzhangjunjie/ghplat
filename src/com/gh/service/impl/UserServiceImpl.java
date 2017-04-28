package com.gh.service.impl;

import java.util.Date;

import org.springframework.stereotype.Service;

import com.gh.dao.IBaseDao;
import com.gh.model.Advertiser;
import com.gh.model.Media;
import com.gh.service.IUserService;
import com.gh.util.StringUtil;
@Service
public class UserServiceImpl implements IUserService{

	private IBaseDao<Advertiser> advertiserDao;
	private IBaseDao<Media> mediaDao;
	
	
	@Override
	public Media userMediaLogin(String account, String password) throws Exception {
		String hql ="from Media m where m.mobile = ? and status = 1";
		Media media = mediaDao.findObject(hql, account);
		if(media==null){
			return null;
		}else{
			if(!media.getPassword().equals(StringUtil.md5(password))){
				return null;
			}else{
				//处理登录后的字段
				media.setLastLoginTime(new Date());
				mediaDao.update(media);
				return media;
			}
		}
	}
	
	
	public Advertiser userAdvertiserLogin(String account,String password) throws Exception{
		String hql ="from Advertiser a where a.mobile = ? and status = 1";
		Advertiser advertiser = advertiserDao.findObject(hql, account);
		if(advertiser==null){
			return null;
		}else{
			if(!advertiser.getPassword().equals(StringUtil.md5(password))){
				return null;
			}else{
				//处理登录后的字段
				advertiser.setLastLoginTime(new Date());
				advertiserDao.update(advertiser);
				return advertiser;
			}
		}
	}
	
	
}
