package org.kosta.momentor.contents.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.momentor.member.model.MomentorMemberPhysicalVO;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminCheckInterceptor extends HandlerInterceptorAdapter{

	//관리자만 접근 가능한 기능에 일반회원 및 비로그인회원이 접근하지 못하도록 막는다.
   @Override
   public boolean preHandle(HttpServletRequest request,
         HttpServletResponse response, Object handler) throws Exception {
      System.out.println("admin interceptor");
      HttpSession session = request.getSession(false);
      MomentorMemberPhysicalVO pnvo = (MomentorMemberPhysicalVO)session.getAttribute("pnvo");
      
      if(session==null||session.getAttribute("pnvo")==null){
         //로그인 되지 않았을 때.
         System.out.println("비로그인 상태이므로 서비스 불가.");
         response.sendRedirect("home.do");
         return false;//컨트롤러 메서드 수행하지 않게 한다.
      }
      else if(pnvo.getMomentorMemberVO().getAuth()!=1){
    	  System.out.println("관리자가 아니므로 서비스 불가");
    	  response.sendRedirect("login_home.do");
    	  return false;
      }
      System.out.println("handler"+handler);
      return true;
   }

}

