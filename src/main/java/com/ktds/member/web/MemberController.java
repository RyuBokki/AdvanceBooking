package com.ktds.member.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.ktds.common.session.Session;
import com.ktds.member.service.MemberService;
import com.ktds.member.vo.MemberVO;
import com.ktds.member.vo.User;
import com.nhncorp.lucy.security.xss.XssFilter;

import validator.MemberValidator;

@Controller
public class MemberController {
	
	private int i = 1;
	
	@Autowired
	private MemberService memberService;
	
	@PostMapping("/member/check/duplicate")
	@ResponseBody
	public Map<String, Object> doCheckDuplicateEmail(@RequestParam String email){
		Map<String, Object> result = new HashMap<>();
		
		result.put("status", "OK");
		result.put("duplicated", this.memberService.isDuplicatedEmail(email));
		
		return result;
	}
	
	@PostMapping("/member/regist")
	@ResponseBody
	public Map<String, Object> doMemberRegistAction( @Validated({MemberValidator.Regist.class})@ModelAttribute MemberVO memberVO
													  , Errors errors) {
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		System.out.println(memberVO.getEmail());
		
		if ( errors.hasErrors() ) {
			result.put("registMemberVO", memberVO);
			
			List<FieldError> errorList = new ArrayList<>();
			for (FieldError error : errors.getFieldErrors()) {
				errorList.add(error);
				System.out.println(error);
			}
			
			
			
			System.out.println("에러발생" + this.i);
			
			i++;
			
			result.put("validated", errorList.size() == 0);
			
			return result;
		}
		else {
			
			XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
			
			memberVO.setEmail(filter.doFilter(memberVO.getEmail()));
			memberVO.setPassword(filter.doFilter(memberVO.getPassword()));
			memberVO.setName(filter.doFilter(memberVO.getName()));
			
			
			boolean isSuccess = this.memberService.registOneMember(memberVO);
			
			result.put("success", isSuccess);
			
			return result;
		}
	}
	
	@GetMapping("/member/loginSuccess")
	public ModelAndView doMemberLoginAction( MemberVO memberVO
											  , HttpSession session) {
		
		ModelAndView view = new ModelAndView("redirect:/concert/list");
		
		User user = ( User ) SecurityContextHolder.getContext()
				  .getAuthentication()
				  .getDetails();


		memberVO.setEmail(user.getUsername());
		memberVO.setPassword(user.getPassword());
		
		MemberVO loginMemberVO = this.memberService.readOneMember(memberVO);
		
		if ( loginMemberVO != null ) {
			
			session.setAttribute(Session.CSRF_TOKEN, user.getToken());
			session.setAttribute(Session.USER, loginMemberVO);
			
			view.addObject("message", "로그인 성공");
		}
		else {
									
			view.setViewName("common/main");
			view.addObject("loginMemberVO", memberVO);
						
			return view;
		}		
		
		return view;
	}
	
	@RequestMapping("/member/loginFail")
	public ModelAndView doMemberLoginFailAction(@ModelAttribute MemberVO memberVO) {
		
		ModelAndView view = new ModelAndView("common/main");
				
		boolean isBlockAccount = this.memberService.isBlockUser(memberVO.getEmail());
		
		boolean isLoginFail = this.memberService.readOneMember(memberVO) == null;
		
		view.addObject("isBlockAccount", isBlockAccount);
		
		view.addObject("isLoginFail", isLoginFail);
				
		view.addObject("loginMemberVO", memberVO);
								
		
		return view;
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
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
		memberVO.setPassword(filter.doFilter(memberVO.getPassword()));
		memberVO.setName(filter.doFilter(memberVO.getName()));
		
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
		
		ModelAndView view = new ModelAndView("redirect:/main");
		
		if ( errors.hasErrors() ) {
			view.setViewName("member/findPassword");
			view.addObject("memberVO", memberVO);
			return view;
		}
		
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
		
		memberVO.setEmail(filter.doFilter(memberVO.getEmail()));
		
		boolean isFindEmailSuccess = this.memberService.findMemberPassword(response, memberVO);
		
		if ( !isFindEmailSuccess ) {
			view.setViewName("member/findPassword");
			view.addObject("memberVO", memberVO);
			return view;
		}
		
		return view;
	}
	
	@GetMapping("/member/myPage")
	public String viewMyPage() {
		return "member/myPage";
	}
	
	@GetMapping("/main")
	public String viewMainPage() {
		return "common/main";
	}
	
}
