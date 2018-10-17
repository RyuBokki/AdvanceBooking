package com.ktds.concert.prefer.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.ktds.common.session.Session;
import com.ktds.concert.prefer.service.PreferService;
import com.ktds.concert.prefer.vo.PreferSearchVO;
import com.ktds.concert.prefer.vo.PreferVO;

import io.github.seccoding.web.pager.explorer.PageExplorer;

@Controller
public class PreferController {
	
	@Autowired
	private PreferService preferService;
	
	@PostMapping("/concert/prefer/regist")
	@ResponseBody
	public Map<String, Object> doRegistPreferAction(
										@SessionAttribute(Session.CSRF_TOKEN) String sessionToken
										, @ModelAttribute PreferVO preferVO) {
		
		if ( !sessionToken.equals( preferVO.getToken() ) ) {
			throw new RuntimeException("잘못된 인증");
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("status", "OK");
		
		PreferVO duplicatedPreferVO = this.preferService.isDuplicatedPrefer(preferVO.getConcertId());
		
		result.put("isDuplicatedPrefer", duplicatedPreferVO != null);
		
		if ( duplicatedPreferVO == null ) {			
			boolean isRegistSuccess = this.preferService.registOnePrefer(preferVO);
			result.put("isRegistSuccess", isRegistSuccess);
		}
		else {
			String preferId = duplicatedPreferVO.getPreferId();
			
			boolean isDeleteSuccess = this.preferService.deleteOnePrefer(preferId);
			result.put("isDeleteSuccess", isDeleteSuccess);
		}
		return result;
	}
	
	@RequestMapping("/concert/prefer/list/init")
	public String viewPreferListPageForInitiate(HttpSession session) {
		session.removeAttribute(Session.CONCERTSEARCH);
		return "redirect:/concert/prefer/list" + "?token=" + session.getAttribute(Session.CSRF_TOKEN);
	}
	
	@RequestMapping("/concert/prefer/list")
	public ModelAndView viewConcertListPage( @ModelAttribute PreferSearchVO preferSearchVO
										, HttpServletRequest request
										, HttpSession session) {
		
		if ( preferSearchVO.getSearchKeyword() == null ) {
			preferSearchVO = (PreferSearchVO)session.getAttribute(Session.PREFERSEARCH);
			
			if ( preferSearchVO == null ) {
				preferSearchVO = new PreferSearchVO();
				preferSearchVO.setPageNo(0);
			}
		}
		
		PageExplorer pageExplorer = this.preferService.readAllPrefers(preferSearchVO);
		
		session.setAttribute(Session.PREFERSEARCH, preferSearchVO);
		
		ModelAndView view = new ModelAndView("prefer/list");
						
		view.addObject("preferVOList", pageExplorer.getList());
		view.addObject("pagenation", pageExplorer.make());
		view.addObject("size", pageExplorer.getTotalCount());
		view.addObject("preferSearchVO", preferSearchVO);
		
		return view;
	}
	
	@PostMapping("/concert/prefer/delete/{preferId}")
	@ResponseBody
	public Map<String, Object> doDeletePreferAction(@SessionAttribute(Session.CSRF_TOKEN) String sessionToken
													, @PathVariable String preferId
													, @RequestParam String token) {
		
		if ( !token.equals(sessionToken) ) {
			throw new RuntimeException("잘못된 인증");
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		boolean isDeleteSuccess = this.preferService.deleteOnePrefer(preferId);
		
		result.put("status", "OK");
		
		result.put("isDeleteSuccess", isDeleteSuccess);
		
		return result; 
	}
	
}
