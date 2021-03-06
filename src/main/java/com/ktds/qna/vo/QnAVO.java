package com.ktds.qna.vo;

import java.util.List;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import com.ktds.member.vo.MemberVO;
import com.ktds.qna.reply.vo.QnAReplyVO;

public class QnAVO {

	private String id;
	
	@NotEmpty(message="제목은 필수 입력값입니다.")
	private String subject;
	
	@NotEmpty(message="내용은 필수 입력값입니다.")
	private String content;
	
	private String email;
	
	private String crtDate;
	
	private String mdfDate;
	
	private String fileName;
	
	private String originFileName;
	
	private MemberVO memberVO;
	
	private String token;
	
	private MultipartFile file;
	
	private List<QnAReplyVO> replyList;
	
	private String isDelete;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
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

	public String getMdfDate() {
		return mdfDate;
	}

	public void setMdfDate(String mdfDate) {
		this.mdfDate = mdfDate;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOriginFileName() {
		return originFileName;
	}

	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<QnAReplyVO> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<QnAReplyVO> replyList) {
		this.replyList = replyList;
	}

	public String getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
	
	
}
