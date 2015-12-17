<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#writeBtn").click(function(){   
    		$("#writeNoticeForm").submit();
    	});
		$("#getNoticeBoardList").click(function() {
			location.href = "${initParam.root}member_getAllNoticeList.do?pageNo=1"
		});//click
	});
</script>    
<form action="${initParam.root}admin_writeNoticeByAdmin.do" method="post" id="writeNoticeForm" class="form-horizontal">
   <div class="form-group">
   <label for="boardTitle" class="col-sm-2 control-label">제목 : </label>
	<div class="col-sm-10">
     <input type="text" class="form-control" name="boardTitle" id="boardTitle" placeholder="제목">
      </div>
   </div>
   <div class="form-group">
      <label class="col-sm-2 control-label">이름 : </label>
   <div class="col-sm-10">
    	${requestScope.pnvo.momentorMemberVO.memberName}
      </div>
   </div>
   <div class="form-group">
      <label for="boardContent" class="col-sm-2 control-label">내용 :
      </label>
      <div class="col-sm-10">
     		<textarea style="resize:none" cols="30" rows="7" class="form-control" name="boardContent" id="boardContent"></textarea>
      </div>
   </div>
   <div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="submit" value="등록하기" class="btn btn-default" id="writeBtn">
				&nbsp;&nbsp; 
				<input type="button" value="되돌아가기"	id="getNoticeBoardList" class="btn btn-default">
			</div>
		</div>
  </form>