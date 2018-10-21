package com.ktds.qna.service;

import com.ktds.qna.vo.QnASearchVO;
import com.ktds.qna.vo.QnAVO;

import io.github.seccoding.web.pager.explorer.PageExplorer;

public interface QnAService {
	
	public boolean createOneQnA(QnAVO qnaVO);
	
	public QnAVO readOneQnA(String id);
	
	public PageExplorer readAllQnAs(QnASearchVO qnaSearchVO);
	
	public boolean updateOneQnA(QnAVO qnaVO);
	
	public boolean updateDeleteOneQnA(String id);
}
