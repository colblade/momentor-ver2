package org.kosta.momentor.contents.model;

public interface QNABoardService {

	public abstract QNABoardVO writeQNA(QNABoardVO qvo);
	public abstract void deleteQNA(int qboardNo);
	public abstract void updateQNA(QNABoardVO qvo);
	public abstract ListVO getAllQNAList(String pageNo);
	public abstract QNABoardVO getQNAByNo(int boardNo);
	public abstract QNABoardVO getQNAByNoNoHit(int boardNo);
	public abstract void qnaReply(QNABoardVO qvo);
}