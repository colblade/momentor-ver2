package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class QNABoardServiceImpl implements QNABoardService {

	@Resource
	private QNABoardDAO qnaBoardDAO;
	/*QNA 글 쓰기*/
	@Override
	public QNABoardVO writeQNA(QNABoardVO qvo){
		return qnaBoardDAO.writeQNA(qvo);
	}
	/*QNA 글 삭제*/
	@Override
	public void deleteQNA(int qboardNo){
		qnaBoardDAO.deleteQNA(qboardNo);
	}
	/*QNA 글 수정*/
	@Override
	public void updateQNA(QNABoardVO qvo){
		qnaBoardDAO.updateQNA(qvo);
	}
	/*QNA 글 목록*/
	@Override
	public ListVO getAllQNAList(String pageNo){
		if(pageNo==null||pageNo==""){ 
			pageNo="1";
		}
		List<BoardVO> qnaList = qnaBoardDAO.getAllQNAList(pageNo);
		int total = qnaBoardDAO.totalQNAContent();
		PagingBean paging = new PagingBean(total, Integer.parseInt(pageNo));
		ListVO lvo = new ListVO((ArrayList<BoardVO>) qnaList, paging);
		return lvo;
	}
	/*QNA 글 상세 보기*/
	@Override
	public QNABoardVO getQNAByNo(int boardNo){
		qnaBoardDAO.qnaUpdateHits(boardNo);
		return qnaBoardDAO.getQNAByNo(boardNo);
	}
	/*QNA 글 상세 보기 조회수 증가 x*/
	@Override
	public QNABoardVO getQNAByNoNoHit(int boardNo){
		return qnaBoardDAO.getQNAByNo(boardNo);
	}
	/*관리자가 QNA 답글 달기*/
	@Override
	public void qnaReply(QNABoardVO qvo) {
		int ref = qvo.getRef();
		int restep = qvo.getRestep();
		int relevel = qvo.getRelevel();
		qnaBoardDAO.updateRestep(ref, restep);
		qvo.setRestep(restep+1);
		qvo.setRelevel(relevel+1);
		qnaBoardDAO.insertRefContent(qvo);
		
	}
}
