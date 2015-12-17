package org.kosta.momentor.aop.model;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class ReportServiceImpl implements ReportService {

	@Resource
	private ReportDAO reportDAO;
	
	
	
	@Override
	public void updateKeyword(String keyword) {
			
	int result = reportDAO.updateKeyword(keyword);

	if(result==0){
		reportDAO.registerKeyword(keyword);
	}
	}

	@Override
	public ArrayList<ReportVO> getKeywordStats() {
		return (ArrayList)reportDAO.getKeywordStats();
	}

}
