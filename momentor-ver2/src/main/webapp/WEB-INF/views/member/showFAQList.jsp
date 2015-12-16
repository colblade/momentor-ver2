<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h2 class="sub-header">FAQ</h2>
<div class="table-responsive">
	<table class="table table-striped">
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>			
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${requestScope.FAQList.list}" var="posting">
				<tr>
					<td>${posting.boardNo }</td>
					<td><a href="getFAQByNo.do?boardNo=${posting.boardNo}">${posting.boardTitle}</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
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
	<nav> 
		<ul class="pager">
			<li class="next"><a href="${initParam.root}admin_writeFAQForm.do">WRITE</a></li>
		</ul>
	</nav>
</c:if>