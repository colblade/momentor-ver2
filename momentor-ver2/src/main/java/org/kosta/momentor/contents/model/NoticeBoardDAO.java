package org.kosta.momentor.contents.model;

import java.util.List;

public interface NoticeBoardDAO {
	public NoticeBoardVO postingNotice(NoticeBoardVO nvo);//글작성
	public void deleteNoticeByNo(int noticeNo);//글 삭제
	public void updateNotice(NoticeBoardVO nvo);//글 수정
	public List<BoardVO> getAllNoticeList(String pageNo); //전체목록
	public NoticeBoardVO getNoticeByNo(int boardNo);//공지사항글 상세보기
	public int totalNotice();//공지사항 글 수
}