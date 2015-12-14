package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service
public class CommunityBoardServiceImpl implements CommunityBoardService {
	@Resource
	private CommunityBoardDAO communityBoardDAO;

	@Override
	public CommunityBoardVO postingCommunity(CommunityBoardVO cvo) {
		return communityBoardDAO.postingCommunity(cvo); 
	}

	@Override
	public void deleteCommunity(int cboardNo) {//커뮤니티 게시판 글삭제
		communityBoardDAO.deleteCommunityImgFile(cboardNo);//해당 게시물 이미지 삭제
		communityBoardDAO.deleteAllReply(cboardNo);//무결성에 따른 덧글 우선삭제
		communityBoardDAO.deleteRecommend(cboardNo);//무결성에 따른 추천 우선 삭제
		communityBoardDAO.deleteCommunity(cboardNo);//그후 게시글 번호로 게시글 삭제	
	}

	@Override
	public void updateCommunity(CommunityBoardVO cvo) {
		communityBoardDAO.updateCommunity(cvo);
	}

	@Override
	public ReplyVO postingReply(ReplyVO rvo) {
		communityBoardDAO.postingReply(rvo);
		return null;
	}

	@Override
	public void deleteReply(int replyNo) {
		communityBoardDAO.deleteReply(replyNo);
		
	}

	@Override
	public void updateReply(ReplyVO rvo) {
		communityBoardDAO.updateReply(rvo);
		
	}

	@Override
	public ReplyVO getReplyByNo(int replyNo) {		
		return communityBoardDAO.getReplyByNo(replyNo);
	}  
	
	@Override
	public List<CommunityBoardVO> findByCbTitle(String cbTitle) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ListVO findByCbNickName(String pageNo, String searchWord) {
		if(pageNo==null||pageNo==""){
			pageNo="1";
		}
		int total=communityBoardDAO.searchContent(searchWord);
		ArrayList<BoardVO> list= null;
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("word", searchWord);
		paramMap.put("pageNo", pageNo);
		list = (ArrayList)communityBoardDAO.findByCbNickName(paramMap);
		PagingBean paging = new PagingBean(total,Integer.parseInt(pageNo));
		ListVO lvo=new ListVO(list, paging);
		return lvo;
   }

	@Override
	public void updateRecommend(int cbRecommend) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateNotRecommend(int cbNotRecommend) {
		// TODO Auto-generated method stub
		
	}

	@Override
	   public ListVO getAllPostingList(String pageNo) {
			if(pageNo==null||pageNo=="") 
				pageNo="1";
			ArrayList<BoardVO> list=(ArrayList)communityBoardDAO.getAllPostingList(pageNo);
			int total=communityBoardDAO.totalContent();
			PagingBean paging=new PagingBean(total,Integer.parseInt(pageNo));
			ListVO lvo=new ListVO(list,paging);
	      return lvo;
	   }
	@Override
	public void updateHits(int boardNo) {
	
		communityBoardDAO.updateHits(boardNo);
		
	}

	@Override
	public List<ReplyVO> getReplyListByNo(int boardNo) {
		// TODO Auto-generated method stub
		return communityBoardDAO.getReplyListByNo(boardNo);
	}


	@Override
	public List<CommunityBoardVO> getCommunityBoardListBestTop5ByRecommend() {
		// TODO Auto-generated method stub
		return communityBoardDAO.getCommunityBoardListBestTop5ByRecommend();
	}
	   public CommunityBoardVO getCommunityByNo(int boardNo) {
		      //System.out.println("service:"+boardNo);
		      return communityBoardDAO.getCommunityByNo(boardNo);
		   }
	   
	   
	   
		 /** 게시물에서 맨 처음 추천/비추천을 한다면 INSERT
			이미 예전에 추천 비추천을 한 경우가 있다면 UPDATE
			*/
		@Override
		public void updateRecommendInfo(int boardNo, String memberId, String recommend, String notRecommend) {


			Map<String, String> map = new HashMap<String, String>();
			map.put("boardNo", String.valueOf(boardNo));
			map.put("memberId", memberId);
			map.put("recommend", recommend);
			map.put("notRecommend", notRecommend);
			int res = communityBoardDAO.updateRecommendInfo(map);
			
			if(res==0){
				communityBoardDAO.insertRecommendInfo(map);
				System.out.println("communityService updateRecommend insert실행");
			}else{
				System.out.println("communityService updateRecommend update실행");
				
			}
		}
	/**
	 * 추천 수 수정
	 */
		@Override
		public void updateRecommend(int boardNo, int num) {
			Map<String, Integer> map = new HashMap<String, Integer>();
					map.put("boardNo", boardNo);
					map.put("num", num);
					communityBoardDAO.updateRecommend(map);
		}
	/**
	 * 비추천수 수정
	 */
		@Override
		public void updateNotRecommend(int boardNo, int num) {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("boardNo", boardNo);
			map.put("num", num);
			communityBoardDAO.updateNotRecommend(map);
		}

	/**
	 *게시글 번호와 아이디를 매개변수로 해당 아이디가 추천했는지 안 했는지 알려준다.
	 */
		@Override
		public Map<String, String> getRecommendInfoByMemberId(
				int boardNo, String memberId) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("boardNo", String.valueOf(boardNo));
			map.put("memberId", memberId);
			Map<String, String> res = communityBoardDAO.getRecommendInfoByMemberId(map);
			
			
			return res;
		}
	/**
	 * 해당 게시물의 추천/비추천 수를 가지고 온다.
	 */
		@Override
		public String[] countRecommend(int boardNo) {

		   String res[] = {String.valueOf(communityBoardDAO.countRecommend(boardNo)),
		         String.valueOf(communityBoardDAO.countNotRecommend(boardNo))};

		   return res;
		}
	public List<CommunityBoardVO> findByTitle(String word) {
		   // 커뮤니티 전체 검색
			return communityBoardDAO.findByTitle(word);
		}
	   public ListVO getSearchCommunityList(String pageNo, String word) {
		   // 커뮤니티 게시판 검색 페이지 이동
			if(pageNo==null||pageNo=="") 
				pageNo="1";
			int total=communityBoardDAO.searchContent(word);
			ArrayList<BoardVO> list= null;
			HashMap<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("word", word);
			paramMap.put("pageNo", pageNo);
			list = (ArrayList)communityBoardDAO.getSearchCommunityList(paramMap);
			PagingBean paging=new PagingBean(total,Integer.parseInt(pageNo));
			ListVO lvo=new ListVO(list,paging);
	      return lvo;
	   }
	   @Override
		public void registerCommunityImgFile(int boardNo,String imgName, String imgPath) {
	HashMap<String, String> map = new HashMap<String, String>();
	map.put("boardNo", String.valueOf(boardNo));
	map.put("imgName", imgName);
	map.put("imgPath", imgPath);
			communityBoardDAO.registerCommunityImgFile(map);
			
		}

		@Override
		public List<HashMap<String, String>> getCommunityFileList(int boardNo) {
			// TODO Auto-generated method stub
			return communityBoardDAO.getCommunityFileList(boardNo);
		}


		@Override
		public void deleteCommunityImgFileByImgName(int boardNo, String imgName) {

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("boardNo", String.valueOf(boardNo));
			map.put("imgName", imgName);
			communityBoardDAO.deleteCommunityImgFileByImgName(map);		
		}
}
