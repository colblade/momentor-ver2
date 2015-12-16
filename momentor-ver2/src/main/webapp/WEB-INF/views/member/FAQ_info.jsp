<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    $(document).ready(function(){
    	var boardNo=$("#boardNo").val();
    	$("#deleteBtn").click(function(){
    		if(confirm("정말 삭제하시겠습니까?")){
    		}else{
    			return false;
    		}
    	});//삭제
    	$("#modifyBtn").click(function(){
    		if(confirm("수정하시겠습니까?")){
    		}else{
    			return false;
    		}
    	});//수정
    });
</script>
<div class="container">

   <div class="row">

      <div class="col-sm-8 blog-main">

         <div class="blog-post">
            <br><br>
            <h2 class="blog-post-title">${requestScope.fvo.boardTitle}</h2>
            <pre>${requestScope.fvo.boardContent }</pre>
            <br><br><br>
            <hr>
            <p>
                 <br>
        <input type='hidden' value='${requestScope.fvo.boardNo}' name='boardNo' id = "boardNo">
            </p>        
             <div class="row marketing">
               <hr>
	           </div>
	           <div class="row marketing">                 
                <nav> 
					<ul class="pager">
					<li class="next"><a href="${initParam.root}showFAQList.do?pageNo=1" id="listBtn">목록으로</a></li>
						<c:if test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">
							<li class="next"><a href="admin_deleteFAQByNo.do?boardNo=${requestScope.fvo.boardNo}" id="deleteBtn">삭제하기</a></li>
							<li class="next"><a href="admin_updateFAQForm.do?boardNo=${requestScope.fvo.boardNo}" id="modifyBtn">수정하기</a></li>
						</c:if>
						
					</ul>				
				</nav>                           
            </div><!-- 글 삭제/수정 버튼 div -->
         </div><!-- 전체 post div -->
      </div><!-- 전체 post div -->
      <!-- /.blog-sidebar -->
   </div>
   <!-- /.row -->
</div>
<!-- /.container -->