package org.sist.project.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ReplyVO;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyItemVO;
import org.sist.project.domain.SurveyVO;
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
	
	@Override
	public List<SurveyVO> selectSurveyList(SearchCriteria cri) throws Exception {
		logger.info("selectSurveyList");
		List<SurveyVO> surveyList = sqlSession.selectList(namespace+".selectSurveyList", cri);
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

	// 아이템리스트가 포함된 select
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

	@Override
	public SurveyItemVO selecyMySurveyResult(int survey_seq, int member_seq) {
		logger.info("selecyMySurveyResult");
		Map<String, Integer> params = new HashMap<>();
		params.put("survey_seq", survey_seq);
		params.put("member_seq", member_seq);
		return sqlSession.selectOne(namespace+".selecyMySurveyResult", params);
	}
	
	@Override
	public List<ReplyVO> selectReplyList(int survey_seq) {
		logger.info("selectReplyList");
		return sqlSession.selectList(namespace+".selectReplyList", survey_seq);
	}

	@Override
	public int insertReply(ReplyVO replyVO) {
		logger.info("insertReply");
		String username = replyVO.getUsername();
		replyVO.setMember_seq(sqlSession.selectOne(namespace+".selectReplyMember",username));
		return sqlSession.insert(namespace+".insertReply", replyVO);
	}

	@Override
	public void addSurvey(SurveyVO svo) {
		logger.info("addSurvey");
		 sqlSession.insert(namespace+".addSurvey",svo);
		System.out.println("addsurvey 성공");
	}
	@Override
	public void addSurveyItem(SurveyItemVO sivo) {
		logger.info("addSurveyItem");
		sqlSession.insert(namespace+".addSurveyItem", sivo);
		System.out.println("addsurveyitem 성공");
	}
}
