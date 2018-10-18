package com.ktds.concert.prefer.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ktds.concert.prefer.vo.PreferSearchVO;
import com.ktds.concert.prefer.vo.PreferVO;

import io.github.seccoding.web.pager.explorer.PageExplorer;

public interface PreferService {
	
	public boolean registOnePrefer(PreferVO preferVO);
	
	public boolean deleteOnePrefer(PreferVO preferVO);
	
	public PreferVO isDuplicatedPrefer(PreferVO preferVO);
	
	public PageExplorer readAllPrefers(PreferSearchVO preferSearchVO, HttpSession session);
	
	public void sendEmail(PreferVO preferVO) throws Exception;
	
	public boolean sendAdvanceBookingInfo() throws Exception;
	
}
