package org.kosta.momentor.aop.controller;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.kosta.momentor.aop.model.ReportService;
import org.kosta.momentor.aop.model.ReportVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class ReportController {

@Resource
private ReportService reportService;

@RequestMapping("member_getKeywordStats.do")
@ResponseBody
//검색어 랭킹 5위까지 목록 보여주기
public ArrayList<ReportVO> getKeywordStats(){	
	ArrayList<ReportVO> rvo = reportService.getKeywordStats();
	ArrayList<ReportVO> list = new ArrayList<ReportVO>();
	if(rvo==null||rvo.size()==0){
	
	}else{
		for(int i = 0;i<rvo.size();i++){
			if(i<5){
				list.add(rvo.get(i));
			}
		}
	}
	return list;
	}

}
