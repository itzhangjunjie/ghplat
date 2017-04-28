package com.gh.service;

import com.gh.model.Advertiser;
import com.gh.model.Media;

public interface IUserService {

	/**
	 * media登录验证    密码是没有经过处理的
	 */
	public Media userMediaLogin(String account,String password) throws Exception;
	
	
	/**
	 * advertiser登录验证   密码是没有经过处理的
	 */
	public Advertiser userAdvertiserLogin(String account,String password) throws Exception;
	
	
	
	
}
