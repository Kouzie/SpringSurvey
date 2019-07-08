package org.sist.project.persistance;

import java.util.List;

import org.sist.project.domain.MemberVO;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyVO;

public interface SurveyDAO {
	public List<SurveyVO> selectSurveyList(SearchCriteria cri) throws Exception;

	public PageMaker selectCountPaging(SearchCriteria cri);
}
