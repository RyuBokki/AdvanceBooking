package com.ktds.qna.reply.dao;

import java.util.List;

import com.ktds.qna.reply.vo.QnAReplyVO;

public interface QnAReplyDao {
	
	public int insertOneReply(QnAReplyVO qnaReplyVO);
	
	public QnAReplyVO selectOneReply(String replyId);
	
	public List<QnAReplyVO> selectAllReplies(String qnaId);
	
	public int deleteOneReply(String replyId);
	
	public int updateOneReply(QnAReplyVO qnaReplyVO);
	
}
