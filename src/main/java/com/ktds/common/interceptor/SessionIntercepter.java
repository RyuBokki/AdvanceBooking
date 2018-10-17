package com.ktds.common.interceptor;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ktds.common.session.Session;
import com.ktds.member.vo.MemberVO;

public class SessionIntercepter extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute(Session.USER);
		
		if ( memberVO == null ) {
			response.sendRedirect("/AdvanceBooking/main?message="+URLEncoder.encode("로그인이 필요합니다", "UTF-8"));
			return false;
		}
		
		return true;
	}
	
}
