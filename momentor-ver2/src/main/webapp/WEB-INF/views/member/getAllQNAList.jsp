<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<h2 class="sub-header">Q&A</h2>
<div class="table-responsive">
 <table class="table table-striped, table-hover">
 <thead>
           <tr>
             <th class="text-left">NO</th>
             <th class="text-center">제목</th>
             <th class="text-center">작성일</th>
             <th class="text-center">작성자</th>
             <th class="text-center">조회수</th>
           </tr>
</thead>
<tbody>
 <c:forEach items="${requestScope.QNAList.list }" var="QNAList" varStatus="vs">
	<tr>
		<td class="text-left">${QNAList.boardNo }</td>
		<td class="text-left">
			<c:if test="${QNAList.relevel!=0 }">
			<c:forEach begin="0" end="${QNAList.relevel }" step="1">
				&nbsp;&nbsp;
			</c:forEach>
				<img src="${initParam.root }image/reply.jpg">
			</c:if>
 			<c:choose>
				<c:when test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">
				<a href="${initParam.root}my_getQNAByNo.do?boardNo=${QNAList.boardNo}">${QNAList.boardTitle }</a>
				</c:when>
				<c:when test="${QNAList.refMemberId eq sessionScope.pnvo.momentorMemberVO.memberId}">
				<a href="${initParam.root}my_getQNAByNo.do?boardNo=${QNAList.boardNo}">${QNAList.boardTitle }</a>
				</c:when>
				<c:otherwise>
				${QNAList.boardTitle}
				</c:otherwise>
			</c:choose>
		</td>
		<td class="text-center">${QNAList.boardWdate }</td>
		<td class="text-center">${QNAList.momentorMemberVO.memberId }</td>
		<td class="text-center">${QNAList.qnaHits}</td>
	</tr>
</c:forEach>
</tbody>
</table>

<c:if test="${sessionScope.pnvo!=null}">
	<nav>
	   <ul class="pager">
			<li><a href="${initParam.root}my_writeQNAForm.do">WRITE</a>
	   </ul>
    </nav>
</c:if>
</div>
<br><br>	
<div align="center">
<nav>
<p class="paging">
	<c:set var="pb" value="${requestScope.QNAList.pagingBean}"></c:set>
	<ul class="pagination">
	<c:if test="${pb.previousPageGroup}">
		<li>
		<a href="member_getAllQNAList.do?pageNo=${pb.startPageOfPageGroup-1}"
		aria-label="Previous"><span aria-hidden="true">&laquo;</span>
		◀&nbsp; </a>		
		</li>				
	</c:if>
	<c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
	<c:choose>
		<c:when test="${pb.nowPage!=i}">
		<li>
			<a href="member_getAllQNAList.do?pageNo=${i}">${i}</a> 
		</li>
		</c:when>
		<c:otherwise>
		<li class="active">
			<span>	${i}</span>
		</li>
		</c:otherwise>
	</c:choose>
	&nbsp;
	</c:forEach>	 

	<c:if test="${pb.nextPageGroup}">
		<li>
		<a href="member_getAllQNAList.do?pageNo=${pb.endPageOfPageGroup+1}"
		aria-label="Next">
		 <span aria-hidden="true">&raquo;</span></a>			
		<li>			
	</c:if>
	</ul>
	</nav>
	</div>
</body>