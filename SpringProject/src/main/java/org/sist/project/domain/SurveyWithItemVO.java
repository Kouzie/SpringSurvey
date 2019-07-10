package org.sist.project.domain;

import java.sql.ResultSet;
import java.sql.SQLException;
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
	
	public SurveyWithItemVO(SurveyVO surveyVO) {
		super(surveyVO);
	}
	public List<SurveyItemVO> getSurveyItemList() {
		return surveyItemList;
	}

	public void setSurveyItemList(List<SurveyItemVO> surveyItemList) {
		this.surveyItemList = surveyItemList;
	}
	public static SurveyWithItemVO initSurveyWithItemVO(ResultSet rs) throws SQLException {
		SurveyWithItemVO surveyWithItemVO = new SurveyWithItemVO();
		ResultSet itemRs = (ResultSet) rs.getObject("surveyItemList");
		surveyWithItemVO.initSurveyVO(rs);
		surveyWithItemVO.setSurveyItemList(SurveyItemVO.initSurveyItemVO(itemRs));
		return surveyWithItemVO;
	}
}
