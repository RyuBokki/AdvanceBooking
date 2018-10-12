package com.ktds.qna.reply.vo;

import javax.validation.constraints.NotEmpty;

import com.ktds.member.vo.MemberVO;
import com.ktds.qna.vo.QnAVO;

public class QnAReplyVO {
		
	private String replyId;
	
	private String qnaId;
	
	private String email;
	
	@NotEmpty(message="댓글 내용은 필수 입력값입니다.")
	private String content;
	
	private String crtDate;
		
	private QnAVO qnaVO;
	
	private MemberVO memberVO;
		
	public String getReplyId() {
		return replyId;
	}
	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}
	public String getQnaId() {
		return qnaId;
	}
	public void setQnaId(String qnaId) {
		this.qnaId = qnaId;
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
	public QnAVO getQnaVO() {
		return qnaVO;
	}
	public void setQnaVO(QnAVO qnaVO) {
		this.qnaVO = qnaVO;
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
}
