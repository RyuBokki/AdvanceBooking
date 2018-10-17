package com.ktds.concert.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.concert.vo.ConcertSearchVO;
import com.ktds.concert.vo.ConcertVO;

@Repository
public class ConcertDaoImpl extends SqlSessionDaoSupport implements ConcertDao {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public ConcertVO selectOneConcert(String concertId) {
		return this.getSqlSession().selectOne("ConcertDao.selectOneConcert", concertId);
	}

	@Override
	public List<ConcertVO> selectAllConcerts(ConcertSearchVO concertSearchVO) {
		return this.getSqlSession().selectList("ConcertDao.selectAllConcerts",concertSearchVO);
	}

	@Override
	public int selectAllConcertsCount(ConcertSearchVO concertSearchVO) {
		return this.getSqlSession().selectOne("ConcertDao.selectAllConcertsCount", concertSearchVO);
	}

	@Override
	public int deleteOneConcert(String concertId) {
		return this.getSqlSession().delete("ConcertDao.deleteOneConcert", concertId);
	}

}
