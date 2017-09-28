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
@Table(name="gh_content")
@SequenceGenerator(name="content_seq",sequenceName="seq_content_id")
public class Content {

	@Id
    @Column(name = "id")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="content_seq")
	private long id;
	@Column(name = "title")
	private String title;
	@Column(name = "image")
	private String image;
	@Column(name = "author")
	private String author;
	@Column(name = "type")
	private String type;//原创   转载
	@Column(name = "content")
	private String content;//内容
	@ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="publish_id")
	private Publish publish;//自媒体
	@Column(name = "createTime")
	private Date createTime;
	@Column(name = "status")
	private int status;// 0创建  1发布  -1是未发布
	
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
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Publish getPublish() {
		return publish;
	}
	public void setPublish(Publish publish) {
		this.publish = publish;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
}
