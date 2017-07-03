package com.gh.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gh.dto.PublishForm;
import com.gh.model.Advertiser;
import com.gh.model.Media;
import com.gh.model.Order;
import com.gh.model.Publish;
import com.gh.service.IBaseService;
import com.gh.service.IOrderService;
import com.gh.service.IPublishService;
import com.gh.util.PageList;
import com.gh.util.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/")
public class OrderController extends BaseControllerSupport{

	@Resource
	private IOrderService orderService;
	
	
	@RequestMapping(value = "/deleteOrder", method = {RequestMethod.POST})
	public @ResponseBody String deleteOrder(HttpServletRequest request){
		try {
			long orderId = Long.parseLong(request.getParameter("orderId"));
			orderService.deleteOrder(orderId);
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	@RequestMapping(value = "/getOrderList", method = {RequestMethod.GET})
	public String getOrderList(PublishForm publishForm,HttpServletRequest request){
		try {
			if(request.getSession().getAttribute("user")==null){
				return "redirect:/index";
			}else{
				String type = (String)request.getSession().getAttribute("type");
				long userid = 0;
				if("自媒体".equals(type)){
					Media media = (Media)request.getSession().getAttribute("user");
					userid = media.getId();
				}else{
					Advertiser adver = (Advertiser)request.getSession().getAttribute("user");
					userid = adver.getId();
				}
				PageList<Order> orderList = orderService.getOrderList(publishForm,userid);
				request.setAttribute("orderlist", orderList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/person";
	}
	@RequestMapping(value = "/saveOrder", method = {RequestMethod.POST})
	public @ResponseBody String saveOrder(HttpServletRequest request,String orderArray){
		jsonObject.clear();
		try {
			if(request.getSession().getAttribute("user")==null){
				jsonObject.put("result", "no");
				return jsonObject.toString();
			}else{
				String type = (String)request.getSession().getAttribute("type");
				int typeint = 1;
				long userid = 0;
				if("自媒体".equals(type)){
					Media media = (Media)request.getSession().getAttribute("user");
					typeint = 1;//自媒体
					userid = media.getId();
				}else{
					Advertiser adver = (Advertiser)request.getSession().getAttribute("user");
					typeint = 2;//广告主
					userid = adver.getId();
				}
				String totalPrice = request.getParameter("totalPrice");
				String flag = request.getParameter("wtdlfalge");
				orderService.saveOrder(typeint, userid, orderArray,totalPrice,flag);
				jsonObject.put("result", "yes");
			}
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/downFile", method = {RequestMethod.GET})
	public String downFile(HttpServletRequest request, HttpServletResponse response){
		String fileUrl = request.getSession().getServletContext().getRealPath("/attachment/cartFile/cartItemList.xlsx");
		String fileName = StringUtil.getRandStr(10).toString()+"-cart.xlsx";
	      response.setCharacterEncoding("utf-8");
			response.setContentType("multipart/form-data");
			response.setHeader("Content-Disposition", "attachment;fileName="
					+ fileName);
			try {
				InputStream inputStream = new FileInputStream(new File(fileUrl));
				OutputStream os = response.getOutputStream();
				byte[] b = new byte[2048];
				int length;
				while ((length = inputStream.read(b)) > 0) {
					os.write(b, 0, length);
				}
				 // 这里主要关闭。
				os.close();
				inputStream.close();
			} catch (Exception e) {
				e.printStackTrace();
			} 
	            //  返回值要注意，要不然就出现下面这句错误！
	            //java+getOutputStream() has already been called for this response
			return null;
	}
	
	@Resource
	private IBaseService<Publish> basePublishService;
	
	@RequestMapping(value = "/orderExport", method = {RequestMethod.POST})
	public @ResponseBody String orderExport(HttpServletRequest request, HttpServletResponse response,String orderArray){
		FileOutputStream output = null;
		 try{
			 String fileUrl = request.getSession().getServletContext().getRealPath("/attachment/cartFile/cartItemList.xlsx");
			 System.out.println(fileUrl);
			 File file = new File(fileUrl);
			 if(!file.exists()){
				 file.createNewFile();
			 }
			JSONArray jaobj = JSONArray.fromObject(orderArray);
			InputStream stream = new FileInputStream(file);
		    XSSFWorkbook xssfWorkbook = new XSSFWorkbook(stream);  
		      output = new FileOutputStream(file); 
		      XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(0);  
		      if(jaobj.size()>0){
		    	  XSSFRow xssfRow = xssfSheet.createRow(0);
		    	  XSSFCell c0 = xssfRow.createCell(0);
		    	  c0.setCellValue("广告主题");
		    	  XSSFCell c1 = xssfRow.createCell(1);
		    	  c1.setCellValue("类型");
		    	  XSSFCell c2 = xssfRow.createCell(2);
		    	  c2.setCellValue("投放格式");
		    	  XSSFCell c3 = xssfRow.createCell(3);
		    	  c3.setCellValue("价格");
		    	  XSSFCell c4 = xssfRow.createCell(4);
		    	  c4.setCellValue("粉丝数");
	//				    	  XSSFCell c5 = xssfRow.createCell(5);
	//				    	  c5.setCellValue("阅读数");
		      }
		      for(int rowNum = 1; rowNum <= jaobj.size(); rowNum++ ){
		    	  JSONObject obj = (JSONObject)jaobj.get(rowNum-1);
					long publishId = Long.parseLong(obj.getString("publishId"));
					String priceStr = obj.getString("priceStr");
					String price = obj.getString("price");
					Publish publish = basePublishService.getById(Publish.class, publishId);
		    	    XSSFRow xssfRow = xssfSheet.createRow(rowNum);
			        XSSFCell c = xssfRow.createCell(0);
					c.setCellValue(publish.getPublishName());
					XSSFCell c1 = xssfRow.createCell(1);
					c1.setCellValue(publish.getPublishTypeObj().getPublishFieldName());
					XSSFCell c2 = xssfRow.createCell(2);
					c2.setCellValue(priceStr);
					XSSFCell c3 = xssfRow.createCell(3);
					c3.setCellValue(price);
					XSSFCell c4 = xssfRow.createCell(4);
					c4.setCellValue(publish.getPlatformFans());
		      }
	      xssfWorkbook.write(output);
	      output.close();
	      jsonObject.put("result", "yes");
		}catch(Exception e){
			System.out.println("读取失败！");
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		 return jsonObject.toString();
	}
}
