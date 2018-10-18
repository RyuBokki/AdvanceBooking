package com.ktds.member.vo;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.springframework.stereotype.Repository;

import validator.MemberValidator;

public class MemberVO {
	
	@NotEmpty(message="이름은 필수 입력값입니다."
			  , groups= {MemberValidator.Regist.class
					  	, MemberValidator.Update.class})
	private String name;
	
	@NotEmpty(message="비밀번호는 필수 입력값입니다."
			  , groups= {MemberValidator.Regist.class
		  	  , MemberValidator.Login.class
		  	  , MemberValidator.Update.class})
	@Pattern(message="숫자 영대소문자 특수 문자를 포함한 8~20자를 입력하세요."
			 , groups= {MemberValidator.Regist.class
				  	  , MemberValidator.Login.class
				  	  , MemberValidator.Update.class}
			 , regexp="((?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()]).{8,20})")
	private String password;
	
	@NotEmpty(message="비밀번호 확인은 필수 입력값입니다."
			  , groups= {MemberValidator.Regist.class
					  , MemberValidator.Update.class})
	private String passwordConfirm;
	
	@NotEmpty(message="아이디(이메일)은 필수 입력값입니다."
			, groups= {MemberValidator.Regist.class
	  	    , MemberValidator.Login.class})
	@Email(message="이메일 형식으로 작성해주세요."
		   , groups= {MemberValidator.Regist.class
			  	    , MemberValidator.Login.class})
	private String email;
	
	private String salt;
	
	private int loginFailCount;
	
	private String latestLogin;
	
	private String authority;
	
	private String token;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public int getLoginFailCount() {
		return loginFailCount;
	}
	public void setLoginFailCount(int loginFailCount) {
		this.loginFailCount = loginFailCount;
	}
	public String getLatestLogin() {
		return latestLogin;
	}
	public void setLatestLogin(String latestLogin) {
		this.latestLogin = latestLogin;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPasswordConfirm() {
		return passwordConfirm;
	}
	public void setPasswordConfirm(String passwordConfirm) {
		this.passwordConfirm = passwordConfirm;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	
	
}
