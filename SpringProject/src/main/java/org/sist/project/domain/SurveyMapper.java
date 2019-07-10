package org.sist.project.domain;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class SurveyMapper implements RowMapper<SurveyWithItemVO>{
	@Override
	public SurveyWithItemVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		SurveyWithItemVO surveyWithItemVO = new SurveyWithItemVO();
		ResultSet itemRs = (ResultSet) rs.getObject("surveyItemList");
		surveyWithItemVO.initSurveyVO(rs);
		surveyWithItemVO.setSurveyItemList(SurveyItemVO.initSurveyItemVO(itemRs));
		return surveyWithItemVO;
	}
}
