package com.ktds.member.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.common.util.SHA256Util;
import com.ktds.member.dao.MemberDao;
import com.ktds.member.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public boolean registOneMember(MemberVO memberVO) {
		
		String salt = SHA256Util.generateSalt();
		
		memberVO.setPassword(SHA256Util.getEncrypt(memberVO.getPassword(), salt));
		memberVO.setSalt(salt);
		
		return this.memberDao.insertOneMember(memberVO) > 0;
	}

	@Override
	public MemberVO readOneMember(MemberVO memberVO) {
		
		
		String password = memberVO.getPassword();
		String salt = this.memberDao.getSaltByEmail(memberVO.getEmail());
		
		memberVO.setPassword(SHA256Util.getEncrypt(memberVO.getPassword(), salt));
		
		MemberVO loginMemberVO = this.memberDao.selectOneMember(memberVO);
		
		if ( loginMemberVO == null ) {
			memberVO.setPassword(password);
		}
		
		return loginMemberVO;
	}

	@Override
	public boolean isBlockUser(String email) {
		return this.memberDao.isBlockUser(email);
	}

	@Override
	public boolean unBlockUser(String email) {
		return this.memberDao.unBlockUser(email) > 0;
	}

	@Override
	public boolean increaseLoginFailCount(String email) {
		return this.memberDao.increaseLoginFailCount(email) > 0;
	}

	@Override
	public boolean isDuplicatedEmail(String email) {
		return this.memberDao.isDuplicatedEmail(email);
	}

	@Override
	public boolean updateOneMember(MemberVO memberVO) {
		
		String password = memberVO.getPassword();
		
		String salt = SHA256Util.generateSalt();
		
		memberVO.setPassword(SHA256Util.getEncrypt(memberVO.getPassword(), salt));
		memberVO.setSalt(salt);
		
		System.out.println(salt);
		
		boolean isUpdateSuccess = this.memberDao.updateOneMember(memberVO) > 0;
		
		if (!isUpdateSuccess) {
			memberVO.setPassword(password);
		}
		
		return isUpdateSuccess;
	}


	@Override
	public void sendEmail(MemberVO memberVO) throws Exception {
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "bookki@naver.com";
		String hostSMTPpwd = "dbqhrrl!!";
	
		String fromEmail = "bookki@naver.com";
		String fromName = "Concert Advance Booking";
		String subject = "";
		String msg = "";
		
		subject = "Spring Homepage 임시 비밀번호 입니다.";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>";
		msg += memberVO.getName() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
		msg += "<p>임시 비밀번호 : ";
		msg += memberVO.getPassword() + "</p></div>";
		
		
		String mail = memberVO.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSLOnConnect(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587);

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setStartTLSEnabled(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}

	@Override
	public boolean findMemberPassword(HttpServletResponse response, MemberVO memberVO) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 아이디가 없으면
		if( !this.memberDao.isDuplicatedEmail(memberVO.getEmail()) ) {
			out.print("<script>alert('잘못된 이메일 입니다.'); location.href='/AdvanceBooking/member/findPassword';</script>");
			out.close();
			
			return false;
		}
		else {
			
			MemberVO selectMember = this.memberDao.selectOneMemberByEmail(memberVO.getEmail());
			
			// 임시 비밀번호 생성
			String newPassword = makeRandomPassword();
			// 비밀번호 변경
			
			String passwordPolicy = "((?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()]).{8,})";
		      
		    Pattern pattern = Pattern.compile(passwordPolicy);
		    Matcher matcher = pattern.matcher(newPassword);
		      
		    boolean isMatcher = matcher.matches();
			
		    if ( isMatcher ) {
		    	
		    	selectMember.setPassword(newPassword);
		    	
		    	sendEmail(selectMember);
		    					
				Map<String, Object> params = new HashMap<String, Object>();
				
				String salt = SHA256Util.generateSalt();
								
				selectMember.setPassword(SHA256Util.getEncrypt(newPassword, salt));
				selectMember.setSalt(salt);
				
				params.put("email", selectMember.getEmail());
				
				params.put("password", selectMember.getPassword());	
				
				params.put("salt", selectMember.getSalt());

				this.memberDao.updateMemberPassword(params);		    	
		    	
		    	out.print("<script>alert('이메일로 임시 비밀번호를 발송하였습니다.'); location.href='/AdvanceBooking/member/login';</script>");
		    	out.close();		    	
		    }
		    else {
		    	findMemberPassword(response, memberVO);
		    	out.close();		    	
		    }
		    return true;
		}
	}

	@Override
	public String makeRandomPassword() {
		char passwordArray[] = new char[] { 
                '1','2','3','4','5','6','7','8','9','0', 
                'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z', 
                'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z', 
                '!','@','#','$','%','^','&','*','(',')'};//배열에 선언 

		String randomPassword = ""; 

		for (int i = 0; i < 11; i++) { 
			int selectRandomPw = (int)(Math.random()*(passwordArray.length));//Math.rondom()은 0.0이상 1.0미만의 난수를 생성해 준다. 
			randomPassword += passwordArray[selectRandomPw]; 
		} 
		return randomPassword; 
	} 

}
