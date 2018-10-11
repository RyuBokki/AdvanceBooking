package com.ktds.qna.reply.service;

import java.util.List;

import com.ktds.qna.reply.vo.QnAReplyVO;

public interface QnAReplyService {

	public boolean createOneReply(QnAReplyVO qnaReplyVO);
	
	public QnAReplyVO readOneReply(String replyId);
	
	public boolean updateOneReply(QnAReplyVO qnaReplyVO);
	
	public boolean updateParentReplyId(String parentReplyId);
	
	public boolean deleteOneReply(String replyId);
}
