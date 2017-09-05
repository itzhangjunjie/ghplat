package com.gh.model;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="GH_publish")
@SequenceGenerator(name="publish_seq",sequenceName="SEQ_PUBLISH_ID")  
public class Publish {
	
	
	
	@Id
    @Column(name = "PUBLISH_ID")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="publish_seq")
	private long id;
	
	@Transient
	private Map<String,String> priceMap = new HashMap<String,String>();//价格字段对应
	@Transient
	private Map<String,String> infoMap = new HashMap<String,String>();//info字段对应
	@Transient
	private String qq;
	
	@JoinColumn(name="PUBLISH_TYPE")
	@ManyToOne(targetEntity=PublishType.class)
	private PublishType publishTypeObj =  new PublishType();
	
	
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	@Column(name="GHID")
	private String ghid;//标识符
	@Column(name="MEDIA_ID")
	private long mediaId;//供应商标识
	
//	@Column(name="PUBLISH_TYPE")
//	private String publishType;//类型
	@Column(name="PUBLISH_NAME")
	private String publishName;//名称
	@Column(name="PUBLISH_FIELD")
	private String publishField;//领域
	@Column(name="PUBLISH_REGION")
	private String publishRegion;//区域  省份
	@Column(name="PUBLISH_REGION_2")
	private String publishRegion2;//区域   市
	@Column(name="PUBLISH_REGION_3")
	private String publishRegion3;//区域  区
	@Column(name="PUBLISH_TIME")
	private Date publishTime;//发布时间
	@Column(name="LAST_VIEWED_TIME")
	private Date lastViewedTime;//最后浏览时间
	@Column(name="FOLLOW_COUNT")
	private int followCount = 0;//关注数
	@Column(name="IMAGE")
	private String image;//头像
	@Column(name="PLATFORM_NAME")
	private String platformName;//平台名称
	@Column(name="PLATFORM_ICON")
	private String platformIcon;//平台的图片
	@Column(name="PLATFORM_FANS")
	private long platformFans;//平台粉丝数
	@Column(name="POWER_SCORE")
	private int powerScore;//权重值
	@Column(name="KEYWORD")
	private String keyword;//关键词
	@Column(name="PUBLISH_STATUS")
	private String publishStatus;//状态
	@Column(name="INFO_01")
	private String info01;
	@Column(name="INFO_02")
	private String info02;
	@Column(name="INFO_03")
	private String info03;
	@Column(name="INFO_04")
	private String info04;
	@Column(name="INFO_05")
	private String info05;
	@Column(name="INFO_06")
	private String info06;
	@Column(name="INFO_07")
	private String info07;
	@Column(name="INFO_08")
	private String info08;
	@Column(name="INFO_09")
	private String info09;
	@Column(name="INFO_10")
	private String info10;
	@Column(name="INFO_11")
	private String info11;
	@Column(name="INFO_12")
	private String info12;
	@Column(name="INFO_13")
	private String info13;
	@Column(name="INFO_14")
	private String info14;
	@Column(name="INFO_15")
	private String info15;
	@Column(name="INFO_16")
	private String info16;
	@Column(name="INFO_17")
	private String info17;
	@Column(name="INFO_18")
	private String info18;
	@Column(name="INFO_19")
	private String info19;
	@Column(name="INFO_20")
	private String info20;
	@Column(name="PRICE_01")
	private String price01;
	@Column(name="PRICE_02")
	private String price02;
	@Column(name="PRICE_03")
	private String price03;
	@Column(name="PRICE_04")
	private String price04;
	@Column(name="PRICE_05")
	private String price05;
	@Column(name="PRICE_06")
	private String price06;
	@Column(name="PRICE_07")
	private String price07;
	@Column(name="PRICE_08")
	private String price08;
	@Column(name="PRICE_09")
	private String price09;
	@Column(name="PRICE_10")
	private String price10;
	@Column(name="PRICE_11")
	private String price11;
	@Column(name="PRICE_12")
	private String price12;
	@Column(name="PRICE_13")
	private String price13;
	@Column(name="PRICE_14")
	private String price14;
	@Column(name="PRICE_15")
	private String price15;
	@Column(name="PRICE_16")
	private String price16;
	@Column(name="PRICE_17")
	private String price17;
	@Column(name="PRICE_18")
	private String price18;
	@Column(name="PRICE_19")
	private String price19;
	@Column(name="PRICE_20")
	private String price20;
	
	
	
	public Map<String, String> getInfoMap() {
		return infoMap;
	}
	public void setInfoMap(Map<String, String> infoMap) {
		this.infoMap = infoMap;
	}
	public Map<String, String> getPriceMap() {
		return priceMap;
	}
	public void setPriceMap(Map<String, String> priceMap) {
		this.priceMap = priceMap;
	}
	public PublishType getPublishTypeObj() {
		return publishTypeObj;
	}
	public void setPublishTypeObj(PublishType publishTypeObj) {
		this.publishTypeObj = publishTypeObj;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getGhid() {
		return ghid;
	}
	public void setGhid(String ghid) {
		this.ghid = ghid;
	}
	public long getMediaId() {
		return mediaId;
	}
	public void setMediaId(long mediaId) {
		this.mediaId = mediaId;
	}
	public String getPublishName() {
		return publishName;
	}
	public void setPublishName(String publishName) {
		this.publishName = publishName;
	}
	public String getPublishField() {
		return publishField;
	}
	public void setPublishField(String publishField) {
		this.publishField = publishField;
	}
	public String getPublishRegion() {
		return publishRegion;
	}
	public void setPublishRegion(String publishRegion) {
		this.publishRegion = publishRegion;
	}
	public Date getPublishTime() {
		return publishTime;
	}
	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}
	public Date getLastViewedTime() {
		return lastViewedTime;
	}
	public void setLastViewedTime(Date lastViewedTime) {
		this.lastViewedTime = lastViewedTime;
	}
	public int getFollowCount() {
		return followCount;
	}
	public void setFollowCount(int followCount) {
		this.followCount = followCount;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getPlatformName() {
		return platformName;
	}
	public void setPlatformName(String platformName) {
		this.platformName = platformName;
	}
	public long getPlatformFans() {
		return platformFans;
	}
	public void setPlatformFans(long platformFans) {
		this.platformFans = platformFans;
	}
	public int getPowerScore() {
		return powerScore;
	}
	public void setPowerScore(int powerScore) {
		this.powerScore = powerScore;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getPublishStatus() {
		return publishStatus;
	}
	public void setPublishStatus(String publishStatus) {
		this.publishStatus = publishStatus;
	}
	public String getInfo01() {
		return info01;
	}
	public void setInfo01(String info01) {
		this.info01 = info01;
	}
	public String getInfo02() {
		return info02;
	}
	public void setInfo02(String info02) {
		this.info02 = info02;
	}
	public String getInfo03() {
		return info03;
	}
	public void setInfo03(String info03) {
		this.info03 = info03;
	}
	public String getInfo04() {
		return info04;
	}
	public void setInfo04(String info04) {
		this.info04 = info04;
	}
	public String getInfo05() {
		return info05;
	}
	public void setInfo05(String info05) {
		this.info05 = info05;
	}
	public String getPrice01() {
		return price01;
	}
	public void setPrice01(String price01) {
		this.price01 = price01;
	}
	public String getPrice02() {
		return price02;
	}
	public void setPrice02(String price02) {
		this.price02 = price02;
	}
	public String getPrice03() {
		return price03;
	}
	public void setPrice03(String price03) {
		this.price03 = price03;
	}
	public String getPrice04() {
		return price04;
	}
	public void setPrice04(String price04) {
		this.price04 = price04;
	}
	public String getPrice05() {
		return price05;
	}
	public void setPrice05(String price05) {
		this.price05 = price05;
	}
//	public String getPublishType() {
//		return publishType;
//	}
//	public void setPublishType(String publishType) {
//		this.publishType = publishType;
//	}
	
	public String getInfo06() {
		return info06;
	}
	public void setInfo06(String info06) {
		this.info06 = info06;
	}
	public String getInfo07() {
		return info07;
	}
	public void setInfo07(String info07) {
		this.info07 = info07;
	}
	public String getInfo08() {
		return info08;
	}
	public void setInfo08(String info08) {
		this.info08 = info08;
	}
	public String getInfo09() {
		return info09;
	}
	public void setInfo09(String info09) {
		this.info09 = info09;
	}
	public String getInfo10() {
		return info10;
	}
	public void setInfo10(String info10) {
		this.info10 = info10;
	}
	public String getInfo11() {
		return info11;
	}
	public void setInfo11(String info11) {
		this.info11 = info11;
	}
	public String getInfo12() {
		return info12;
	}
	public void setInfo12(String info12) {
		this.info12 = info12;
	}
	public String getInfo13() {
		return info13;
	}
	public void setInfo13(String info13) {
		this.info13 = info13;
	}
	public String getInfo14() {
		return info14;
	}
	public void setInfo14(String info14) {
		this.info14 = info14;
	}
	public String getInfo15() {
		return info15;
	}
	public void setInfo15(String info15) {
		this.info15 = info15;
	}
	public String getInfo16() {
		return info16;
	}
	public void setInfo16(String info16) {
		this.info16 = info16;
	}
	public String getInfo17() {
		return info17;
	}
	public void setInfo17(String info17) {
		this.info17 = info17;
	}
	public String getInfo18() {
		return info18;
	}
	public void setInfo18(String info18) {
		this.info18 = info18;
	}
	public String getInfo19() {
		return info19;
	}
	public void setInfo19(String info19) {
		this.info19 = info19;
	}
	public String getInfo20() {
		return info20;
	}
	public void setInfo20(String info20) {
		this.info20 = info20;
	}
	public String getPrice06() {
		return price06;
	}
	public void setPrice06(String price06) {
		this.price06 = price06;
	}
	public String getPrice07() {
		return price07;
	}
	public void setPrice07(String price07) {
		this.price07 = price07;
	}
	public String getPrice08() {
		return price08;
	}
	public void setPrice08(String price08) {
		this.price08 = price08;
	}
	public String getPrice09() {
		return price09;
	}
	public void setPrice09(String price09) {
		this.price09 = price09;
	}
	public String getPrice10() {
		return price10;
	}
	public void setPrice10(String price10) {
		this.price10 = price10;
	}
	public String getPrice11() {
		return price11;
	}
	public void setPrice11(String price11) {
		this.price11 = price11;
	}
	public String getPrice12() {
		return price12;
	}
	public void setPrice12(String price12) {
		this.price12 = price12;
	}
	public String getPrice13() {
		return price13;
	}
	public void setPrice13(String price13) {
		this.price13 = price13;
	}
	public String getPrice14() {
		return price14;
	}
	public void setPrice14(String price14) {
		this.price14 = price14;
	}
	public String getPrice15() {
		return price15;
	}
	public void setPrice15(String price15) {
		this.price15 = price15;
	}
	public String getPrice16() {
		return price16;
	}
	public void setPrice16(String price16) {
		this.price16 = price16;
	}
	public String getPrice17() {
		return price17;
	}
	public void setPrice17(String price17) {
		this.price17 = price17;
	}
	public String getPrice18() {
		return price18;
	}
	public void setPrice18(String price18) {
		this.price18 = price18;
	}
	public String getPrice19() {
		return price19;
	}
	public void setPrice19(String price19) {
		this.price19 = price19;
	}
	public String getPrice20() {
		return price20;
	}
	public void setPrice20(String price20) {
		this.price20 = price20;
	}
	public String getPlatformIcon() {
		return platformIcon;
	}
	public void setPlatformIcon(String platformIcon) {
		this.platformIcon = platformIcon;
	}
	
	public String getPublishRegion2() {
		return publishRegion2;
	}
	public void setPublishRegion2(String publishRegion2) {
		this.publishRegion2 = publishRegion2;
	}
	public String getPublishRegion3() {
		return publishRegion3;
	}
	public void setPublishRegion3(String publishRegion3) {
		this.publishRegion3 = publishRegion3;
	}
	@Override
	public String toString() {
		return "Publish [id=" + id + ", publishTypeObj=" + publishTypeObj + ", ghid=" + ghid + ", mediaId=" + mediaId
				+ ", publishName=" + publishName + ", publishField=" + publishField + ", publishRegion=" + publishRegion
				+ ", publishTime=" + publishTime + ", lastViewedTime=" + lastViewedTime + ", followCount=" + followCount
				+ ", image=" + image + ", platformName=" + platformName + ", platformFans=" + platformFans
				+ ", powerScore=" + powerScore + ", keyword=" + keyword + ", publishStatus=" + publishStatus
				+ ", info01=" + info01 + ", info02=" + info02 + ", info03=" + info03 + ", info04=" + info04
				+ ", info05=" + info05 + ", price01=" + price01 + ", price02=" + price02 + ", price03=" + price03
				+ ", price04=" + price04 + ", price05=" + price05 + "]";
	}
	
}
