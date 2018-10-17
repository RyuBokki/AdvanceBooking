package com.ktds.concert.prefer.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.common.session.Session;
import com.ktds.concert.prefer.dao.PreferDao;
import com.ktds.concert.prefer.vo.PreferSearchVO;
import com.ktds.concert.prefer.vo.PreferVO;
import com.ktds.member.vo.MemberVO;

import io.github.seccoding.web.pager.Pager;
import io.github.seccoding.web.pager.PagerFactory;
import io.github.seccoding.web.pager.explorer.ClassicPageExplorer;
import io.github.seccoding.web.pager.explorer.PageExplorer;

@Service
public class PreferServiceImpl implements PreferService {

	@Autowired
	private PreferDao preferDao;
	
	@Override
	public boolean registOnePrefer(PreferVO preferVO) {
		return this.preferDao.insertOnePrefer(preferVO) > 0;
	}

	@Override
	public boolean deleteOnePrefer(String preferId) {
		return this.preferDao.deleteOnePrefer(preferId) > 0;
	}

	@Override
	public PreferVO isDuplicatedPrefer(String concertId) {
		return this.preferDao.isDuplicatedPrefer(concertId);
	}

	@Override
	public PageExplorer readAllPrefers(PreferSearchVO preferSearchVO
										, HttpSession session) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute(Session.USER);
		
		preferSearchVO.setEmail(memberVO.getEmail());
		
		int totalCount = this.preferDao.selectAllPrefersCount(preferSearchVO);
		
		Pager pager = PagerFactory.getPager(Pager.ORACLE
				, preferSearchVO.getPageNo() + "");

		pager.setTotalArticleCount(totalCount);
		
		PageExplorer pageExplorer = pager.makePageExplorer(ClassicPageExplorer.class, preferSearchVO);
		
		pageExplorer.setList(this.preferDao.selectAllPrefers(preferSearchVO));
		
		return pageExplorer;
	}

}
