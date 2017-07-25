package com.gh.service;

import com.gh.dto.PublishForm;
import com.gh.model.Advertiser;
import com.gh.model.Media;
import com.gh.util.PageList;

public interface IUserService {

	/**
	 * media登录验证    密码是没有经过处理的
	 */
	public Media userMediaLogin(String account,String password) throws Exception;
	
	
	/**
	 * advertiser登录验证   密码是没有经过处理的
	 */
	public Advertiser userAdvertiserLogin(String account,String password) throws Exception;
	
	/**
	 * 是否存在手机号    type为自媒体，广告主
	 */
	public int isExistsMobile(String mobile,String type) throws Exception;


	/**
	 * 修改密码
	 */
	public void updateUserPassword(String mobile, String password) throws Exception;


	public PageList<Media> getUserlist(PublishForm publishForm) throws Exception;


	public PageList<Advertiser> getUserAdlist(PublishForm publishForm) throws Exception;


	public void updateUserFlag(long userid, String userflag,int type) throws Exception;
	
	
}
