<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#answerImg").click(function() {
			if ($("#boardTitle").val() == "") {
				alert("제목을 입력하세요!");
				return;
			} else if ($("#boardContent").val() == "") {
				alert("본문 내용을 입력하세요!");
				return;
			}
			$("#writeForm").submit();
		});
	});
</script>

<form action="${initParam.root}admin_qnaReply.do" method="post"
	id="writeForm" class="form-horizontal">
	<h4>답변글쓰기</h4>
	<div class="form-group">
		<label for="boardTitle" class="col-sm-2 control-label">제목 : </label>
		<div class="col-sm-10">
			<input type="text" class="form-control" name="boardTitle"
				id="boardTitle" value="${requestScope.qvo.boardTitle }"
				placeholder="제목">
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label">이름 : </label>
		<div class="col-sm-10">관리자</div>
	</div>
	<div class="form-group">
		<label for="boardContent" class="col-sm-2 control-label">내용 :
		</label>
		<div class="col-sm-10">
			<textarea style="resize: none" cols="30" rows="7" class="form-control" name="boardContent" id="boardContent"></textarea>
		</div>
	</div>
	<nav>
		<ul class="pager">
			<li id="answerImg"><a href="#">답변쓰기</a></li>
		</ul>
	</nav>
	<input type="hidden" name="ref" value="${requestScope.qvo.ref }">
	<input type="hidden" name="restep" value="${requestScope.qvo.restep }">
	<input type="hidden" name="relevel" value="${requestScope.qvo.relevel }"> 
	<input type="hidden" name="boardNo" value="${requestScope.qvo.boardNo }"> 
	<input type ="hidden" name ="refMemberId" value="${requestScope.qvo.refMemberId }">
	<input type="hidden" name="momentorMemberVO.memberId" value="${sessionScope.pnvo.momentorMemberVO.memberId }">

</form>


