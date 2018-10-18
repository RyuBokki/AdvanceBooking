package com.ktds.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.qna.dao.QnADao;
import com.ktds.qna.reply.dao.QnAReplyDao;
import com.ktds.qna.reply.vo.QnAReplyVO;
import com.ktds.qna.vo.QnASearchVO;
import com.ktds.qna.vo.QnAVO;

import io.github.seccoding.web.pager.Pager;
import io.github.seccoding.web.pager.PagerFactory;
import io.github.seccoding.web.pager.explorer.ClassicPageExplorer;
import io.github.seccoding.web.pager.explorer.PageExplorer;


@Service
public class QnAServiceImpl implements QnAService {
	
	@Autowired
	private QnADao qnaDao;
	
	@Autowired
	private QnAReplyDao qnaReplyDao;
	
	@Override
	public boolean createOneQnA(QnAVO qnaVO) {
		return this.qnaDao.insertOneQnA(qnaVO) > 0;
	}

	@Override
	public QnAVO readOneQnA(String id) {
		
		QnAVO qnaVO = this.qnaDao.selectOneQnA(id);
		
		List<QnAReplyVO> replyList = this.qnaReplyDao.selectAllReplies(id);
		
		if ( replyList != null ) {
			qnaVO.setReplyList(replyList);
		}
		
		return qnaVO;
	}

	@Override
	public PageExplorer readAllQnAs(QnASearchVO qnaSearchVO) {
		
		int totalCount = this.qnaDao.selectAllQnAsCount(qnaSearchVO);
		
		Pager pager = PagerFactory.getPager(Pager.ORACLE
											, qnaSearchVO.getPageNo() + "");
		
		pager.setTotalArticleCount(totalCount);
		
		PageExplorer pageExplorer = pager.makePageExplorer(ClassicPageExplorer.class, qnaSearchVO);
		
		pageExplorer.setList(this.qnaDao.selectAllQnAs(qnaSearchVO));
		
		return pageExplorer;
	}

	@Override
	public boolean updateOneQnA(QnAVO qnaVO) {
		return this.qnaDao.updateOneQnA(qnaVO) > 0;
	}

	@Override
	public boolean deleteOneQnA(String id) {
		return this.qnaDao.deleteOneQnA(id) > 0;
	}

}
