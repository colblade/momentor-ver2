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
	//검색어 등록
	public void registerKeyword(String keyword) {
	sqlSessionTemplate.insert("report.registerKeyword", keyword);
	}

	@Override
	//검색어 count 증가
	public int updateKeyword(String keyword) {
	
		return sqlSessionTemplate.update("report.updateKeyword", keyword);	
	}

	@Override
	//검색어 랭킹 목록 가져오기
	public List<ReportVO> getKeywordStats() {
		return sqlSessionTemplate.selectList("report.getKeywordStats");
	}

}
