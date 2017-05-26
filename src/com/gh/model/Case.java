package com.gh.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="GH_CASE")
@SequenceGenerator(name="case_seq",sequenceName="SEQ_CASE_ID")
public class Case {
	
	
	 /*
     * cascade：为级联操作，里面有级联保存，级联删除等，all为所有 
     * fetch：加载类型，有lazy和eager二种，
     *   eager为急加载，意为立即加载，在类加载时就加载，lazy为慢加载，第一次调用的时候再加载，由于数据量太大，onetomany一般为lazy
     * mappedBy：这个为manytoone中的对象名，这个不要变哦
     * Set<role>：这个类型有两种，一种为list另一种为set
     * 
     *
     */
    @OneToMany(cascade=CascadeType.ALL,fetch=FetchType.LAZY)
    @JoinColumn(name="CASE_ID")
	private List<CaseImage> caseImageList;
    
    @Transient
    private List<Publish> childPublish=new ArrayList<Publish>();
	
	@Id
    @Column(name = "CASE_ID")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="case_seq")
	private long case_id;//案例标识
	@Column(name="GHID")
	private String ghid;//标识符
	@Column(name="order_id")
	private long order_id;//订单标识
	@Column(name="media_id")
	private long media_id;//供应商标识
	@Column(name="case_title")
	private String case_title;//案例主题
	@Column(name="case_Industry")
	private String case_Industry;//案例行业
	@Column(name="case_brand")
	private String case_brand;//案例品牌
	@Column(name="case_product")
	private String case_product;//案例产品
	@Column(name="case_desc")
	private String case_desc;//案例描述
	@Column(name="case_publish_time")
	private Date case_publish_time;//案例发布时间
	@Column(name="last_viewed_time")
	private Date last_viewed_time;//案例最后访问时间
	@Column(name="follow_count")
	private long follow_count;//关注数
	@Column(name="keyword")
	private String keyword;//关键词
	@Column(name="case_status")
	private String case_status;//案例状态
	@Column(name="image")
	private String image;//案例主题
	
	public List<Publish> getChildPublish() {
		return childPublish;
	}
	public void setChildPublish(List<Publish> childPublish) {
		this.childPublish = childPublish;
	}
	public long getCase_id() {
		return case_id;
	}
	public void setCase_id(long case_id) {
		this.case_id = case_id;
	}
	public String getGhid() {
		return ghid;
	}
	public void setGhid(String ghid) {
		this.ghid = ghid;
	}
	public long getOrder_id() {
		return order_id;
	}
	public void setOrder_id(long order_id) {
		this.order_id = order_id;
	}
	public long getMedia_id() {
		return media_id;
	}
	public void setMedia_id(long media_id) {
		this.media_id = media_id;
	}
	public String getCase_title() {
		return case_title;
	}
	public void setCase_title(String case_title) {
		this.case_title = case_title;
	}
	public String getCase_Industry() {
		return case_Industry;
	}
	public void setCase_Industry(String case_Industry) {
		this.case_Industry = case_Industry;
	}
	public String getCase_brand() {
		return case_brand;
	}
	public void setCase_brand(String case_brand) {
		this.case_brand = case_brand;
	}
	public String getCase_product() {
		return case_product;
	}
	public void setCase_product(String case_product) {
		this.case_product = case_product;
	}
	public String getCase_desc() {
		return case_desc;
	}
	public void setCase_desc(String case_desc) {
		this.case_desc = case_desc;
	}
	public Date getCase_publish_time() {
		return case_publish_time;
	}
	public void setCase_publish_time(Date case_publish_time) {
		this.case_publish_time = case_publish_time;
	}
	public Date getLast_viewed_time() {
		return last_viewed_time;
	}
	public void setLast_viewed_time(Date last_viewed_time) {
		this.last_viewed_time = last_viewed_time;
	}
	public long getFollow_count() {
		return follow_count;
	}
	public void setFollow_count(long follow_count) {
		this.follow_count = follow_count;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getCase_status() {
		return case_status;
	}
	public void setCase_status(String case_status) {
		this.case_status = case_status;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public List<CaseImage> getCaseImageList() {
		return caseImageList;
	}
	public void setCaseImageList(List<CaseImage> caseImageList) {
		this.caseImageList = caseImageList;
	}

	
	
}
