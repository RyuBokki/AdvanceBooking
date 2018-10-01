package com.ktds.member.dao;

import java.util.List;

import com.ktds.member.vo.MemberVO;

public interface MemberDao {
	
	public int insertOneMember(MemberVO memberVO);
	
	public MemberVO selectOneMember(MemberVO memberVO);
	
	public List<MemberVO> selectAllMembers();
	
	public int updateOneMember(String email);
	
	public int isBlockUser(String email);
	
	public int unBlockUser(String email);
	
	public int increaseLoginFailCount(String email);
	
	public int isDuplicatedEmail(String email);
	
}
