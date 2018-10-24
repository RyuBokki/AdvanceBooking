package com.ktds.concert.reply.service;

import com.ktds.concert.reply.vo.ConcertReplyVO;

public interface ConcertReplyService {
	
	public boolean createOneReply(ConcertReplyVO concertReplyVO);
	
	public ConcertReplyVO readOneReply(String replyId);
	
	public boolean updateOneReply(ConcertReplyVO concertReplyVO);
		
	public boolean updateDeleteOneReply(String replyId);
	
}
