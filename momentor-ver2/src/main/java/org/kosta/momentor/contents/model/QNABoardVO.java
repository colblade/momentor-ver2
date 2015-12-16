package org.kosta.momentor.contents.model;

import org.kosta.momentor.member.model.MomentorMemberVO;

public class QNABoardVO extends BoardVO{
	private int qnaHits;
	private int ref;// 원 게시물 번호 , 글묶음 
	private int restep;// ref 글묶음내의 글순서 
	private int relevel;// 답변의 단계 
	public QNABoardVO() {
		super();
	}

	public QNABoardVO(int boardNo, MomentorMemberVO momentorMemberVO,
			String boardTitle, String boardWdate, String boardContent,
			int ranking, int qnaHits, int ref, int restep, int relevel) {
		super(boardNo, momentorMemberVO, boardTitle, boardWdate, boardContent,
				ranking);
		this.qnaHits = qnaHits;
		this.ref = ref;
		this.restep = restep;
		this.relevel = relevel;
	}

	public int getQnaHits() {
		return qnaHits;
	}

	public void setQnaHits(int qnaHits) {
		this.qnaHits = qnaHits;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRestep() {
		return restep;
	}

	public void setRestep(int restep) {
		this.restep = restep;
	}

	public int getRelevel() {
		return relevel;
	}

	public void setRelevel(int relevel) {
		this.relevel = relevel;
	}

	@Override
	public String toString() {
		return "QNABoardVO [qnaHits=" + qnaHits + ", ref=" + ref + ", restep="
				+ restep + ", relevel=" + relevel + ", getBoardNo()="
				+ getBoardNo() + ", getMomentorMemberVO()="
				+ getMomentorMemberVO() + ", getBoardTitle()="
				+ getBoardTitle() + ", getBoardWdate()=" + getBoardWdate()
				+ ", getBoardContent()=" + getBoardContent()
				+ ", getRanking()=" + getRanking() + ", toString()="
				+ "]";
	}


	
	
}
