package com.gh.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;


public class DataExport {

	public static void main(String[] args) {
		writeXlsx("E:/cartItemList.xlsx");
	}
	
	public static void writeXlsx(String fileUrl){
	     FileOutputStream output = null;
		 try{
				InputStream stream = new FileInputStream(fileUrl);
			    XSSFWorkbook xssfWorkbook = new XSSFWorkbook(stream);  
			      int totalSheets = xssfWorkbook.getNumberOfSheets();
			      System.out.println("表总共的数量为"+totalSheets);
			      output = new FileOutputStream(fileUrl); 
			      for(int numSheet = 0; numSheet < totalSheets; numSheet++){ 
			    	  System.out.println("处理第"+numSheet+"个表格");
				      XSSFSheet xssfSheet = xssfWorkbook.getSheetAt( numSheet);  
				      if(xssfSheet == null){  
				         break;  
				      } 
				     // int lastNum = xssfSheet.getLastRowNum();
				      for(int rowNum = 1; rowNum <= 2; rowNum++ ){
				    	    XSSFRow xssfRow = xssfSheet.createRow(0);
					        //XSSFRow xssfRow = xssfSheet.getRow( rowNum);
					        if(xssfRow == null){
					        	System.out.println("rownum"+rowNum+"  空");
					        	break;
					        }
					        XSSFCell c = xssfRow.createCell(0);
							c.setCellValue(100);
							XSSFCell c2 = xssfRow.createCell(1);
							c2.setCellValue(200);
							XSSFCell c3 = xssfRow.createCell(2);
							c3.setCellValue(3300);
				      }
			      }
			      xssfWorkbook.write(output);
			      output.close();
				}catch(Exception e){
					System.out.println("读取失败！");
					e.printStackTrace();
				}finally{
				}
		  
	} 
	
	 /**
	   * 获取表格的数据
	 * @param xssfCell
	 * @return
	 */
	private static String getValue(XSSFCell xssfCell){ 
		if(xssfCell == null){
			return null;
		}
		    if(xssfCell.getCellType() == xssfCell.CELL_TYPE_BOOLEAN){  
		      return String.valueOf( xssfCell.getBooleanCellValue());  
		    }else if(xssfCell.getCellType() == xssfCell.CELL_TYPE_NUMERIC){ 
		    	if(HSSFDateUtil.isCellDateFormatted(xssfCell)){
		    		//用于转化为日期格式
		    		Date d = xssfCell.getDateCellValue();

		    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		    		return sdf.format(d);
		    	}else{
		    		double a = xssfCell.getNumericCellValue();
			    	BigDecimal b = new BigDecimal(a);	    		    	
			    	return b.toPlainString();
		    	}
		    	
		     // return Integer.parseInt((int)getNumericCellValue());  
		    }else{  
		      return String.valueOf( xssfCell.getStringCellValue());  
		    }  
	} 
}
