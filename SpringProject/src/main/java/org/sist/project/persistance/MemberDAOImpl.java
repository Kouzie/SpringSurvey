package org.sist.project.persistance;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.sist.project.domain.MemberVO;
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

}
