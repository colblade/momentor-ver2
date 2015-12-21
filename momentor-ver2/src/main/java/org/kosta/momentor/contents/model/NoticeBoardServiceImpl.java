package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {
	@Resource
	private NoticeBoardDAO noticeBoardDAO;

	/*공지사항 글 작성*/
	@Override
	public NoticeBoardVO postingNotice(NoticeBoardVO nvo) {
		return noticeBoardDAO.postingNotice(nvo);
	}
	/*공지사항 글 삭제*/
	@Override
	public void deleteNoticeByNo(int noticeNo) {
		noticeBoardDAO.deleteNoticeByNo(noticeNo);
	}
	/*공지사항 글 수정*/
	@Override
	public void updateNotice(NoticeBoardVO nvo) {
		noticeBoardDAO.updateNotice(nvo);
	}
	/*공지사항 글 리스트*/
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
	/*공지사항 글 상세 보기*/
	@Override
	public NoticeBoardVO getNoticeByNo(int boardNo) {
		return noticeBoardDAO.getNoticeByNo(boardNo);
	}
}
