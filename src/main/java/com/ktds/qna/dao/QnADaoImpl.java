package com.ktds.qna.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktds.qna.vo.QnAVO;

@Repository
public class QnADaoImpl extends SqlSessionDaoSupport 
						 implements QnADao {
	
	private Logger logger = LoggerFactory.getLogger(QnADaoImpl.class);
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		logger.debug("Initiate MyBatis");
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int insertOneQnA(QnAVO qnaVO) {
		return this.getSqlSession().insert("QnADao.insertOneQnA", qnaVO);
	}

	@Override
	public QnAVO selectOneQnA(String id) {
		return this.getSqlSession().selectOne("QnADao.selectOneQnA", id);
	}

	@Override
	public List<QnAVO> selectAllQnAs() {
		return this.getSqlSession().selectList("QnADao.selectAllQnAs");
	}

	@Override
	public int updateOneQnA(String id) {
		return this.getSqlSession().update("QnADao.updateOneQnA", id);
	}

	@Override
	public int deleteOneQnA(String id) {
		return this.getSqlSession().delete("QnADao.deleteOneQnA", id);
	}

}
