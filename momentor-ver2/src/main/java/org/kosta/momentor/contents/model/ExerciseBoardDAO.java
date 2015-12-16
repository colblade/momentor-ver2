package org.kosta.momentor.contents.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.momentor.cart.model.ExerciseVO;

public interface ExerciseBoardDAO {
public void postingExercise(ExerciseBoardVO evo);//운동 게시물 업로드
public void deleteExerciseBoardByNo(int eboardNo);//글 삭제
public void updateExerciseBoard(ExerciseBoardVO ebvo);//글 수정


//전체 운동 게시물 뿌려주기
public List<BoardVO> getAllExerciseList(String pageNo);
//전체 페이지 수 계산
public int totalExercise();
//운동 이름이 이미 존재하는지 검사
public int exerciseNameOverLappingCheck(String exerciseName);

//운동 업로드
public void registerExercise(ExerciseVO evo);
//운동 상세보기
public ExerciseBoardVO getExerciseByNo(int boardNo);

//운동게시물의 조회수 증가
public void updateExerciseHits(int boardNo);
//운동 삭제
public void deleteExerciseByExerciseName(String exerciseName);
//운동 수정
public void updateExercise(ExerciseVO evo);
public List<ExerciseBoardVO> getExerciseListBestTop5ByHits();
public List<ExerciseBoardVO> findExerciseListByTitle(String word); // 운동게시판 전체 검색
public List<ExerciseBoardVO> getExerciseListByTitle(HashMap<String, String> paramMap); // 운동게시판 검색 페이지
public int totalExerciseByTitle(String word); // 운동게시판 검색 총 개수

//운동명으로 해당 운동게시물 불러오기
public ExerciseBoardVO getExerciseInfoByExName(String exerciseName);


//파일 업로드
public void registerExerciseImg(Map<String, String> map); 
//파일 리스트 불러오기
public List<Map<String, String>> getExerciseImgListByExerciseName(String exerciseName);

//사진 파일 삭제
public void deleteAllExerciseImg(String exerciseName);

//사진파일 개별삭제
public void deleteExerciseImgByImgName(Map<String, String> map);

//URL 업로드
public void registerVideoURL(HashMap<String,String> paramMap);

//URL을 통해 영상 불러오기
public HashMap<String,String> getURLByExerciseName(String exerciseName);
//영상 삭제
public void deleteExerciseURL(String exerciseName);
//영상 url 업데이트
public int updateExerciseURL(HashMap<String,String> paramMap);
}