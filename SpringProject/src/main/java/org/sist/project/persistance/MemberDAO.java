package org.sist.project.persistance;

import java.util.List;

import org.sist.project.domain.MemberVO;

public interface MemberDAO {
	public List<MemberVO> selectAdminList() throws Exception;
}
