package com.gh.service;

import java.util.List;
import java.util.Map;

import com.gh.model.IndexBanner;
import com.gh.model.Publish;
import com.gh.util.PageList;

public interface IIndexBannerService {

	PageList<IndexBanner> getBannerList(Map<String, Object> map, PageList page) throws Exception;

	List<Publish> getBannerPublishList(Map<String, Object> map) throws Exception;

	IndexBanner getBannerDetails(Long bannerId) throws Exception;

}
