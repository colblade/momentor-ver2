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
		$("#writeQNAForm").submit(function(){   
    		if($("#boardTitle").val() == ""){
    			alert("제목을 입력하세요!");
    			return false;
    		} else if($("#boardTitle").val() == ""){
    			alert("내용을 입력하세요!");
    			return false;    			
    		}
    	});
		$("#getQNABoardList").click(function(){
			location.href="member_getAllQNAList.do?pageNo=1";
		});
	});
</script>    
<form action="${initParam.root}my_writeQNA.do" method="post" id="writeQNAForm" class="form-horizontal">
<input type="hidden" name = "momentorMemberVO.memberId"  value = "${sessionScope.pnvo.momentorMemberVO.memberId }">
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
					<input type="button" value="되돌아가기" id="getQNABoardList" class="btn btn-primary">
			    </div>
			</div>
		</div>
	</div>
  </form>