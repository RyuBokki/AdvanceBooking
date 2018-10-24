package com.ktds.concert.reply.web;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.ktds.common.session.Session;
import com.ktds.concert.reply.service.ConcertReplyService;
import com.ktds.concert.reply.vo.ConcertReplyVO;
import com.ktds.member.vo.MemberVO;
import com.ktds.qna.reply.vo.QnAReplyVO;
import com.nhncorp.lucy.security.xss.XssFilter;

@Controller
public class ConcertReplyController {
	
	@Autowired
	private ConcertReplyService concertReplyService;
	
	@RequestMapping("concert/reply/write")
	public ModelAndView doCreateReplyAction(@ModelAttribute ConcertReplyVO concertReplyVO
											, @SessionAttribute(Session.USER) MemberVO memberVO
											, @SessionAttribute(Session.CSRF_TOKEN) String sessionToken
											, Errors errors) {
		
		if ( !concertReplyVO.getToken().equals(sessionToken) ) {
			throw new RuntimeException("잘못된 인증");
		}
		
		ModelAndView view = new ModelAndView("redirect:/concert/detail/" + concertReplyVO.getConcertId() + "?token=" + sessionToken);
		
		if ( errors.hasErrors() ) {
			view.setViewName("concert/detail");
			view.addObject("concertReplyVO", concertReplyVO);
		}
	
		concertReplyVO.setEmail(memberVO.getEmail());
		
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
		concertReplyVO.setContent(filter.doFilter(concertReplyVO.getContent()));
		
		boolean isCreateReplySuccess = this.concertReplyService.createOneReply(concertReplyVO);
		
		return view;
	}
	
	@RequestMapping("concert/reply/delete/{replyId}")
	public String doDeleteReplyAction(@PathVariable String replyId
									   , @RequestParam String token
									   , @SessionAttribute(Session.CSRF_TOKEN) String sessionToken) {
		
		if ( !token.equals(sessionToken) ) {
			throw new RuntimeException("잘못된 인증");
		}
		
		String concertId = this.concertReplyService.readOneReply(replyId).getConcertId();
		
		boolean isDeleteSuccess = this.concertReplyService.updateDeleteOneReply(replyId);
		
		
		return "redirect:/concert/detail/" + concertId + "?token=" + sessionToken;
	}
	
	@RequestMapping("concert/reply/update/{replyId}")
	public ModelAndView doUpdateReplyAction(@PathVariable String replyId
									   , @ModelAttribute ConcertReplyVO concertReplyVO 
									   , Errors errors
									   , @SessionAttribute(Session.CSRF_TOKEN) String sessionToken) {
		
		if ( !sessionToken.equals(concertReplyVO.getToken()) ) {
			throw new RuntimeException("잘못된 인증");
		}
		
		String concertId = this.concertReplyService.readOneReply(replyId).getConcertId();

		ModelAndView view = new ModelAndView("redirect:/concert/detail/" + concertId + "?token=" + sessionToken);
		
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
		concertReplyVO.setContent(filter.doFilter(concertReplyVO.getContent()));
		
		if ( errors.hasErrors() ) {
			view.setViewName("concert/detail");
			view.addObject("updateConcertReplyVO", concertReplyVO);
			
			return view;
		}
		
		boolean isUpdateSuccess = this.concertReplyService.updateOneReply(concertReplyVO);
		
		return view;
	}
	
	
}
