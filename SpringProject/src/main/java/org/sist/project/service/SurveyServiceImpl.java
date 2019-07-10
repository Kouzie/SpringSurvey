package org.sist.project.service;

import java.util.List;

import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyVO;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;
import org.sist.project.persistance.SurveyDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SurveyServiceImpl implements SurveyService{

	@Autowired
	SurveyDAO dao;
	
	@Override
	public List<SurveyVO> getSurveyList(SearchCriteria cri) throws Exception {
		return dao.selectSurveyList(cri);
	}

	@Override
	public PageMaker getPagination(SearchCriteria cri) throws Exception {
		return dao.selectCountPaging(cri);
	}

	@Override
	public SurveyWithItemVO getSurvey(int survey_seq) throws Exception {
		return dao.selectSurvey(survey_seq);
	}

	@Override
	public SurveyWithDatasetVO getSurveyResult(int survey_seq) throws Exception {
		SurveyWithDatasetVO surveyWithDatasetVO = new SurveyWithDatasetVO(dao.selectSurvey(survey_seq));
		surveyWithDatasetVO.setDataset(dao.selectSurveyResultDataSet(survey_seq));
		return surveyWithDatasetVO;
	}

}
