package org.kosta.momentor.aop.model;

public class ReportVO {
	private String keyword;
	private int count;
	private int ranking;
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getRanking() {
		return ranking;
	}
	public void setRanking(int ranking) {
		this.ranking = ranking;
	}
	public ReportVO(String keyword, int count, int ranking) {
		super();
		this.keyword = keyword;
		this.count = count;
		this.ranking = ranking;
	}
	public ReportVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "ReportVO [keyword=" + keyword + ", count=" + count
				+ ", ranking=" + ranking + "]";
	}
	
	
}
