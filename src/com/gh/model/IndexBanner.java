package com.gh.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
@Entity
@Table(name = "GH_INDEXBANNER")
@SequenceGenerator(name="indexBanner_seq",sequenceName="SEQ_INDEXBANNER_ID")  
public class IndexBanner {
    @Id
    @Column(name = "INDEXBANNER_ID")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="indexBanner_seq")
	private long indexBannerId;
    @Column(name = "TITLE")
    private String title;//标题
    @Column(name = "MODULE")
	private String module;//模块   首页banner  自媒体展示      联合推广资源      我们的合作伙伴
    @Column(name = "TYPE")
	private String type;//类型     静态图     外链     内链      自媒体展示
    @Column(name = "IMAGE")
    private String image;//图片
    @Column(name = "URL")
    private String url;//链接
    @Column(name = "CONTENT")
    private String content;//内容
    @Column(name = "POSITION")
	private int position;//排序
    @Column(name = "STATUS")
	private int status;//状态   -1是删除   1是正常
    @Column(name = "CREATE_TIME")
	private Date createTime;
	
	
	public long getIndexBannerId() {
		return indexBannerId;
	}
	public void setIndexBannerId(long indexBannerId) {
		this.indexBannerId = indexBannerId;
	}
	public String getModule() {
		return module;
	}
	public void setModule(String module) {
		this.module = module;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getPosition() {
		return position;
	}
	public void setPosition(int position) {
		this.position = position;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
