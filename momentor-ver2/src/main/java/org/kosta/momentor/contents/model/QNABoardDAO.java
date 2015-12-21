package org.kosta.momentor.contents.model;

import java.util.List;

public interface QNABoardDAO {
	public abstract QNABoardVO writeQNA(QNABoardVO qvo);		//QNA 글 쓰기
	public abstract void deleteQNA(int qboardNo);					//QNA 글 삭제
	public abstract void updateQNA(QNABoardVO qvo);				//QNA 글 수정
	public abstract void qnaUpdateHits(int boardNo);					//QNA 글 조회수
	public abstract List<BoardVO> getAllQNAList(String pageNo);	//QNA 글 리스트
	public abstract QNABoardVO getQNAByNo(int boardNo);		//QNA 글 상세 보기
	public abstract int totalQNAContent();							//QNA 글 수
	public abstract void updateRestep(int ref, int restep);			//QNA 답글 단계
	public abstract void insertRefContent(QNABoardVO qvo);		//QNA 답글
}