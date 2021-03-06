<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<h2 class="sub-header">Momentor Guide</h2>
 <div class="table-responsive">
 <table class="table table-striped table-hover">
 <thead>
			<tr>
				<th>No</th>
				<th>타이틀</th>
				<th>운동</th>
				<th>글쓴이</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
<tbody>
<c:forEach items="${requestScope.exerciseList }" var="list">
  <tr>
                  <td>${list.boardNo }</td>
                  <td><a href="${initParam.root }member_getExerciseByNo.do?boardNo=${list.boardNo}&pageNo=${param.pageNo}">${list.boardTitle }</a></td>
                  <td>${list.exerciseVO.exerciseName }</td>
                  <td>관리자</td>
                   <td>${list.boardWdate }</td>
                   <td>${list.exerciseHits }</td>
                </tr>

</c:forEach>
</tbody>
</table>
</div>
<div align="center">
<nav>
<c:set var="p" value="${requestScope.pageObject}"></c:set>
	  <ul class="pagination">	  
	  <c:if test="${p.isPreviousPageGroup()==true }">	
	    <li>
			<a href="${initParam.root}member_exerciseBoard.do?pageNo=${p.getNowPage()-1 }"
			aria-label="Previous"><span aria-hidden="true">&laquo;</span>
			</a>	
	    </li>
	  </c:if>
	  <c:forEach var="i" begin="${p.getStartPageOfPageGroup() }" end = "${ p.getEndPageOfPageGroup()}">
			<c:choose>
				<c:when test="${p.nowPage!=i}">
				<li>
					<a href="${initParam.root}member_exerciseBoard.do?pageNo=${i}">${i}</a>
				</li> 
				</c:when>
				<c:otherwise>
				<li class="active">
      				<span>${i}</span>
    			</li>
				</c:otherwise>
			</c:choose>		    
		</c:forEach>
    	<c:if test="${p.isNextPageGroup()==true }">
	    <li>
			<a href="${initParam.root}member_exerciseBoard.do?pageNo=${p.getEndPageOfPageGroup()+1 }"
			aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
	      </li>
		</c:if>
	  </ul>
	</nav>
</div><br>
<div class="clearfix">
    <span class="btn-group"></span>
    <c:if test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">	
    	<div class="pull-right">
        <a href="${initParam.root}admin_writeView.do" class="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> 글쓰기</a>   
    </div>
	</c:if>	    
</div>
