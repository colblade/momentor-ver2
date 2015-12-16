<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<script type="text/javascript">
	$(document).ready(function(){
		$("#answerImg").click(function(){
			if($("#boardTitle").val()==""){
				alert("제목을 입력하세요!");
				return;
			}else if($("#boardContent").val()==""){
				alert("본문 내용을 입력하세요!");
				return;
			}
			$("#writeForm").submit();
		});
	});
</script>
</head>
<body>
<form action="admin_qnaReply.do" method="post" id="writeForm"  >
 <table class="inputForm" >
    <caption>답변글쓰기</caption>
    <tbody>
	 <tr>
		<td>제목</td>
		<td><input type="text" name="boardTitle" id="boardTitle" value="${requestScope.qvo.boardTitle }"></td>
	 </tr>
	 <tr>
		<td>이름</td>
		<td>관리자</td>
	 </tr>
	 <tr>
		<td colspan=2 >
		<textarea cols="40" rows="10" name="boardContent" id="boardContent"></textarea>		
		</td>
	 </tr>
	 <tr>
	 	<td  colspan=2 >
	 		<img src="${initParam.root}image/answer_btn.jpg"  id="answerImg" />		
	 	</td>
	 </tr>
 </table> 
  <input type="hidden" name="ref" value="${requestScope.qvo.ref }">
 <input type="hidden" name="restep" value="${requestScope.qvo.restep }">
 <input type="hidden" name="relevel" value="${requestScope.qvo.relevel }">
 <input type="hidden" name="boardNo" value="${requestScope.qvo.boardNo }"> 
 <input type="hidden" name="momentorMemberVO.memberId" value="${sessionScope.pnvo.momentorMemberVO.memberId }"> 
 
 </form>
</body>
</html>





