package com.gh.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

public class PropertiesFileUtil {

	
	
	/**
	* @Title: readProperty
	* @Description: TODO(读取配置文件)
	* @param @param path mail 配置文件路径
	* @param
	* @return Map<String,String>    返回类型
	* @throws
	*/
	public  static  Map<String,String> readProperty(String path){
		try{
			Properties pro = new Properties();
			pro.load(PropertiesFileUtil.class.getResourceAsStream(path));
			Set<Object> keySet = pro.keySet();
			Map<String,String>  valueMap = new HashMap<String,String>(keySet.size());
			Iterator<Object> it = keySet.iterator();
			while (it.hasNext()) {
				String key = (String) it.next();
				valueMap.put(key, pro.getProperty(key));
			}
			return valueMap;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
