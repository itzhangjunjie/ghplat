package com.gh.test;

import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.gh.dto.PublishForm;
import com.gh.dto.PublishTypeDTO;
import com.gh.service.IPublishService;

import net.sf.json.JSONObject;

@RunWith(SpringJUnit4ClassRunner.class)  //使用junit4进行测试  
@ContextConfiguration(locations = "classpath:beans.xml")
public class DataImportTest {

	@Resource
	private IPublishService publishService;
	
	
	@Test
	@Transactional   //标明此方法需使用事务  
    @Rollback(false) 
	public void testImportUser(){
		try {
//			JSONObject jsonObject = new JSONObject();
//			List<PublishTypeDTO> pts = publishService.getPublishType();
//			for(PublishTypeDTO pt :pts){
//				System.out.println(pt.getPublishFieldList().size()+"||"+pt.getPublishName());
//			}
			PublishForm pf = new PublishForm();
			pf.setMediaId(1);
			publishService.getCaseList(pf);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
