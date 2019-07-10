package org.sist.project.domain;

import java.util.List;

public class SurveyWithItemVO extends SurveyVO {
	private List<SurveyItemVO> surveyItemList;

	@Override
	public String toString() {
		return super.toString() + "SurveyWithItemVO [surveyItemList=" + surveyItemList + "]";
	}
	public SurveyWithItemVO() {
		super();
	}
	public SurveyWithItemVO(SurveyWithItemVO surveyCopy) {
		super((SurveyVO)surveyCopy);
		this.surveyItemList = surveyCopy.surveyItemList;
	}
	
	public List<SurveyItemVO> getSurveyItemList() {
		return surveyItemList;
	}

	public void setSurveyItemList(List<SurveyItemVO> surveyItemList) {
		this.surveyItemList = surveyItemList;
	}	
}
