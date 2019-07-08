package org.sist.project.service;

import java.util.List;

import org.sist.project.domain.MemberVO;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyVO;

public interface SurveyService {
	public List<SurveyVO> getSurveyList(SearchCriteria cri) throws Exception;

}
