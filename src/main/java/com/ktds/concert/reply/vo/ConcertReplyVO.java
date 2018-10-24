package com.ktds.concert.reply.vo;

import javax.validation.constraints.NotEmpty;

import com.ktds.concert.vo.ConcertVO;
import com.ktds.member.vo.MemberVO;

public class ConcertReplyVO {

	private String replyId;
	
	private String concertId;
	
	private String email;
	
	@NotEmpty(message="댓글 내용은 필수 입력값입니다.")
	private String content;
	
	private String crtDate;
		
	private ConcertVO concertVO;
	
	private MemberVO memberVO;
	
	private String token;
	
	private String isDelete;
	
	private String parentReplyId;
	
	private int level;
	
	private boolean isChildReplyExist;
		
	public String getReplyId() {
		return replyId;
	}
	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}
	public String getConcertId() {
		return concertId;
	}
	public void setConcertId(String concertId) {
		this.concertId = concertId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCrtDate() {
		return crtDate;
	}
	public void setCrtDate(String crtDate) {
		this.crtDate = crtDate;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
	public String getParentReplyId() {
		return parentReplyId;
	}
	public void setParentReplyId(String parentReplyId) {
		this.parentReplyId = parentReplyId;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public boolean isChildReplyExist() {
		return isChildReplyExist;
	}
	public void setChildReplyExist(boolean isChildReplyExist) {
		this.isChildReplyExist = isChildReplyExist;
	}
	
}
