package com.gh.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
@Entity
@Table(name="GH_order_detail")
@SequenceGenerator(name="order_detail_seq",sequenceName="seq_order_detail_id")
public class OrderDetails {

	@Id
    @Column(name = "order_detail_id")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="order_detail_seq")
	private long order_detail_id;
	@Column(name="ghid")
	private String ghid;
	@JoinColumn(name="order_id")
	@ManyToOne(targetEntity=Order.class)
	private Order order;
	@JoinColumn(name="publish_id")
	@ManyToOne(targetEntity=Publish.class)
	private Publish publish;
	@Column(name="publish_type")
	private String publish_type;
	@Column(name="publish_pricestr")
	private String publish_pricestr;
	@Column(name="publish_price")
	private String publish_price;
	@Column(name="column_1")
	private String column_1;
	@Column(name="column_2")
	private String column_2;
	@Column(name="column_4")
	private Date column_4;
	
	
	public String getPublish_pricestr() {
		return publish_pricestr;
	}
	public void setPublish_pricestr(String publish_pricestr) {
		this.publish_pricestr = publish_pricestr;
	}
	public String getPublish_price() {
		return publish_price;
	}
	public void setPublish_price(String publish_price) {
		this.publish_price = publish_price;
	}
	public long getOrder_detail_id() {
		return order_detail_id;
	}
	public void setOrder_detail_id(long order_detail_id) {
		this.order_detail_id = order_detail_id;
	}
	public String getGhid() {
		return ghid;
	}
	public void setGhid(String ghid) {
		this.ghid = ghid;
	}
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public Publish getPublish() {
		return publish;
	}
	public void setPublish(Publish publish) {
		this.publish = publish;
	}
	public String getPublish_type() {
		return publish_type;
	}
	public void setPublish_type(String publish_type) {
		this.publish_type = publish_type;
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
	@Override
	public String toString() {
		return "OrderDetails [order_detail_id=" + order_detail_id + ", ghid=" + ghid + ", order=" + order + ", publish="
				+ publish + ", publish_type=" + publish_type + ", publish_pricestr=" + publish_pricestr
				+ ", publish_price=" + publish_price + "]";
	}
	
}
