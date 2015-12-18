package org.kosta.momentor.contents.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.momentor.cart.model.ExerciseVO;

public interface ExerciseBoardService {
	public void postingExercise(ExerciseBoardVO evo);//운동 업로드
	public void deleteExerciseByAdmin(int eboardNo,String exerciseName);//글 삭제
	public void updateExerciseByAdmin(ExerciseBoardVO ebvo,ExerciseVO evo);//글 수정
	public ListVO getAllExerciseList(String pageNo);
	public String exerciseNameOverLappingCheck(String exerciseName);
	public void updateExerciseHits(int boardNo);
	public List<ExerciseBoardVO> getExerciseListBestTop5ByHits();
	public List<ExerciseBoardVO> findExerciseListByTitle(String word); // 운동게시판 검색
	public ListVO getExerciseListByTitle(String pageNo, String word) ; // 운동게시판 검색 페이지
	//사진 올리기
	public void registerExerciseImg(String exerciseName, String imgName, String imgPath);
	//운동게시물 상세보기
	public Map<String, Object> getExerciseByNo(int boardNo);
	//사진 개별 삭제
	public void deleteExerciseImgByImgName(String exerciseName, String imgName);
	//사진 가지고 오기
	public List<Map<String, String>> getExerciseImgListByExerciseName(String exerciseName);
	//운동명으로 해당 운동게시물 불러오기
	public Map<String, Object> getExerciseInfoByExName(String exerciseName);
	//URL 등록
	public void registerVideoURL(String exerciseName,String url);
	//url 통해 영상 보기
	public HashMap<String,String> getURLByExerciseName(String exerciseName);
	//url 업데이트
	public void updateExerciseURL(String exerciseName,String url);
}