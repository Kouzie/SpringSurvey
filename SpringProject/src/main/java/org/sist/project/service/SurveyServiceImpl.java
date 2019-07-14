package org.sist.project.service;

import java.util.List;

import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ReplyVO;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyItemVO;
import org.sist.project.domain.SurveyVO;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;
import org.sist.project.persistance.SurveyDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

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
		surveyWithItemVO.setSurveyItemList(dao.selectSurveyItems(survey_seq));
//		surveyWithItemVO.setMySurvey(dao.selecyMySurveyResult(survey_seq, member_seq));
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

	@Override
	public List<ReplyVO> getReplyList(int survey_seq) {
		List<ReplyVO> replyList = dao.selectReplyList(survey_seq);
		return replyList;
	}

	@Override
	public int insertReply(ReplyVO replyVO) {
		int result = dao.insertReply(replyVO);
		return result;
	}

	@Transactional
	@Override
	public void addSurvey(SurveyVO svo, SurveyWithItemVO sivo) {
		
		dao.insertSurvey(svo);
		dao.insertSurveyItem(sivo.getSurveyItemList());
		
	}
}
