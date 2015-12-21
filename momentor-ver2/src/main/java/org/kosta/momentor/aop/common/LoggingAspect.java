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
//사용자가 검색을 실행했을 때 검색 결과가 있을 때만  Arround를 이용해 검색어를 저장.
public class LoggingAspect {
	private Log log = LogFactory.getLog(getClass());
	@Resource
	private ReportService reportService;

	@Around("execution(public * org.kosta.momentor..*Service.find*(..))")
	public Object loggingAspect(ProceedingJoinPoint joinPoint) throws Throwable {		
		Object obj= joinPoint.proceed();

		Object[] args = joinPoint.getArgs();
		String keyword = (String)args[0];
		ArrayList resultVal = (ArrayList)obj;
		if(!resultVal.isEmpty()&&resultVal.size()>0){
			
			reportService.updateKeyword(keyword);	
			}
	
	return obj;
	
	}

}
