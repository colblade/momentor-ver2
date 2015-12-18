package org.kosta.momentor.contents.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
@Repository
public class NoticeBoardDAOImpl implements NoticeBoardDAO {
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public NoticeBoardVO postingNotice(NoticeBoardVO nvo) {
		sqlSessionTemplate.insert("content.postingNotice",nvo);
		return nvo;
	}

	@Override
	public void deleteNoticeByNo(int noticeNo) {
		sqlSessionTemplate.delete("content.deleteNoticeByNo", noticeNo);
		
	}

	@Override
	public void updateNotice(NoticeBoardVO nvo) {
		sqlSessionTemplate.update("content.updateNotice",nvo);
		
	}

	@Override
	public List<BoardVO> getAllNoticeList(String pageNo) {
		return sqlSessionTemplate.selectList("content.getAllNoticeList",pageNo);
	}

	@Override
	public NoticeBoardVO getNoticeByNo(int boardNo) {
		return sqlSessionTemplate.selectOne("content.getNoticeByNo",boardNo);
	}

	@Override
	public int totalNotice() {
		return sqlSessionTemplate.selectOne("content.totalNotice");
	}
	@Override  //전체 FAQ 리스트 출력
	public List<BoardVO> getAllFAQList(String pageNo) {
		List<BoardVO> list=sqlSessionTemplate.selectList("content.getAllFAQList",pageNo);//resultMap 으로 받아옵시다
		return list;
	}

	@Override //전체 FAQ 글 갯수 출력
	public int totalFAQContent() {
		return sqlSessionTemplate.selectOne("content.totalFAQContent");
	}

	@Override //번호로 단일 FAQ 글 가져오기
	public FAQBoardVO getFAQByNo(int boardNo) {
		return sqlSessionTemplate.selectOne("content.getFAQByNo",boardNo);
	}

	@Override //FAQ 글 쓰기
	public int postingFAQ(FAQBoardVO fvo) {
		sqlSessionTemplate.insert("content.postingFAQ",fvo);
		return sqlSessionTemplate.selectOne("content.getFAQPostingNumber");
	}

	@Override //FAQ 글 삭제
	public void deleteFAQByNo(int boardNo) {
		sqlSessionTemplate.delete("content.deleteFAQByNo", boardNo);
	}

	@Override //FAQ 글 수정
	public void updateFAQ(FAQBoardVO fvo) {
		sqlSessionTemplate.update("content.updateFAQ",fvo);
	}
}
