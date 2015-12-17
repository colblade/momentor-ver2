package org.kosta.momentor.aop.common;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.kosta.momentor.aop.model.ReportService;
import org.kosta.momentor.contents.model.BoardVO;
import org.kosta.momentor.contents.model.ExerciseBoardService;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LoggingAspect {
	private Log log = LogFactory.getLog(getClass());
	@Resource
	private ReportService reportService;

	@Around("execution(public * org.kosta.momentor..*Service.find*(..))")
	public Object loggingAspect(ProceedingJoinPoint joinPoint) throws Throwable {		
		Object obj= joinPoint.proceed();
 //검색결과로 저장할 때
	/*ArrayList<BoardVO> list = (ArrayList)obj;
	for(BoardVO vo :list){
	String	keyword = vo.getBoardTitle();
	String serviceName = "";
	if(joinPoint.getTarget() instanceof ExerciseBoardService){
		serviceName="[운동게시판]";
	}
	else{
		serviceName="[커뮤니티게시판]";
	}
*//*}*/
		//검색어로 저장할 때
		Object[] args = joinPoint.getArgs();
		String keyword = (String)args[0];
		ArrayList resultVal = (ArrayList)obj;
		if(!resultVal.isEmpty()&&resultVal.size()>0){
			
			reportService.updateKeyword(keyword);	
			}
	
	return obj;
	
	}

}
