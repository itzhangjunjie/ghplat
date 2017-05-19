package com.gh.model;

import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
@Entity
@Table(name = "GH_ADVERTISER")
@SequenceGenerator(name="advertiser_seq",sequenceName="SEQ_ADVERTISER_ID")  
public class Advertiser {
	//广告主对象
    @Id
    @Column(name = "ADVERTISER_ID")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="advertiser_seq")
    private Long advertiserId;
    @Column(name="GHID")
	private String ghid;//标识符
    @Column(name = "INDUSTRY")
    private String industry;
    @Basic(optional = false)
    @Column(name = "USERNAME")
    private String username;//用户名
    @Basic(optional = false)
    @Column(name = "PASSWD")
    private String password;//口令
    @Column(name = "CORPORATION_NAME")
    private String corporation_name;  //公司名称
    @Column(name = "TELEPHONE")
    private String telephone;  //电话号码
    @Basic(optional = false)
    @Column(name = "MOBILE")
    private String mobile;  //手机号码
    @Column(name = "WECHAT")
    private String wechat;
    @Column(name = "QQ")
    private String qq;
    @Basic(optional = false)
    @Column(name = "EMAIL")
    private String email;
    @Basic(optional = false)
    @Column(name = "SIGN_UP_TIME")
    @Temporal(TemporalType.DATE)
    private Date signUpTime;//注册时间
    @Basic(optional = false)
    @Column(name = "LAST_LOGIN_TIME")
    @Temporal(TemporalType.DATE)
    private Date lastLoginTime;//最后登录时间
    @Basic(optional = false)
    @Column(name = "STATUS")
    private String status;
    @Basic(optional=false)
    @Column(name="USER_FLAG")
    private String userFlag;//是否是会员
    @Column(name = "COLUMN_1")
    private String column1;
    @Column(name = "COLUMN_2")
    private String column2;
    @Column(name = "COLUMN_3")
    private Long column3;
    @Column(name = "COLUMN_4")
    @Temporal(TemporalType.DATE)
    private Date column4;
    
    
	public String getGhid() {
		return ghid;
	}
	public void setGhid(String ghid) {
		this.ghid = ghid;
	}
	public Long getAdvertiserId() {
		return advertiserId;
	}
	public void setAdvertiserId(Long advertiserId) {
		this.advertiserId = advertiserId;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCorporation_name() {
		return corporation_name;
	}
	public void setCorporation_name(String corporation_name) {
		this.corporation_name = corporation_name;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getWechat() {
		return wechat;
	}
	public void setWechat(String wechat) {
		this.wechat = wechat;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getSignUpTime() {
		return signUpTime;
	}
	public void setSignUpTime(Date signUpTime) {
		this.signUpTime = signUpTime;
	}
	public Date getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getColumn1() {
		return column1;
	}
	public void setColumn1(String column1) {
		this.column1 = column1;
	}
	public String getColumn2() {
		return column2;
	}
	public void setColumn2(String column2) {
		this.column2 = column2;
	}
	public Long getColumn3() {
		return column3;
	}
	public void setColumn3(Long column3) {
		this.column3 = column3;
	}
	public Date getColumn4() {
		return column4;
	}
	public void setColumn4(Date column4) {
		this.column4 = column4;
	}
	public String getUserFlag() {
		return userFlag;
	}
	public void setUserFlag(String userFlag) {
		this.userFlag = userFlag;
	}
    
    
    

    
}
