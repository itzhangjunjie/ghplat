package com.gh.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期相关的操作
 * @author Dawei
 *
 */

public class DateUtil {

	public static void main(String[] args) {
		String str = getShowDate(new Date(1500282543000L));
		System.out.println(str);
	}
	public static String getShowDate(Date date){
		SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
		Calendar nowC = Calendar.getInstance();
		Date nowDate = new Date();
		nowC.setTime(nowDate);
		int nowYear = nowC.get(Calendar.YEAR);
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		int year = c.get(Calendar.YEAR );
		String showDate = "";
		
		long minute = Math.abs((nowDate.getTime()-date.getTime())/(60*1000));
		if(minute<60){//分钟显示格式
			if(minute == 0){
				showDate = "刚刚";
			}else{
				showDate = (int)minute+"分前";
			}
		}else if(minute/60<24){//小时显示格式
			int diffHour = (int) (minute/60);
			showDate = diffHour+"小时前";
		}else if(minute/60/24<7){
			int diffDay = (int) (minute/60/24);
			showDate = diffDay+"天前";
		}else if(year == nowYear){
			sdf = new SimpleDateFormat("MM-dd");
			showDate = sdf.format(date);
		}else{
			showDate = sdf.format(date);
		}
		return showDate;
	}
	/**
	 * 将一个字符串转换成日期格式
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static Date toDate(String date, String pattern) {
		if((""+date).equals("")){
			return null;
		}
		if(pattern == null){
			pattern = "yyyy-MM-dd";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		Date newDate = new Date();
		try {
			newDate = sdf.parse(date);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return newDate;
	}
	
	/**
	 * 把日期转换成字符串型
	 * @param date
	 * @param pattern
	 * @return
	 */
	public static String toString(Date date, String pattern){
		if(date == null){
			return "";
		}
		if(pattern == null){
			pattern = "yyyy-MM-dd";;
		}
		String dateString = "";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		try {
			dateString = sdf.format(date);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return dateString;
	}
	
}
