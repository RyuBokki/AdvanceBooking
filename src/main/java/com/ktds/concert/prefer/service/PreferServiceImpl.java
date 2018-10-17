package com.ktds.concert.prefer.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktds.concert.prefer.dao.PreferDao;
import com.ktds.concert.prefer.vo.PreferVO;

@Service
public class PreferServiceImpl implements PreferService {

	@Autowired
	private PreferDao preferDao;
	
	@Override
	public boolean registOnePrefer(PreferVO preferVO) {
		return this.preferDao.insertOnePrefer(preferVO) > 0;
	}

}
