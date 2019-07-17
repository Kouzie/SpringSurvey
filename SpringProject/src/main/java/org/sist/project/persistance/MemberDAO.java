package org.sist.project.persistance;

import java.util.List;

import org.sist.project.domain.MemberVO;
import org.sist.project.domain.NoticeVO;
import org.sist.project.domain.SearchVO;
import org.sist.project.domain.UpdateMemberVO;
import org.sist.project.member.MemberDetails;

public interface MemberDAO {
	public List<MemberVO> selectAdminList() throws Exception;
	public boolean insertMember(MemberVO member) throws Exception;
	public boolean updateMember(MemberVO member) throws Exception;
	public boolean deleteMember(int member_seq) throws Exception;
	public MemberDetails selectUserById(String username) throws Exception;
	public String selectUsername(String username) throws Exception;
	public String selectUserEmail(String username) throws Exception;
	public void updateUserPassword(String username, String authKey) throws Exception;
	public List<MemberVO> selectSearchMember(SearchVO searchvo);
	public void updateMemberUnabled(String [] memlist);
//	public void updateMemberUnabled2(ArrayList<Integer> member_seqList);
	public int selectNoticeCount(int member_seq) throws Exception;
	public List<NoticeVO> selectUserNotice(int member_seq);
	public int readUserNotice(int member_seq);
}
