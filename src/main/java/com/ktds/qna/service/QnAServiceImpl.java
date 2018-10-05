package com.ktds.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.qna.dao.QnADao;
import com.ktds.qna.vo.QnAVO;


@Service
public class QnAServiceImpl implements QnAService {
	
	@Autowired
	private QnADao qnaDao;
	
	@Override
	public boolean createOneQnA(QnAVO qnaVO) {
		return this.qnaDao.insertOneQnA(qnaVO) > 0;
	}

	@Override
	public QnAVO readOneQnA(String id) {
		return null;
	}

	@Override
	public List<QnAVO> readAllQnAs() {
		return null;
	}

	@Override
	public boolean updateOneQnA(String id) {
		return false;
	}

	@Override
	public boolean deleteOneQnA(String id) {
		return false;
	}

}
