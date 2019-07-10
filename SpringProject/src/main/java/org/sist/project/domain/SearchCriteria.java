package org.sist.project.domain;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class SearchCriteria extends Criteria {
	private String sort;
	private String progressing;
	private String search;

	@Override
	public String toString() {
		return "SearchCriteria [sort=" + sort + ", progressing=" + progressing + ", search=" + search + "]";
	}
	
	public String makeSearch() {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
			.queryParam("perPageNum", this.getPerPageNum())
			.queryParam("sort", this.getSort())
			.queryParam("progressing", this.getProgressing())
			.queryParam("search", this.getSearch())
			.build();
		return uriComponents.toUriString();
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getProgressing() {
		return progressing;
	}
	public void setProgressing(String progressing) {
		this.progressing = progressing;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
}
