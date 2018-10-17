package com.ktds.concert.prefer.service;

import javax.servlet.http.HttpSession;

import com.ktds.concert.prefer.vo.PreferSearchVO;
import com.ktds.concert.prefer.vo.PreferVO;

import io.github.seccoding.web.pager.explorer.PageExplorer;

public interface PreferService {
	
	public boolean registOnePrefer(PreferVO preferVO);
	
	public boolean deleteOnePrefer(String preferId);
	
	public PreferVO isDuplicatedPrefer(String concertId);
	
	public PageExplorer readAllPrefers(PreferSearchVO preferSearchVO, HttpSession session);
}
