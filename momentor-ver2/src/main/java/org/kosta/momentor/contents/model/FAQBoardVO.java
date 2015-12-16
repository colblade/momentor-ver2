package org.kosta.momentor.contents.model;

import org.kosta.momentor.member.model.MomentorMemberVO;

public class FAQBoardVO extends BoardVO {

	public FAQBoardVO() {
		super();
	}
	public FAQBoardVO(int boardNo, MomentorMemberVO momentorMemberVO,
			String boardTitle, String boardWdate, String boardContent,
			int ranking) {
		super(boardNo, momentorMemberVO, boardTitle, boardWdate, boardContent,
				ranking);
	}

}
