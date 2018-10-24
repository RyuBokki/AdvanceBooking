package com.ktds.concert.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.ktds.concert.vo.ConcertSearchVO;
import com.ktds.concert.vo.ConcertVO;

import io.github.seccoding.web.pager.explorer.PageExplorer;

public interface ConcertService {
	
	public PageExplorer readAllConcerts(ConcertSearchVO concertSearchVO, HttpSession session);
	
	public ConcertVO readOneConcert(String concertId);
	
}
