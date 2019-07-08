package org.sist.project.service;

import java.util.List;

import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyVO;
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
		
}
