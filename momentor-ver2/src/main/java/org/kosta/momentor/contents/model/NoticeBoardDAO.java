package org.kosta.momentor.contents.model;

import java.util.List;

public interface NoticeBoardDAO {
	public NoticeBoardVO postingNotice(NoticeBoardVO nvo);//글작성
	public void deleteNoticeByNo(int noticeNo);//글 삭제
	public void updateNotice(NoticeBoardVO nvo);//글 수정
	public List<BoardVO> getAllNoticeList(String pageNo); //전체목록
	public NoticeBoardVO getNoticeByNo(int boardNo);//공지사항글 상세보기
	public int totalNotice();
	public List<BoardVO> getAllFAQList(String pageNo);//FAQ 전체 리스트 출력
	public int totalFAQContent();//FAQ 전체 글 갯수
	public FAQBoardVO getFAQByNo(int boardNo);//글 번호로 FAQ 상세보기 
	public int postingFAQ(FAQBoardVO nvo);//FAQ 글 작성
	public void deleteFAQByNo(int boardNo);//FAQ 글 삭제
	public void updateFAQ(FAQBoardVO nvo);//FAQ 글 수정
}