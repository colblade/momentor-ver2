package org.kosta.momentor.aop.model;

import java.util.ArrayList;

public interface ReportService {
	//검색어 등록 및 count 증가
	public void updateKeyword(String keyword);
	//검색어 랭킹 목록 가져오기
	public ArrayList<ReportVO> getKeywordStats();
}
