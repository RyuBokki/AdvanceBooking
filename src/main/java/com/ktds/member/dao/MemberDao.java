package com.ktds.member.dao;

import java.util.List;
import java.util.Map;

import com.ktds.member.vo.MemberVO;

public interface MemberDao {
	
	public int insertOneMember(MemberVO memberVO);
	
	public MemberVO selectOneMember(MemberVO memberVO);

	public MemberVO selectOneMemberByEmail(String email);
	
	public List<MemberVO> selectAllMembers();
	
	public int updateOneMember(MemberVO memberVO);
	
	public boolean isBlockUser(String email);
	
	public int unBlockUser(String email);
	
	public int increaseLoginFailCount(String email);
	
	public boolean isDuplicatedEmail(String email);
	
	public String getSaltByEmail(String email);
	
	public int updateMemberPassword(Map<String, Object> params);
	
}
