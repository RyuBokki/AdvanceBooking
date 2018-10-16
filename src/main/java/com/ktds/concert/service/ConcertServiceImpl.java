package com.ktds.concert.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.concert.dao.ConcertDao;
import com.ktds.concert.reply.dao.ConcertReplyDao;
import com.ktds.concert.reply.vo.ConcertReplyVO;
import com.ktds.concert.vo.ConcertSearchVO;
import com.ktds.concert.vo.ConcertVO;

import io.github.seccoding.web.pager.Pager;
import io.github.seccoding.web.pager.PagerFactory;
import io.github.seccoding.web.pager.explorer.ClassicPageExplorer;
import io.github.seccoding.web.pager.explorer.PageExplorer;

@Service
public class ConcertServiceImpl implements ConcertService {

	@Autowired
	private ConcertDao concertDao;
	
	@Autowired
	private ConcertReplyDao concertReplyDao;
	

	@Override
	public PageExplorer readAllConcerts(ConcertSearchVO concertSearchVO) {
		
		int totalCount = this.concertDao.selectAllConcertsCount(concertSearchVO);
		
		Pager pager = PagerFactory.getPager(Pager.ORACLE
				, concertSearchVO.getPageNo() + "");

		pager.setTotalArticleCount(totalCount);
		
		PageExplorer pageExplorer = pager.makePageExplorer(ClassicPageExplorer.class, concertSearchVO);
		
		pageExplorer.setList(this.concertDao.selectAllConcerts(concertSearchVO));
		
		return pageExplorer;
	}


	@Override
	public ConcertVO readOneConcert(String concertId) {
		
		ConcertVO concertVO = this.concertDao.selectOneConcert(concertId);
		
		List<ConcertReplyVO> replyList = this.concertReplyDao.selectAllReplies(concertId);
		
		concertVO.setReplyList(replyList);
		
		return concertVO;
	}

}
