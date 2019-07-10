package org.sist.project.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyMapper;
import org.sist.project.domain.SurveyVO;
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
	public SurveyWithItemVO selectSurvey(int survey_seq) {
		logger.info("selectSurvey");
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT survey_seq, title, tbl_member.member_seq, name, reg_date, content, progressing, end_date, tbl_survey.image ,  ");
		sql.append(" ( ");
		sql.append("     SELECT COUNT(survey_result_seq)  ");
		sql.append("     FROM tbl_survey_result ");
		sql.append("     JOIN tbl_survey_item ON tbl_survey_result.survey_item_seq = tbl_survey_item.survey_item_seq ");
		sql.append("     WHERE tbl_survey_item.survey_seq = tbl_survey.survey_seq ");
		sql.append(" ) participantCnt, ");
		sql.append(" CURSOR( ");
		sql.append("     SELECT *  ");
		sql.append("     FROM tbl_survey_item  ");
		sql.append("     WHERE tbl_survey.survey_seq = tbl_survey_item.survey_seq ");
		sql.append(" ) surveyItemList ");
		sql.append(" FROM tbl_survey ");
		sql.append(" JOIN tbl_member ON tbl_survey.member_seq = tbl_member.member_seq ");
		sql.append(" WHERE survey_seq = :survey_seq ");

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("survey_seq", survey_seq);
		SurveyWithItemVO surveyWithItemVO = this.jdbcTemplate.queryForObject(
				sql.toString(), 
				paramMap, 
				new SurveyMapper());
		return surveyWithItemVO;
	}

	@Override
	public List<ResultDataSet> selectSurveyResultDataSet(int survey_seq) {
		logger.info("selectSurveyResultDataSet");
		return sqlSession.selectList(namespace+".selectResultDataset", survey_seq);
	}

}
