package org.kosta.momentor.contents.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FAQBoardDAOImpl implements FAQBoardDAO{
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override  //전체 FAQ 리스트 출력
	public List<BoardVO> getAllFAQList(String pageNo) {
		System.out.println("페이지 no = "+pageNo);
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
