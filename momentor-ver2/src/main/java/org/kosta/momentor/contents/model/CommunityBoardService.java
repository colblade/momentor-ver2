package org.kosta.momentor.contents.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
public interface CommunityBoardService {
	public ListVO getAllCommunityList(String pageNo);//전체 목록
	public CommunityBoardVO postingCommunity(CommunityBoardVO cvo);//jsp에서 cvo형식으로 받아와 글 업로드
	//커뮤니티에서 이미지 등록
	public void registerCommunityImg(int boardNo,String imgName, String imgPath);
	//해당 게시글 커뮤니티 이미지 불러오기
	public List<HashMap<String, String>> getCommunityImgListByNo(int boardNo);
	public void deleteCommunity(int cboardNo);////글 번호로 커뮤니티 게시판 글 삭제
	//해당 커뮤니티 게시글 img 개별 삭제 boardNo, imgName을 가지고 옵니다.
	public void deleteCommunityImgByImgName(int boardNo, String imgName);
	public void updateCommunity(CommunityBoardVO cvo);//수정 폼에서 cvo 형식으로 받아와 DB에 수정
	public CommunityBoardVO getCommunityByNo(int boardNo);//커뮤니티 글 번호로 상세 글 정보 가져오기
	public List<ReplyVO> getReplyListByNo(int boardNo);//게시글 번호로 해당 게시물에 있는 덧글 목록 가져오기
	public void updateCommunityHits(int boardNo); //조회수 증가.
	public List<CommunityBoardVO> getCommunityListBestTop5ByRecommend();//커뮤니티 게시판 추천수 TOP5
	public ReplyVO postingReply(ReplyVO rvo);//커뮤니티 게시판 덧글 폼에서 rvo로 받아와 덧글 등록
	public void deleteReplyByNo(int replyNo);//덧글 고유 시퀀스로 덧글 삭제
	public void updateReply(ReplyVO rvo);//덧글 고유 시퀀스로 덧글 수정
	//해당 커뮤니티 게시물에서 맨 처음 추천/비추천을 한다면 INSERT
	//이미 예전에 추천 비추천을 한 경우가 있다면 UPDATE
	//#{boardNo},#{memberId},#{recommend},#{notrecommend}
	public void updateRecommendInfo(int boardNo, String memberId, String recommend, String notRecommend);
	//커뮤니티 추천/비추천수를 수정한다.
	public void updateRecommend(int boardNo, int num);
	public void updateNotRecommend(int boardNo, int num);
	//커뮤키티 게시글 번호와 아이디를 매개변수로 해당 아이디가 추천했는지 안 했는지 알려준다.
	public Map<String, String> getRecommendInfoByMemberId(int boardNo, String memberId);	
	//해당 커뮤니티 게시글의 추천/비추천수를 가지고 온다.
	public String[] totalRecommendByNo(int boardNo);
	public List<CommunityBoardVO> findCommunityListByTitle(String word); // 커뮤니티 검색
	public ListVO getCommunityListByTitle(String pageNo, String word); // 검색된 커뮤니티 목록
	public ListVO findByCbNickName(String pageNo, String searchWord);//닉네임으로 검색
	public List<Map<String, Integer>> getReplyCountList();
}
