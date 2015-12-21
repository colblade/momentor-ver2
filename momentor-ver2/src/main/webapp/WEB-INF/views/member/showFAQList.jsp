<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h2 class="sub-header">FAQ</h2>
<div class="table-responsive">
	<script type="text/javascript">
	function updateFAQ(boardNo){
		if(confirm("수정 하시겠습니까?")){
			location.href="admin_updateFAQForm.do?boardNo="+boardNo;
		}
	};
	function deleteFAQ(boardNo){
		if(confirm("삭제 하시겠습니까?")){
			location.href="admin_deleteFAQByNo.do?boardNo="+boardNo;
		}
	}		//FAQ 토글 아코디언
		    $(document).ready(function(){
		    	$("#accordion").accordion({  		
				 active: false,//처음 화면 로딩시 아무것도 열려있지 않게함
				collapsible: true
		    	});
		    	$("#modifyBtn").click(function(){    			
	    			if(confirm("수정 하시겠습니까?")){
	    				location.href="admin_updateFAQForm.do?boardNo="+$("#");
	    			}
	    	});
		    });
			</script>
	<div id="accordion"class="ui-accordion-content">
			<c:forEach items="${requestScope.FAQList.list}" var="posting">
			<h3 class="ui-accordion-header" >${posting.boardTitle}</h3>
			<pre>${posting.boardContent}<br>
				<c:if test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">
				<input type="button"  id=" modifyBtn"  value="수정"  onclick="updateFAQ(${posting.boardNo})" class="btn btn-primary pull-right"><input type="button"  id="deleteBtn"  value="삭제" onclick="deleteFAQ(${posting.boardNo})" class="btn btn-primary pull-right">
				</c:if>
			</pre>		
			</c:forEach>
</div>
</div>
<div align="center">
<nav>
<c:set var="pb" value="${requestScope.FAQList.pagingBean}"></c:set>
     <ul class="pagination">
     <c:if test="${pb.previousPageGroup}">   
       <li>
         <a href="showFAQList.do?pageNo=${pb.startPageOfPageGroup-1}"
         aria-label="Previous"><span aria-hidden="true">&laquo;</span>
         </a>   
       </li>
     </c:if>
     <c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
         <c:choose>
            <c:when test="${pb.nowPage!=i}">
            <li>
               <a href="showFAQList.do?pageNo=${i}">${i}</a>
            </li> 
            </c:when>
            <c:otherwise>
            <li class="active">
                  <span>${i}</span>
             </li>
            </c:otherwise>
         </c:choose>          
      </c:forEach>
       <c:if test="${pb.nextPageGroup}">
       <li>
         <a href="showFAQList.do?pageNo=${pb.endPageOfPageGroup+1}"
         aria-label="Next">
         <span aria-hidden="true">&raquo;</span>
         </a>
       </li>
      </c:if>
     </ul>
   </nav>
</div>
<c:if test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">
	<div class="clearfix">
	    <span class="btn-group"></span>
	    <div class="pull-right">
	       <a href="${initParam.root}admin_writeFAQForm.do" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> 글쓰기</a>   
	    </div>
	</div>
</c:if>