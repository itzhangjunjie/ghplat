package com.gh.model;

import java.util.List;

public class PublishArea {

	private String area_code;
	private String area_name;//
	private String parent_area_code;
	private String pinyin_code;//拼音吗
	private int priority;//优先级
	private String is_enabled;
	
	public String getParent_area_code() {
		return parent_area_code;
	}
	public void setParent_area_code(String parent_area_code) {
		this.parent_area_code = parent_area_code;
	}
	public String getArea_code() {
		return area_code;
	}
	public void setArea_code(String area_code) {
		this.area_code = area_code;
	}
	public String getArea_name() {
		return area_name;
	}
	public void setArea_name(String area_name) {
		this.area_name = area_name;
	}
	public String getPinyin_code() {
		return pinyin_code;
	}
	public void setPinyin_code(String pinyin_code) {
		this.pinyin_code = pinyin_code;
	}
	
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getIs_enabled() {
		return is_enabled;
	}
	public void setIs_enabled(String is_enabled) {
		this.is_enabled = is_enabled;
	}
	
	
}
