package com.ktds.member.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.common.session.Session;
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


}
