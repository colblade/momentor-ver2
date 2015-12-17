package org.kosta.momentor.aop.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class ReportDAOImpl implements ReportDAO{

	@Resource
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public void registerKeyword(String keyword) {
	sqlSessionTemplate.insert("report.registerKeyword", keyword);
	}

	@Override
	public int updateKeyword(String keyword) {
	
		return sqlSessionTemplate.update("report.updateKeyword", keyword);	
	}

	@Override
	public List<ReportVO> getKeywordStats() {
		return sqlSessionTemplate.selectList("report.getKeywordStats");
	}

}
