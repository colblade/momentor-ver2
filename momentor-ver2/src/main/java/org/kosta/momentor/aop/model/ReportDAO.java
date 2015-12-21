package org.kosta.momentor.aop.model;

import java.util.List;


public interface ReportDAO {
//검색어 등록
public void registerKeyword(String keyword);
//검색이 되었을 때 해당 검색어 count 증가
public int updateKeyword(String keyword);
//검색어 랭킹목록 받아오기
public List<ReportVO> getKeywordStats();

}
