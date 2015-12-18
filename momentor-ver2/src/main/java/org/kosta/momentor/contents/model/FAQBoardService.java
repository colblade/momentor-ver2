package org.kosta.momentor.contents.model;

public interface FAQBoardService {
	public ListVO getAllFAQList(String pageNo);//FAQ 전체 리스트 출력
	public FAQBoardVO getFAQByNo(int boardNo);//글 번호로 FAQ 상세보기
	public int postingFAQ(FAQBoardVO nvo);//FAQ 글 작성
	public void deleteFAQByNo(int boardNo);//FAQ 글 삭제
	public void updateFAQ(FAQBoardVO fvo);//FAQ 글 수정
}
