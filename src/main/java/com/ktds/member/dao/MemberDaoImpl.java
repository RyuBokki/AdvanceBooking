package com.ktds.member.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.member.vo.MemberVO;

@Repository
public class MemberDaoImpl extends SqlSessionDaoSupport 
							implements MemberDao {
	
	private Logger logger = LoggerFactory.getLogger(MemberDaoImpl.class);
	
	
	@Autowired
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		logger.debug("Initiate MyBatis");
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int insertOneMember(MemberVO memberVO) {
		return getSqlSession().insert("MemberDao.insertOneMember", memberVO);
	}

	@Override
	public MemberVO selectOneMember(MemberVO memberVO) {
		return getSqlSession().selectOne("MemberDao.selectOneMember", memberVO);
	}

	@Override
	public List<MemberVO> selectAllMembers() {
		return getSqlSession().selectList("MemberDao.selectAllMembers");
	}

	@Override
	public int updateOneMember(String email) {
		return getSqlSession().update("MemberDao.updateOneMember", email);
	}

	@Override
	public boolean isBlockUser(String email) {
		return getSqlSession().selectOne("MemberDao.isBlockUser", email);
	}

	@Override
	public int unBlockUser(String email) {
		return getSqlSession().update("MemberDao.unBlockUser", email);
	}

	@Override
	public int increaseLoginFailCount(String email) {
		return getSqlSession().update("MemberDao.increaseLoginFailCount", email);
	}

	@Override
	public boolean isDuplicatedEmail(String email) {
		return getSqlSession().selectOne("MemberDao.isDuplicatedEmail", email);
	}

	@Override
	public String getSaltByEmail(String email) {
		return getSqlSession().selectOne("MemberDao.getSaltByEmail", email);
	}

}
