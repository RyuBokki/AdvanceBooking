package com.ktds.concert.prefer.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.concert.prefer.vo.PreferSearchVO;
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

	@Override
	public int deleteOnePrefer(String preferId) {
		return this.getSqlSession().delete("PreferDao.deleteOnePrefer", preferId);
	}

	@Override
	public PreferVO isDuplicatedPrefer(String concertId) {
		return this.getSqlSession().selectOne("PreferDao.isDuplicatedPrefer", concertId);
	}

	@Override
	public List<PreferVO> selectAllPrefers(PreferSearchVO preferSearchVO) {
		return this.getSqlSession().selectList("PreferDao.selectAllPrefers", preferSearchVO);
	}

	@Override
	public int selectAllPrefersCount(PreferSearchVO preferSearchVO) {
		return this.getSqlSession().selectOne("PreferDao.selectAllPrefersCount", preferSearchVO);
	}

	
	
}
