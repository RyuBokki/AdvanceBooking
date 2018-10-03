package com.ktds.member.service;

import javax.servlet.http.HttpServletResponse;

import com.ktds.member.vo.MemberVO;

public interface MemberService {

	public boolean registOneMember(MemberVO memberVO);
	
	public MemberVO readOneMember(MemberVO memberVO);
	
	public boolean isBlockUser(String email);
	
	public boolean unBlockUser(String email);
	
	public boolean increaseLoginFailCount(String email);
	
	public boolean isDuplicatedEmail(String email);
	
	public boolean updateOneMember(MemberVO memberVO);
		
	public void sendEmail(MemberVO memerVO) throws Exception;
	
	public boolean findMemberPassword(HttpServletResponse response, MemberVO memberVO) throws Exception;
	
	public String makeRandomPassword();
}
