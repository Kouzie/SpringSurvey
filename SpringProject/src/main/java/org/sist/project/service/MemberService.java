package org.sist.project.service;

import java.util.List;

import org.sist.project.domain.MemberVO;

public interface MemberService {
	public List<MemberVO> getAdminList() throws Exception;

}
