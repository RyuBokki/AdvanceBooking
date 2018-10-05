package com.ktds.member.service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.ktds.member.vo.MemberVO;
import com.ktds.member.vo.User;
import com.nhncorp.lucy.security.xss.XssFilter;

public class UserService implements AuthenticationProvider {
	
	@Autowired
	private MemberService memberService;
	
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		String userEmail = authentication.getPrincipal().toString();
		String userPassword = authentication.getCredentials().toString();
		
		
		MemberVO memberVO = new MemberVO();

		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
		
		memberVO.setEmail(filter.doFilter(userEmail));
		
		memberVO.setPassword(filter.doFilter(userPassword));
		
		
		boolean isBlockAccount = this.memberService.isBlockUser(memberVO.getEmail());
		
		MemberVO loginMember = null;
		
		if ( !isBlockAccount ) {
				System.out.println("패스워드" + memberVO.getPassword());
				loginMember = this.memberService.readOneMember(memberVO);
				System.out.println(loginMember);
			if ( loginMember == null ) {
				memberService.increaseLoginFailCount(memberVO.getEmail());
			}
			else {
				memberService.unBlockUser(memberVO.getEmail());
			}
			
		}

		UsernamePasswordAuthenticationToken result = null;
		
		if ( loginMember != null ) {
			String token = UUID.randomUUID().toString();
			String grade = "ROLE_USER";
			
			System.out.println(loginMember.getEmail());
			
			boolean isAdmin = this.memberService.selectOneMemberByEmail(loginMember.getEmail())
												 .getAuthority().equals("ADMIN");
			
			System.out.println(isAdmin);
			
			if ( isAdmin ) {
				grade = "ROLE_ADMIN";
			}
			
			List<GrantedAuthority> roles = new ArrayList<>();
			roles.add( new SimpleGrantedAuthority(grade) );
			
			if ( grade.equals("ROLE_ADMIN") ) {
				roles.add( new SimpleGrantedAuthority("ROLE_USER") );
			}
			
			result = new UsernamePasswordAuthenticationToken(userEmail, loginMember.getPassword(), roles);
			
			User user = new User(userEmail, userPassword, grade, isBlockAccount, token);
			
			System.out.println(user.toString());
			
			
			result.setDetails(user);
		}
		else {
			throw new BadCredentialsException("잘못된 인증");
		}
		
		return result;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
