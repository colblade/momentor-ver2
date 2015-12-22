package org.kosta.momentor.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter{

   //일반회원만 접근 가능한 기능에 비로그인회원이 접근하지 못하도록 막는다.
   @Override
   public boolean preHandle(HttpServletRequest request,
         HttpServletResponse response, Object handler) throws Exception {
      HttpSession session = request.getSession(false);
      if(session==null||session.getAttribute("pnvo")==null){
         //로그인 안 됐을 때
         System.out.println("비로그인 상태이므로 서비스 불가.");
         response.sendRedirect("home.do");
         return false;//컨트롤러 메서드 수행하지 않게 한다.
      }
      System.out.println("handler"+handler);
      return true;
   }

}