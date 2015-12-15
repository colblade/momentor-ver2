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

}
