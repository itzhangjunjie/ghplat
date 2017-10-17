package com.gh.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;
@Entity
@Table(name="GH_order")
@SequenceGenerator(name="order_seq",sequenceName="seq_order_id") 
public class Order {

	@Id
    @Column(name = "order_id")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="order_seq")
	private long order_id;//订单标识
	
	@Transient
	private List<OrderDetails> orderDetailsList = new ArrayList<OrderDetails>();
	@Transient
	private Advertiser advertiser;
	
	
	@Column(name="ghid")
	private String ghid;//标识符
	@Column(name="order_type")
	private String order_type;//订单类型
	@Column(name="order_user_id")
	private String order_user_id;//用户标识
	@Column(name="order_advertiser_id")
	private long order_advertiser_id;//广告主标识
	@Column(name="order_title")
	private String order_title;//广告主题
	@Column(name="order_style")
	private String order_style;//广告形式
	@Column(name="order_platform")
	private String order_platform;//投放平台
	@Column(name="order_contentstyle")
	private String order_contentstyle;//内容形式
	@Column(name="order_contentmake")
	private String order_contentmake;//内容制作
	@Column(name="order_contentaddress")
	private String order_contentaddress;//地域限定
	@Column(name="order_contentbudget")
	private String order_contentbudget;//预算
	@Column(name="order_contentremark")
	private String order_contentremark;//备注
	@Column(name="order_createtime")
	private Date order_createtime;//订单生成时间
	@Column(name="order_status")
	private String order_status;//订单状态 0是新建的 待付款   1是已付款  2是取消订单  3是删除  4是已完成
	@Column(name="admincontent")
	private String admincontent;
	@Column(name="column_1")
	private String column_1;
	@Column(name="column_2")
	private String column_2;
	@Column(name="column_4")
	private Date column_4;
	
	
	public String getAdmincontent() {
		return admincontent;
	}
	public void setAdmincontent(String admincontent) {
		this.admincontent = admincontent;
	}
	public Advertiser getAdvertiser() {
		return advertiser;
	}
	public void setAdvertiser(Advertiser advertiser) {
		this.advertiser = advertiser;
	}
	public List<OrderDetails> getOrderDetailsList() {
		return orderDetailsList;
	}
	public void setOrderDetailsList(List<OrderDetails> orderDetailsList) {
		this.orderDetailsList = orderDetailsList;
	}
	public long getOrder_id() {
		return order_id;
	}
	public void setOrder_id(long order_id) {
		this.order_id = order_id;
	}
	public String getGhid() {
		return ghid;
	}
	public void setGhid(String ghid) {
		this.ghid = ghid;
	}
	public String getOrder_type() {
		return order_type;
	}
	public void setOrder_type(String order_type) {
		this.order_type = order_type;
	}
	public String getOrder_user_id() {
		return order_user_id;
	}
	public void setOrder_user_id(String order_user_id) {
		this.order_user_id = order_user_id;
	}
	public long getOrder_advertiser_id() {
		return order_advertiser_id;
	}
	public void setOrder_advertiser_id(long order_advertiser_id) {
		this.order_advertiser_id = order_advertiser_id;
	}
	public String getOrder_title() {
		return order_title;
	}
	public void setOrder_title(String order_title) {
		this.order_title = order_title;
	}
	public String getOrder_style() {
		return order_style;
	}
	public void setOrder_style(String order_style) {
		this.order_style = order_style;
	}
	public String getOrder_platform() {
		return order_platform;
	}
	public void setOrder_platform(String order_platform) {
		this.order_platform = order_platform;
	}
	public String getOrder_contentstyle() {
		return order_contentstyle;
	}
	public void setOrder_contentstyle(String order_contentstyle) {
		this.order_contentstyle = order_contentstyle;
	}
	public String getOrder_contentmake() {
		return order_contentmake;
	}
	public void setOrder_contentmake(String order_contentmake) {
		this.order_contentmake = order_contentmake;
	}
	public String getOrder_contentaddress() {
		return order_contentaddress;
	}
	public void setOrder_contentaddress(String order_contentaddress) {
		this.order_contentaddress = order_contentaddress;
	}
	public String getOrder_contentbudget() {
		return order_contentbudget;
	}
	public void setOrder_contentbudget(String order_contentbudget) {
		this.order_contentbudget = order_contentbudget;
	}
	public String getOrder_contentremark() {
		return order_contentremark;
	}
	public void setOrder_contentremark(String order_contentremark) {
		this.order_contentremark = order_contentremark;
	}
	public Date getOrder_createtime() {
		return order_createtime;
	}
	public void setOrder_createtime(Date order_createtime) {
		this.order_createtime = order_createtime;
	}
	public String getOrder_status() {
		return order_status;
	}
	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}
	public String getColumn_1() {
		return column_1;
	}
	public void setColumn_1(String column_1) {
		this.column_1 = column_1;
	}
	public String getColumn_2() {
		return column_2;
	}
	public void setColumn_2(String column_2) {
		this.column_2 = column_2;
	}
	public Date getColumn_4() {
		return column_4;
	}
	public void setColumn_4(Date column_4) {
		this.column_4 = column_4;
	}
	
	
	
}
