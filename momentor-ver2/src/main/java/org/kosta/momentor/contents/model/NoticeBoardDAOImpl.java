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
}
