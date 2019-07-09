package org.sist.project.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.sist.project.domain.MemberVO;
import org.sist.project.persistance.MemberDAO;
import org.sist.project.persistance.MemberDAOImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MemberServiceImpl implements MemberService{
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	@Autowired
	MemberDAO dao;

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

}

