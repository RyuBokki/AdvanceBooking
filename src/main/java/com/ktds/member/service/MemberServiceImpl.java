package com.ktds.member.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.common.session.Session;
import com.ktds.member.dao.MemberDao;
import com.ktds.member.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public boolean registOneMember(MemberVO memberVO) {
		return this.memberDao.insertOneMember(memberVO) > 0;
	}

	@Override
	public MemberVO readOneMember(MemberVO memberVO) {
		return this.memberDao.selectOneMember(memberVO);
	}

	@Override
	public boolean isBlockUser(String email) {
		return this.memberDao.isBlockUser(email) > 4;
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
		return this.memberDao.isDuplicatedEmail(email) > 0;
	}

	@Override
	public boolean isSuccessLogin(MemberVO memberVO, HttpSession session) {
		
		MemberVO loginMemberVO = this.memberDao.selectOneMember(memberVO);
		
		if ( loginMemberVO != null ) {
			session.setAttribute(Session.USER, loginMemberVO);
		}
		
		return loginMemberVO != null;
	}

}
