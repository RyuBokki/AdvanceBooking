package com.ktds.qna.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.qna.reply.dao.QnAReplyDao;
import com.ktds.qna.reply.vo.QnAReplyVO;

@Service
public class QnAReplyServiceImpl implements QnAReplyService{
	
	@Autowired
	private QnAReplyDao qnaReplyDao;
	
	@Override
	public boolean createOneReply(QnAReplyVO qnaReplyVO) {
		return this.qnaReplyDao.insertOneReply(qnaReplyVO) > 0;
	}

	@Override
	public boolean deleteOneReply(String replyId) {
		return this.qnaReplyDao.deleteOneReply(replyId) > 0;
	}

	@Override
	public QnAReplyVO readOneReply(String replyId) {
		return this.qnaReplyDao.selectOneReply(replyId);
	}

	@Override
	public boolean updateOneReply(QnAReplyVO qnaReplyVO) {
		return this.qnaReplyDao.updateOneReply(qnaReplyVO) > 0;
	}

	@Override
	public boolean updateParentReplyId(String parentReplyId) {
		return this.qnaReplyDao.updateParentReplyId(parentReplyId) > 0;
	}

}
