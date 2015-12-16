package org.kosta.momentor.contents.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class QNABoardDAOImpl implements QNABoardDAO {
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public QNABoardVO writeQNA(QNABoardVO qvo){
		sqlSessionTemplate.insert("content.writeQNA",qvo);
		return qvo;
	}

	@Override
	public void deleteQNA(int qboardNo){
		sqlSessionTemplate.delete("content.deleteQNA", qboardNo);
	}
	@Override
	public void updateQNA(QNABoardVO qvo){
		sqlSessionTemplate.update("content.updateQNA",qvo);
	}
	@Override
	public void qnaUpdateHits(int boardNo){
		sqlSessionTemplate.update("content.qnaUpdateHits",boardNo);
	}

	@Override
	public List<BoardVO> getAllQNAList(String pageNo){
		return sqlSessionTemplate.selectList("content.getAllQNAList",pageNo);
	}

	@Override
	public QNABoardVO getQNAByNo(int boardNo){
		return sqlSessionTemplate.selectOne("content.getQNAByNo",boardNo);
	}

	@Override
	public int totalQNAContent(){
		return sqlSessionTemplate.selectOne("content.totalQNAContent");
	}

	@Override
	public void updateRestep(int ref, int restep) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("ref", ref);
		map.put("restep", restep);
		sqlSessionTemplate.update("content.updateRestep",map);
	}

	@Override
	public void insertRefContent(QNABoardVO qvo) {
		sqlSessionTemplate.insert("content.writeQNAReply",qvo);
	}
	

}
