package org.kosta.momentor.aop.model;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class ReportServiceImpl implements ReportService {

	@Resource
	private ReportDAO reportDAO;
	
	//검색어 등록 및 검색횟수 증가.
	@Override
	public void updateKeyword(String keyword) {
			
	int result = reportDAO.updateKeyword(keyword);

	if(result==0){
		reportDAO.registerKeyword(keyword);
	}
	}

	//검색어 랭킹목록 가져오기
	@Override
	public ArrayList<ReportVO> getKeywordStats() {
		return (ArrayList)reportDAO.getKeywordStats();
	}

}
