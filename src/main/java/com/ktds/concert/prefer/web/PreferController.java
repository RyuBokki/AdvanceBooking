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
import com.ktds.member.vo.MemberVO;

import io.github.seccoding.web.pager.explorer.PageExplorer;

@Controller
public class PreferController {
	
	@Autowired
	private PreferService preferService;
	
	@PostMapping("/prefer/regist")
	@ResponseBody
	public Map<String, Object> doRegistPreferAction(
										@SessionAttribute(Session.CSRF_TOKEN) String sessionToken
										, @SessionAttribute(Session.USER) MemberVO memberVO
										, @ModelAttribute PreferVO preferVO) {
		
		if ( !sessionToken.equals( preferVO.getToken() ) ) {
			throw new RuntimeException("잘못된 인증");
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("status", "OK");
		
		PreferVO duplicatedPreferVO = this.preferService.isDuplicatedPrefer(preferVO);
		
		result.put("isDuplicatedPrefer", duplicatedPreferVO != null);
		
		if ( duplicatedPreferVO == null ) {			
			boolean isRegistSuccess = this.preferService.registOnePrefer(preferVO);
			result.put("isRegistSuccess", isRegistSuccess);
		}
		else {
			
			PreferVO deletePreferVO = new PreferVO();
			
			deletePreferVO.setPreferId(duplicatedPreferVO.getPreferId());
			deletePreferVO.setEmail(memberVO.getEmail());
			
			boolean isDeleteSuccess = this.preferService.deleteOnePrefer(deletePreferVO);
			result.put("isDeleteSuccess", isDeleteSuccess);
		}
		return result;
	}
	
	@RequestMapping("/prefer/list/init")
	public String viewPreferListPageForInitiate(HttpSession session) {
		session.removeAttribute(Session.CONCERTSEARCH);
		return "redirect:/prefer/list" + "?token=" + session.getAttribute(Session.CSRF_TOKEN);
	}
	
	@RequestMapping("/prefer/list")
	public ModelAndView viewConcertListPage( @ModelAttribute PreferSearchVO preferSearchVO
										, HttpServletRequest request
										, HttpSession session) {
		
		System.out.println(preferSearchVO.getEmail());
		
		if ( preferSearchVO.getSearchKeyword() == null ) {
			preferSearchVO = (PreferSearchVO)session.getAttribute(Session.PREFERSEARCH);
			
			if ( preferSearchVO == null ) {
				preferSearchVO = new PreferSearchVO();
				preferSearchVO.setPageNo(0);
			}
		}
		
		PageExplorer pageExplorer = this.preferService.readAllPrefers(preferSearchVO, session);
		
		session.setAttribute(Session.PREFERSEARCH, preferSearchVO);
		
		
		
		ModelAndView view = new ModelAndView("prefer/list");
						
		view.addObject("preferVOList", pageExplorer.getList());
		view.addObject("pagenation", pageExplorer.make());
		view.addObject("size", pageExplorer.getTotalCount());
		view.addObject("preferSearchVO", preferSearchVO);
		
		return view;
	}
	
	@PostMapping("/prefer/delete/{preferId}")
	@ResponseBody
	public Map<String, Object> doDeletePreferAction(@SessionAttribute(Session.CSRF_TOKEN) String sessionToken
													, @SessionAttribute(Session.USER) MemberVO memberVO
													, @PathVariable String preferId
													, @RequestParam String token) {
		
		if ( !token.equals(sessionToken) ) {
			throw new RuntimeException("잘못된 인증");
		}
		
		PreferVO preferVO = new PreferVO();
		
		preferVO.setPreferId(preferId);
		preferVO.setEmail(memberVO.getEmail());		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		boolean isDeleteSuccess = this.preferService.deleteOnePrefer(preferVO);
		
		result.put("status", "OK");
		
		result.put("isDeleteSuccess", isDeleteSuccess);
		
		return result; 
	}
	
	@PostMapping("/prefer/sendEmail")
	@ResponseBody
	public Map<String, Object> doSendEmailPreferInfoAction(@RequestParam String token
															, @SessionAttribute(Session.CSRF_TOKEN) String sessionToken) throws Exception {
		
		if ( !token.equals(sessionToken) ) {
			throw new RuntimeException("잘못된 인증");
		}
		
		Map<String,Object> result = new HashMap<String, Object>();
		
		System.out.println("실행됨");
		
		boolean isSendEmailSuccess = this.preferService.sendAdvanceBookingInfo();
		
		result.put("status", "OK");
		
		if ( isSendEmailSuccess ) {
			result.put("isSendEmailSuccess", isSendEmailSuccess);
		}
		
		return result;
	}
	
}
