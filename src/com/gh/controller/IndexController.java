package com.gh.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class IndexController extends BaseControllerSupport{

	
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String index(HttpServletRequest request){
		request.setAttribute("ss", "123");
		return "/index";
	}
	
}
