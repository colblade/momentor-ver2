package org.kosta.momentor.contents.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.kosta.momentor.cart.model.ExerciseVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
@Repository
public class ExerciseBoardDAOImpl implements ExerciseBoardDAO {
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void postingExercise(ExerciseBoardVO evo) {
		 sqlSessionTemplate.insert("content.postingExercise", evo);
	}

	@Override
	public void deleteExerciseByExerciseName(String exerciseName) {
		sqlSessionTemplate.delete("content.deleteExerciseByExerciseName", exerciseName);
	}

	@Override
	public void updateExercise(ExerciseVO evo) {
		sqlSessionTemplate.update("content.updateExercise", evo);
		
	}

	@Override
	public List<BoardVO> getAllExerciseList(String pageNo) {
		List<BoardVO> list = sqlSessionTemplate.selectList("content.getAllExerciseList", pageNo);
		
		return list;
		
	}

	@Override
	public int totalExercise() {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("content.totalExercise");
	}

	@Override
	public int exerciseNameOverLappingCheck(String exerciseName) {
		return  sqlSessionTemplate.selectOne("content.exerciseNameOverLappingCheck", exerciseName);
	}

	@Override
	public ExerciseBoardVO getExerciseByNo(int boardNo) {
		return sqlSessionTemplate.selectOne("content.getExerciseByNo", boardNo);
	}

	
	
	@Override
	public void registerExercise(ExerciseVO evo) {
		sqlSessionTemplate.insert("content.registerExercise", evo);
	}

	@Override
	public void updateExerciseHits(int boardNo) {
		sqlSessionTemplate.insert("content.updateExerciseHits", boardNo);		
	}

	@Override
	public void deleteExerciseBoardByNo(int eboardNo) {
		sqlSessionTemplate.delete("content.deleteExerciseBoardByNo", eboardNo);
	}

	@Override
	public void updateExerciseBoard(ExerciseBoardVO ebvo) {
			sqlSessionTemplate.update("content.updateExerciseBoard", ebvo);
	}

	@Override
	public List<ExerciseBoardVO> getExerciseListBestTop5ByHits() {
		
		return sqlSessionTemplate.selectList("content.getExerciseListBestTop5ByHits");
		
	}
	@Override
	public List<ExerciseBoardVO> findExerciseListByTitle(String word) {
		// 운동게시판 전체 검색
		return sqlSessionTemplate.selectList("content.findExerciseListByTitle",word);
	}
	public List<ExerciseBoardVO> getExerciseListByTitle(HashMap<String, String> paramMap) {
		// 운동게시판 검색 페이지
		List<ExerciseBoardVO> list=sqlSessionTemplate.selectList("content.getExerciseListByTitle", paramMap);
		return list;
	}
	public int totalExerciseByTitle(String word){
		// 운동게시판 검색 총 개수
		return sqlSessionTemplate.selectOne("content.totalExerciseByTitle", word);
	}
	@Override
	public void registerExerciseImg(Map<String, String> map) {
		sqlSessionTemplate.insert("content.registerExerciseImg", map);		
	}

	@Override
	public List<Map<String, String>> getExerciseImgListByExerciseName(String exerciseName) {
	return	sqlSessionTemplate.selectList("content.getExerciseImgListByExerciseName", exerciseName);		
	}

	@Override
	public void deleteAllExerciseImg(String exerciseName) {

		
		
		sqlSessionTemplate.delete("content.deleteAllExerciseImg", exerciseName)
		;
	}
	public void registerURL(HashMap<String,String> paramMap){
		sqlSessionTemplate.insert("content.registerExerciseURL",paramMap);
	}
	@Override
	public void deleteExerciseImgByImgName(Map<String, String> map) {
sqlSessionTemplate.delete("content.deleteExerciseImgByImgName",map);		
	}
	public void deleteExerciseURL(String exerciseName){
		sqlSessionTemplate.delete("content.deleteExerciseURL",exerciseName);
	}
	public HashMap<String,String> getURLByExerciseName(String exerciseName){
		System.out.println("DAO"+exerciseName);
		return sqlSessionTemplate.selectOne("content.getExerciseURL",exerciseName);
	}
	@Override
	public ExerciseBoardVO getExerciseInfoByExName(String exerciseName){
		return sqlSessionTemplate.selectOne("content.getExerciseInfoByExName", exerciseName);
	}
	@Override
	public void updateExerciseURL(HashMap<String,String> paramMap) {
		// TODO Auto-generated method stub
		sqlSessionTemplate.update("content.updateExerciseURL",paramMap);
	}

}
