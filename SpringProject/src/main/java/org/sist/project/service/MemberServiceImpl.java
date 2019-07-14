   package org.sist.project.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import org.sist.project.domain.MemberVO;
import org.sist.project.persistance.MemberDAO;
import org.sist.project.persistance.MemberDAOImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MemberServiceImpl implements MemberService{
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
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
		String password = member.getPassword();
		String encodedPassword = passwordEncoder.encode(password);
		member.setPassword(encodedPassword);
		result = dao.insertMember(member);
		UsernamePasswordAuthenticationToken authentication
		= new UsernamePasswordAuthenticationToken(member.getUsername(), password);
		Authentication authUser = authenticationManager.authenticate(authentication);
		SecurityContextHolder.getContext().setAuthentication(authUser);
		return result;
	}

	@Override
	public boolean removeMember(int member_seq) throws Exception {
		return dao.deleteMember(member_seq);
	}

	public void secAddMember(MemberVO member, MultipartFile multipartFile, String realPath) throws Exception {
		UserDetails user = new User(
				member.getUsername(), 
				member.getPassword(), 
				Arrays.asList(new SimpleGrantedAuthority("ROLE_USER"))
				);
	}

	@Override
	public String checkUsername(String username) throws Exception {
		return dao.selectUsername(username);
	}

	// 코드 개발중
	@Override
	public boolean updateMember(MemberVO member, MultipartFile multipartFile, String realPath) throws Exception {
		boolean result = false;
		/* 이미 존재하는 파일을 수정해야 할 경우 고려해야 함
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
		*/
		
		String password = member.getPassword();
		String encodedPassword = passwordEncoder.encode(password);
		member.setPassword(encodedPassword);
		result = dao.updateMember(member);
		/* 회원정보 업데이트인데 또 해야 하나?
		UsernamePasswordAuthenticationToken authentication
		= new UsernamePasswordAuthenticationToken(member.getUsername(), password);
		Authentication authUser = authenticationManager.authenticate(authentication);
		SecurityContextHolder.getContext().setAuthentication(authUser);
		*/
		return result;
	}
}

