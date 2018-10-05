package com.ktds.qna.dao;

import com.ktds.qna.vo.QnAVO;

public interface QnADao {
	
	public int insertOneQnA(QnAVO qnaVO);
	
	public QnAVO selectOneQnA(String id);
	
	public QnAVO selectAllQnAs();
	
	public int updateOneQnA(String id);
	
	public int deleteOneQnA(String id);
	
}
