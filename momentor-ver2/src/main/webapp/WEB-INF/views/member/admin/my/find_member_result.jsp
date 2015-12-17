<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
      <%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
                <script>
$(function (){
	   $(".sideview").tooltip("hide"); 
   $("#searchMenuForm").submit(function(){
		  if($("#search").val()==""){
			  alert("검색어를 입력하세요!");
			  return false;
		  }
	   });
});
</script>

     <h3>검색 회원 목록</h3>
     <hr>
     <c:choose>
     <c:when test="${fn:length(requestScope.list.list)==0}">
    <h4><font style="font-style: italic;">검색된 회원결과 없음</font> </h4>
     </c:when>
     <c:otherwise>
 <table class="table table-striped">
  <thead>
  <tr>
    <th>아이디</th>
    <th>이름</th>
    <th>키</th>
    <th>몸무게</th>
    <th>나이</th>
    <th>별명</th>
    <th>성별</th>
    <th>주소</th>
      <th>회원강퇴</th>
  </tr>
  </thead>
  <tbody>
<c:forEach items="${requestScope.list.list}" var="memberList">
   <tr>
     <c:choose>
         <c:when test="${sessionScope.pnvo==null }">
            <td>${memberList.momentorMemberVO.memberId}</td>
         </c:when>
        <c:otherwise><td><a class="sideview"  data-placement="right"  style="cursor:pointer" data-container="body" data-toggle="tooltip" data-html="true" title="회원 상세 정보<br>아이디 : ${memberList.momentorMemberVO.memberId}<br>비밀번호 : ${memberList.momentorMemberVO.memberPassword}<br>이름 : ${memberList.momentorMemberVO.memberName}<br>생년월일 :  ${memberList.momentorMemberVO.birthYear}/ ${memberList.momentorMemberVO.birthMonth}/ ${memberList.momentorMemberVO.birthDay}<br>나이 : ${memberList.age}<br>별명 : ${memberList.momentorMemberVO.nickName}<br>이메일 : ${memberList.momentorMemberVO.memberEmail}<br>성별 : ${memberList.momentorMemberVO.gender}<br>주소 : ${memberList.momentorMemberVO.memberAddress}<br>키 : ${memberList.memberHeight}<br>몸무게 : ${memberList.memberWeight}<br>bmi : ${memberList.bmi}<br>"  id="test">${memberList.momentorMemberVO.memberId}</a></td></c:otherwise>
      </c:choose>
      <td>${memberList.momentorMemberVO.memberName }</td>
      <td>${memberList.memberHeight}</td>
      <td>${memberList.memberWeight}</td>
      <td>${memberList.age}</td>
      <td>${memberList.momentorMemberVO.nickName}</td>
      <td>${memberList.momentorMemberVO.gender }</td>
      <td>${memberList.momentorMemberVO. memberAddress}</td>
    	 <td><form method="post" action="deleteMemberByAdmin.do?memberId=${memberList.momentorMemberVO.memberId}" id="">
		<input type="submit" value="회원강퇴" class="btn btn-primary" >   
		<input type="hidden"  name="searchMenu" value="${requestScope.searchMenu }">
		<input type="hidden"  name="search" value="${requestScope.search }">
		</form>
   </tr>
</c:forEach>
</tbody>
</table>
</c:otherwise>
</c:choose>
<br><br>	
<div align="center">
<nav>
<c:set var="pb" value="${requestScope.list.pagingBean}"></c:set>
	  <ul class="pagination">	  
	  <c:if test="${pb.previousPageGroup}">	
	    <li>
			<a href="admin_my_managerFindBy.do?pageNo=${pb.startPageOfPageGroup-1}&search=${requestScope.search}&searchMenu=${requestScope.searchMenu}"
			aria-label="Previous"><span aria-hidden="true">&laquo;</span>
			</a>	
	    </li>
	  </c:if>
	  <c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
			<c:choose>
				<c:when test="${pb.nowPage!=i}">
				<li>
					<a href="admin_my_managerFindBy.do?pageNo=${i}&search=${requestScope.search}&searchMenu=${requestScope.searchMenu}">${i}</a>
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
			<a href="admin_my_managerFindBy.do?pageNo=${pb.endPageOfPageGroup+1}&search=${requestScope.search}&searchMenu=${requestScope.searchMenu}"
			aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
	      </li>
		</c:if>
	  </ul>
	</nav>
</div><br>
<center>
<form class="form-inline" action="admin_my_managerFindBy.do?pageNo=1" id="searchMenuForm">
  <div class="form-group">
      <select name="searchMenu" class="form-control input-sm" id="command">
           <option value="id" >아이디</option>
           <option value="name" >이름</option>
           <option value="nickName" >닉네임</option>
      </select> 
  </div>
  <div class="form-group">
  	<input type="text" name="search" id="search" class="form-control" placeholder="검색어를 입력하세요">
  </div>
  <button type="submit" class="btn btn-primary">검색</button>
</form>
</center>