package com.gh.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class ContentController extends BaseControllerSupport{

	
	@RequestMapping(value="/contentadd",method=RequestMethod.GET)
	public String persionad(HttpServletRequest request){
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/contentadd";
	}
	
	
}
