package org.sist.project.persistance;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.sist.project.domain.MemberVO;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class SurveyDAOImpl implements SurveyDAO{
	private static final Logger logger = LoggerFactory.getLogger(SurveyDAOImpl.class);
	private String namespace = "org.sist.project.mapper.SurveyMapper";

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<SurveyVO> selectSurveyList(SearchCriteria cri) throws Exception {
		logger.info("getSurveyList");
		List<SurveyVO> surveyList = sqlSession.selectList(namespace+".selectSurveyList", cri);
		for (int i = 0; i < surveyList.size(); i++) {
			logger.info(surveyList.get(i).toString());
		}
		return surveyList;
	}

	@Override
	public PageMaker selectCountPaging(SearchCriteria cri) {
		logger.info("getPagination");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		int totalCount = sqlSession.selectOne(namespace+".selectCountPaging", cri);
		pageMaker.setTotalCount(totalCount);
		return pageMaker;
	}

}
