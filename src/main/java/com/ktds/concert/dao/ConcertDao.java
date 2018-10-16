package com.ktds.concert.dao;

import java.util.List;

import com.ktds.concert.vo.ConcertSearchVO;
import com.ktds.concert.vo.ConcertVO;

public interface ConcertDao {
	
	public ConcertVO selectOneConcert(String concertId);
	
	public int selectAllConcertsCount(ConcertSearchVO concertSearchVO);
	
	public List<ConcertVO> selectAllConcerts(ConcertSearchVO concertSearchVO);
}
