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
	public int deleteOnePrefer(PreferVO preferVO) {
		return this.getSqlSession().delete("PreferDao.deleteOnePrefer", preferVO);
	}

	@Override
	public PreferVO isDuplicatedPrefer(PreferVO preferVO) {
		return this.getSqlSession().selectOne("PreferDao.isDuplicatedPrefer", preferVO);
	}

	@Override
	public List<PreferVO> selectAllPrefers(PreferSearchVO preferSearchVO) {
		return this.getSqlSession().selectList("PreferDao.selectAllPrefers", preferSearchVO);
	}

	@Override
	public int selectAllPrefersCount(PreferSearchVO preferSearchVO) {
		return this.getSqlSession().selectOne("PreferDao.selectAllPrefersCount", preferSearchVO);
	}

	@Override
	public int updateEmailSendedPrefer(String preferId) {
		return this.getSqlSession().update("PreferDao.updateEmailSendedPrefer", preferId);
	}

	@Override
	public List<PreferVO> selectAllPrefersForMessage() {
		return this.getSqlSession().selectList("PreferDao.selectAllPrefersForMessage");
	}

	
	
}
