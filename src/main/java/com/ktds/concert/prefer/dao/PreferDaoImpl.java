package com.ktds.concert.prefer.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.concert.prefer.vo.PreferVO;

@Repository
public class PreferDaoImpl extends SqlSessionDaoSupport implements PreferDao {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int insertOnePrefer(PreferVO preferVO) {
		return this.getSqlSession().insert("PreferDao.insertOnePrefer", preferVO);
	}

	
	
}
