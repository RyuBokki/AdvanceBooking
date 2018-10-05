package com.ktds.qna.service;

import java.util.List;

import com.ktds.qna.vo.QnAVO;

public interface QnAService {
	
	public boolean createOneQnA(QnAVO qnaVO);
	
	public QnAVO readOneQnA(String id);
	
	public List<QnAVO> readAllQnAs();
	
	public boolean updateOneQnA(String id);
	
	public boolean deleteOneQnA(String id);
}
