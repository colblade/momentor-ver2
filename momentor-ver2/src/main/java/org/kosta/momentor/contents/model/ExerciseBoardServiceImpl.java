package org.kosta.momentor.contents.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.kosta.momentor.cart.model.ExerciseVO;
import org.springframework.stereotype.Service;

@Service
public class ExerciseBoardServiceImpl implements ExerciseBoardService {
	@Resource
	private ExerciseBoardDAO exerciseBoardDAO;

	@Override
	public void postingExercise(ExerciseBoardVO evo) {
		exerciseBoardDAO.registerExercise(evo.getExerciseVO());
		exerciseBoardDAO.postingExercise(evo);
		
	}

	@Override
	public void deleteExerciseByAdmin(int eboardNo, String exerciseName) {
				//먼저 게시물을 지우고 그 다음
				//운동을 지운다.
		exerciseBoardDAO.deleteAllExerciseImg(exerciseName);
		exerciseBoardDAO.deleteExerciseBoardByNo(eboardNo);
		exerciseBoardDAO.deleteExerciseByExerciseName(exerciseName);
		
	}

	@Override
	public void updateExerciseByAdmin(ExerciseBoardVO ebvo,ExerciseVO evo) {
		exerciseBoardDAO.updateExercise( evo);
		exerciseBoardDAO.updateExerciseBoard(ebvo);
	}


	

	@Override
	public ListVO getAllExerciseList(String pageNo) {

		if(pageNo==null||pageNo.equals("")){
			pageNo = "1";
		}
		
		ArrayList<BoardVO> list = (ArrayList)exerciseBoardDAO.getAllExerciseList(pageNo);
		
		PagingBean pagingBean = new PagingBean(exerciseBoardDAO.totalExercise(), Integer.parseInt(pageNo));
		ListVO vo = new ListVO(list, pagingBean);
		
		
		return vo;
	}

	@Override
	public String exerciseNameOverLappingCheck(String exerciseName) {
		int res = exerciseBoardDAO.exerciseNameOverLappingCheck(exerciseName);
		String result = "false";
		if(res==0){
			result = "true";
		}
		return result;
	}

	

	@Override
	public void updateExerciseHits(int boardNo) {
		exerciseBoardDAO.updateExerciseHits(boardNo);
		
	}

	@Override
	public List<ExerciseBoardVO> getExerciseListBestTop5ByHits() {
		return exerciseBoardDAO.getExerciseListBestTop5ByHits();
	}
	@Override
	public List<ExerciseBoardVO> findExerciseListByTitle(String word) {
		// 운동게시판 전체 검색
		return exerciseBoardDAO.findExerciseListByTitle(word);
	}
	 public ListVO getExerciseListByTitle(String pageNo, String word) {
		 // 운동 게시판 검색 페이지
			if(pageNo==null||pageNo=="") 
				pageNo="1";
			int total=exerciseBoardDAO.totalExerciseByTitle(word);
			ArrayList<BoardVO> list= null;
			HashMap<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("word", word);
			paramMap.put("pageNo", pageNo);
			list = (ArrayList)exerciseBoardDAO.getExerciseListByTitle(paramMap);
			PagingBean paging=new PagingBean(total,Integer.parseInt(pageNo));
			ListVO lvo=new ListVO(list,paging);
	      return lvo;
	   }
	 
	 @Override
		public void registerExerciseImg(String exerciseName, String imgName,
				String imgPath) {

			Map<String, String> map = new HashMap<String, String>();
			
			map.put("exerciseName", exerciseName);
			map.put("imgName", imgName);
			map.put("imgPath", imgPath);
			
			exerciseBoardDAO.registerExerciseImg(map);
		}

		@Override
		public Map<String, Object> getExerciseByNo(int boardNo) {
			
			Map<String, Object> result = new HashMap<String, Object>();
			ExerciseBoardVO ebvo = exerciseBoardDAO.getExerciseByNo(boardNo);
			result.put("exerciseInfo", exerciseBoardDAO.getExerciseByNo(boardNo));
			result.put("nameList",exerciseBoardDAO.getExerciseImgListByExerciseName(ebvo.getExerciseVO().getExerciseName()));
			
			
			return result;
		}
		
	

		@Override
		public void deleteExerciseImgByImgName(String exerciseName,
				String imgName) {
	Map<String, String> map = new HashMap<String, String>();
	map.put("exerciseName", exerciseName);
	map.put("imgName", imgName);
	exerciseBoardDAO.deleteExerciseImgByImgName(map);
		}

		@Override
		public List<Map<String, String>> getExerciseImgListByExerciseName(String exerciseName) {
			
			return exerciseBoardDAO.getExerciseImgListByExerciseName(exerciseName);
		}

		@Override
		public Map<String, Object> getExerciseInfoByExName(String exerciseName) {
			Map<String, Object> result = new HashMap<String, Object>();
			ExerciseBoardVO ebvo = exerciseBoardDAO.getExerciseInfoByExName(exerciseName);
			result.put("exerciseInfo", ebvo);
			result.put("nameList",exerciseBoardDAO.getExerciseImgListByExerciseName(exerciseName));
			return result;
		}
}
