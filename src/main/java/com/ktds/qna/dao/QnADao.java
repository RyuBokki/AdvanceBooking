package com.ktds.qna.dao;

import java.util.List;

import com.ktds.qna.vo.QnAVO;

public interface QnADao {
	
	public int insertOneQnA(QnAVO qnaVO);
	
	public QnAVO selectOneQnA(String id);
	
	public List<QnAVO> selectAllQnAs();
	
	public int updateOneQnA(String id);
	
	public int deleteOneQnA(String id);
	
}
