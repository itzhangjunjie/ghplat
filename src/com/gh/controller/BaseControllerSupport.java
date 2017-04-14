package com.gh.controller;

import java.util.Date;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;
import com.gh.util.DateUtil;
import com.gh.util.FileUtil;
import com.gh.util.PageList;
import com.gh.util.StringUtil;

public class BaseControllerSupport{
	
	@SuppressWarnings("rawtypes")
	protected static PageList page=new PageList();
	protected JSONObject jsonObject = new JSONObject();
	protected static Log logger=LogFactory.getLog(BaseControllerSupport.class);

	static{
		page.setPage(1);
		page.setRows(20);
	}
	
	/**
	 * 上传图片
	 * @param file
	 * @param fileName
	 * @param subFolder
	 * @return
	 */
	public String uploadImage(MultipartFile file,String fileName,String subFolder) throws Exception{
		String ext = FileUtil.getFileExt(fileName);
		String saveName = DateUtil.toString(new Date(), "yyyyMMddHHmmss") + StringUtil.getRandStr(4) + "." + ext;
		String filePath = subFolder+"/"+saveName;
		FileUtil.createFile(file.getInputStream(), filePath);
		return saveName;
	}

	public void deleteImage(String filePath){
		FileUtil.delete(filePath);
	}
	
	@SuppressWarnings("rawtypes")
	public PageList getPage() {
		return page;
	}


	@SuppressWarnings({ "rawtypes", "static-access" })
	public void setPage(PageList page) {
		this.page = page;
	}
	
}
