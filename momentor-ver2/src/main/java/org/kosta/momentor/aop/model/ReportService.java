package org.kosta.momentor.aop.model;

import java.util.ArrayList;

public interface ReportService {
	public void updateKeyword(String keyword);
	public ArrayList<ReportVO> getKeywordStats();
}
