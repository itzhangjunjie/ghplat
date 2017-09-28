package com.gh.service;

import com.gh.dto.PublishForm;
import com.gh.model.Content;
import com.gh.util.PageList;

public interface IContentService {

	PageList<Content> getContentList(PublishForm publishForm);

	void updateContent(long parseLong, String status);

}
