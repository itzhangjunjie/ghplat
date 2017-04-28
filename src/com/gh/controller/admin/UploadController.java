package com.gh.controller.admin;

import javax.servlet.http.HttpServletRequest;
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

}
