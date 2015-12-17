package org.kosta.momentor.aop.model;

import java.util.List;


public interface ReportDAO {
public void registerKeyword(String keyword);
public int updateKeyword(String keyword);
public List<ReportVO> getKeywordStats();

}
