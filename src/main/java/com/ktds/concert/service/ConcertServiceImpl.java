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
		
		List<String> preferConcertIdList = this.concertDao.selectAllPreferConcerts();
		
		List<ConcertVO> concertVOList = this.concertDao.selectAllConcerts(concertSearchVO);
		
		if ( preferConcertIdList != null ) {
			
			for (ConcertVO concertVO : concertVOList) {
				
				String concertId = concertVO.getConcertId();
				
				for (String preferConcertId : preferConcertIdList) {
					if ( preferConcertId.equals(concertId) ) {
						System.out.println("비교성공");
						System.out.println(preferConcertId);
						concertVO.setRegisteredPrefer(true);
					}
					else {
						concertVO.setRegisteredPrefer(false);
					}
				}
			}
		}
		
		pageExplorer.setList(concertVOList);
		
		return pageExplorer;
	}


	@Override
	public ConcertVO readOneConcert(String concertId) {
		
		ConcertVO concertVO = this.concertDao.selectOneConcert(concertId);
		
		List<ConcertReplyVO> replyList = this.concertReplyDao.selectAllReplies(concertId);
		
		for (ConcertReplyVO concertReplyVO : replyList) {
			boolean isChildReplyExist = this.concertReplyDao.isChildReplyExist(concertReplyVO) != null;
			
			if ( isChildReplyExist ) {
				concertReplyVO.setChildReplyExist(true);
			}
			else {
				concertReplyVO.setChildReplyExist(false);
			}
		}
		
		concertVO.setReplyList(replyList);
		
		return concertVO;
	}


	@Override
	public List<String> readAllPreferConcerts() {
		return this.concertDao.selectAllPreferConcerts();
	}

}
