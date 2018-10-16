package com.ktds.concert.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.ktds.common.session.Session;
import com.ktds.concert.service.ConcertService;
import com.ktds.concert.vo.ConcertSearchVO;

import io.github.seccoding.web.pager.explorer.PageExplorer;

@Controller
public class ConcertController {
	
	@Autowired
	private ConcertService concertService;
	
	@RequestMapping("/concert/list")
	public ModelAndView viewConcertListPage( @ModelAttribute ConcertSearchVO concertSearchVO
										, HttpServletRequest request
										, HttpSession session) {
		
		if ( concertSearchVO.getSearchKeyword() == null ) {
			concertSearchVO = (ConcertSearchVO)session.getAttribute(Session.CONCERTSEARCH);
			
			if ( concertSearchVO == null ) {
				concertSearchVO = new ConcertSearchVO();
				concertSearchVO.setPageNo(0);
			}
		}
		
		PageExplorer pageExplorer = this.concertService.readAllConcerts(concertSearchVO);
		
		session.setAttribute(Session.CONCERTSEARCH, concertSearchVO);
		
		ModelAndView view = new ModelAndView("concert/list");
						
		view.addObject("concertVOList", pageExplorer.getList());
		view.addObject("pagenation", pageExplorer.make());
		view.addObject("size", pageExplorer.getTotalCount());
		view.addObject("concertSearchVO", concertSearchVO);
		
		return view;
	}
	
	
}
