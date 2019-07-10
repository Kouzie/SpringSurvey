package org.sist.project.persistance;

import java.util.List;

import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyVO;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;

public interface SurveyDAO {
	public List<SurveyVO> selectSurveyList(SearchCriteria cri) throws Exception;

	public PageMaker selectCountPaging(SearchCriteria cri);

	public SurveyWithItemVO selectSurvey(int survey_seq);

	public List<ResultDataSet> selectSurveyResultDataSet(int survey_seq);
}
