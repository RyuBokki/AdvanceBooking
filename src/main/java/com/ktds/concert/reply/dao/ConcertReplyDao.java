package com.ktds.concert.reply.dao;

import java.util.List;

import com.ktds.concert.reply.vo.ConcertReplyVO;

public interface ConcertReplyDao {
public int insertOneReply(ConcertReplyVO concertReplyVO);
	
	public ConcertReplyVO selectOneReply(String replyId);
	
	public List<ConcertReplyVO> selectAllReplies(String concertId);
	
	public int deleteOneReply(String replyId);
	
	public int updateOneReply(ConcertReplyVO concertReplyVO);
}
