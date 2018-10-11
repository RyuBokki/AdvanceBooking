package com.ktds.qna.reply.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.qna.reply.vo.QnAReplyVO;

@Repository
public class QnAReplyDaoImpl extends SqlSessionDaoSupport implements QnAReplyDao {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int insertOneReply(QnAReplyVO qnaReplyVO) {
		return this.getSqlSession().insert("QnAReplyDao.insertOneReply", qnaReplyVO);
	}

	@Override
	public List<QnAReplyVO> selectAllReplies(String qnaId) {
		return this.getSqlSession().selectList("QnAReplyDao.selectAllReplies", qnaId);
	}

	@Override
	public int deleteOneReply(String replyId) {
		return this.getSqlSession().delete("QnAReplyDao.deleteOneReply", replyId);
	}

	@Override
	public QnAReplyVO selectOneReply(String replyId) {
		return this.getSqlSession().selectOne("QnAReplyDao.selectOneReply", replyId);
	}

	@Override
	public int updateOneReply(QnAReplyVO qnaReplyVO) {
		return this.getSqlSession().update("QnAReplyDao.updateOneReply", qnaReplyVO);
	}

	@Override
	public int updateParentReplyId(String parentReplyId) {
		return this.getSqlSession().update("QnAReplyDao.updateParentReplyId", parentReplyId);
	}

}
