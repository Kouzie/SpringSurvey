package org.sist.project.domain;

public class SearchCriteria extends Criteria {
	private String sort;
	private String progressing;
	private String search;
	
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
	@Override
	public String toString() {
		return "SearchCriteria [sort=" + sort + ", progressing=" + progressing + ", search=" + search + "]";
	}
}
