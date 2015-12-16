package org.kosta.momentor.contents.model;

import java.util.List;

public interface QNABoardDAO {

	public abstract QNABoardVO writeQNA(QNABoardVO qvo);
	public abstract void deleteQNA(int qboardNo);
	public abstract void updateQNA(QNABoardVO qvo);
	public abstract void qnaUpdateHits(int boardNo);
	public abstract List<BoardVO> getAllQNAList(String pageNo);
	public abstract QNABoardVO getQNAByNo(int boardNo);
	public abstract int totalQNAContent();
	public abstract void updateRestep(int ref, int restep);
	public abstract void insertRefContent(QNABoardVO qvo);
}