package com.gh.model;

public class PublishPlatform {

	private String platformId;
	private String publishType;
	private String platformName;
	private String platformIcon;
	
	
	public String getPlatformId() {
		return platformId;
	}
	public void setPlatformId(String platformId) {
		this.platformId = platformId;
	}
	public String getPublishType() {
		return publishType;
	}
	public void setPublishType(String publishType) {
		this.publishType = publishType;
	}
	public String getPlatformName() {
		return platformName;
	}
	public void setPlatformName(String platformName) {
		this.platformName = platformName;
	}
	public String getPlatformIcon() {
		return platformIcon;
	}
	public void setPlatformIcon(String platformIcon) {
		this.platformIcon = platformIcon;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((publishType == null) ? 0 : publishType.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PublishPlatform other = (PublishPlatform) obj;
		if (publishType == null) {
			if (other.publishType != null)
				return false;
		} else if (!publishType.equals(other.publishType))
			return false;
		return true;
	}
	
	
}
