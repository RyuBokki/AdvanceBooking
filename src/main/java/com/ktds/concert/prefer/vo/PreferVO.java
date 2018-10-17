package com.ktds.concert.prefer.vo;

import com.ktds.concert.vo.ConcertVO;
import com.ktds.member.vo.MemberVO;

public class PreferVO {
	
	private String preferId;
	
	private String email;
	
	private String concertId;
	
	private String token;
	
	private ConcertVO concertVO;
	
	private MemberVO memberVO; 
	
	public String getPreferId() {
		return preferId;
	}

	public void setPreferId(String preferId) {
		this.preferId = preferId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getConcertId() {
		return concertId;
	}

	public void setConcertId(String concertId) {
		this.concertId = concertId;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public ConcertVO getConcertVO() {
		return concertVO;
	}

	public void setConcertVO(ConcertVO concertVO) {
		this.concertVO = concertVO;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

}
