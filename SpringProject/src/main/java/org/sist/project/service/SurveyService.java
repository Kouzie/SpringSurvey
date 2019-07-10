package org.sist.project.service;

import java.util.List;

import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyVO;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;
import org.sist.test.SurveyTest;

public interface SurveyService {
	public List<SurveyVO> getSurveyList(SearchCriteria cri) throws Exception;
	public PageMaker getPagination(SearchCriteria cri) throws Exception;
	public SurveyVO getSurvey(int survey_seq) throws Exception;
	public SurveyWithItemVO getSurveyItems(int survey_seq) throws Exception;
	public SurveyWithDatasetVO getSurveyResult(int survey_seq) throws Exception;
}
