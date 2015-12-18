<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#writeNoticeForm").submit(function(){   
			if($("#boardTitle").val() == ""){
				alert("제목을 입력하세요!");
				return false;
			} else if($("#boardContent").val() == ""){
				alert("내용을 입력하세요!");
				return false;
			}
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
     <input type="text" class="form-control" name="boardTitle" id="boardTitle" placeholder="제목을 입력하세요."
					required="required">
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
     		<textarea style="resize:none" cols="30" rows="7" class="form-control" name="boardContent" id="boardContent"
     		placeholder="내용을 입력하세요." required="required"></textarea>
      </div>
   </div>
   <div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<div class="clearfix">
			    <span class="btn-group"></span>
			    <div class="pull-right">
			    	<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span>글쓰기</button>
					<input type="button" value="되돌아가기" id="getNoticeBoardList" class="btn btn-primary">
			    </div>
			</div>
		</div>
	</div>
  </form>