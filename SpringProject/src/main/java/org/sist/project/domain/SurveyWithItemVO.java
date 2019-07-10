package org.sist.project.domain;

import java.util.List;

// 상세설문조사, 아이템리스트 포함
// 실제 출력해야 하는 부분
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
