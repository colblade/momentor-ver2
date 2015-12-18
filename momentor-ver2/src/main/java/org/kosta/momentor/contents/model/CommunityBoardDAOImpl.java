package org.kosta.momentor.contents.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
@Repository
public class CommunityBoardDAOImpl implements CommunityBoardDAO {
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<BoardVO> getAllCommunityList(String pageNo) {
		List<BoardVO> list=sqlSessionTemplate.selectList("content.getAllCommunityList", pageNo);
	    return list;
	}
	public CommunityBoardVO getCommunityByNo(int boardNo) {
		return sqlSessionTemplate.selectOne("content.getCommunityByNo", boardNo);
	}
	@Override
	public CommunityBoardVO postingCommunity(CommunityBoardVO cvo) {
		sqlSessionTemplate.insert("content.postingCommunity",cvo);
		int no=sqlSessionTemplate.selectOne("content.getCommunityBoardNo");
		cvo.setBoardNo(no);
		return cvo;
	}
	@Override
	public void registerCommunityImg(HashMap<String, String> map) {
		sqlSessionTemplate.insert("content.registerCommunityImg", map);
	}
	@Override
	public List<HashMap<String, String>> getCommunityImgListByNo(int boardNo) {
		return sqlSessionTemplate.selectList("content.getCommunityImgListByNo",boardNo);
	}
	@Override
	public void deleteCommunityByNo(int cboardNo) {
		sqlSessionTemplate.delete("content.deleteCommunityByNo",cboardNo);
	}
	@Override
	public void deleteCommunityImgByImgName(HashMap<String, String> map) {
		sqlSessionTemplate.delete("content.deleteCommunityImgByImgName", map);
	}
	@Override
	public void updateCommunity(CommunityBoardVO cvo) {
		sqlSessionTemplate.update("content.updateCommunity",cvo);
	}
	@Override
	public ReplyVO postingReply(ReplyVO rvo) {
		sqlSessionTemplate.insert("content.postingReply",rvo);
		return null;
	}
	@Override
	public void deleteAllReplyByNo(int cboardNo) {
		sqlSessionTemplate.delete("content.deleteAllReplyByNo", cboardNo);
	}
	@Override
	public void deleteReplyByNo(int replyNo) {
		sqlSessionTemplate.delete("content.deleteReplyByNo", replyNo);	
	}
	@Override
	public void updateReply(ReplyVO rvo) {
		sqlSessionTemplate.update("content.updateReply",rvo);	
	}
	@Override
	public List<ReplyVO> getReplyListByNo(int boardNo) {
		return sqlSessionTemplate.selectList("content.getReplyListByNo", boardNo);
	}
	@Override
	public ReplyVO getReplyByNo(int replyNo) {
		return sqlSessionTemplate.selectOne("content.getReplyByNo", replyNo);
	}
	@Override
	public void updateRecommend(Map<String, Integer> map) {
			sqlSessionTemplate.update("content.updateRecommend", map);		
	}
	@Override
	public void updateNotRecommend(Map<String, Integer> map) {
		sqlSessionTemplate.update("content.updateNotRecommend", map);		
	}
	@Override
	public void deleteRecommendByNo(int cboardNo) {
		sqlSessionTemplate.delete("content.deleteRecommendByNo",cboardNo);
	}
	@Override
	public void updateCommunityHits(int boardNo) {
		sqlSessionTemplate.update("content.updateCommunityHits", boardNo);
	}
	@Override
	public List<CommunityBoardVO> getCommunityListBestTop5ByRecommend() {		
		return sqlSessionTemplate.selectList("content.getCommunityListBestTop5ByRecommend");
	}
	@Override
	public int totalCommunity(){
		return sqlSessionTemplate.selectOne("content.totalCommunity");
	}  
	@Override
	public Map<String, String> getRecommendInfoByMemberId(Map<String, String> map) {	
		Map<String, String> res = sqlSessionTemplate.selectOne("content.getRecommendInfoByMemberId", map);
		return res;
	}
	@Override
	public int updateRecommendInfo(Map<String, String> map) {
		return	sqlSessionTemplate.update("content.updateRecommendInfo", map);		
	}
	@Override
	public void registerRecommendInfo(Map<String, String> map) {
		sqlSessionTemplate.update("content.registerRecommendInfo", map);
	}
	@Override
	public int totalRecommendByNo(int boardNo) {
		return sqlSessionTemplate.selectOne("content.totalRecommendByNo", boardNo);
	}
	@Override
	public int totalNotRecommendByNo(int boardNo) {
		return sqlSessionTemplate.selectOne("content.totalNotRecommendByNo", boardNo);
	}
	@Override
	public List<CommunityBoardVO> findCommunityListByTitle(String word) {
		// 커뮤니티 게시판 전체 검색
		return sqlSessionTemplate.selectList("content.findCommunityListByTitle",word);
	}
	public List<CommunityBoardVO> getCommunityListByTitle(HashMap<String, String> paramMap) {
		// 커뮤니티 게시판 검색 페이지
		List<CommunityBoardVO> list=sqlSessionTemplate.selectList("content.getCommunityListByTitle", paramMap);
		return list;
	}
	public int totalCommunityByTitle(String word){
		// 커뮤니티 게시판 검색 총 개수
		return sqlSessionTemplate.selectOne("content.totalCommunityByTitle", word);
	}
	@Override
	public void deleteAllCommunityImg(int boardNo) {
		sqlSessionTemplate.delete("content.deleteAllCommunityImg", boardNo);			
	}
	@Override
	public List<CommunityBoardVO> findByCbNickName(HashMap<String, String> paramMap) {
		return sqlSessionTemplate.selectList("content.findByCbNickName", paramMap);
	}
	@Override
	public List<Map<String, Integer>> getReplyCountList(){
		return sqlSessionTemplate.selectList("content.getReplyCountList");
	}
}
