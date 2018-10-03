package com.ktds.member.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ktds.common.session.Session;
import com.ktds.member.service.MemberService;
import com.ktds.member.vo.MemberVO;

import validator.MemberValidator;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/member/regist")
	public String viewMemberRegistPage() {
		return "member/regist";
	}
	
	@PostMapping("/member/check/duplicate")
	@ResponseBody
	public Map<String, Object> doCheckDuplicateEmail(@RequestParam String email){
		Map<String, Object> result = new HashMap<>();
		
		result.put("status", "OK");
		result.put("duplicated", this.memberService.isDuplicatedEmail(email));
		
		return result;
	}
	
	@PostMapping("/member/regist")
	public ModelAndView doMemberRegistAction( @Validated({MemberValidator.Regist.class})@ModelAttribute MemberVO memberVO
											   , Errors errors) {
	
		ModelAndView view = new ModelAndView("redirect:/member/login");
		
		if ( errors.hasErrors() ) {
			view.setViewName("member/regist");
			view.addObject("memberVO", memberVO);
			
			return view;
		}
		
		boolean isSuccess = this.memberService.registOneMember(memberVO);
		
		return view;
	}
	
	@GetMapping("/member/login")
	public String viewMemberLoginPage() {
		return "member/login";
	}
	
	@PostMapping("/member/login")
	public ModelAndView doMemberLoginAction( @Validated({MemberValidator.Login.class})@ModelAttribute MemberVO memberVO
											  , Errors errors
											  , HttpSession session) {
		
		ModelAndView view = new ModelAndView("redirect:/concert/list");
		
		
		if ( errors.hasErrors() ) {
			view.setViewName("member/login");
			view.addObject("memberVO", memberVO);
				
			return view;
		}

		boolean isBlockAccount = this.memberService.isBlockUser(memberVO.getEmail());
		
		if ( !isBlockAccount ) {
			MemberVO loginMember = this.memberService.readOneMember(memberVO);
			
			if ( loginMember != null ) {				
				
				session.setAttribute(Session.USER, loginMember);
				this.memberService.unBlockUser(loginMember.getEmail());
				
			}
			else {
				this.memberService.increaseLoginFailCount(memberVO.getEmail());
				
				view.setViewName("member/login");
				view.addObject("memberVO", memberVO);
				
				return view;
			}
		}
		else {
									
			view.setViewName("member/login");
			view.addObject("memberVO", memberVO);
			
			return view;
		}		
		
		return view;
	}
	
	@GetMapping("/member/logout")
	public String doMemberLogoutAction(HttpSession session) {
		session.invalidate();
		return "redirect:/member/login";
	}
	
	//회원정보 수정
	@GetMapping("/member/update")
	public String viewMemberUpdatePage() {
		return "member/update";
	}
	
	@PostMapping("/member/update")
	public ModelAndView doMemberUpdateAction(@Validated({MemberValidator.Update.class}) @ModelAttribute MemberVO memberVO
											  , Errors errors) {
		
		ModelAndView view = new ModelAndView("redirect:/member/myPage");
				
		if ( errors.hasErrors() ) {
			view.setViewName("member/update");
			view.addObject("memberVO", memberVO);
			
			return view;
		}
		
		boolean isUpdateSuccess = this.memberService.updateOneMember(memberVO);
		
		return view;
	}
	
	@GetMapping("/member/findPassword")
	public String viewFindPasswordPage() {	
		return "member/findPassword";
	}
	
	@PostMapping("/member/findPassword")
	public ModelAndView doFindMemberPassword(@Validated({MemberValidator.FindEmail.class})	@ModelAttribute MemberVO memberVO
											  , Errors errors
											  , HttpServletResponse response) throws Exception {
		
		ModelAndView view = new ModelAndView("redirect:/member/login");
		
		if ( errors.hasErrors() ) {
			view.setViewName("member/findPassword");
			view.addObject("memberVO", memberVO);
			
			return view;
		}
		
		boolean isFindEmailSuccess = this.memberService.findMemberPassword(response, memberVO);
		
		if ( !isFindEmailSuccess ) {
			view.setViewName("member/findPassword");
			view.addObject("memberVO", memberVO);
			
			return view;
		}
		
		return view;
	}
	
	@GetMapping("/concert/list")
	public String viewBoardIndexPage() {
		return "concert/list";
	}
	
	@GetMapping("/member/myPage")
	public String viewMyPage() {
		return "member/myPage";
	}
}
