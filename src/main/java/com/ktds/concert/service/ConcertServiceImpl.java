package com.ktds.concert.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.concert.dao.ConcertDao;
import com.ktds.concert.vo.ConcertVO;

@Service
public class ConcertServiceImpl implements ConcertService {

	@Autowired
	private ConcertDao concertDao;
	
	@Override
	public boolean createOneConcert(ConcertVO concertVO) {
		return this.concertDao.insertOneConcert(concertVO) > 0;
	}

}
