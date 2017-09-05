package com.gh.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.net.InetAddress;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gh.model.Advertiser;
import com.gh.model.IndexBanner;
import com.gh.model.Media;
import com.gh.model.Publish;
import com.gh.service.IBaseService;
import com.gh.service.IIndexBannerService;
import com.gh.service.IUserService;
import com.gh.util.EmailSend;
import com.gh.util.PageList;
import com.gh.util.SendMessageUtil;
import com.gh.util.StringUtil;

@Controller
@RequestMapping("/")
public class IndexController extends BaseControllerSupport{

	@Resource
	private IIndexBannerService bannerService;
	@Resource
	private IBaseService<IndexBanner> baseService;
	
	@RequestMapping(value="/abortUs",method=RequestMethod.GET)
	public String abortUs(HttpServletRequest request){
		try {
			String type = request.getParameter("type");
			request.setAttribute("type", type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/front/abortUs";
	}
	
	@RequestMapping(value="/getBannerDetails",method=RequestMethod.GET)
	public String getBannerDetails(HttpServletRequest request){
		try {
			Long bannerId = Long.parseLong(request.getParameter("bannerId"));
			IndexBanner ib = bannerService.getBannerDetails(bannerId);
			request.setAttribute("bannerDetails", ib);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("获取banner列表失败!");
		}
		return "/front/bannerDetails";
	}
	
	
	@RequestMapping(value="/",method=RequestMethod.GET)
	public String index(HttpServletRequest request){
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("status", 1);
			map.put("module", "首页banner");// 首页banner  
			page.setRows(5);
			PageList<IndexBanner> banners = bannerService.getBannerList(map,page);
			System.out.println("banners:"+banners.getList().size());
			request.setAttribute("bannerlist", banners);
			map.put("module", "联合推广资源");// 联合推广资源 
			page.setRows(20);
			PageList<IndexBanner> tuiguangs = bannerService.getBannerList(map,page);
			request.setAttribute("tuiguangs", tuiguangs);
			System.out.println("tuiguangs:"+tuiguangs.getList().size());
			map.put("module", "自媒体展示");// 我们的合作伙伴  
			List<Publish> zimeitis = bannerService.getBannerPublishList(map);
			request.setAttribute("zimeitilist", zimeitis);
			page.setRows(20);
			map.put("module", "我们的合作伙伴");// 我们的合作伙伴
			PageList<IndexBanner> hezuos = bannerService.getBannerList(map,page);
			request.setAttribute("hezuos", hezuos);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("获取banner列表失败!");
		}
		return "/front/index";
	}
	
	
	@Resource
	private IUserService userService;
	@RequestMapping(value="/sendCodeMsg")
	public @ResponseBody String sendCodeMsg(HttpServletRequest request){
		try {
			jsonObject.clear();
			String mobile = request.getParameter("mobile");
			String type = request.getParameter("type");
			if(mobile!=null){
				if(userService.isExistsMobile(mobile, type)==-1){
					String code = StringUtil.getRandStr(4);
					if(type.equals("修改密码")){
						SendMessageUtil.sendMessage("【勾画互动】修改密码"+type+"，验证码："+code, mobile);
					}else{
						SendMessageUtil.sendMessage("【勾画互动】你正在注册"+type+"，验证码："+code, mobile);
					}
					//request.getSession().setAttribute("regCode", code);
					jsonObject.put("code", code);
					jsonObject.put("result", "yes");
				}else{
					jsonObject.put("result", "no");
					jsonObject.put("reason", "手机号已存在");
				}
			}else{
				jsonObject.put("result", "no");
				jsonObject.put("reason", "手机号为空");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	@RequestMapping(value="/sendPasswordCodeMsg")
	public @ResponseBody String sendPasswordCodeMsg(HttpServletRequest request){
		try {
			jsonObject.clear();
			String mobile = request.getParameter("mobile");
			String type = request.getParameter("type");
			if(mobile!=null){
				if(userService.isExistsMobile(mobile, type)==1){
					String code = StringUtil.getRandStr(4);
					if(type.equals("修改密码")){
						SendMessageUtil.sendMessage("【勾画互动】修改密码"+type+"，验证码："+code, mobile);
					}else{
						SendMessageUtil.sendMessage("【勾画互动】你正在注册"+type+"，验证码："+code, mobile);
					}
					jsonObject.put("code", code);
					jsonObject.put("result", "yes");
				}else{
					jsonObject.put("result", "no");
					jsonObject.put("reason", "手机号未注册");
				}
			}else{
				jsonObject.put("result", "no");
				jsonObject.put("reason", "手机号为空");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	@RequestMapping(value="/updatePassword")
	public @ResponseBody String updatePassword(HttpServletRequest request){
		try {
			 jsonObject.clear();
			 String mobile = request.getParameter("mobile");
			 String password = request.getParameter("password");
			 userService.updateUserPassword(mobile,password);
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	@Resource
	private IBaseService<Media> baseMediaService;
	@Resource
	private IBaseService<Advertiser> baseAdvertiserService;
	@RequestMapping(value="/register")
	public @ResponseBody String register(HttpServletRequest request){
		try {
			 jsonObject.clear();
			 String mobile = request.getParameter("mobile");
			 String username = request.getParameter("username");
			 String email = request.getParameter("email");
			 String password = request.getParameter("password");
			 String qqweixin = request.getParameter("qqweixin");
			 String companyname = request.getParameter("companyname");
			 String type = request.getParameter("type");
			 if("自媒体".equals(type)){
				 Media media = new Media();
				 media.setMobile(mobile);
				 media.setUsername(username);
				 media.setEmail(email);
				 media.setPassword(StringUtil.md5(password));
				 media.setQq(qqweixin);
				 media.setWechat(qqweixin);
				 media.setStatus("1");
				 media.setUserFlag("00000000000000000000");
				 media.setCorporation_name(companyname);
				 media.setGhid(UUID.randomUUID().toString().replace("-", ""));
				 media.setSignUpTime(new Date());
				 baseMediaService.save(media);
				 EmailSend.sendMail("新用户注册-自媒体", "用户名："+username+"|手机号："+mobile+"|qq:"+qqweixin+"|weixin:"+qqweixin);
			 }else if("广告主".equals(type)){
				 Advertiser ad = new Advertiser();
				 ad.setMobile(mobile);
				 ad.setUsername(username);
				 ad.setEmail(email);
				 ad.setPassword(StringUtil.md5(password));
				 ad.setQq(qqweixin);
				 ad.setWechat(qqweixin);
				 ad.setStatus("1");
				 ad.setUserFlag("00000000000000000000");
				 ad.setCorporation_name(companyname);
				 ad.setGhid(UUID.randomUUID().toString().replace("-", ""));
				 ad.setSignUpTime(new Date());
				 baseAdvertiserService.save(ad);
				 EmailSend.sendMail("新用户注册-广告主", "用户名："+username+"|手机号："+mobile+"|qq:"+qqweixin+"|weixin:"+qqweixin);
			 }
			 jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	
	@RequestMapping(value="/vefityMobile")
	public @ResponseBody String vefityMobile(HttpServletRequest request){
		try {
			 jsonObject.clear();
			 String index = request.getParameter("index");
			 String mobile = request.getParameter("mobile");
			 int isexists = userService.isExistsMobile(mobile, index);
			 if(isexists==-1){
				 jsonObject.put("result", "yes");
			 }else{
				 jsonObject.put("result", "no");
			 }
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/login")
	public @ResponseBody String login(HttpServletRequest request){
		try {
			 jsonObject.clear();
			 String mobile = request.getParameter("mobile");
			 String password = request.getParameter("password");
			 String type = request.getParameter("type");
			 String strCode = request.getParameter("strCode");
			 String sessionStrCode = (String) request.getSession().getAttribute("strCode");
			 if(!strCode.equals(sessionStrCode)){
				 jsonObject.put("result", "no");
				 jsonObject.put("reason", "验证码不对");
				 return jsonObject.toString();
			 }
			 if("自媒体".equals(type)){
				 Media media = userService.userMediaLogin(mobile, password);
				 if(media!=null){
					 request.getSession().setAttribute("user", media);
					 request.getSession().setAttribute("type", "自媒体");
					 jsonObject.put("result", "yes");
				 }else{
					 jsonObject.put("result", "no");
					 jsonObject.put("reason", "用户名或密码不对");
				 }
			}else if("广告主".equals(type)){
				Advertiser ad = userService.userAdvertiserLogin(mobile, password);
				if(ad!=null){
					InetAddress ia = InetAddress.getLocalHost();
					String macStr = SendMessageUtil.getLocalMac(ia);
					String userflag = ad.getUserFlag().substring(0, 1);
					if(!ad.getMachineId().equals(macStr)&&userflag.equals("1")){
						 jsonObject.put("result", "no");
						 jsonObject.put("reason", "只能在一台机器下登陆");
					}
					 request.getSession().setAttribute("user", ad);
					 request.getSession().setAttribute("type", "广告主");
					 jsonObject.put("result", "yes");
				 }else{
					 jsonObject.put("result", "no");
					 jsonObject.put("reason", "用户名或密码不对");
				 }
			}
		} catch (Exception e) {
			jsonObject.put("result", "no");
			jsonObject.put("reason", "系统错误");
			e.printStackTrace();
			logger.error(e);
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/exit")
	public @ResponseBody String exit(HttpServletRequest request){
		try {
			 jsonObject.clear();
			request.getSession().removeAttribute("user");
			request.getSession().removeAttribute("type");
			jsonObject.put("result", "yes");
		} catch (Exception e) {
			jsonObject.put("result", "no");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
	@RequestMapping(value="/authCode")
    public void getAuthCode(HttpServletRequest request, HttpServletResponse response){
		try {
			int width = 63;
			int height = 37;
			Random random = new Random();
			//设置response头信息
			//禁止缓存
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			
			//生成缓冲区image类
			BufferedImage image = new BufferedImage(width, height, 1);
			//产生image类的Graphics用于绘制操作
			Graphics g = image.getGraphics();
			//Graphics类的样式
			g.setColor(this.getRandColor(200, 250));
			g.setFont(new Font("Times New Roman",0,28));
			g.fillRect(0, 0, width, height);
			//绘制干扰线
			for(int i=0;i<40;i++){
				g.setColor(this.getRandColor(130, 200));
				int x = random.nextInt(width);
				int y = random.nextInt(height);
				int x1 = random.nextInt(12);
				int y1 = random.nextInt(12);
				g.drawLine(x, y, x + x1, y + y1);
			}
			
			//绘制字符
			String strCode = "";
			for(int i=0;i<4;i++){
				String rand = String.valueOf(random.nextInt(10));
				strCode = strCode + rand;
				g.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));
				g.drawString(rand, 13*i+6, 28);
			}
			//将字符保存到session中用于前端的验证
			request.getSession().setAttribute("strCode", strCode);
			g.dispose();
			
			ImageIO.write(image, "JPEG", response.getOutputStream());
			response.getOutputStream().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}

    }
	
	//创建颜色
   public Color getRandColor(int fc,int bc){
        Random random = new Random();
        if(fc>255)
            fc = 255;
        if(bc>255)
            bc = 255;
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r,g,b);
    }
}
