<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript">
$(document).ready(function(){
	$("#memberInfoUpdateBtn").click(function(){
		if(confirm("회원정보를 수정하시겠습니까?")){
    		location.href="my_myInfoUpdateForm.do?memberId=${pnvo.momentorMemberVO.memberId}";			
		}
	});

	$("#memberInfoDeleteBtn").click(function(){
		if(confirm("회원을 탈퇴하시겠습니까?")){
    		location.href="my_myInfoDeleteForm.do?memberId=${pnvo.momentorMemberVO.memberId}";			
		}
		
	}); 
});
</script>
<c:choose>
	<c:when test="${requestScope.pnvo.momentorMemberVO.infoPublic == 1}">
<div style="width: 70%; padding-left: 400px">
<form method="post" name="myInfo" action="#">
	<p class="text-center">아이디 : ${requestScope.pnvo.momentorMemberVO.memberId}</p>
	<hr>
	<p class="text-center">패스워드 :
		<c:forEach begin="0" end="${fn:length(requestScope.pnvo.momentorMemberVO.memberPassword)}">
			*
		</c:forEach>
	</p>	
	<hr>
	<p class="text-center">이름 : ${requestScope.pnvo.momentorMemberVO.memberName}</p>
	<hr>
	<p class="text-center">생년월일 : ${requestScope.pnvo.momentorMemberVO.birthYear}년 ${requestScope.pnvo.momentorMemberVO.birthMonth}월 ${requestScope.pnvo.momentorMemberVO.birthDay}일</p>
	<hr>
	<p class="text-center">별명 : ${requestScope.pnvo.momentorMemberVO.nickName}</p>
	<hr>
	<p class="text-center">이메일 : ${requestScope.pnvo.momentorMemberVO.memberEmail}</p>
	<hr>
	<p class="text-center">성별 : ${requestScope.pnvo.momentorMemberVO.gender}</p>
	<hr>
	<p class="text-center">주소 : ${requestScope.pnvo.momentorMemberVO.memberAddress}</p>
	<hr>
	<p class="text-center">몸무게 : ${requestScope.pnvo.memberWeight} kg</p>
	<hr>
	<p class="text-center">키 : ${requestScope.pnvo.memberHeight} cm</p>
	<hr>
	<p class="text-center">나이 : ${requestScope.pnvo.age} 세</p>
	<hr>
	<p class="text-center">bmi : ${requestScope.pnvo.bmi}</p>
	<hr>
<br>
</form>
</div>			
	</c:when>
	<c:otherwise>
		<div style="width: 60%; padding-left: 450px">
			<form method="post" name="myInfo" action="#">
				<p class="text-center">회원정보 비공개입니다.</p>
			</form>
		</div>
	</c:otherwise>	 
</c:choose>
 
	<div align="center">
	<input type="button" value="회원정보수정하기" id="memberInfoUpdateBtn" class="btn btn-default">&nbsp;&nbsp;&nbsp;
	<input type="button" value="탈퇴하기" id="memberInfoDeleteBtn" class="btn btn-default">
	</div>

