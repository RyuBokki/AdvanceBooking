package com.ktds.concert.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.concert.vo.ConcertVO;

@Repository
public class ConcertDaoImpl extends SqlSessionDaoSupport implements ConcertDao {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public ConcertVO insertOneConcert(ConcertVO concertVO) {
		return this.getSqlSession().insert("", parameter);
	}

}
