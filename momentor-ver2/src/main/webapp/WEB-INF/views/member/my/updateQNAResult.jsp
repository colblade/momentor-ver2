<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <div class="table-responsive" align="center">
   <table class="table table-striped" style="width: 50%">
   	<tr><td class="text-center">NO</td><td>${requestScope.qvo.boardNo }</td></tr>
   	<tr><td class="text-center">제목</td><td>${requestScope.qvo.boardTitle }</td></tr>
	<tr><td class="text-center">조회수</td><td>${requestScope.qvo.qnaHits }</td></tr>   	
   	<tr><td class="text-center">내용</td><td><pre style="border: none; background-color: #f9f9f9;">${requestScope.qvo.boardContent }</pre></td></tr>
   </table>
   </div>
   <p class="noticeLink">
  	 <a href="${initParam.root}login_home.do">홈으로</a><br>
	 <a href="${initParam.root}member_getAllQNAList.do ">목록으로</a>
   </p>