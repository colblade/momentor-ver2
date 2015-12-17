<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
       $(document).ready(function(){
    	   $("input[name=boardTitle]").keyup(function(){
    	        var maxTitleLength=50;
    	         if($("input[name=boardTitle]").val().length>=maxTitleLength){
    	           alert("제목은 한글 기준 "+maxTitleLength+"자 까지만 가능합니다");
    	           $("input[name=boardTitle]").val($("input[name=boardTitle]").val().substring(0,maxTitleLength));
    	            return false;
    	         } 
    	       });
          $("#modifyBtn").click(function(){
             if($("input[name=boardTitle]").val()==""){
                alert("제목을 입력해주세요")
                $("input[name=boardTitle]").focus();
                return false;
             }
             if($("[name=boardContent]").val()==""){
                alert("내용을 입력해주세요")
                $("[name=boardContent]").focus();
                return false;
             }
             else{
            	 $("#updateForm").submit();            	 
             }
          });
       });
    </script>    
    
<form class="form-horizontal" action="admin_updateFAQ.do"   method="post" id="updateForm">
<input type="hidden" id="boardNo"   name="boardNo" value="${requestScope.fvo.boardNo }">
   <div class="form-group">
      <label for="boardTitle" class="col-sm-2 control-label">제목 : </label>
      <div class="col-sm-10">
         <input type="text" class="form-control" name="boardTitle"
            value="${requestScope.fvo.boardTitle }" placeholder="제목">
      </div>
   </div>
   <div class="form-group">
      <label class="col-sm-2 control-label">작성자 : </label>
      <div class="col-sm-10">
         관리자
      </div>
   </div>
   
   <div class="form-group">
      <label for="boardContent" class="col-sm-2 control-label">내용 :
      </label>
      <div class="col-sm-10">
         <textarea rows="7" cols="30" class="form-control" name="boardContent">${requestScope.fvo.boardContent}</textarea>
      </div>
   </div>
<!--    <div class="form-group" align="right">
      <div class="col-sm-offset-2 col-sm-10">
         <button type="submit" class="btn btn-default">수정하기</button>
      </div>
   </div> -->
   <nav> 
		<ul class="pager">
			<li class="next"><a id="modifyBtn">수정하기</a></li>
		</ul>
	</nav>
</form>