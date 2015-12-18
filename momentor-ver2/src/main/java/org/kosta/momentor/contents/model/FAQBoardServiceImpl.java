package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
@Service
public class FAQBoardServiceImpl implements FAQBoardService{

	@Resource
	private FAQBoardDAO faqBoardDAO;
	
	@Override  // 전체 FAQ 리스트를 출력
	public ListVO getAllFAQList(String pageNo) {
		if(pageNo==null||pageNo==""){ 
			pageNo="1";
		}
		List<BoardVO> faqList=faqBoardDAO.getAllFAQList(pageNo);
		int total=faqBoardDAO.totalFAQContent();
		PagingBean paging=new PagingBean(total, Integer.parseInt(pageNo));
		ListVO lvo=new ListVO((ArrayList<BoardVO>)faqList,paging);
		return lvo;
	}

	@Override //글 번호로 FAQ 글 가져오기
	public FAQBoardVO getFAQByNo(int boardNo) {
		return faqBoardDAO.getFAQByNo(boardNo);
	}

	@Override //FAQ 글 등록
	public int postingFAQ(FAQBoardVO nvo) {
		return faqBoardDAO.postingFAQ(nvo);
	}

	@Override //FAQ 글 삭제
	public void deleteFAQByNo(int boardNo) {
		faqBoardDAO.deleteFAQByNo(boardNo);
	}

	@Override //FAQ 글 수정
	public void updateFAQ(FAQBoardVO nvo) {
		faqBoardDAO.updateFAQ(nvo);
	}
}
