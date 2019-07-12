package org.sist.project.persistance;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.sist.project.domain.MemberVO;
import org.sist.project.member.MemberDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MemberDAOImpl implements MemberDAO{
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	private String namespace = "org.sist.project.mapper.MemberMapper";

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MemberVO> selectAdminList() throws Exception {
		logger.info("getAdminList");
		return sqlSession.selectList(namespace+".selectAdminList");
	}

	@Override
	public boolean insertMember(MemberVO member) throws Exception {
		logger.info("addMember");
		return sqlSession.insert(namespace+".insertMember", member) != 0 ? true : false;
	}

	@Override
	public boolean deleteMember(int member_seq) throws Exception {
		logger.info("deleteMember");
		return sqlSession.insert(namespace+".deleteMember", member_seq) != 0 ? true : false;
	}

	@Override
	public MemberDetails selectUserById(String username) {
		logger.info("selectUserById");
		return sqlSession.selectOne(namespace+".selectUserById", username);
	}

}
