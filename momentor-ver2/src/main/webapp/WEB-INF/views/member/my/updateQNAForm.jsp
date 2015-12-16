<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#updateBtn").click(function(){
			if($("#boardTitle").val()==null||$("#boardTitle").val()==""){
				alert("제목을 입력하시오");
				return false;
			}
			if($("#boardContent").val()==null||$("#boardContent").val()==""){
				alert("내용을 입력하시오");
				return false;
			}
			$("#updateQNAForm").submit();
		});
	});
</script>
<form method="post" name="updateQNAForm" id="updateQNAForm" action="${initParam.root} my_updateQNA.do" class="form-horizontal">
	<input type="hidden" name="memberId" value="${sessionScope.mvo.memberId}">
	<input type="hidden" name="boardNo" value="${requestScope.qvo.boardNo }">
	<input type="hidden" name="qnaHits" value="${requestScope.qvo.qnaHits }">
<div class="form-group">
<label for="boardTitle" class="col-sm-2 control-label">제목 : </label>
	<div class="col-sm-10">
         <input type="text" class="form-control" name="boardTitle" id="boardTitle" 
            value="${requestScope.qvo.boardTitle}" placeholder="제목">
    </div>
   </div>
   <div class="form-group">
      <label for="boardContent" class="col-sm-2 control-label">내용 :
      </label>
    <div class="col-sm-10">
         <pre><textarea style="resize:none" rows="7" cols="30" class="form-control" name="boardContent" id="boardContent" >${requestScope.qvo.boardContent }</textarea></pre>
    </div>
	</div>
   <div class="form-group" align="right">
      <div class="col-sm-offset-2 col-sm-10">
     <input type="button" value="수정하기" id="updateBtn" class="btn btn-default">
      </div>
   </div>
</form>
