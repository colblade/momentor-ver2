<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2 class="sub-header">공지사항</h2>
<div class="table-responsive">
 <table class="table table-striped table-hover">
 <thead>
           <tr>
             <th class="text-left">NO</th>
             <th class="text-center">제목</th>
             <th class="text-center">작성일</th>
             <th class="text-center">작성자</th>
             
           </tr>
</thead>
<tbody>
 <c:forEach items="${requestScope.noticeList.list }" var="noticeList">
	<tr>
		<td class="text-left">${noticeList.boardNo }</td>
		<td class="text-left">
			<a href="${initParam.root}member_getNoticeByNo.do?boardNo=${noticeList.boardNo}">${noticeList.boardTitle }</a>
		</td>
		<td class="text-center">${noticeList.boardWdate }</td>
		<td class="text-center">관리자</td>
	</tr>
</c:forEach>
</tbody>
</table>
</div>
<div align="center">
<nav>
<c:set var="pb" value="${requestScope.noticeList.pagingBean}"></c:set>
	  <ul class="pagination">	  
	  <c:if test="${pb.previousPageGroup}">	
	    <li>
			<a href="member_getAllNoticeList.do?pageNo=${pb.startPageOfPageGroup-1}"
			aria-label="Previous"><span aria-hidden="true">&laquo;</span>
			</a>	
	    </li>
	  </c:if>
	  <c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
			<c:choose>
				<c:when test="${pb.nowPage!=i}">
				<li>
					<a href="member_getAllNoticeList.do?pageNo=${i}">${i}</a>
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
			<a href="member_getAllNoticeList.do?pageNo=${pb.endPageOfPageGroup+1}"
			aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
	      </li>
		</c:if>
	  </ul>
	</nav>
</div><br>
<!-- &&sessionScope.mvo.Auth==1 -->
<c:if test="${sessionScope.pnvo!=null&&sessionScope.pnvo.momentorMemberVO.auth==1}">
<div class="clearfix">
    <span class="btn-group"></span>
    <div class="pull-right">
        <a href="${initParam.root}admin_writeNoticeByAdminForm.do" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> 글쓰기</a>   
    </div>
</div>
</c:if>