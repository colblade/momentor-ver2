<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<script type="text/javascript">
   $(document).ready(function() {
  		$("input[name=boardTitle]").keyup(function(){
  	        var maxTitleLength=50;
  	        	if($("input[name=boardTitle]").val().length>=maxTitleLength){
  	          		alert("제목은 한글 기준 "+maxTitleLength+"자 까지만 가능합니다");
  	           $("input[name=boardTitle]").val($("input[name=boardTitle]").val().substring(0,maxTitleLength));
  	            return false;
  	       		} 
  	       });
      $("#writeForm").submit(function() {
         if ($("input[name=boardTitle]").val() == "") {
            alert("제목을 입력해주세요")
            $("input[name=boardTitle]").focus();
            return false;
         }
         if ($("[name=boardContent]").val() == "") {
            alert("내용을 입력해주세요")
            $("[name=boardContent]").focus();
            return false;
         }
      });
      $("#getCommunityBoardList").click(function() {
			location.href = "${initParam.root}showCommunityList.do?pageNo=1"
		});//click
      var count =1;
      
      $("#addFileBtn").click(function(){
    	  if(count>4){
    		  
    		 alert("사진은 5개까지 추가할 수 있습니다.");
    		 $(this).attr("readonly","readonly");
    		  return;
    	  }
    	  $("#fileSpan").append("<input type = 'file' name = 'file["+count+"]'>");
    	  count++;
      })
      
   
   });
</script>
<form class="form-horizontal" action="my_postingCommunity.do"
   method="post" id="writeForm" enctype="multipart/form-data">
   <input type="hidden" name="momentorMemberVO.memberId" value="${sessionScope.pnvo.momentorMemberVO.memberId}">
   <div class="form-group">
      <label for="boardTitle" class="col-sm-2 control-label">제목 : </label>
      <div class="col-sm-10">
         <input type="text" class="form-control" name="boardTitle"
            placeholder="제목">
      </div>
   </div>
   <div class="form-group">
      <label class="col-sm-2 control-label">작성자 : </label>
      <div class="col-sm-10">
         ${sessionScope.pnvo.momentorMemberVO.nickName }<br>
      </div>
   </div>
   
   
      <div class="form-group">
      <label class="col-sm-2 control-label"></label>
      <div class="col-sm-10">
        <input type="file" name="file[0]"><span id="fileSpan"></span><br>
				<input type="button" value="사진추가하기" id="addFileBtn" class="btn btn-primary"><br><br>
      </div>
   </div>
   
   
   <div class="form-group">
      <label for="boardContent" class="col-sm-2 control-label">내용 :
      </label>
      <div class="col-sm-10">
         <textarea rows="7" cols="30" class="form-control" name="boardContent" style="resize:none"></textarea>
      </div>
   </div>
   <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
	   <div class="clearfix">
		    <span class="btn-group"></span>
		    <div class="pull-right">
         		<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span>글쓰기</button>
         		<input type="button" value="되돌아가기" id="getCommunityBoardList" class="btn btn-primary">   
		    </div>
		</div>
      </div>
   </div>
</form>