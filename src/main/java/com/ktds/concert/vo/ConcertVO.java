package com.ktds.concert.vo;

import java.util.List;

import com.ktds.concert.reply.vo.ConcertReplyVO;

public class ConcertVO {
	
	private String subject;
	
	private String contents;
	
	private String concertId;
	
	private String advanceBookingUrl;
	
	private String advanceBookingDay;

	private String token;
	
	private List<ConcertReplyVO> replyList;
	
	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getConcertId() {
		return concertId;
	}

	public void setConcertId(String concertId) {
		this.concertId = concertId;
	}

	public String getAdvanceBookingUrl() {
		return advanceBookingUrl;
	}

	public void setAdvanceBookingUrl(String advanceBookingUrl) {
		this.advanceBookingUrl = advanceBookingUrl;
	}

	public String getAdvanceBookingDay() {
		return advanceBookingDay;
	}

	public void setAdvanceBookingDay(String advanceBookingDay) {
		this.advanceBookingDay = advanceBookingDay;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public List<ConcertReplyVO> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<ConcertReplyVO> replyList) {
		this.replyList = replyList;
	}
	
}
