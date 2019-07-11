   package org.sist.project.service;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Arrays;
import java.util.List;

import org.sist.project.domain.MemberVO;
import org.sist.project.persistance.MemberDAO;
import org.sist.project.persistance.MemberDAOImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MemberServiceImpl implements MemberService{
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	@Autowired
	private MemberDAO dao;

	private UserDetailsManager userDetailsManager;

	@Override
	public List<MemberVO> getAdminList() throws Exception {
		return dao.selectAdminList();
	}

	@Override
	public boolean addMember(MemberVO member, MultipartFile multipartFile, String realPath) throws Exception {
		boolean result = false;
		try {
			if (!multipartFile.isEmpty()) {
				byte[] bytes = multipartFile.getBytes();
				String filename = multipartFile.getOriginalFilename();
				File file = new File(realPath, filename);
				FileCopyUtils.copy(bytes, file);
				member.setImage(filename);
			}
			else 
				logger.info("no file to upload....");
		}
		catch (IOException e) {
			logger.warn("file upload fail....");
			e.printStackTrace();
			return false;
		}
		dao.insertMember(member);
		return result;
	}

	@Override
	public boolean removeMember(int member_seq) throws Exception {
		return dao.deleteMember(member_seq);
	}

	public UserDetailsManager getUserDetailsManager() {
		return userDetailsManager;
	}

	public void setUserDetailsManager(UserDetailsManager userDetailsManager) {
		this.userDetailsManager = userDetailsManager;
	}

	public void secAddMember(MemberVO member, MultipartFile multipartFile, String realPath) throws Exception {
		UserDetails user = new User(
				member.getUsername(), 
				member.getPassword(), 
				Arrays.asList(new SimpleGrantedAuthority("ROLE_USER"))
				);
	}
}


