package com.ktds.qna.dao;

import java.util.List;

import com.ktds.qna.vo.QnASearchVO;
import com.ktds.qna.vo.QnAVO;

public interface QnADao {
	
	public int insertOneQnA(QnAVO qnaVO);
	
	public QnAVO selectOneQnA(String id);
	
	public List<QnAVO> selectAllQnAs(QnASearchVO qnaSearchVO);
	
	public int updateOneQnA(QnAVO qnaVO);
	
	public int updateDeleteOneQnA(String id);
	
	public int selectAllQnAsCount(QnASearchVO qnaSearchVO);
}
