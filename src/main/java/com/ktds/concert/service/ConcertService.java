package com.ktds.concert.service;

import com.ktds.concert.vo.ConcertSearchVO;
import com.ktds.concert.vo.ConcertVO;

import io.github.seccoding.web.pager.explorer.PageExplorer;

public interface ConcertService {
	
	public PageExplorer readAllConcerts(ConcertSearchVO concertSearchVO);
	
	public ConcertVO readOneConcert(String concertId);
}
