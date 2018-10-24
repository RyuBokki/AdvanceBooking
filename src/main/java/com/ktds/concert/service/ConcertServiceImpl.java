package com.ktds.concert.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.common.session.Session;
import com.ktds.concert.dao.ConcertDao;
import com.ktds.concert.reply.dao.ConcertReplyDao;
import com.ktds.concert.reply.vo.ConcertReplyVO;
import com.ktds.concert.vo.ConcertSearchVO;
import com.ktds.concert.vo.ConcertVO;
import com.ktds.member.vo.MemberVO;

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
	public PageExplorer readAllConcerts(ConcertSearchVO concertSearchVO, HttpSession session) {
		
		int totalCount = this.concertDao.selectAllConcertsCount(concertSearchVO);
		
		Pager pager = PagerFactory.getPager(Pager.ORACLE
				, concertSearchVO.getPageNo() + "");

		pager.setTotalArticleCount(totalCount);
		
		PageExplorer pageExplorer = pager.makePageExplorer(ClassicPageExplorer.class, concertSearchVO);
		
		MemberVO memberVO = (MemberVO) session.getAttribute(Session.USER);
		
		List<String> preferConcertIdList = this.concertDao.selectAllPreferConcerts(memberVO.getEmail());
		
		List<ConcertVO> concertVOList = this.concertDao.selectAllConcerts(concertSearchVO);
		
		if ( preferConcertIdList != null ) {
			
			for (ConcertVO concertVO : concertVOList) {
				
				concertVO.setRegisteredPrefer(checkPreferConcert(concertVO,preferConcertIdList));
				
			}
		}
		
		pageExplorer.setList(concertVOList);
		
		return pageExplorer;
	}

	private boolean checkPreferConcert(ConcertVO concertVO, List<String> preferConcertIdList) {
		
		for (String preferConcertId : preferConcertIdList) {
			
			if ( preferConcertId.equals(concertVO.getConcertId()) ) {
				return true;
			}
		}
		
		return false;
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
	public List<String> readAllPreferConcerts(String email) {
		// TODO Auto-generated method stub
		return null;
	}

}
