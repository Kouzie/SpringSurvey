package org.sist.project.persistance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyItemVO;
import org.sist.project.domain.SurveyMapper;
import org.sist.project.domain.SurveyVO;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class SurveyDAOImpl implements SurveyDAO{
	private static final Logger logger = LoggerFactory.getLogger(SurveyDAOImpl.class);
	private String namespace = "org.sist.project.mapper.SurveyMapper";

	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private NamedParameterJdbcTemplate jdbcTemplate; 

	@Override
	public List<SurveyVO> selectSurveyList(SearchCriteria cri) throws Exception {
		logger.info("selectSurveyList");
		List<SurveyVO> surveyList = sqlSession.selectList(namespace+".selectSurveyList", cri);
		for (int i = 0; i < surveyList.size(); i++) {
			logger.info(surveyList.get(i).toString());
		}
		return surveyList;
	}

	@Override
	public PageMaker selectCountPaging(SearchCriteria cri) {
		logger.info("selectCountPaging");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		int totalCount = sqlSession.selectOne(namespace+".selectCountPaging", cri);
		pageMaker.setTotalCount(totalCount);
		return pageMaker;
	}

	@Override
	public List<SurveyItemVO> selectSurveyItems(int survey_seq) {
		logger.info("selectSurvey");
		List<SurveyItemVO> surveyItemList = null;
		surveyItemList = sqlSession.selectList(namespace+".selectSurveyItems", survey_seq);
		return surveyItemList;
	}

	@Override
	public List<ResultDataSet> selectSurveyResultDataSet(int survey_seq) {
		logger.info("selectSurveyResultDataSet");
		return sqlSession.selectList(namespace+".selectResultDataset", survey_seq);
	}

	@Override
	public SurveyVO selectSurvey(int survey_seq) {
		logger.info("selectSurvey");
		return sqlSession.selectOne(namespace+".selectSurvey", survey_seq);
	}
}
