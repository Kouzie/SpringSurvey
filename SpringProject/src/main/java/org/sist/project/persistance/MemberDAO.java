package org.sist.project.persistance;

import java.util.List;

import org.sist.project.domain.MemberVO;

public interface MemberDAO {
	public List<MemberVO> selectAdminList() throws Exception;
	public boolean insertMember(MemberVO member) throws Exception;
	public boolean deleteMember(int member_seq) throws Exception;
}