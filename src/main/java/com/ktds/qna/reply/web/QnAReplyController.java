package com.ktds.qna.reply.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.ktds.common.session.Session;
import com.ktds.member.vo.MemberVO;
import com.ktds.qna.reply.service.QnAReplyService;
import com.ktds.qna.reply.vo.QnAReplyVO;
import com.nhncorp.lucy.security.xss.XssFilter;

@Controller
public class QnAReplyController {

	@Autowired
	private QnAReplyService qnaReplyService;
	
	@RequestMapping("/reply/write")
	public ModelAndView doCreateReplyAction(@ModelAttribute QnAReplyVO qnaReplyVO
											, @SessionAttribute(Session.USER) MemberVO memberVO
											, @SessionAttribute(Session.CSRF_TOKEN) String sessionToken
											, Errors errors) {
		
		ModelAndView view = new ModelAndView("redirect:/qna/detail/" + qnaReplyVO.getQnaId() + "?token=" + sessionToken);
		
		if ( errors.hasErrors() ) {
			view.setViewName("qna/detail");
			view.addObject("qnaReplyVO", qnaReplyVO);
		}
		
		qnaReplyVO.setEmail(memberVO.getEmail());
		
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
		qnaReplyVO.setContent(filter.doFilter(qnaReplyVO.getContent()));
		
		boolean isCreateReplySuccess = this.qnaReplyService.createOneReply(qnaReplyVO);
		
		return view;
	}
	
	@RequestMapping("/reply/delete/{replyId}")
	public String doDeleteReplyAction(@PathVariable String replyId
									   , @SessionAttribute(Session.CSRF_TOKEN) String sessionToken) {
		
		String qnaId = this.qnaReplyService.readOneReply(replyId).getQnaId();
		
		boolean isDeleteSuccess = this.qnaReplyService.deleteOneReply(replyId);
		
		return "redirect:/qna/detail/" + qnaId + "?token=" + sessionToken;
	}
	
	@RequestMapping("/reply/update/{replyId}")
	public ModelAndView doUpdateReplyAction(@PathVariable String replyId
									   , @ModelAttribute QnAReplyVO qnaReplyVO 
									   , Errors errors
									   , @SessionAttribute(Session.CSRF_TOKEN) String sessionToken) {
		
		String qnaId = this.qnaReplyService.readOneReply(replyId).getQnaId();

		ModelAndView view = new ModelAndView("redirect:/qna/detail/" + qnaId + "?token=" + sessionToken);
		
		boolean isDeleteSuccess = this.qnaReplyService.deleteOneReply(replyId);
		
		return view;
	}
	
	@RequestMapping("/reply/repl/{replyId}")
	public ModelAndView doReplAction(@PathVariable String replyId
											, @ModelAttribute QnAReplyVO qnaReplyVO
											, @SessionAttribute(Session.USER) MemberVO memberVO
											, @SessionAttribute(Session.CSRF_TOKEN) String sessionToken
											, Errors errors) {
		
		ModelAndView view = new ModelAndView("redirect:/qna/detail/" + qnaReplyVO.getQnaId() + "?token=" + sessionToken);
		
		if ( errors.hasErrors() ) {
			view.setViewName("qna/detail");
			view.addObject("qnaReplVO", qnaReplyVO);
		}
		
		qnaReplyVO.setEmail(memberVO.getEmail());
		
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
		qnaReplyVO.setContent(filter.doFilter(qnaReplyVO.getContent()));
		
		qnaReplyVO.setParentReplyId(replyId);
		
		boolean isCreateReplySuccess = this.qnaReplyService.createOneReply(qnaReplyVO);
		
		return view;
	}
	
}
