package org.sist.project.service;

import java.util.List;

import org.sist.project.domain.MemberVO;
import org.sist.project.persistance.MemberDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDAO dao;
	
	@Override
	public List<MemberVO> getAdminList() throws Exception {
		return dao.selectAdminList();
	}
		
}
