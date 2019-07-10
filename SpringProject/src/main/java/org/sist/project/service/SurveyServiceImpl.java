package org.sist.project.service;

import java.util.List;

import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyItemVO;
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
	public SurveyVO getSurvey(int survey_seq) throws Exception {
		return dao.selectSurvey(survey_seq);
	}
	@Override
	public SurveyWithItemVO getSurveyItems(int survey_seq) throws Exception {
		SurveyVO surveyVO = getSurvey(survey_seq);
		SurveyWithItemVO surveyWithItemVO = new SurveyWithItemVO(surveyVO);
		List<SurveyItemVO> surveyItemList = dao.selectSurveyItems(survey_seq);
		surveyWithItemVO.setSurveyItemList(surveyItemList);
		return surveyWithItemVO;
	}

	@Override
	public SurveyWithDatasetVO getSurveyResult(int survey_seq) throws Exception {
		SurveyWithItemVO surveyWithItemVO = getSurveyItems(survey_seq);
		SurveyWithDatasetVO surveyWithDatasetVO = new SurveyWithDatasetVO(surveyWithItemVO);
		List<ResultDataSet> dataSetList = dao.selectSurveyResultDataSet(survey_seq);
		surveyWithDatasetVO.setDataset(dataSetList);
		return surveyWithDatasetVO;
	}
}
