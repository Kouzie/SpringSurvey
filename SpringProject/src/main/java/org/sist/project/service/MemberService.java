package org.sist.project.service;

import java.io.IOException;
import java.util.List;

import org.sist.project.domain.MemberVO;
import org.springframework.web.multipart.MultipartFile;

public interface MemberService {
	public List<MemberVO> getAdminList() throws Exception;

	public boolean addMember(MemberVO member, MultipartFile multipartFile, String realPath) throws Exception;
	public boolean removeMember(int member_seq) throws Exception;
}