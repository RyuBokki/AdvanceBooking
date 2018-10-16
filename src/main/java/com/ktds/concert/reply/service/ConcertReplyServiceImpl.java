package com.ktds.concert.reply.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.concert.reply.dao.ConcertReplyDao;
import com.ktds.concert.reply.vo.ConcertReplyVO;

@Service
public class ConcertReplyServiceImpl implements ConcertReplyService {

	@Autowired
	private ConcertReplyDao concertReplyDao;
	
	@Override
	public boolean createOneReply(ConcertReplyVO concertReplyVO) {
		return this.concertReplyDao.insertOneReply(concertReplyVO) > 0;
	}

	@Override
	public ConcertReplyVO readOneReply(String replyId) {
		return this.concertReplyDao.selectOneReply(replyId);
	}

	@Override
	public boolean updateOneReply(ConcertReplyVO concertReplyVO) {
		return this.concertReplyDao.updateOneReply(concertReplyVO) > 0;
	}

	@Override
	public boolean deleteOneReply(String replyId) {
		return this.concertReplyDao.deleteOneReply(replyId) > 0;
	}

}
