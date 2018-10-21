package com.ktds.concert.reply.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.concert.reply.vo.ConcertReplyVO;

@Repository
public class ConcertReplyDaoImpl extends SqlSessionDaoSupport implements ConcertReplyDao {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int insertOneReply(ConcertReplyVO concertReplyVO) {
		return this.getSqlSession().insert("ConcertReplyDao.insertOneReply", concertReplyVO);
	}

	@Override
	public ConcertReplyVO selectOneReply(String replyId) {
		return this.getSqlSession().selectOne("ConcertReplyDao.selectOneReply", replyId);
	}

	@Override
	public List<ConcertReplyVO> selectAllReplies(String concertId) {
		return this.getSqlSession().selectList("ConcertReplyDao.selectAllReplies", concertId);
	}

	@Override
	public int updateDeleteOneReply(String replyId) {
		return this.getSqlSession().delete("ConcertReplyDao.updateDeleteOneReply", replyId);
	}

	@Override
	public int updateOneReply(ConcertReplyVO concertReplyVO) {
		return this.getSqlSession().update("ConcertReplyDao.updateOneReply", concertReplyVO);
	}

	@Override
	public int updateParentReplyId(ConcertReplyVO concertReplyVO) {
		return this.getSqlSession().update("ConcertReplyDao.updateParentReplyId", concertReplyVO);
	}

}
