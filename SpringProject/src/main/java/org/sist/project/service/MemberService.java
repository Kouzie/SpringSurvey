package org.sist.project.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.sist.project.domain.MemberVO;
import org.sist.project.domain.SearchVO;
import org.sist.project.domain.UpdateMemberVO;
import org.springframework.web.multipart.MultipartFile;

public interface MemberService {
	public List<MemberVO> getAdminList() throws Exception;

	public void addMember(MemberVO member, MultipartFile multipartFile, String realPath) throws Exception;

	public void updateMember(MemberVO member, MultipartFile multipartFile, String realPath,
			String password, String changePassword, int garbage) throws Exception;
	
	public boolean removeMember(int member_seq) throws Exception;
	public String checkUsername(String username) throws Exception;
	public String checkUserEmail(String username) throws Exception;

	public void modifyPassword(String username, String authKey) throws Exception;

	public int getNoticeCount(int member_seq) throws Exception;

	public List<MemberVO> getSearchMember(SearchVO searchvo);

	public void modifyMemberUnabled(String[] memlist);

	//public void UpdateMemberUnabled2(ArrayList<Integer> member_seqList);
}
