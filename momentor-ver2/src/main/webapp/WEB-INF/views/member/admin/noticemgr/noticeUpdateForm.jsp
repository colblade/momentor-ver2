<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		//제목 입력 란의 글자 수가 50자 이상이면 replace를 통해 50자 까지 입력된 걸로 대체 시킨후 alert를 띄워준다
		$("#boardTitle").keyup(function(){
	        var maxTitleLength=50;
	        	if($("#boardTitle").val().length>=maxTitleLength){
	          		alert("제목은 한글 기준 "+maxTitleLength+"자 까지만 가능합니다");
	           $("#boardTitle").val($("#boardTitle").val().substring(0,maxTitleLength));
	            return false;
	       		} 
	       });
		$("#updateBtn").click(function(){
			if($("#boardTitle").val()==null||$("#boardTitle").val()==""){
				alert("제목을 입력하시오");
				return false;
			}
			if($("#boardContent").val()==null||$("#boardContent").val()==""){
				alert("내용을 입력하시오");
				return false;
			}
			$("#noticeUpdateForm").submit();
		});
		$("#getNoticeByNo").click(function(){
    		location.href = "${initParam.root}member_getNoticeByNo.do?boardNo="+$("#boardNo").val();
    	});//click
	});
</script>
<form method="post" name="noticeUpdateForm" id="noticeUpdateForm" action="${initParam.root} admin_noticeUpdate.do" class="form-horizontal">
	<input type="hidden" name="memberId" value="${sessionScope.mvo.memberId}">
	<input type="hidden" id="boardNo" name="boardNo" value="${requestScope.nvo.boardNo }">
<div class="form-group">
<label for="boardTitle" class="col-sm-2 control-label">제목 : </label>
	<div class="col-sm-10">
         <input type="text" class="form-control" name="boardTitle" id="boardTitle" 
            value="${requestScope.nvo.boardTitle}" placeholder="제목">
    </div>
   </div>
   <div class="form-group">
      <label for="boardContent" class="col-sm-2 control-label">내용 :
      </label>
    <div class="col-sm-10">
         <pre><textarea style="resize:none" rows="7" cols="30" class="form-control" name="boardContent" id="boardContent" >${requestScope.nvo.boardContent }</textarea></pre>
    </div>
	</div>
	<div class="form-group" align="right">
      <div class="col-sm-offset-2 col-sm-10">
         <input type="submit" value="수정하기" class="btn btn-primary">
         &nbsp;&nbsp; 
		<input type="button" value="되돌아가기" id="getNoticeByNo" class="btn btn-primary">
      </div>
   </div>
</form>
