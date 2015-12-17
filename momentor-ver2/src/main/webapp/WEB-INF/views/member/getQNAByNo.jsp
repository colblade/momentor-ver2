<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#updateQNABtn").click(function(){
		if(confirm("qna를 수정하시겠습니까?")){
    		location.href="my_updateQNAForm.do?qnaNo=${requestScope.qvo.boardNo}";			
		}
	});

	$("#deleteQNABtn").click(function(){
		if(confirm("qna를 삭제하시겠습니까?")){
    		location.href="my_deleteQNA.do?qnaNo=${requestScope.qvo.boardNo}";			
		}
		
	}); 
});
</script>
<body>
<div class="table-responsive" class="text-center" align="center">
<form method="post" name="qnaInfo" action="#" >
<table class="table table-striped" style="width: 50%" >
	<tbody>
	<tr><td class="text-center">NO</td><td>${requestScope.qvo.boardNo}</td></tr>
	<tr><td class="text-center">제목</td><td>${requestScope.qvo.boardTitle }</td></tr>
	<tr><td class="text-center">작성일</td><td>${requestScope.qvo.boardWdate}</td></tr>
	<tr><td class="text-center">작성자</td><td>${requestScope.qvo.momentorMemberVO.memberId }</td></tr>
	<tr><td class="text-center">조회수</td><td>${requestScope.qvo.qnaHits}</td></tr>
	<tr><td class="text-center">내용</td><td><pre style="border: none; background-color: #f9f9f9;">${requestScope.qvo.boardContent }</pre></td></tr>
	</tbody>
</table>
<input type="hidden" name="memberName" value="${requestScope.qvo.momentorMemberVO.memberName }">
</form>
</div>
	<c:if test="${sessionScope.pnvo!=null&&sessionScope.pnvo.momentorMemberVO.memberId==requestScope.qvo.momentorMemberVO.memberId||sessionScope.pnvo.momentorMemberVO.auth==1}">
	<nav>
	   <ul class="pager">
	   		<c:if test="${sessionScope.pnvo!=null&&sessionScope.pnvo.momentorMemberVO.auth==1 }">
	   			<li><a href="admin_replyView.do?boardNo=${requestScope.qvo.boardNo}">답글</a>&nbsp;&nbsp;&nbsp;</li>
	   		</c:if>
	   		<li><a id="updateQNABtn">수정하기</a>&nbsp;&nbsp;&nbsp;</li>
	   		<li><a id="deleteQNABtn">삭제하기</a>&nbsp;&nbsp;&nbsp;</li>
			<li><a href="${initParam.root} member_getAllQNAList.do?pageNo=1">목록으로</a></li>
	   </ul>
    </nav>
	</c:if>
	<br>
	<c:if test="${sessionScope.pnvo!=null&&sessionScope.pnvo.momentorMemberVO.memberId!=requestScope.qvo.momentorMemberVO.memberId&&sessionScope.pnvo.momentorMemberVO.auth!=1}">
		<ul class="pager">
			<li><a href="${initParam.root} member_getAllQNAList.do?pageNo=1">목록으로</a></li>
		</ul>
	</c:if>
</body>