package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class QNABoardServiceImpl implements QNABoardService {

	@Resource
	private QNABoardDAO qnaBoardDAO;

	@Override
	public QNABoardVO writeQNA(QNABoardVO qvo){
		return qnaBoardDAO.writeQNA(qvo);
	}

	@Override
	public void deleteQNA(int qboardNo){
		qnaBoardDAO.deleteQNA(qboardNo);
	}

	@Override
	public void updateQNA(QNABoardVO qvo){
		qnaBoardDAO.updateQNA(qvo);
	}

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

	@Override
	public QNABoardVO getQNAByNo(int boardNo){
		qnaBoardDAO.qnaUpdateHits(boardNo);
		return qnaBoardDAO.getQNAByNo(boardNo);
	}
	
	@Override
	public QNABoardVO getQNAByNoNoHit(int boardNo){
		return qnaBoardDAO.getQNAByNo(boardNo);
	}

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
