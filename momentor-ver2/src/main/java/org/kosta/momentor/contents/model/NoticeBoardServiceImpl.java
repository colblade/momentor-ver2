package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {
	@Resource
	private NoticeBoardDAO noticeBoardDAO;

	@Override
	public NoticeBoardVO postingNotice(NoticeBoardVO nvo) {
		return noticeBoardDAO.postingNotice(nvo);
	}

	@Override
	public void deleteNoticeByNo(int noticeNo) {
		noticeBoardDAO.deleteNoticeByNo(noticeNo);
		
	}

	@Override
	public void updateNotice(NoticeBoardVO nvo) {
		noticeBoardDAO.updateNotice(nvo);
	}

	@Override
	public ListVO getAllNoticeList(String pageNo) {
		if(pageNo==null||pageNo==""){ 
			pageNo="1";
		}
		List<BoardVO> noticeList = noticeBoardDAO.getAllNoticeList(pageNo);
		int total = noticeBoardDAO.totalNotice();
		PagingBean paging=new PagingBean(total,Integer.parseInt(pageNo));
		ListVO lvo = new ListVO((ArrayList<BoardVO>) noticeList,paging);
		return lvo;
	}

	@Override
	public NoticeBoardVO getNoticeByNo(int boardNo) {
		return noticeBoardDAO.getNoticeByNo(boardNo);
	}

	@Override  // 전체 FAQ 리스트를 출력
	public ListVO getAllFAQList(String pageNo) {
		if(pageNo==null||pageNo==""){ 
			pageNo="1";
		}
		List<BoardVO> faqList=noticeBoardDAO.getAllFAQList(pageNo);
		int total=noticeBoardDAO.totalFAQContent();
		PagingBean paging=new PagingBean(total, Integer.parseInt(pageNo));
		ListVO lvo=new ListVO((ArrayList<BoardVO>)faqList,paging);
		return lvo;
	}

	@Override //글 번호로 FAQ 글 가져오기
	public FAQBoardVO getFAQByNo(int boardNo) {
		return noticeBoardDAO.getFAQByNo(boardNo);
	}

	@Override //FAQ 글 등록
	public int postingFAQ(FAQBoardVO nvo) {
		return noticeBoardDAO.postingFAQ(nvo);
	}

	@Override //FAQ 글 삭제
	public void deleteFAQByNo(int boardNo) {
		noticeBoardDAO.deleteFAQByNo(boardNo);
	}

	@Override //FAQ 글 수정
	public void updateFAQ(FAQBoardVO nvo) {
		noticeBoardDAO.updateFAQ(nvo);
	}
}
