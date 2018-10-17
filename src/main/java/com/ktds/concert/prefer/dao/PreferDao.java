package com.ktds.concert.prefer.dao;

import java.util.List;

import com.ktds.concert.prefer.vo.PreferSearchVO;
import com.ktds.concert.prefer.vo.PreferVO;

public interface PreferDao {

	public int insertOnePrefer(PreferVO preferVO);
	
	public int deleteOnePrefer(String preferId);
	
	public PreferVO isDuplicatedPrefer(String concertId);
	
	public List<PreferVO> selectAllPrefers(PreferSearchVO preferSearchVO);
	
	public int selectAllPrefersCount(PreferSearchVO preferSearchVO);
	
}
