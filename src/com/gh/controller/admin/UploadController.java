package com.gh.controller.admin;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gh.controller.BaseControllerSupport;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin")
public class UploadController extends BaseControllerSupport {

	@RequestMapping(value = "/uploadContent", method = RequestMethod.POST)
	public @ResponseBody String upload(HttpServletRequest request, @RequestParam("file") MultipartFile file) throws Exception {
		try {
			jsonObject.put("code", -1);
			if (null != file) {
				String saveName = uploadImage(file, file.getOriginalFilename(),
						request.getSession().getServletContext().getRealPath("/attachment") + "/" + "uploadFile");
				jsonObject.put("code", 0);
				JSONObject data = new JSONObject();
				data.put("src", "/ghplat/attachment/uploadFile/" + saveName);
				jsonObject.put("data", data);
			}
		} catch (Exception ex) {
			logger.error("上传文件异常，ex=", ex);
			jsonObject.put("code", -1);
			ex.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/uploadImage")
	public @ResponseBody String uploadImage(HttpServletRequest request, @RequestParam MultipartFile[] files) throws Exception {
		try {
			jsonObject.put("code", -1);
			if(files!=null&&files.length>0){  
				String bepath = request.getSession().getServletContext().getRealPath("/attachment");
				List<String> imageList = new ArrayList<String>();
				//循环获取file数组中得文件 
	            for(int i = 0;i<files.length;i++){  
	                MultipartFile file = files[i]; 
	                if (null != file) {
	                	String saveName = uploadImage(file, file.getOriginalFilename(),
	                			bepath+ "/" + "temp");
	                	System.out.println(saveName);
	                	imageList.add("/ghplat/attachment/temp/" + saveName);
	                }
	            }  
	            if(imageList.size()>0){
	            	jsonObject.put("imageList", imageList);
	            }
	            jsonObject.put("length", files.length);
	            jsonObject.put("code", 0);
	        }  
		} catch (Exception ex) {
			logger.error("上传文件异常，ex=", ex);
			jsonObject.put("code", -1);
			ex.printStackTrace();
		}
		return jsonObject.toString();
	}

	@RequestMapping(value = "/upImg", method = RequestMethod.POST)
	public @ResponseBody String upImg(HttpServletRequest request, @RequestParam("file") MultipartFile file) throws Exception {
		try {
			jsonObject.put("err", "");
			if (null != file) {
				String saveName = uploadImage(file, file.getOriginalFilename(),
						request.getSession().getServletContext().getRealPath("/attachment") + "/" + "uploadFile");
				jsonObject.put("msg", "!/ghplat/attachment/uploadFile/" + saveName);
			}
		} catch (Exception ex) {
			logger.error("上传文件异常，ex=", ex);
			jsonObject.put("err", "yes");
			ex.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "/upploadImg", method = RequestMethod.POST)
    public @ResponseBody String upploadImg(HttpServletRequest request, HttpServletResponse response) throws Exception{
			int i = request.getContentLength();
	        byte buffer[] = new byte[i];
	        int j = 0;
	        while (j < i) { //获取表单的上传文件
	            int k = request.getInputStream().read(buffer, j, i - j);
	            j += k;
	        }
	        String url = null;
        	if (buffer.length >= 0) { //文件是否为空
		       String timeTamp = new Date().getTime() + "";
		       url = "../../attachment/uploadFile/"+timeTamp+".jpg";
		       File file = new File(request.getSession().getServletContext().getRealPath("/attachment/uploadFile") +"/"+timeTamp+".jpg");  
		       OutputStream output = new FileOutputStream(file);  
		       BufferedOutputStream bufferedOutput = new BufferedOutputStream(output);  
		       bufferedOutput.write(buffer);  
        	}
            return "{\"err\":\"\",\"msg\":\""+url+"\"}";
    }
	
}
