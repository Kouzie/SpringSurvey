   package org.sist.project.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.sist.project.domain.MemberVO;
import org.sist.project.domain.NoticeVO;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SearchVO;
import org.sist.project.member.MemberDetails;
import org.sist.project.persistance.MemberDAO;
import org.sist.project.persistance.MemberDAOImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
	private PasswordEncoder passwordEncoder; //join시에 비밀번호 암호화 저장하기 위한 객체
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
	@Override
	public List<MemberVO> getAdminList() throws Exception {
		return dao.selectAdminList();
	}

	@Override
	public void addMember(MemberVO member, MultipartFile multipartFile, String realPath) throws Exception {
		try {
			if (multipartFile.getSize() != 0) {
				String uuidname = UUID.randomUUID().toString()+".jpg";
				byte[] bytes = multipartFile.getBytes();
				File file = new File(realPath, uuidname);
				FileCopyUtils.copy(bytes, file);
				member.setImage(uuidname);
			}
		}
		catch (IOException e) {
			logger.warn("file upload fail....");
			throw e;
		}
		String password = member.getPassword();
		String encodedPassword = passwordEncoder.encode(password);
		member.setPassword(encodedPassword);
		dao.insertMember(member);
		UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(member.getUsername(), password);
		Authentication authUser = authenticationManager.authenticate(authentication);
		SecurityContextHolder.getContext().setAuthentication(authUser);		//회원가입후 바로 인증객체를 생성. securitycontext에 저장.
	}

	@Override
	public void removeMember(int member_seq, String password) throws Exception {
		MemberDetails member = (MemberDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(member.getUsername(), password);
		Authentication authUser = authenticationManager.authenticate(authentication);
		if (authUser.isAuthenticated()) {
			dao.removeMember(member_seq);
		}
	}

	@Override
	public String checkUsername(String username) throws Exception {
		//아이디 중복체크를 위한 메서드
		return dao.selectUsername(username);
	}
	
	@Override
	public void modifyMember(MemberVO member, MultipartFile multipartFile,
			String realPath, String password, String changePassword, int garbage) throws Exception {
		
		UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(member.getUsername(), password);
		authenticationManager.authenticate(authentication);

		String changeEncodedPassword = passwordEncoder.encode(changePassword);
		member.setPassword(changeEncodedPassword);

		try {
			if (multipartFile.getSize() != 0) {
				byte[] bytes = multipartFile.getBytes();
				String filename = UUID.randomUUID().toString()+".jpg"; 
				File newfile = new File(realPath, filename);
				FileCopyUtils.copy(bytes, newfile);
				
				//기존 가지고있던 파일 삭제
				if (member.getImage() != null) {
					File deletefile = new File(realPath, member.getImage());
					if( deletefile.exists() ){
			            if(deletefile.delete()){
			                System.out.println("파일삭제 성공");
			            }else{
			                System.out.println("파일삭제 실패");
			            }
			        }else{
			            System.out.println("파일이 존재하지 않습니다.");
			        }
				}
				member.setImage(filename);
			}
			else if(multipartFile.getSize() == 0 && garbage == 1) {
				// db에서 파일명 삭제 & 로컬에서 파일 삭제
				File file = new File(realPath, member.getImage());
				file.delete();
				member.setImage(null);
			}
			else if(multipartFile.getSize() == 0 && garbage == 0) {
				String filename = member.getImage();
				member.setImage(filename);
			}
		}
		catch (IOException e) {
			logger.warn("file upload fail....");
			e.printStackTrace();
			throw e;
		}
		dao.modifyMember(member);
	}
	@Override
	public String checkUserEmail(String username) throws Exception {
		// 비밀번호 찾기시 email일지하느지 확인하기 위한 메서드
		return dao.selectUserEmail(username);
	}

	@Override
	public void modifyPassword(String username, String authKey) throws Exception {
		// 비밀번호 찾기시 임시 비밀번호로 변경
		String encodedPassword = passwordEncoder.encode(authKey);
		dao.updateUserPassword(username, encodedPassword);
	}

	@Override
	public int getNoticeCount(int member_seq) throws Exception {
		
		return dao.selectNoticeCount(member_seq);
	}
	@Override
	public List<MemberVO> getSearchMember(SearchCriteria cri) {
		List<MemberVO> list =  dao.selectSearchMember(cri);
		return list;
	}
	@Override
	public void modifyMemberUnabled(String [] memlist) {
		dao.updateMemberUnabled(memlist);
		
	}

	@Override
	public List<NoticeVO> getUserNotice(int member_seq) {
		
		return dao.selectUserNotice(member_seq);
	}

	@Override
	public int readUserNotice(int member_seq) {
		return dao.readUserNotice(member_seq);
		
	}

	@Override
	public PageMaker getMemberPagination(SearchCriteria cri) throws Exception {
		return dao.selectMemberCountPaging(cri);
	}

/*	@Override
	public void UpdateMemberUnabled2(ArrayList<Integer> member_seqList) {
		dao.updateMemberUnabled2(member_seqList);
		
	}*/
}

