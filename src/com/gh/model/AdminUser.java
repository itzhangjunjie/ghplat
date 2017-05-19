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
@Table(name="GH_ADMINUSER")
@SequenceGenerator(name="adminuser_seq",sequenceName="ADMINUSER_SEQ")  
public class AdminUser {

	@Id
    @Column(name = "id")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="adminuser_seq")
	private long id;
	@Column(name="username")
	private String username;
	@Column(name="password")
	private String password;
	@Column(name="loginTime")
	private Date loginTime;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
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
	public Date getLoginTime() {
		return loginTime;
	}
	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}
	
	
	
	
	
}
