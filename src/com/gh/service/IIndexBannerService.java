package com.gh.service;

import java.util.Map;

import com.gh.model.IndexBanner;
import com.gh.util.PageList;

public interface IIndexBannerService {

	PageList<IndexBanner> getBannerList(Map<String, Object> map, PageList page) throws Exception;

}
