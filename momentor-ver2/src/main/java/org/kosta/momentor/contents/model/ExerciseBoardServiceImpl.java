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

	//운동과 운동게시물 업로드
	@Override
	public void postingExercise(ExerciseBoardVO evo) {
		exerciseBoardDAO.registerExercise(evo.getExerciseVO());
		exerciseBoardDAO.postingExercise(evo);
	}
	//운동게시물 삭제
	@Override
	public void deleteExerciseByAdmin(int eboardNo, String exerciseName) {
		// 먼저 운동게시물 이미지와 url을 지우고
		// 운동게시물과 운동을 지운다.
		exerciseBoardDAO.deleteAllExerciseImg(exerciseName);
		exerciseBoardDAO.deleteExerciseURL(exerciseName);
		exerciseBoardDAO.deleteExerciseBoardByNo(eboardNo);
		exerciseBoardDAO.deleteExerciseByExerciseName(exerciseName);
	}
	//글 수정
	@Override
	public void updateExerciseByAdmin(ExerciseBoardVO ebvo, ExerciseVO evo) {
		exerciseBoardDAO.updateExercise(evo);
		exerciseBoardDAO.updateExerciseBoard(ebvo);
	}
	//페이징을 적용한 전체 운동게시글 목록 가져오기
	@Override
	public ListVO getAllExerciseList(String pageNo) {
		if (pageNo == null || pageNo.equals("")) {
			pageNo = "1";
		}
		ArrayList<BoardVO> list = (ArrayList) exerciseBoardDAO.getAllExerciseList(pageNo);
		PagingBean pagingBean = new PagingBean(exerciseBoardDAO.totalExercise(), Integer.parseInt(pageNo));
		ListVO vo = new ListVO(list, pagingBean);
		return vo;
	}
	//운동이름 중복검사
	@Override
	public String exerciseNameOverLappingCheck(String exerciseName) {
		int res = exerciseBoardDAO.exerciseNameOverLappingCheck(exerciseName);
		String result = "false";
		if (res == 0) {
			result = "true";
		}
		return result;
	}
	//운동게시물 조회수 증가
	@Override
	public void updateExerciseHits(int boardNo) {
		exerciseBoardDAO.updateExerciseHits(boardNo);
	}
	//운동게시물 조회수 top5 목록 가져오기
	@Override
	public List<ExerciseBoardVO> getExerciseListBestTop5ByHits() {
		return exerciseBoardDAO.getExerciseListBestTop5ByHits();
	}
	/**
	 *  header.jsp에서 전체 검색 중 운동게시판 전체 검색 부분
	 */
	@Override
	public List<ExerciseBoardVO> findExerciseListByTitle(String word) {
		return exerciseBoardDAO.findExerciseListByTitle(word);
	}
	/**
	 *  전체 검색 후 커뮤니티에서 검색된 부분으로 이동
	 */
	public ListVO getExerciseListByTitle(String pageNo, String word) {
		if (pageNo == null || pageNo == "")
			pageNo = "1";
		int total = exerciseBoardDAO.totalExerciseByTitle(word);
		ArrayList<BoardVO> list = null;
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("word", word);
		paramMap.put("pageNo", pageNo);
		list = (ArrayList) exerciseBoardDAO.getExerciseListByTitle(paramMap);
		PagingBean paging = new PagingBean(total, Integer.parseInt(pageNo));
		ListVO lvo = new ListVO(list, paging);
		return lvo;
	}
	//운동 게시물 이미지 등록
	@Override
	public void registerExerciseImg(String exerciseName, String imgName,
			String imgPath) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("exerciseName", exerciseName);
		map.put("imgName", imgName);
		map.put("imgPath", imgPath);
		exerciseBoardDAO.registerExerciseImg(map);
	}
	//게시글 번호로 운동게시물 상세보기. 이미지, url도 같이 보내준다.
	@Override
	public Map<String, Object> getExerciseByNo(int boardNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		ExerciseBoardVO ebvo = exerciseBoardDAO.getExerciseByNo(boardNo);
		result.put("exerciseInfo", exerciseBoardDAO.getExerciseByNo(boardNo));
		result.put("nameList", exerciseBoardDAO
				.getExerciseImgListByExerciseName(ebvo.getExerciseVO()
						.getExerciseName()));
		result.put("URLVideo", exerciseBoardDAO.getURLByExerciseName(ebvo
				.getExerciseVO().getExerciseName()));
		return result;
	}
	//운동게시물에 있는 이미지 개별 삭제(ajax)
	@Override
	public void deleteExerciseImgByImgName(String exerciseName, String imgName) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("exerciseName", exerciseName);
		map.put("imgName", imgName);
		exerciseBoardDAO.deleteExerciseImgByImgName(map);
	}
	//해당 운동게시물에 있는 이미지 목록 가져오기
	@Override
	public List<Map<String, String>> getExerciseImgListByExerciseName(
			String exerciseName) {
		return exerciseBoardDAO.getExerciseImgListByExerciseName(exerciseName);
	}
	//운동이름으로 운동게시물 상세보기. 이미지, url도 같이 보내준다.
	@Override
	public Map<String, Object> getExerciseInfoByExName(String exerciseName) {
		Map<String, Object> result = new HashMap<String, Object>();
		ExerciseBoardVO ebvo = exerciseBoardDAO
				.getExerciseInfoByExName(exerciseName);
		result.put("exerciseInfo", ebvo);
		result.put("nameList", exerciseBoardDAO.getExerciseImgListByExerciseName(exerciseName));
		result.put("URLVideo", exerciseBoardDAO.getURLByExerciseName(ebvo.getExerciseVO().getExerciseName()));
		return result;
	}
	//운동 게시물 url 등록
	@Override
	public void registerVideoURL(String exerciseName, String url) {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("exerciseName", exerciseName);
		paramMap.put("urlPath", url);
		exerciseBoardDAO.registerVideoURL(paramMap);
	}
	//운동 게시물 url 수정/삭제 부분.
	@Override
	public void updateExerciseURL(String exerciseName, String urlPath) {
		HashMap<String, String> paramMap = new HashMap<String, String>();
		if (urlPath == null || urlPath.equals("") || urlPath.trim().equals("null")) {
			exerciseBoardDAO.deleteExerciseURL(exerciseName);
		} else if (urlPath != null && !urlPath.equals("") && !urlPath.trim().equals("null")) {
			paramMap.put("exerciseName", exerciseName);
			paramMap.put("urlPath", urlPath);
			int updateCount = exerciseBoardDAO.updateExerciseURL(paramMap);
			if (updateCount == 0) {
				exerciseBoardDAO.registerVideoURL(paramMap);
			}
		}
	}
	//해당 운동게시물에 있는 url을 통한 영상 불러오기
	public HashMap<String, String> getURLByExerciseName(String exerciseName) {
		return exerciseBoardDAO.getURLByExerciseName(exerciseName);
	}
}
