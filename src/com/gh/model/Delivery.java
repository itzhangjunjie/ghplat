package com.gh.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
@Entity
@Table(name="gh_delivery")
@SequenceGenerator(name="delivery_seq",sequenceName="seq_delivery_id")
public class Delivery {

	@Id
    @Column(name = "id")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="delivery_seq")
	private long id;
	@Column(name = "titile")
	private String title;
	@Column(name = "xingshi")
	private String xingshi;//主要形式
	@Column(name = "ziyuan")
	private String ziyuan;//主要资源
	@Column(name = "yusuan")
	private String yusuan;//投放预算
	@Column(name = "peitao")
	private String peitao;//配套资源
	@Column(name = "intro")
	private String intro;//备注
	@Column(name = "createTime")
	private Date createTime;
	@ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="advertiser_id")
	private Advertiser advertiser;
	@Column(name = "status")
	private int status;// 状态 0是新建的 待付款   1是已付款  2是取消订单  3是删除
	
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getXingshi() {
		return xingshi;
	}
	public void setXingshi(String xingshi) {
		this.xingshi = xingshi;
	}
	public String getZiyuan() {
		return ziyuan;
	}
	public void setZiyuan(String ziyuan) {
		this.ziyuan = ziyuan;
	}
	public String getPeitao() {
		return peitao;
	}
	public void setPeitao(String peitao) {
		this.peitao = peitao;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Advertiser getAdvertiser() {
		return advertiser;
	}
	public void setAdvertiser(Advertiser advertiser) {
		this.advertiser = advertiser;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getYusuan() {
		return yusuan;
	}
	public void setYusuan(String yusuan) {
		this.yusuan = yusuan;
	}
	
	
	
}
